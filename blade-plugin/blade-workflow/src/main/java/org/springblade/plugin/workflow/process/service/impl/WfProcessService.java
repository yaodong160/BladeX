package org.springblade.plugin.workflow.process.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.google.common.collect.Sets;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.converter.BpmnXMLConverter;
import org.flowable.bpmn.model.*;
import org.flowable.bpmn.model.Process;
import org.flowable.engine.*;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.history.HistoricProcessInstanceQuery;
import org.flowable.engine.impl.bpmn.behavior.ParallelMultiInstanceBehavior;
import org.flowable.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.flowable.engine.impl.persistence.entity.AttachmentEntityImpl;
import org.flowable.engine.impl.util.ExecutionGraphUtil;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ActivityInstance;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.engine.task.Attachment;
import org.flowable.engine.task.Comment;
import org.flowable.identitylink.api.IdentityLinkInfo;
import org.flowable.task.api.DelegationState;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.api.history.HistoricTaskInstanceQuery;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.flowable.variable.api.history.HistoricVariableInstanceQuery;
import org.springblade.core.mp.support.Query;
import org.springblade.core.redis.lock.RedisLock;
import org.springblade.core.tool.api.R;
import org.springblade.core.tool.utils.DateUtil;
import org.springblade.core.tool.utils.Func;
import org.springblade.core.tool.utils.StringUtil;
import org.springblade.plugin.workflow.core.constant.WfExtendConstant;
import org.springblade.plugin.workflow.core.query.WfHistoricTaskInstanceQuery;
import org.springblade.plugin.workflow.core.utils.ObjectUtil;
import org.springblade.plugin.workflow.core.utils.WfModelUtil;
import org.springblade.plugin.workflow.core.utils.WfSearchUtil;
import org.springblade.plugin.workflow.design.entity.WfModel;
import org.springblade.plugin.workflow.design.mapper.WfModelMapper;
import org.springblade.plugin.workflow.design.service.IWfSerialService;
import org.springblade.plugin.workflow.process.entity.WfNotice;
import org.springblade.plugin.workflow.process.model.WfNode;
import org.springblade.plugin.workflow.process.model.WfProcess;
import org.springblade.plugin.workflow.core.cache.WfProcessCache;
import org.springblade.plugin.workflow.core.constant.WfProcessConstant;
import org.springblade.plugin.workflow.core.utils.WfTaskUtil;
import org.springblade.plugin.workflow.process.model.WfTaskUser;
import org.springblade.plugin.workflow.process.service.*;
import org.springblade.system.user.cache.UserCache;
import org.springblade.system.user.entity.User;
import org.springblade.system.user.feign.IUserSearchClient;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;

import javax.annotation.Nullable;
import java.util.*;
import java.util.concurrent.Future;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class WfProcessService implements IWfProcessService {

	private final RuntimeService runtimeService;
	private final IdentityService identityService;
	private final HistoryService historyService;
	private final TaskService taskService;
	private final RepositoryService repositoryService;
	private final ProcessEngineConfigurationImpl processEngineConfiguration;

	private final IWfCopyService wfCopyService;
	private final IWfSerialService wfSerialService;
	private final IWfNoticeService wfNoticeService;
	private final IWfDraftService wfDraftService;
	private final IWfExpressionService wfExpressionService;
	private final WfModelMapper wfModelService;

	private final IUserSearchClient userSearchService;

	@Override
	public String startProcessInstanceById(String processDefId, Map<String, Object> variables) {
		String userId = WfTaskUtil.getTaskUser();
		User user = UserCache.getUser(Long.parseLong(userId));
		variables.put(WfProcessConstant.TASK_VARIABLE_APPLY_USER, userId);
		variables.put(WfProcessConstant.TASK_VARIABLE_APPLY_USER_NAME, user.getName());

		ProcessDefinition definition = WfProcessCache.getProcessDefinition(processDefId);
		if (definition == null) {
			throw new RuntimeException("??????????????????????????????");
		}
		// ?????????
		String sn = wfSerialService.getNextSN(definition.getDeploymentId());
		if (!StringUtil.isNotBlank(sn)) {
			variables.put(WfProcessConstant.TASK_VARIABLE_SN, sn);
		}

		// ????????????
		identityService.setAuthenticatedUserId(userId);
		ProcessInstance processInstance = runtimeService.startProcessInstanceById(processDefId, variables);
		try {
			// ???????????????????????????????????????
			runtimeService.setProcessInstanceName(processInstance.getId(), definition.getName());
		} catch (Exception ignore) {
			return processInstance.getId();
		}

		// ????????????????????????
		BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefId);
		String skip = WfModelUtil.getProcessExtensionAttribute(bpmnModel, WfExtendConstant.SKIP_FIRST_NODE);
		if (StringUtil.isNotBlank(skip) && "true".equals(skip)) {
			List<Task> taskList = taskService.createTaskQuery().processInstanceId(processInstance.getId()).list();
			taskList.forEach(task -> taskService.complete(task.getId()));
		}
		// ????????????????????????
		this.handleNextNodeAssignee(processInstance.getId(), variables.get(WfProcessConstant.TASK_VARIABLE_ASSIGNEE));
		// ??????
		wfNoticeService.resolveNoticeInfo(new WfNotice()
			.setFromUserId(userId)
			.setProcessId(processInstance.getId())
			.setType(WfNotice.Type.START));
		// ????????????
		Object copyUser = variables.get(WfProcessConstant.TASK_VARIABLE_COPY_USER);
		if (ObjectUtil.isNotEmpty(copyUser)) {
			List<Task> taskList = taskService.createTaskQuery().processInstanceId(processInstance.getId()).list();
			if (taskList.size() > 0) {
				Task task = taskList.get(0);
				WfProcess process = new WfProcess();
				process.setAssignee(WfTaskUtil.getTaskUser());
				process.setAssigneeName(WfTaskUtil.getNickName());
				process.setTaskId(task.getId());
				process.setTaskName(processInstance.getProcessDefinitionName() + "-" + task.getName());
				process.setProcessInstanceId(processInstance.getId());
				process.setCopyUser(copyUser.toString());
				wfCopyService.resolveCopyUser(process);
			}
		}
		// ???????????????
		wfDraftService.deleteByProcessDefId(processDefId, WfTaskUtil.getTaskUser());

		return processInstance.getId();
	}

	@Override
	public IPage<WfProcess> selectTaskPage(WfProcess process, Query query) {
		IPage<WfProcess> page = new Page<>();

		String taskUser = WfTaskUtil.getTaskUser();
		String taskGroup = WfTaskUtil.getCandidateGroup();

		WfHistoricTaskInstanceQuery taskInstanceQuery = new WfHistoricTaskInstanceQuery(processEngineConfiguration.getCommandExecutor(), processEngineConfiguration.getDatabaseType(), processEngineConfiguration.getTaskServiceConfiguration(), processEngineConfiguration.getVariableServiceConfiguration())
			.orderByTaskCreateTime()
			.desc()
			.taskTenantId(WfTaskUtil.getTenantId());
		String status;
		switch (process.getStatus()) {
			case WfProcessConstant.STATUS_TODO:  // ??????
				taskInstanceQuery
					.or()
					.taskAssignee(taskUser).taskCandidateUser(taskUser).taskCandidateGroupIn(Func.toStrList(taskGroup))
					.endOr()
					.active();
				status = WfProcessConstant.STATUS_TODO;
				break;
			case WfProcessConstant.STATUS_CLAIM:  // ??????
				taskInstanceQuery.taskCandidateUser(taskUser).taskCandidateGroupIn(Func.toStrList(taskGroup)).active();
				status = WfProcessConstant.STATUS_TODO;
				break;
			case WfProcessConstant.STATUS_DONE:  // ??????
				taskInstanceQuery.taskAssignee(taskUser).finished();
				status = WfProcessConstant.STATUS_DONE;
				break;
			default:
				return page;
		}

		if (StringUtil.isNotBlank(process.getProcessDefinitionName())) { // ????????????
			taskInstanceQuery.processDefinitionNameLike("%" + process.getProcessDefinitionName() + "%");
		}
		if (StringUtil.isNotBlank(process.getProcessDefinitionKey())) { // ????????????
			taskInstanceQuery.processDefinitionKey(process.getProcessDefinitionKey());
		}
		if (StringUtil.isNotBlank(process.getSerialNumber())) { // ?????????
			taskInstanceQuery.processVariableValueLike(WfProcessConstant.TASK_VARIABLE_SN, "%" + process.getSerialNumber() + "%");
		}
		if (StringUtil.isNotBlank(process.getStartUsername())) { // ?????????
			taskInstanceQuery.processVariableValueLike(WfProcessConstant.TASK_VARIABLE_APPLY_USER_NAME, "%" + process.getStartUsername() + "%");
		}
		if (StringUtil.isNotBlank(process.getCategory())) { // ??????
			taskInstanceQuery.processCategoryIn(Func.toStrList(process.getCategory()));
		}
		WfSearchUtil.buildSearchQuery(taskInstanceQuery, process.getFormSearch()); // ??????????????????
		long count = taskInstanceQuery.count();
		if (count > 0) {
			List<WfProcess> list = new LinkedList<>();
			buildTaskList(list, taskInstanceQuery, query, status);
			page.setRecords(list);
		}
		page.setTotal(count);
		page.setCurrent(query.getCurrent());
		page.setSize(query.getSize());

		return page;
	}

	@Override
	public IPage<WfProcess> selectProcessPage(WfProcess process, Query query) {
		IPage<WfProcess> page = new Page<>();

		String taskUser = WfTaskUtil.getTaskUser();
		HistoricProcessInstanceQuery historyQuery = historyService.createHistoricProcessInstanceQuery()
			.orderByProcessInstanceStartTime()
			.desc()
			.processInstanceTenantId(WfTaskUtil.getTenantId());

		if (StringUtil.isNotBlank(process.getStatus())) {
			switch (process.getStatus()) {
				case WfProcessConstant.STATUS_SEND: // ????????????
					historyQuery.startedBy(taskUser);
					break;
				case WfProcessConstant.STATUS_DONE: // ??????
					historyQuery.involvedUser(taskUser).finished();
					break;
				case WfProcessConstant.STATUS_FINISH: // ??????
					historyQuery.finished();
					break;
			}
		}
		if (StringUtil.isNotBlank(process.getProcessDefinitionName())) { // ????????????
			historyQuery.processInstanceNameLike("%" + process.getProcessDefinitionName() + "%");
		}
		if (StringUtil.isNotBlank(process.getProcessDefinitionKey())) { // ????????????
			historyQuery.processDefinitionKey(process.getProcessDefinitionKey());
		}
		if (StringUtil.isNotBlank(process.getSerialNumber())) { // ?????????
			historyQuery.variableValueLike(WfProcessConstant.TASK_VARIABLE_SN, "%" + process.getSerialNumber() + "%");
		}
		if (StringUtil.isNotBlank(process.getStartUsername())) { // ?????????
			historyQuery.variableValueLike(WfProcessConstant.TASK_VARIABLE_APPLY_USER_NAME, "%" + process.getStartUsername() + "%");
		}
		if (StringUtil.isNotBlank(process.getCategory())) { // ??????
			historyQuery.processDefinitionCategory(process.getCategory());
		}
		if (StringUtil.isNotBlank(process.getStartTimeRange())) { // ????????????
			String[] dates = Func.toStrArray(process.getStartTimeRange());
			if (dates.length == 2) {
				historyQuery.startedAfter(Func.parseDate(dates[0], DateUtil.PATTERN_DATETIME));
				historyQuery.startedBefore(Func.parseDate(dates[1], DateUtil.PATTERN_DATETIME));
			}
		}
		if (StringUtil.isNotBlank(process.getEndTimeRange())) { // ????????????
			String[] dates = Func.toStrArray(process.getEndTimeRange());
			if (dates.length == 2) {
				historyQuery.finishedAfter(Func.parseDate(dates[0], DateUtil.PATTERN_DATETIME));
				historyQuery.finishedBefore(Func.parseDate(dates[1], DateUtil.PATTERN_DATETIME));
			}
		}
		WfSearchUtil.buildSearchQuery(historyQuery, process.getFormSearch()); // ??????????????????

		if (process.getProcessIsFinished() != null) { // ????????????
			switch (process.getProcessIsFinished()) {
				case WfProcessConstant.STATUS_UNFINISHED:
					historyQuery.unfinished();
					break;
				case WfProcessConstant.STATUS_FINISHED:
					historyQuery.finished();
					break;
				case WfProcessConstant.STATUS_TERMINATE:
					historyQuery.finished();
					historyQuery.variableValueEquals(WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE, "true");
					break;
				case WfProcessConstant.STATUS_WITHDRAW:
					historyQuery.finished();
					historyQuery.variableValueEquals(WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE, WfProcessConstant.STATUS_WITHDRAW);
					break;
				case WfProcessConstant.STATUS_REJECT:
					historyQuery.unfinished();
					historyQuery.variableValueEquals(WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE, WfProcessConstant.STATUS_REJECT);
					break;
				case WfProcessConstant.STATUS_RECALL:
					historyQuery.unfinished();
					historyQuery.variableValueEquals(WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE, WfProcessConstant.STATUS_RECALL);
					break;
			}
		}

		long count = historyQuery.count();
		if (count > 0) {
			List<WfProcess> list = new LinkedList<>();
			buildProcessList(list, historyQuery, query);
			page.setRecords(list);
		}
		page.setTotal(count);
		page.setCurrent(query.getCurrent());
		page.setSize(query.getSize());
		return page;
	}

	@Async
	@Override
	public Future<List<WfProcess>> historyFlowList(String processInstanceId, String startActivityId, String endActivityId) {
		List<WfProcess> flowList = new LinkedList<>();
		List<HistoricActivityInstance> historicActivityInstanceList = historyService.createHistoricActivityInstanceQuery()
			.processInstanceId(processInstanceId)
			.orderByHistoricActivityInstanceStartTime().asc()
			.orderByHistoricActivityInstanceEndTime().asc()
			.list();
		List<Comment> commentList = taskService.getProcessInstanceComments(processInstanceId);
		List<Attachment> attachmentList = taskService.getProcessInstanceAttachments(processInstanceId);
		boolean start = false;
		Map<String, Integer> activityMap = new HashMap<>(16);
		for (int i = 0; i < historicActivityInstanceList.size(); i++) {
			HistoricActivityInstance historicActivityInstance = historicActivityInstanceList.get(i);
			// ??????????????????????????????
			if (StringUtil.isNotBlank(startActivityId) && startActivityId.equals(historicActivityInstance.getActivityId())) {
				start = true;
			}
			if (StringUtil.isNotBlank(startActivityId) && !start) {
				continue;
			}
			// ?????????????????????????????????????????????????????????????????????
			if (WfProcessConstant.USER_TASK.equals(historicActivityInstance.getActivityType())
				|| WfProcessConstant.START_EVENT.equals(historicActivityInstance.getActivityType())
				|| WfProcessConstant.END_EVENT.equals(historicActivityInstance.getActivityType())
				|| WfProcessConstant.SEQUENCE_FLOW.equals(historicActivityInstance.getActivityType())) {
				// ?????????????????????
				Integer activityNum = activityMap.get(historicActivityInstance.getActivityId());
				if (activityNum == null) {
					activityMap.put(historicActivityInstance.getActivityId(), activityMap.size());
				}
				WfProcess flow = new WfProcess();
				flow.setHistoryActivityId(historicActivityInstance.getActivityId());
				flow.setHistoryActivityName(historicActivityInstance.getActivityName());
				flow.setHistoryActivityType(historicActivityInstance.getActivityType());
				flow.setCreateTime(historicActivityInstance.getStartTime());
				flow.setEndTime(historicActivityInstance.getEndTime());
				String durationTime = DateUtil.secondToTime(Func.toLong(historicActivityInstance.getDurationInMillis(), 0L) / 1000);
				flow.setHistoryActivityDurationTime(durationTime);
				// ???????????????????????????
				if (WfProcessConstant.START_EVENT.equals(historicActivityInstance.getActivityType())) {
					List<HistoricProcessInstance> processInstanceList = historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).orderByProcessInstanceStartTime().asc().list();
					if (processInstanceList.size() > 0) {
						if (StringUtil.isNotBlank(processInstanceList.get(0).getStartUserId())) {
							String taskUser = processInstanceList.get(0).getStartUserId();
							User user = UserCache.getUser(WfTaskUtil.getUserId(taskUser));
							if (user != null) {
								flow.setAssignee(historicActivityInstance.getAssignee());
								flow.setAssigneeName(user.getName());
							}
						}
					}
				} else if (WfProcessConstant.USER_TASK.equals(historicActivityInstance.getActivityType())) {
					// ???????????????????????????
					if (StringUtil.isNotBlank(historicActivityInstance.getAssignee())) {
						User user = UserCache.getUser(WfTaskUtil.getUserId(historicActivityInstance.getAssignee()));
						if (user != null) {
							flow.setAssignee(historicActivityInstance.getAssignee());
							flow.setAssigneeName(user.getName());
						}
					} else {
						WfTaskUser taskUser = this.getTaskUser(historicActivityInstance.getProcessDefinitionId(), historicActivityInstance.getProcessInstanceId(), historicActivityInstance.getActivityId());
						List<User> userList = taskUser.getUserList();
						if (ObjectUtil.isNotEmpty(userList)) {
							if (userList.size() == 1) {
								flow.setAssignee(userList.get(0).getId() + "");
								flow.setAssigneeName(userList.get(0).getName());
							} else {
								flow.setAssigneeName(userList.stream().map(User::getName).collect(Collectors.joining("/")));
							}
						}
					}
				}

				// ????????????????????????/??????
				if (StringUtil.isNotBlank(historicActivityInstance.getTaskId())) {
					List<Comment> comments = new ArrayList<>();
					for (Comment comment : commentList) {
						if (comment.getTaskId().equals(historicActivityInstance.getTaskId())) {
							comments.add(comment);
						}
					}
					flow.setComments(comments);

					List<Attachment> attachments = new ArrayList<>();
					for (Attachment attachment : attachmentList) {
						if (attachment.getTaskId().equals(historicActivityInstance.getTaskId())) {
							attachments.add(attachment);
						}
					}
					flow.setAttachments(attachments);
				}
				flowList.add(flow);
			}
			// ??????????????????????????????
			if (StringUtils.isNotBlank(endActivityId) && endActivityId.equals(historicActivityInstance.getActivityId())) {
				boolean temp = false;
				Integer activityNum = activityMap.get(historicActivityInstance.getActivityId());
				// ??????????????????????????????????????????????????????????????????????????????????????????
				for (int j = i + 1; j < historicActivityInstanceList.size(); j++) {
					HistoricActivityInstance hi = historicActivityInstanceList.get(j);
					Integer activityNumA = activityMap.get(hi.getActivityId());
					boolean numberTemp = activityNumA != null && activityNumA < activityNum;
					boolean equalsTemp = StringUtils.equals(hi.getActivityId(), historicActivityInstance.getActivityId());
					if (numberTemp || equalsTemp) {
						temp = true;
					}
				}
				if (!temp) {
					break;
				}
			}
		}
		// ???????????????????????????
		if (historicActivityInstanceList.size() > 0) {
			String processDefId = historicActivityInstanceList.get(0).getProcessDefinitionId();
			String processInsId = historicActivityInstanceList.get(0).getProcessInstanceId();
			HistoricProcessInstance processInstance = historyService.createHistoricProcessInstanceQuery().processInstanceId(processInsId).singleResult();
			if (processInstance.getEndTime() == null) { // ????????????????????????????????????????????????
				BpmnModel model = repositoryService.getBpmnModel(processDefId);

				List<FlowElement> elements = new ArrayList<>();
				model.getMainProcess().getFlowElements().forEach(flowElement -> {
					if (flowElement instanceof UserTask) {
						WfProcess wfProcess = flowList.stream().filter(flow -> flow.getHistoryActivityId().equals(flowElement.getId())).findFirst().orElse(null);
						if (wfProcess == null) {
							elements.add(flowElement);
						}
					}
				});
				if (elements.size() > 0) {
					elements.forEach(element -> {
						WfProcess flow = new WfProcess();
						flow.setHistoryActivityId(element.getId());
						flow.setHistoryActivityName(element.getName());
						flow.setHistoryActivityType(WfProcessConstant.CANDIDATE);
						List<User> userList = this.getTaskUser(processDefId, processInsId, element.getId()).getUserList();
						if (ObjectUtil.isNotEmpty(userList)) {
							flow.setAssigneeName(userList.stream().map(User::getName).collect(Collectors.joining("/")));
						}
						flowList.add(flow);
					});
				}
			}
		}
		return new AsyncResult<>(flowList);
	}

	@Async
	@Override
	public Future<WfProcess> detail(String taskId, String assignee, String candidateGroup) {
		WfProcess process = new WfProcess();

		HistoricTaskInstance task = historyService.createHistoricTaskInstanceQuery() // ????????????
			.taskId(taskId)
			.includeProcessVariables()
//			.includeTaskLocalVariables()
			.includeIdentityLinks()
			.singleResult();
		if (task == null) {
			return new AsyncResult<>(process);
		}
		if (StringUtil.isNotBlank(task.getAssignee())) { // ????????????
			if (assignee.equals(task.getAssignee())) { // ????????????
				if (task.getEndTime() == null) {
					process.setStatus(WfProcessConstant.STATUS_TODO);
				} else {
					process.setStatus(WfProcessConstant.STATUS_DONE);
				}
			} else {
				process.setStatus(WfProcessConstant.STATUS_DONE);
			}
		} else { // ??????????????????
			List<? extends IdentityLinkInfo> identityLinks = task.getIdentityLinks();
			// ?????????
			List<String> roles = new ArrayList<>();
			// ?????????
			List<String> userIds = new ArrayList<>();
			identityLinks.forEach(link -> {
				if (StringUtil.isNotBlank(link.getGroupId())) {
					roles.add(link.getGroupId());
				}
				if (StringUtil.isNotBlank(link.getUserId())) {
					userIds.add(link.getUserId());
				}
			});
			List<String> candidateGroups = Arrays.asList(candidateGroup.split(","));
			if ((userIds.contains(assignee) || roles.stream().anyMatch(candidateGroups::contains)) && task.getEndTime() == null) { // ????????????????????????
				process.setStatus(WfProcessConstant.STATUS_TODO);
			} else {
				process.setStatus(WfProcessConstant.STATUS_DONE);
			}
		}

		process.setIsMultiInstance(this.isMultiInstance(task.getTaskDefinitionKey(), task.getProcessDefinitionId()));
		process.setTaskId(task.getId());
		process.setTaskDefinitionKey(task.getTaskDefinitionKey());
		process.setTaskName(task.getName());
		process.setAssignee(task.getAssignee());
		process.setCreateTime(task.getCreateTime());
		process.setExecutionId(task.getExecutionId());
		process.setHistoryTaskEndTime(task.getEndTime());
		Map<String, Object> variables = task.getProcessVariables();
		variables.putAll(task.getTaskLocalVariables());
		process.setVariables(variables);
		process.setProcessInstanceId(task.getProcessInstanceId());

		ProcessDefinition processDefinition = WfProcessCache.getProcessDefinition(task.getProcessDefinitionId());

		process.setProcessDefinitionId(processDefinition.getId());
		process.setProcessDefinitionName(processDefinition.getName());
		process.setProcessDefinitionKey(processDefinition.getKey());
		process.setProcessDefinitionVersion(processDefinition.getVersion());
		process.setCategory(processDefinition.getCategory());

		HistoricProcessInstance processInstance = historyService.createHistoricProcessInstanceQuery()
			.processInstanceId(task.getProcessInstanceId())
			.singleResult();
		User starter = UserCache.getUser(Long.valueOf(processInstance.getStartUserId()));
		if (starter != null) {
			process.setStartUsername(starter.getName());
		}
		process.setIsOwner(assignee.equals(processInstance.getStartUserId()));
		process.setIsReturnable(this.isReturnable(taskId, assignee));

		// ????????????
		this.setProcessStatus(process, processInstance);

		BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinition.getId());

		try {
			WfModel model = wfModelService.selectOne(new LambdaQueryWrapper<WfModel>().eq(WfModel::getModelKey, processDefinition.getKey()));
			if (model == null) throw new RuntimeException();
			process.setXml(model.getXml());
		} catch (Exception e) {
			process.setXml(new String(new BpmnXMLConverter().convertToXML(bpmnModel)));
		}

		if (process.getStatus().equals(WfProcessConstant.STATUS_TODO)) { // ???????????????????????????
			String taskKey = task.getTaskDefinitionKey();

			// ????????????????????????
			String hideAttachment = WfModelUtil.getUserTaskExtensionAttribute(taskKey, bpmnModel, WfExtendConstant.HIDE_ATTACHMENT);
			if (StringUtil.isNotBlank(hideAttachment) && "true".equals(hideAttachment)) {
				process.setHideAttachment(true);
			}

			// ?????????????????????
			String hideCopy = WfModelUtil.getUserTaskExtensionAttribute(taskKey, bpmnModel, WfExtendConstant.HIDE_COPY);
			if (StringUtil.isNotBlank(hideCopy) && "true".equals(hideCopy)) {
				process.setHideCopy(true);
			}

			// ??????????????????????????????
			String hideExamine = WfModelUtil.getUserTaskExtensionAttribute(taskKey, bpmnModel, WfExtendConstant.HIDE_EXAMINE);
			if (StringUtil.isNotBlank(hideExamine) && "true".equals(hideExamine)) {
				process.setHideExamine(true);
			}

			// ???????????????
			List<ExtensionElement> copyUsers = WfModelUtil.getUserTaskExtensionElements(taskKey, bpmnModel, WfExtendConstant.COPY_USER);
			if (copyUsers != null && copyUsers.size() > 0) {
				List<String> values = new ArrayList<>();
				List<String> texts = new ArrayList<>();
				copyUsers.forEach(copyUser -> {
					String value = copyUser.getAttributes().get("value").get(0).getValue();
					String text = copyUser.getAttributes().get("text").get(0).getValue();
					if (StringUtil.isNoneBlank(value, text)) {
						values.add(value);
						texts.add(text);
					}
				});
				if (values.size() > 0 && texts.size() > 0) {
					process.setCopyUser(String.join(",", values));
					process.setCopyUserName(String.join(",", texts));
				}
			}
		}

		return new AsyncResult<>(process);
	}

	@Override
	@RedisLock(value = "WfTaskLock", param = "#process.taskId")
	public Object completeTask(WfProcess process) {
		String taskId = process.getTaskId();

		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return R.fail("?????????????????????");
		}
		taskService.setVariable(task.getId(), WfProcessConstant.PASS_KEY, process.isPass());
		process.setTaskName(process.getProcessDefinitionName() + "-" + task.getName());
		process.setAssigneeName(WfTaskUtil.getNickName());
		process.setTaskDefinitionKey(task.getTaskDefinitionKey());

		if (process.isPass()) { // ????????????
			this.passTask(process, task);
		} else { // ???????????????
			this.rejectTask(process);
		}

		// ????????????
		if (StringUtil.isNotBlank(process.getCopyUser())) {
			process.setAssignee(WfTaskUtil.getTaskUser());
			wfCopyService.resolveCopyUser(process);
		}

		return R.success("????????????");
	}

	@Override
	@RedisLock(value = "WfTaskLock", param = "#process.taskId")
	public Object transferTask(WfProcess process) {
		String taskId = process.getTaskId();
		String acceptUser = process.getAssignee();
		String comment = process.getComment();
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return R.fail("?????????????????????");
		}
		if (StringUtil.isNotBlank(comment)) {
			User fromUser = UserCache.getUser(Long.valueOf(WfTaskUtil.getTaskUser()));
			User toUser = UserCache.getUser(Long.valueOf(acceptUser));
			if (fromUser != null && toUser != null) {
				comment = fromUser.getName() + "???" + toUser.getName() + "???" + comment;
			}
			taskService.addComment(taskId, task.getProcessInstanceId(), WfProcessConstant.COMMENT_TYPE_TRANSFER, comment);
		}
		// ????????????
		List<AttachmentEntityImpl> attachment = process.getAttachment();
		if (ObjectUtil.isNotEmpty(attachment)) {
			identityService.setAuthenticatedUserId(WfTaskUtil.getTaskUser());
			String finalComment = comment;
			attachment.forEach(att -> taskService.saveAttachment(taskService.createAttachment(WfProcessConstant.COMMENT_TYPE_TRANSFER, taskId, task.getProcessInstanceId(), att.getName(), finalComment, att.getUrl())));
		}
		taskService.removeVariable(taskId, WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE); // ????????????/????????????
		taskService.setOwner(taskId, WfTaskUtil.getTaskUser());
		taskService.setAssignee(taskId, acceptUser);

		// ????????????
		if (StringUtil.isNotBlank(process.getCopyUser())) {
			process.setTaskName(process.getProcessDefinitionName() + "-" + task.getName());
			process.setAssigneeName(WfTaskUtil.getNickName());
			process.setAssignee(WfTaskUtil.getTaskUser());
			wfCopyService.resolveCopyUser(process);
		}

		// ????????????
		wfNoticeService.resolveNoticeInfo(new WfNotice()
			.setFromUserId(WfTaskUtil.getTaskUser())
			.setToUserId(acceptUser)
			.setProcessId(task.getProcessInstanceId())
			.setTaskId(taskId)
			.setComment(comment)
			.setType(WfNotice.Type.TRANSFER));
		return R.success("????????????");
	}

	@Override
	@RedisLock(value = "WfTaskLock", param = "#process.taskId")
	public Object delegateTask(WfProcess process) {
		String taskId = process.getTaskId();
		String acceptUser = process.getAssignee();
		String comment = process.getComment();
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return R.fail("?????????????????????");
		}
		if (StringUtil.isNotBlank(comment)) {
			User fromUser = UserCache.getUser(Long.valueOf(WfTaskUtil.getTaskUser()));
			User toUser = UserCache.getUser(Long.valueOf(acceptUser));
			if (fromUser != null && toUser != null) {
				comment = fromUser.getName() + "???" + toUser.getName() + "???" + comment;
			}
			taskService.addComment(taskId, task.getProcessInstanceId(), WfProcessConstant.COMMENT_TYPE_DELEGATE, comment);
		}
		// ????????????
		List<AttachmentEntityImpl> attachment = process.getAttachment();
		if (ObjectUtil.isNotEmpty(attachment)) {
			identityService.setAuthenticatedUserId(WfTaskUtil.getTaskUser());
			String finalComment = comment;
			attachment.forEach(att -> taskService.saveAttachment(taskService.createAttachment(WfProcessConstant.COMMENT_TYPE_DELEGATE, taskId, task.getProcessInstanceId(), att.getName(), finalComment, att.getUrl())));
		}
		taskService.removeVariable(taskId, WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE); // ????????????/????????????
		taskService.setOwner(taskId, WfTaskUtil.getTaskUser());
		taskService.delegateTask(taskId, acceptUser);

		// ????????????
		if (StringUtil.isNotBlank(process.getCopyUser())) {
			process.setTaskName(process.getProcessDefinitionName() + "-" + task.getName());
			process.setAssigneeName(WfTaskUtil.getNickName());
			process.setAssignee(WfTaskUtil.getTaskUser());
			wfCopyService.resolveCopyUser(process);
		}

		// ????????????
		wfNoticeService.resolveNoticeInfo(new WfNotice()
			.setFromUserId(WfTaskUtil.getTaskUser())
			.setToUserId(acceptUser)
			.setProcessId(task.getProcessInstanceId())
			.setTaskId(taskId)
			.setComment(comment)
			.setType(WfNotice.Type.DELEGATE));
		return R.success("????????????");
	}

	@Override
	@RedisLock(value = "WfTaskLock", param = "#process.taskId")
	public Object claimTask(String taskId) {
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return R.fail("?????????????????????");
		}
		taskService.claim(taskId, WfTaskUtil.getTaskUser());
		return R.success("????????????");
	}

	@Override
	public List<WfNode> getBackNodes(WfProcess wfProcess) {
		String taskId = wfProcess.getTaskId();
		String processInstanceId = wfProcess.getProcessInstanceId();
		HistoricTaskInstance task = historyService.createHistoricTaskInstanceQuery().taskId(taskId).singleResult();

		String currActId = task.getTaskDefinitionKey();
		String processDefinitionId = task.getProcessDefinitionId();
		Process process = repositoryService.getBpmnModel(processDefinitionId).getMainProcess();
		FlowNode currentFlowElement = (FlowNode) process.getFlowElement(currActId, true);
		List<HistoricActivityInstance> activities = historyService.createHistoricActivityInstanceQuery().processInstanceId(processInstanceId).finished().orderByHistoricActivityInstanceStartTime().asc().list();
		List<String> activityIds =
			activities.stream().filter(activity -> activity.getActivityType().equals(BpmnXMLConstants.ELEMENT_TASK_USER) || activity.getActivityType().equals(BpmnXMLConstants.ELEMENT_EVENT_START)).map(HistoricActivityInstance::getActivityId).filter(activityId -> !activityId.equals(currActId)).distinct().collect(Collectors.toList());
		List<WfNode> result = new ArrayList<>();
		for (String activityId : activityIds) {
			FlowNode toBackFlowElement = (FlowNode) process.getFlowElement(activityId, true);
			if (toBackFlowElement != null && ExecutionGraphUtil.isReachable(process, toBackFlowElement, currentFlowElement, Sets.newHashSet())) {
				WfNode vo = new WfNode();
				vo.setNodeName(toBackFlowElement.getName());
				vo.setNodeId(activityId);
				result.add(vo);
			}
		}
		return result;
	}

	@Override
	@RedisLock(value = "WfTaskLock", param = "#process.taskId")
	public Object rollbackTask(WfProcess process) {
		String taskId = process.getTaskId();
		String nodeId = process.getNodeId();
		String comment = process.getComment();
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return R.fail("?????????????????????");
		}
		if (StringUtil.isBlank(task.getAssignee())) {
			taskService.claim(taskId, WfTaskUtil.getTaskUser());
		}

		ActivityInstance targetRealActivityInstance = runtimeService
			.createActivityInstanceQuery()
			.processInstanceId(task.getProcessInstanceId())
			.activityId(nodeId).list().get(0);
		if (targetRealActivityInstance.getActivityType().equals(BpmnXMLConstants.ELEMENT_EVENT_START)) {
			process.setProcessInstanceId(task.getProcessInstanceId());
			this.terminateProcess(process);
		} else {
			if (StringUtil.isNoneBlank(comment)) { // ????????????
				taskService.addComment(taskId, task.getProcessInstanceId(), WfProcessConstant.COMMENT_TYPE_ROLLBACK, comment);
			}
			List<AttachmentEntityImpl> attachment = process.getAttachment();
			if (ObjectUtil.isNotEmpty(attachment)) { // ??????????????????
				identityService.setAuthenticatedUserId(WfTaskUtil.getTaskUser());
				attachment.forEach(att -> taskService.saveAttachment(taskService.createAttachment(WfProcessConstant.COMMENT_TYPE_ROLLBACK, taskId, task.getProcessInstanceId(), att.getName(), comment, att.getUrl())));
			}
			taskService.setVariable(taskId, WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE, WfProcessConstant.STATUS_REJECT); // ??????????????????

			BpmnModel model = repositoryService.getBpmnModel(task.getProcessDefinitionId());

			// ????????????????????????????????? ???????????????????????????
			if (model != null) {
				String backToRejecter = WfModelUtil.getUserTaskExtensionAttribute(process.getNodeId(), model, WfExtendConstant.BACK_TO_REJECTER);
				if (StringUtil.isNotBlank(backToRejecter) && "true".equals(backToRejecter)) {
					taskService.setVariable(taskId, WfExtendConstant.BACK_TO_REJECTER, task.getTaskDefinitionKey());
				}
			}

//			this.dispatchTaskTo(task.getProcessInstanceId(), nodeId);

			UserTask userTask = WfModelUtil.getUserTaskByKey(task.getTaskDefinitionKey(), model);
			boolean isParallelGateway = false;
			if (userTask != null) {
				List<SequenceFlow> incomingFlows = userTask.getIncomingFlows();
				for (SequenceFlow sequenceFlow : incomingFlows) {
					FlowElement element = sequenceFlow.getSourceFlowElement();
					if (element instanceof ParallelGateway || element instanceof InclusiveGateway) {
						isParallelGateway = true;
						break;
					}
				}
			}
			if (isParallelGateway) {
				this.dispatchTaskTo(task.getProcessInstanceId(), nodeId);
			} else {
				runtimeService.createChangeActivityStateBuilder()
					.processInstanceId(task.getProcessInstanceId())
					.moveActivityIdTo(task.getTaskDefinitionKey(), nodeId).changeState();
			}

			// ????????????
			wfNoticeService.resolveNoticeInfo(new WfNotice()
				.setFromUserId(WfTaskUtil.getTaskUser())
				.setProcessId(task.getProcessInstanceId())
				.setTaskId(taskId)
				.setComment(comment)
				.setType(WfNotice.Type.REJECT));
		}

		return R.success("????????????");
	}

	@Override
	@RedisLock(value = "WfTaskLock", param = "#process.taskId")
	public Object terminateProcess(WfProcess process) {
		String taskId = process.getTaskId();
		String comment = process.getComment();
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return R.fail("?????????????????????");
		}
		BpmnModel model = repositoryService.getBpmnModel(task.getProcessDefinitionId());
		EndEvent endEvent = WfModelUtil.getEndEvent(model);
		if (endEvent == null) {
			return R.fail("????????????????????????");
		}
		if (StringUtil.isBlank(task.getAssignee())) {
			taskService.claim(taskId, WfTaskUtil.getTaskUser());
		}
		// ??????????????????
		taskService.setVariable(taskId, WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE, "true");
		// ????????????
		if (StringUtil.isNoneBlank(task.getProcessInstanceId(), comment)) {
			taskService.addComment(taskId, task.getProcessInstanceId(), WfProcessConstant.COMMENT_TYPE_TERMINATE, comment);
		}
		// ????????????
		List<AttachmentEntityImpl> attachment = process.getAttachment();
		if (ObjectUtil.isNotEmpty(attachment)) {
			identityService.setAuthenticatedUserId(WfTaskUtil.getTaskUser());
			attachment.forEach(att -> taskService.saveAttachment(taskService.createAttachment(WfProcessConstant.COMMENT_TYPE_TERMINATE, taskId, task.getProcessInstanceId(), att.getName(), comment, att.getUrl())));
		}
		this.dispatchTaskTo(task.getProcessInstanceId(), endEvent.getId());

		// ????????????
		wfNoticeService.resolveNoticeInfo(new WfNotice()
			.setFromUserId(WfTaskUtil.getTaskUser())
			.setProcessId(task.getProcessInstanceId())
			.setTaskId(taskId)
			.setComment(comment)
			.setType(WfNotice.Type.TERMINATE));

		return R.success("????????????");
	}

	@Override
	@RedisLock(value = "WfTaskLock", param = "#process.taskId")
	public Object addMultiInstance(WfProcess process) {
		String taskId = process.getTaskId();
		String comment = StringUtil.isBlank(process.getComment()) ? "" : process.getComment() + " - ";

		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return R.fail("?????????????????????");
		}
		String assignee = process.getAssignee();
		String[] ids = assignee.split(",");
		List<String> usernames = new ArrayList<>();
		for (String id : ids) {
			User user = UserCache.getUser(Long.valueOf(id));
			if (user == null) continue;

			// ????????????
			runtimeService.addMultiInstanceExecution(task.getTaskDefinitionKey(), task.getProcessInstanceId(), Collections.singletonMap("assignee", id));

			usernames.add(user.getName());
			// ????????????
			wfNoticeService.resolveNoticeInfo(new WfNotice()
				.setFromUserId(WfTaskUtil.getTaskUser())
				.setToUserId(id)
				.setProcessId(task.getProcessInstanceId())
				.setTaskId(taskId)
				.setComment(comment)
				.setType(WfNotice.Type.ADD_MULTI_INSTANCE));
		}
		// ????????????
		if (StringUtil.isBlank(comment) || comment.contains("??????????????????")) {
			comment += Func.join(usernames);
			taskService.addComment(taskId, task.getProcessInstanceId(), WfProcessConstant.COMMENT_TYPE_ADD_MULTI_INSTANCE, comment);
		}
		// ????????????
		List<AttachmentEntityImpl> attachment = process.getAttachment();
		if (ObjectUtil.isNotEmpty(attachment)) {
			identityService.setAuthenticatedUserId(WfTaskUtil.getTaskUser());
			String finalComment = comment;
			attachment.forEach(att -> taskService.saveAttachment(taskService.createAttachment(WfProcessConstant.COMMENT_TYPE_ADD_MULTI_INSTANCE, taskId, task.getProcessInstanceId(), att.getName(), finalComment, att.getUrl())));
		}
		return R.success("????????????");
	}

	@Override
	@RedisLock(value = "WfTaskLock", param = "#process.taskId")
	public Object withdrawTask(WfProcess process) {
		String taskId = process.getTaskId();
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return R.fail("?????????????????????");
		}
		String currentUser = WfTaskUtil.getTaskUser();
		Boolean isRevocable = this.isReturnable(taskId, currentUser);
		if (!isRevocable) {
			return R.fail("?????????????????????");
		}
		BpmnModel model = repositoryService.getBpmnModel(task.getProcessDefinitionId());
		if (WfProcessConstant.WITHDRAW_TYPE_START.equals(process.getWithdrawType())) { // ????????????
			StartEvent startEvent = WfModelUtil.getStartEvent(model);
			if (startEvent != null) {
				List<SequenceFlow> outgoingFlows = startEvent.getOutgoingFlows();
				for (SequenceFlow outgoingFlow : outgoingFlows) {
					FlowElement targetFlowElement = outgoingFlow.getTargetFlowElement();
					if (targetFlowElement instanceof UserTask) {
						UserTask userTask = (UserTask) targetFlowElement;
						WfTaskUser taskUser = this.getTaskUser(task.getProcessDefinitionId(), task.getProcessInstanceId(), userTask.getId());
						List<User> userList = taskUser.getUserList();
						if (userList.size() == 1 && currentUser.equals(userList.get(0).getId() + "")) {
							// ??????????????????????????????
							taskService.setVariable(taskId, WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE, WfProcessConstant.STATUS_RECALL);
							// ????????????
							taskService.addComment(taskId, task.getProcessInstanceId(), WfProcessConstant.COMMENT_TYPE_RECALL, "??????????????????");
							this.dispatchTaskTo(task.getProcessInstanceId(), userTask.getId());
							return R.success("????????????");
						}
					}
				}
			}
		}
		EndEvent endEvent = WfModelUtil.getEndEvent(model);
		if (endEvent == null) {
			return R.fail("????????????????????????");
		}
		// ????????????????????????
		taskService.setVariable(taskId, WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE, WfProcessConstant.STATUS_WITHDRAW);
		// ????????????
		taskService.addComment(taskId, task.getProcessInstanceId(), WfProcessConstant.COMMENT_TYPE_WITHDRAW, "????????????");
		this.dispatchTaskTo(task.getProcessInstanceId(), endEvent.getId());

		return R.success("????????????");
	}

	@Override
	public Boolean isReturnable(String taskId, String currentUser) {
		Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
		if (task == null) {
			return false;
		}
		ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(task.getProcessInstanceId()).singleResult();
		if (processInstance == null) {
			return false;
		}
		if (!currentUser.equals(processInstance.getStartUserId())) { // ???????????????????????????
			return false;
		}
		HistoricTaskInstanceQuery query = historyService.createHistoricTaskInstanceQuery()
			.processInstanceId(task.getProcessInstanceId())
			.taskWithoutDeleteReason()
			.finished();

		// ======start======???????????????????????????????????????????????????????????????======
		long count = query.count();
		if (count > 1) {
			return false;
		}
		// ======end======

		List<HistoricTaskInstance> list = query.list();
		for (HistoricTaskInstance t : list) { // ?????????????????????????????????????????????????????????????????????????????????
			if (StringUtil.isNotBlank(t.getAssignee())) {
				if (!currentUser.equals(t.getAssignee())) {
					return false;
				}
			} else {
				WfTaskUser taskUser = this.getTaskUser(t.getProcessDefinitionId(), t.getProcessInstanceId(), t.getTaskDefinitionKey());
				List<User> userList = taskUser.getUserList();
				if (userList.size() != 1) { // ????????????/?????????????????????
					return false;
				}
				if (!currentUser.equals(userList.get(0).getId() + "")) {
					return false;
				}
			}
		}
		return true;
	}

	@Override
	public Boolean isMultiInstance(String taskKey, String processDefId) {
		boolean isMultiInstance = false;

		BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefId);
		Process process = bpmnModel.getMainProcess();
		FlowElement flowElement = process.getFlowElement(taskKey, true);
		if (flowElement instanceof UserTask) {
			UserTask userTask = (UserTask) flowElement;
			if (userTask.getBehavior() instanceof ParallelMultiInstanceBehavior) {
				ParallelMultiInstanceBehavior behavior = (ParallelMultiInstanceBehavior) userTask.getBehavior();
				if (behavior != null && behavior.getCollectionExpression() != null) {
					isMultiInstance = true;
				}
			}
		}
		return isMultiInstance;
	}

	@Override
	public WfTaskUser getTaskUser(String processDefId, @Nullable String processInsId, String nodeId) {
		WfTaskUser taskUser = new WfTaskUser();

		BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefId);
		if (bpmnModel == null) {
			return taskUser;
		}

		List<ExtensionElement> elements = WfModelUtil.getUserTaskExtensionElements(nodeId, bpmnModel, WfExtendConstant.ASSIGNEE);
		if (elements == null) {
			elements = WfModelUtil.getSubProcessExtensionElements(nodeId, bpmnModel, WfExtendConstant.ASSIGNEE); // ?????????
			if (elements == null) {
				return taskUser;
			}
		}

		// ?????? - ?????? ?????????candidateUserIds????????????????????????
		// ??????/??????/?????? ?????????candidateGroupIds????????????????????????
		// ?????? - ?????? ?????????assignee???????????????????????????????????????assignee??????????????????????????????????????????
		// userList????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
		// Q??????????????????????????????????????????????????????????????????????????? A????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
		LinkedHashSet<User> userList = new LinkedHashSet<>(); // ?????????????????????????????????????????????????????????????????????????????????
		LinkedHashSet<String> candidateUserIds = new LinkedHashSet<>(); // ??????????????????
		LinkedHashSet<String> candidateGroupIds = new LinkedHashSet<>(); // ???????????????
		String assignee = null; // ???????????????

		for (ExtensionElement element : elements) {
			String type = element.getAttributes().get("type").get(0).getValue();
			String value = element.getAttributes().get("value").get(0).getValue();

			switch (type) {
				case "role": // ??????
					candidateGroupIds.addAll(Func.toStrList(value));
					userList.addAll(userSearchService.listByRole(value).getData());
					break;
				case "dept": // ??????
					candidateGroupIds.addAll(Func.toStrList(value));
					userList.addAll(userSearchService.listByDept(value).getData());
					break;
				case "post": // ??????
					candidateGroupIds.addAll(Func.toStrList(value));
					userList.addAll(userSearchService.listByPost(value).getData());
					break;
				case "user": // ??????
					candidateUserIds.addAll(Func.toStrList(value));
					userList.addAll(userSearchService.listByUser(value).getData());
					break;
				case "custom": // ?????????
					if (StringUtil.isBlank(processInsId)) {
						break;
					}

					switch (value) {
						case "currentUser": // ???????????????
							userList.addAll(userSearchService.listByUser(WfTaskUtil.getTaskUser()).getData());
							assignee = WfTaskUtil.getTaskUser();
							break;
						case "${assignee}":
							assignee = "${assignee}";
							break;
						case "leader": // ????????????????????????
							userList.addAll(userSearchService.listByUser("1123598821738675201").getData());
							assignee = "1123598821738675201";
							break;
						default:
							List<User> users = new ArrayList<>();
							if ((!value.startsWith("${") && !value.startsWith("#{") && !value.endsWith("}"))) {
								value = String.format("${%s}", value);
							}
							try {
								// flowable???????????????
								Object defaultVal = wfExpressionService.getValue(processInsId, value);
								if (defaultVal != null) {
									// id1,id2,id3,...
									if (defaultVal instanceof String) {
										users = userSearchService.listByUser(defaultVal.toString()).getData();
									}
									// [User1, User2, User3, ...]
									else if (defaultVal instanceof List && !((List) defaultVal).isEmpty() && ((List) defaultVal).get(0) instanceof User) {
										users = JSON.parseArray(JSON.toJSONString(defaultVal), User.class);
									}
									// String [id1, id2, id3, ...]
									else if (defaultVal instanceof List && !((List) defaultVal).isEmpty() && ((List) defaultVal).get(0) instanceof String) {
										List<String> ids = JSON.parseArray(JSON.toJSONString(defaultVal), String.class);
										users = userSearchService.listByUser(Func.join(ids)).getData();
									}
									// Long [id1, id2, id3, ...]
									else if (defaultVal instanceof List && !((List) defaultVal).isEmpty() && ((List) defaultVal).get(0) instanceof Long) {
										List<Long> ids = JSON.parseArray(JSON.toJSONString(defaultVal), Long.class);
										users = userSearchService.listByUser(Func.join(ids)).getData();
									}
								}
							} catch (Exception ignore) {

							}
							if (ObjectUtil.isNotEmpty(users) && !users.isEmpty()) {
								userList.addAll(users);
								candidateUserIds.addAll(users.stream().map(u -> u.getId() + "").collect(Collectors.toSet()));
							}

							break;
					}
					break;
			}
		}
		taskUser.setUserList(new ArrayList<>(userList));
		taskUser.setAssignee(assignee);
		taskUser.setCandidateUserIds(candidateUserIds);
		taskUser.setCandidateGroupIds(candidateGroupIds);

		return taskUser;
	}

	@Override
	public void dispatchTaskTo(String processInsId, String nodeId) {
		List<Execution> executions = runtimeService.createExecutionQuery().parentId(processInsId).list();
		List<String> executionIds = new ArrayList<>();
		executions.forEach(execution -> executionIds.add(execution.getId()));
		runtimeService.createChangeActivityStateBuilder().moveExecutionsToSingleActivityId(executionIds, nodeId).changeState();
	}

	@Override
	public void setProcessStatus(WfProcess process, HistoricProcessInstance processInstance) {
		if (processInstance.getEndTime() == null) {
			process.setProcessIsFinished(WfProcessConstant.STATUS_UNFINISHED);
		} else {
			process.setProcessIsFinished(WfProcessConstant.STATUS_FINISHED);
		}
		HistoricVariableInstanceQuery variableInstanceQuery = historyService.createHistoricVariableInstanceQuery().processInstanceId(processInstance.getId());
		HistoricVariableInstance terminate = variableInstanceQuery.variableName(WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE).singleResult();
		if (ObjectUtil.isNotEmpty(terminate) && ObjectUtil.isNotEmpty(terminate.getValue())) {
			String processIsFinished = terminate.getValue().toString();
			if ("true".equals(processIsFinished)) processIsFinished = WfProcessConstant.STATUS_TERMINATE;
			process.setProcessIsFinished(processIsFinished);
		}
	}

	/**
	 * ????????????
	 */
	private void passTask(WfProcess process, Task task) {
		String taskId = task.getId();
		String processInstanceId = process.getProcessInstanceId();
		String processDefinitionId = process.getProcessDefinitionId();
		String assignee = process.getAssignee();
		String comment = process.getComment();

		// ????????????
		Map<String, Object> variables = process.getVariables();
		if (variables == null) {
			variables = new HashMap<>();
		}
//		variables.put(WfProcessConstant.PASS_KEY, process.isPass());

		if (StringUtil.isNoneBlank(processInstanceId, comment)) { // ????????????
			taskService.addComment(taskId, processInstanceId, comment);
		}
		List<AttachmentEntityImpl> attachment = process.getAttachment();
		if (ObjectUtil.isNotEmpty(attachment)) { // ??????????????????
			identityService.setAuthenticatedUserId(WfTaskUtil.getTaskUser());
			String finalComment = comment;
			attachment.forEach(att -> taskService.saveAttachment(taskService.createAttachment(WfProcessConstant.COMMENT_TYPE_COMMENT, taskId, task.getProcessInstanceId(), att.getName(), finalComment, att.getUrl())));
		}

		taskService.removeVariable(taskId, WfProcessConstant.TASK_VARIABLE_PROCESS_TERMINATE); // ????????????/????????????

		boolean needComplete = true;
		// ???????????????????????????
		Object nodeId = runtimeService.getVariable(processInstanceId, WfExtendConstant.BACK_TO_REJECTER);
		if (ObjectUtil.isNotEmpty(nodeId) && StringUtil.isNotBlank(processDefinitionId)) {
			BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);
			String backToRejecter = WfModelUtil.getUserTaskExtensionAttribute(task.getTaskDefinitionKey(), bpmnModel, WfExtendConstant.BACK_TO_REJECTER);
			if (StringUtil.isNotBlank(backToRejecter) && "true".equals(backToRejecter)) {
				taskService.setVariables(taskId, variables);
				this.dispatchTaskTo(processInstanceId, nodeId.toString());
				runtimeService.removeVariable(processInstanceId, WfExtendConstant.BACK_TO_REJECTER);
				needComplete = false;
			}
		}

		if (needComplete) {
			if (StringUtil.isNotBlank(task.getOwner())) { // ??????/???????????????owner
				DelegationState delegationState = task.getDelegationState();
				if (delegationState != null) {
					switch (delegationState) {
						case PENDING: // ???????????????????????????????????????????????????????????????????????????????????????
							if (StringUtil.isEmpty(comment)) { // ??????????????????????????????????????????????????????????????????????????????
								comment = WfTaskUtil.getNickName() + "?????????";
								taskService.addComment(taskId, processInstanceId, comment);
							}
							taskService.resolveTask(taskId, variables);
//						taskService.complete(taskId, variables);
							break;
						case RESOLVED: // ???????????????
						default: // ?????????
							taskService.complete(taskId, variables);
							break;
					}
				} else {
					taskService.complete(taskId, variables);
				}
			} else if (StringUtil.isEmpty(task.getAssignee())) { // ????????????????????????
				this.claimTask(taskId);
				taskService.complete(taskId, variables);
			} else {
				taskService.complete(taskId, variables);
			}
		}

		// ????????????????????????
		this.handleNextNodeAssignee(processInstanceId, assignee);
		// ????????????
		wfNoticeService.resolveNoticeInfo(new WfNotice()
			.setFromUserId(WfTaskUtil.getTaskUser())
			.setProcessId(processInstanceId)
			.setTaskId(taskId)
			.setComment(comment)
			.setTaskVariables(variables)
			.setType(WfNotice.Type.PASS));
	}

	/**
	 * ???????????????
	 */
	private void rejectTask(WfProcess process) {
		String taskId = process.getTaskId();
		String taskKey = process.getTaskDefinitionKey();
		String processInstanceId = process.getProcessInstanceId();
		String processDefinitionId = process.getProcessDefinitionId();
		String rollbackNode = null;

		if (StringUtil.isNotBlank(processDefinitionId)) {
			BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);

			// ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
			List<ExtensionAttribute> attributes;
			rollbackNode = WfModelUtil.getUserTaskExtensionAttribute(taskKey, bpmnModel, WfExtendConstant.ROLLBACK_NODE);
			if (StringUtil.isEmpty(rollbackNode)) {
				attributes = WfModelUtil.getProcessExtensionAttributes(bpmnModel, WfExtendConstant.ROLLBACK_NODE);
				if (attributes != null) {
					rollbackNode = attributes.get(0).getValue();
				}
			}
		}
		List<WfNode> backNodes = this.getBackNodes(process);
		if (backNodes.size() > 0) {
			String finalRollbackNode = rollbackNode;
			// ??????????????????????????????????????????????????????????????????????????????
			if (StringUtil.isNotBlank(rollbackNode) && backNodes.stream().filter(wfNode -> wfNode.getNodeId().equals(finalRollbackNode)).findAny().orElse(null) != null) {
				process.setNodeId(rollbackNode);
			} else {
				WfNode node = backNodes.get(backNodes.size() - 1);
				process.setNodeId(node.getNodeId());
			}
			this.rollbackTask(process);
		}
	}

	private void buildProcessList(List<WfProcess> wfProcessList, HistoricProcessInstanceQuery historyQuery, Query query) {
		// ????????????
		List<HistoricProcessInstance> historyList;
		if (query == null || query.getSize() == -1) {
			historyList = historyQuery.list();
		} else {
			historyList = historyQuery.listPage(Func.toInt((query.getCurrent() - 1) * query.getSize()), Func.toInt(query.getSize()));
		}

		historyList.forEach(historicProcessInstance -> {
			WfProcess process = new WfProcess();
			// historicProcessInstance
			User user = UserCache.getUser(Long.valueOf(historicProcessInstance.getStartUserId()));
			if (user != null) {
				process.setStartUsername(user.getName());
			}
			process.setCreateTime(historicProcessInstance.getStartTime());
			process.setEndTime(historicProcessInstance.getEndTime());
			process.setProcessInstanceId(historicProcessInstance.getId());
			process.setHistoryProcessInstanceId(historicProcessInstance.getId());
			// Variables
			Map<String, Object> variables = new HashMap<>();
			HistoricVariableInstanceQuery variableInstanceQuery = historyService.createHistoricVariableInstanceQuery()
				.processInstanceId(historicProcessInstance.getId());
			HistoricVariableInstance sn = variableInstanceQuery.variableName(WfProcessConstant.TASK_VARIABLE_SN).singleResult();
			if (ObjectUtil.isNotEmpty(sn)) {
				variables.put(WfProcessConstant.TASK_VARIABLE_SN, sn.getValue());
			}
			process.setVariables(variables);
			// ProcessDefinition
			ProcessDefinition processDefinition = WfProcessCache.getProcessDefinition(historicProcessInstance.getProcessDefinitionId());
			process.setProcessDefinitionId(processDefinition.getId());
			process.setProcessDefinitionName(processDefinition.getName());
			process.setProcessDefinitionKey(processDefinition.getKey());
			process.setCategory(processDefinition.getCategory());
			// HistoricTaskInstance
			List<HistoricTaskInstance> historyTasks = historyService.createHistoricTaskInstanceQuery()
				.processInstanceId(historicProcessInstance.getId())
				.orderByTaskCreateTime().desc()
				.orderByHistoricTaskInstanceEndTime().desc()
				.list();
			if (Func.isNotEmpty(historyTasks)) {
				HistoricTaskInstance historyTask = historyTasks.iterator().next();
				process.setTaskId(historyTask.getId());
				process.setTaskName(historyTask.getName());

				BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinition.getId());
				String exFormKey = WfModelUtil.getUserTaskExtensionAttribute(historyTask.getTaskDefinitionKey(), bpmnModel, WfExtendConstant.EX_FORM_KEY);
				if (StringUtil.isNotBlank(exFormKey)) {
					process.setFormKey(WfProcessConstant.EX_FORM_PREFIX + exFormKey);
				}

				String exFormUrl = WfModelUtil.getUserTaskExtensionAttribute(historyTask.getTaskDefinitionKey(), bpmnModel, WfExtendConstant.EX_FORM_URL);
				if (StringUtil.isNotBlank(exFormUrl)) {
					process.setFormUrl(exFormUrl);
				}

				String exAppFormUrl = WfModelUtil.getUserTaskExtensionAttribute(historyTask.getTaskDefinitionKey(), bpmnModel, WfExtendConstant.EX_APP_FORM_URL);
				if (StringUtil.isNotBlank(exAppFormUrl)) {
					process.setAppFormUrl(exAppFormUrl);
				}
			}
			// Status
			if (historicProcessInstance.getEndActivityId() != null) process.setTaskName("??????");
			this.setProcessStatus(process, historicProcessInstance);
			wfProcessList.add(process);
		});
	}

	private void buildTaskList(List<WfProcess> wfProcessList, WfHistoricTaskInstanceQuery historyQuery, Query query, String status) {
		// ????????????
		List<HistoricTaskInstance> historyList = historyQuery.listPage(Func.toInt((query.getCurrent() - 1) * query.getSize()), Func.toInt(query.getSize()));

		historyList.forEach(task -> {
			WfProcess process = new WfProcess();
			process.setTaskId(task.getId());
			process.setTaskDefinitionKey(task.getTaskDefinitionKey());
			process.setTaskName(task.getName());
			process.setCreateTime(task.getCreateTime());
			process.setStatus(status);
			// Variables
			Map<String, Object> variables = new HashMap<>();
			HistoricVariableInstanceQuery variableInstanceQuery = historyService.createHistoricVariableInstanceQuery()
				.processInstanceId(task.getProcessInstanceId());
			HistoricVariableInstance applyUsername = variableInstanceQuery.variableName(WfProcessConstant.TASK_VARIABLE_APPLY_USER_NAME).singleResult();
			if (ObjectUtil.isNotEmpty(applyUsername)) {
				variables.put(WfProcessConstant.TASK_VARIABLE_APPLY_USER_NAME, applyUsername.getValue());
				process.setStartUsername(applyUsername.getValue().toString());
			}
			HistoricVariableInstance sn = variableInstanceQuery.variableName(WfProcessConstant.TASK_VARIABLE_SN).singleResult();
			if (ObjectUtil.isNotEmpty(sn)) {
				variables.put(WfProcessConstant.TASK_VARIABLE_SN, sn.getValue());
			}
			process.setVariables(variables);

			ProcessDefinition processDefinition = WfProcessCache.getProcessDefinition(task.getProcessDefinitionId());
			process.setCategory(processDefinition.getCategory());
			process.setProcessDefinitionId(processDefinition.getId());
			process.setProcessDefinitionName(processDefinition.getName());
			process.setProcessDefinitionKey(processDefinition.getKey());
			process.setProcessInstanceId(task.getProcessInstanceId());

			BpmnModel bpmnModel = repositoryService.getBpmnModel(task.getProcessDefinitionId());
			String exFormKey = WfModelUtil.getUserTaskExtensionAttribute(task.getTaskDefinitionKey(), bpmnModel, WfExtendConstant.EX_FORM_KEY);
			if (StringUtil.isNotBlank(exFormKey)) {
				process.setFormKey(WfProcessConstant.EX_FORM_PREFIX + exFormKey);
			}

			String exFormUrl = WfModelUtil.getUserTaskExtensionAttribute(task.getTaskDefinitionKey(), bpmnModel, WfExtendConstant.EX_FORM_URL);
			if (StringUtil.isNotBlank(exFormUrl)) {
				process.setFormUrl(exFormUrl);
			}

			String exAppFormUrl = WfModelUtil.getUserTaskExtensionAttribute(task.getTaskDefinitionKey(), bpmnModel, WfExtendConstant.EX_APP_FORM_URL);
			if (StringUtil.isNotBlank(exAppFormUrl)) {
				process.setAppFormUrl(exAppFormUrl);
			}

			wfProcessList.add(process);
		});
	}

	/**
	 * ??????????????????????????????
	 *
	 * @param processInsId ????????????id
	 * @param assignee     ??????????????????
	 */
	@Async
	void handleNextNodeAssignee(String processInsId, Object assignee) {
		List<Task> list = taskService.createTaskQuery()
			.processInstanceId(processInsId)
			.taskVariableNotExists(WfProcessConstant.TASK_VARIABLE_APPOINT)
			.list();
		if (list.size() == 0) return;
		if (ObjectUtil.isNotEmpty(assignee)) {
			String[] ids = assignee.toString().split(",");
			if (list.size() > 1 || (list.size() == 1 && this.isMultiInstance(list.get(0).getTaskDefinitionKey(), list.get(0).getProcessDefinitionId()))) { // ?????????
				int index = 0;
				if (list.size() == ids.length) { // ?????????????????????????????????????????????
					for (Task task : list) {
						taskService.setAssignee(task.getId(), ids[index]);
						taskService.setVariableLocal(task.getId(), WfProcessConstant.TASK_VARIABLE_APPOINT, "1");
						index++;
					}
				} else if (list.size() > ids.length) { // ????????????????????????????????????????????????
					for (int i = 0; i < ids.length; i++) {
						taskService.setAssignee(list.get(i).getId(), ids[i]);
						taskService.setVariableLocal(list.get(i).getId(), WfProcessConstant.TASK_VARIABLE_APPOINT, "1");
					}
					list.subList(ids.length, list.size()).forEach(task -> runtimeService.deleteMultiInstanceExecution(task.getExecutionId(), false));
				} else { // ????????????????????????????????????????????????
					for (int i = 0; i < list.size(); i++) {
						taskService.setAssignee(list.get(i).getId(), ids[i]);
						taskService.setVariableLocal(list.get(i).getId(), WfProcessConstant.TASK_VARIABLE_APPOINT, "1");
					}
					for (int i = 0; i < ids.length - list.size(); i++) {
						Task task = list.get(0);
						runtimeService.addMultiInstanceExecution(task.getTaskDefinitionKey(), task.getProcessInstanceId(), Collections.singletonMap("assignee", ids[i + list.size()]));
					}
					list = taskService.createTaskQuery()
						.processInstanceId(processInsId)
						.taskVariableNotExists(WfProcessConstant.TASK_VARIABLE_APPOINT)
						.list();
					list.forEach(t -> taskService.setVariableLocal(t.getId(), WfProcessConstant.TASK_VARIABLE_APPOINT, "1"));
				}
			} else {
				taskService.setAssignee(list.get(0).getId(), ids[0]);
				taskService.setVariableLocal(list.get(0).getId(), WfProcessConstant.TASK_VARIABLE_APPOINT, "1");
			}
		} else {
			for (Task task : list) {
				taskService.setVariableLocal(task.getId(), WfProcessConstant.TASK_VARIABLE_APPOINT, "1");
			}
		}
	}

}
