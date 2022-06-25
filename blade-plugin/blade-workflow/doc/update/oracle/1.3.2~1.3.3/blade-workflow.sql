INSERT INTO "ACT_DE_MODEL" VALUES ('617167d80b6051708484bbedfb72a137', '人员/流转调用自定义方法示例', 'demo-custom-method', 'demo-test', '表单字段联动示例', NULL, TO_DATE('2021-11-29 09:42:20', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2021-12-01 19:18:18', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', '1', '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:dc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:di=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:flowable=\"http://flowable.org/bpmn\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:camunda=\"http://camunda.org/schema/1.0/bpmn\" targetNamespace=\"http://bpmn.io/schema/bpmn\">\n  <process id=\"demo-custom-method\" name=\"人员/流转调用自定义方法示例\" isExecutable=\"true\" flowable:skipFirstNode=\"true\" flowable:rollbackNode=\"Activity_06t0e98\">\n    <documentation>人员/流转调用自定义方法示例</documentation>\n    <startEvent id=\"startEvent_1\" name=\"开始\">\n      <extensionElements>\n        <flowable:formProperty id=\"1624624365132_23209\" name=\"单行文本\" readable=\"true\" writable=\"true\" />\n      </extensionElements>\n      <outgoing>Flow_0yhobgw</outgoing>\n    </startEvent>\n    <userTask id=\"Activity_06t0e98\" name=\"发起人\">\n      <extensionElements>\n        <flowable:assignee type=\"custom\" value=\"applyUser\" text=\"流程发起人\" />\n        <flowable:formProperty id=\"1624624365132_23209\" name=\"单行文本\" readable=\"true\" writable=\"true\" />\n        <flowable:button label=\"通过\" prop=\"wf_pass\" display=\"true\" />\n        <flowable:button label=\"驳回\" prop=\"wf_reject\" display=\"true\" />\n        <flowable:button label=\"打印\" prop=\"wf_print\" display=\"true\" />\n        <flowable:button label=\"转办\" prop=\"wf_transfer\" display=\"true\" />\n        <flowable:button label=\"委托\" prop=\"wf_delegate\" display=\"true\" />\n        <flowable:button label=\"终止\" prop=\"wf_terminate\" display=\"true\" />\n        <flowable:button label=\"加签\" prop=\"wf_add_instance\" display=\"true\" />\n        <flowable:button label=\"减签\" prop=\"wf_del_instance\" display=\"true\" />\n        <flowable:button label=\"指定回退\" prop=\"wf_rollback\" display=\"true\" />\n      </extensionElements>\n      <incoming>Flow_0yhobgw</incoming>\n      <outgoing>Flow_1t6zwdf</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_0yhobgw\" sourceRef=\"startEvent_1\" targetRef=\"Activity_06t0e98\" />\n    <userTask id=\"Activity_07ghy8s\" name=\"方式1\">\n      <extensionElements>\n        <flowable:formProperty id=\"1624624365132_23209\" name=\"单行文本\" readable=\"true\" writable=\"true\" />\n        <flowable:button label=\"通过\" prop=\"wf_pass\" display=\"true\" />\n        <flowable:button label=\"驳回\" prop=\"wf_reject\" display=\"true\" />\n        <flowable:button label=\"打印\" prop=\"wf_print\" display=\"true\" />\n        <flowable:button label=\"转办\" prop=\"wf_transfer\" display=\"true\" />\n        <flowable:button label=\"委托\" prop=\"wf_delegate\" display=\"true\" />\n        <flowable:button label=\"终止\" prop=\"wf_terminate\" display=\"true\" />\n        <flowable:button label=\"加签\" prop=\"wf_add_instance\" display=\"true\" />\n        <flowable:button label=\"减签\" prop=\"wf_del_instance\" display=\"true\" />\n        <flowable:button label=\"指定回退\" prop=\"wf_rollback\" display=\"true\" />\n        <flowable:assignee type=\"custom\" value=\"${wfCustomUserHandler.userList(execution, &#39;自定义参数&#39;)}\" text=\"${wfCustomUserHandler.userList(execution, &#39;自定义参数&#39;)}\" />\n      </extensionElements>\n      <incoming>Flow_1t6zwdf</incoming>\n      <outgoing>Flow_0kxxs74</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_1t6zwdf\" sourceRef=\"Activity_06t0e98\" targetRef=\"Activity_07ghy8s\" />\n    <userTask id=\"Activity_10810pv\" name=\"方式2\">\n      <extensionElements>\n        <flowable:assignee type=\"custom\" value=\"${wfCustomUserHandler.strList(execution, &#39;自定义参数&#39;)}\" text=\"${wfCustomUserHandler.strList(execution, &#39;自定义参数&#39;)}\" />\n        <flowable:formProperty id=\"1624624365132_23209\" name=\"单行文本\" readable=\"true\" writable=\"true\" />\n        <flowable:button label=\"通过\" prop=\"wf_pass\" display=\"true\" />\n        <flowable:button label=\"驳回\" prop=\"wf_reject\" display=\"true\" />\n        <flowable:button label=\"打印\" prop=\"wf_print\" display=\"true\" />\n        <flowable:button label=\"转办\" prop=\"wf_transfer\" display=\"true\" />\n        <flowable:button label=\"委托\" prop=\"wf_delegate\" display=\"true\" />\n        <flowable:button label=\"终止\" prop=\"wf_terminate\" display=\"true\" />\n        <flowable:button label=\"加签\" prop=\"wf_add_instance\" display=\"true\" />\n        <flowable:button label=\"减签\" prop=\"wf_del_instance\" display=\"true\" />\n        <flowable:button label=\"指定回退\" prop=\"wf_rollback\" display=\"true\" />\n      </extensionElements>\n      <incoming>Flow_0kxxs74</incoming>\n      <outgoing>Flow_01h467o</outgoing>\n    </userTask>\n    <sequenceFlow id=\"Flow_0kxxs74\" sourceRef=\"Activity_07ghy8s\" targetRef=\"Activity_10810pv\" />\n    <userTask id=\"Activity_1i46ta4\" name=\"方式3\">\n      <extensionElements>\n        <flowable:assignee type=\"custom\" value=\"${wfCustomUserHandler.longList(execution, &#39;自定义参数&#39;)}\" text=\"${wfCustomUserHandler.longList(execution, &#39;自定义参数&#39;)}\" />\n        <flowable:formProperty id=\"1624624365132_23209\" name=\"单行文本\" readable=\"true\" writable=\"true\" />\n        <flowable:button label=\"通过\" prop=\"wf_pass\" display=\"true\" />\n        <flowable:button label=\"驳回\" prop=\"wf_reject\" display=\"true\" />\n        <flowable:button label=\"打印\" prop=\"wf_print\" display=\"true\" />\n        <flowable:button label=\"转办\" prop=\"wf_transfer\" display=\"true\" />\n        <flowable:button label=\"委托\" prop=\"wf_delegate\" display=\"true\" />\n        <flowable:button label=\"终止\" prop=\"wf_terminate\" display=\"true\" />\n        <flowable:button label=\"加签\" prop=\"wf_add_instance\" display=\"true\" />\n        <flowable:button label=\"减签\" prop=\"wf_del_instance\" display=\"true\" />\n        <flowable:button label=\"指定回退\" prop=\"wf_rollback\" display=\"true\" />\n      </extensionElements>\n      <incoming>Flow_0kdt4xu</incoming>\n      <outgoing>Flow_1x5wxzy</outgoing>\n    </userTask>\n    <userTask id=\"Activity_03trwm6\" name=\"方式4\">\n      <extensionElements>\n        <flowable:assignee type=\"custom\" value=\"${wfCustomUserHandler.str(execution, &#39;自定义参数&#39;)}\" text=\"${wfCustomUserHandler.str(execution, &#39;自定义参数&#39;)}\" />\n        <flowable:formProperty id=\"1624624365132_23209\" name=\"单行文本\" readable=\"true\" writable=\"true\" />\n        <flowable:button label=\"通过\" prop=\"wf_pass\" display=\"true\" />\n        <flowable:button label=\"驳回\" prop=\"wf_reject\" display=\"true\" />\n        <flowable:button label=\"打印\" prop=\"wf_print\" display=\"true\" />\n        <flowable:button label=\"转办\" prop=\"wf_transfer\" display=\"true\" />\n        <flowable:button label=\"委托\" prop=\"wf_delegate\" display=\"true\" />\n        <flowable:button label=\"终止\" prop=\"wf_terminate\" display=\"true\" />\n        <flowable:button label=\"加签\" prop=\"wf_add_instance\" display=\"true\" />\n        <flowable:button label=\"减签\" prop=\"wf_del_instance\" display=\"true\" />\n        <flowable:button label=\"指定回退\" prop=\"wf_rollback\" display=\"true\" />\n      </extensionElements>\n      <incoming>Flow_0jw1ae2</incoming>\n      <outgoing>Flow_00r5t9o</outgoing>\n    </userTask>\n    <endEvent id=\"Event_0uefnoo\">\n      <incoming>Flow_1fun2ye</incoming>\n    </endEvent>\n    <exclusiveGateway id=\"Gateway_0mtj57e\">\n      <incoming>Flow_01h467o</incoming>\n      <outgoing>Flow_0kdt4xu</outgoing>\n      <outgoing>Flow_0jw1ae2</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_01h467o\" sourceRef=\"Activity_10810pv\" targetRef=\"Gateway_0mtj57e\" />\n    <sequenceFlow id=\"Flow_0kdt4xu\" sourceRef=\"Gateway_0mtj57e\" targetRef=\"Activity_1i46ta4\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${wfCustomUserHandler.condition(execution, \''对\'')}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"Flow_0jw1ae2\" sourceRef=\"Gateway_0mtj57e\" targetRef=\"Activity_03trwm6\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${wfCustomUserHandler.condition(execution, \''错\'')}</conditionExpression>\n    </sequenceFlow>\n    <exclusiveGateway id=\"Gateway_0ha0m7b\">\n      <incoming>Flow_1x5wxzy</incoming>\n      <incoming>Flow_00r5t9o</incoming>\n      <outgoing>Flow_1fun2ye</outgoing>\n    </exclusiveGateway>\n    <sequenceFlow id=\"Flow_1x5wxzy\" sourceRef=\"Activity_1i46ta4\" targetRef=\"Gateway_0ha0m7b\" />\n    <sequenceFlow id=\"Flow_1fun2ye\" sourceRef=\"Gateway_0ha0m7b\" targetRef=\"Event_0uefnoo\" />\n    <sequenceFlow id=\"Flow_00r5t9o\" sourceRef=\"Activity_03trwm6\" targetRef=\"Gateway_0ha0m7b\" />\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_flow\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_flow\" bpmnElement=\"demo-custom-method\">\n      <bpmndi:BPMNEdge id=\"Flow_0kxxs74_di\" bpmnElement=\"Flow_0kxxs74\">\n        <di:waypoint x=\"590\" y=\"218\" />\n        <di:waypoint x=\"650\" y=\"218\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1t6zwdf_di\" bpmnElement=\"Flow_1t6zwdf\">\n        <di:waypoint x=\"430\" y=\"218\" />\n        <di:waypoint x=\"490\" y=\"218\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0yhobgw_di\" bpmnElement=\"Flow_0yhobgw\">\n        <di:waypoint x=\"276\" y=\"218\" />\n        <di:waypoint x=\"330\" y=\"218\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_01h467o_di\" bpmnElement=\"Flow_01h467o\">\n        <di:waypoint x=\"750\" y=\"218\" />\n        <di:waypoint x=\"815\" y=\"218\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0kdt4xu_di\" bpmnElement=\"Flow_0kdt4xu\">\n        <di:waypoint x=\"840\" y=\"193\" />\n        <di:waypoint x=\"840\" y=\"90\" />\n        <di:waypoint x=\"910\" y=\"90\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0jw1ae2_di\" bpmnElement=\"Flow_0jw1ae2\">\n        <di:waypoint x=\"840\" y=\"243\" />\n        <di:waypoint x=\"840\" y=\"360\" />\n        <di:waypoint x=\"910\" y=\"360\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1x5wxzy_di\" bpmnElement=\"Flow_1x5wxzy\">\n        <di:waypoint x=\"1010\" y=\"90\" />\n        <di:waypoint x=\"1080\" y=\"90\" />\n        <di:waypoint x=\"1080\" y=\"193\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1fun2ye_di\" bpmnElement=\"Flow_1fun2ye\">\n        <di:waypoint x=\"1105\" y=\"218\" />\n        <di:waypoint x=\"1142\" y=\"218\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_00r5t9o_di\" bpmnElement=\"Flow_00r5t9o\">\n        <di:waypoint x=\"1010\" y=\"360\" />\n        <di:waypoint x=\"1080\" y=\"360\" />\n        <di:waypoint x=\"1080\" y=\"243\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"BPMNShape_startEvent_1\" bpmnElement=\"startEvent_1\">\n        <dc:Bounds x=\"240\" y=\"200\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"248\" y=\"243\" width=\"22\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_06t0e98_di\" bpmnElement=\"Activity_06t0e98\">\n        <dc:Bounds x=\"330\" y=\"178\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_07ghy8s_di\" bpmnElement=\"Activity_07ghy8s\">\n        <dc:Bounds x=\"490\" y=\"178\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_10810pv_di\" bpmnElement=\"Activity_10810pv\">\n        <dc:Bounds x=\"650\" y=\"178\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0mtj57e_di\" bpmnElement=\"Gateway_0mtj57e\" isMarkerVisible=\"true\">\n        <dc:Bounds x=\"815\" y=\"193\" width=\"50\" height=\"50\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1i46ta4_di\" bpmnElement=\"Activity_1i46ta4\">\n        <dc:Bounds x=\"910\" y=\"50\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_03trwm6_di\" bpmnElement=\"Activity_03trwm6\">\n        <dc:Bounds x=\"910\" y=\"320\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0ha0m7b_di\" bpmnElement=\"Gateway_0ha0m7b\" isMarkerVisible=\"true\">\n        <dc:Bounds x=\"1055\" y=\"193\" width=\"50\" height=\"50\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_0uefnoo_di\" bpmnElement=\"Event_0uefnoo\">\n        <dc:Bounds x=\"1142\" y=\"200\" width=\"36\" height=\"36\" />\n      </bpmndi:BPMNShape>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>\n'', ''{\"bounds\":{\"lowerRight\":{\"x\":1485.0,\"y\":700.0},\"upperLeft\":{\"x\":0.0,\"y\":0.0}},\"resourceId\":\"canvas\",\"stencil\":{\"id\":\"BPMNDiagram\"},\"stencilset\":{\"namespace\":\"http://b3mn.org/stencilset/bpmn2.0#\",\"url\":\"../editor/stencilsets/bpmn2.0/bpmn2.0.json\"},\"properties\":{\"process_id\":\"demo-custom-method\",\"name\":\"人员/流转调用自定义方法示例\",\"documentation\":\"人员/流转调用自定义方法示例\",\"process_namespace\":\"http://bpmn.io/schema/bpmn\",\"iseagerexecutionfetch\":false,\"messages\":[],\"executionlisteners\":{\"executionListeners\":[]},\"eventlisteners\":{\"eventListeners\":[]},\"signaldefinitions\":[],\"messagedefinitions\":[],\"escalationdefinitions\":[]},\"childShapes\":[{\"bounds\":{\"lowerRight\":{\"x\":276.0,\"y\":236.0},\"upperLeft\":{\"x\":240.0,\"y\":200.0}},\"resourceId\":\"startEvent_1\",\"childShapes\":[],\"stencil\":{\"id\":\"StartNoneEvent\"},\"properties\":{\"overrideid\":\"startEvent_1\",\"name\":\"开始\",\"interrupting\":true,\"formproperties\":{\"formProperties\":[{\"id\":\"1624624365132_23209\",\"name\":\"单行文本\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_0yhobgw\"}]},{\"bounds\":{\"lowerRight\":{\"x\":430.0,\"y\":258.0},\"upperLeft\":{\"x\":330.0,\"y\":178.0}},\"resourceId\":\"Activity_06t0e98\",\"childShapes\":[],\"stencil\":{\"id\":\"UserTask\"},\"properties\":{\"overrideid\":\"Activity_06t0e98\",\"name\":\"发起人\",\"formproperties\":{\"formProperties\":[{\"id\":\"1624624365132_23209\",\"name\":\"单行文本\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"isforcompensation\":false,\"tasklisteners\":{\"taskListeners\":[]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_1t6zwdf\"}]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_0yhobgw\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":18.0,\"y\":18.0},{\"x\":50.0,\"y\":40.0}],\"outgoing\":[{\"resourceId\":\"Activity_06t0e98\"}],\"target\":{\"resourceId\":\"Activity_06t0e98\"},\"properties\":{\"overrideid\":\"Flow_0yhobgw\"}},{\"bounds\":{\"lowerRight\":{\"x\":590.0,\"y\":258.0},\"upperLeft\":{\"x\":490.0,\"y\":178.0}},\"resourceId\":\"Activity_07ghy8s\",\"childShapes\":[],\"stencil\":{\"id\":\"UserTask\"},\"properties\":{\"overrideid\":\"Activity_07ghy8s\",\"name\":\"方式1\",\"formproperties\":{\"formProperties\":[{\"id\":\"1624624365132_23209\",\"name\":\"单行文本\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"isforcompensation\":false,\"tasklisteners\":{\"taskListeners\":[]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_0kxxs74\"}]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_1t6zwdf\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":50.0,\"y\":40.0},{\"x\":50.0,\"y\":40.0}],\"outgoing\":[{\"resourceId\":\"Activity_07ghy8s\"}],\"target\":{\"resourceId\":\"Activity_07ghy8s\"},\"properties\":{\"overrideid\":\"Flow_1t6zwdf\"}},{\"bounds\":{\"lowerRight\":{\"x\":750.0,\"y\":258.0},\"upperLeft\":{\"x\":650.0,\"y\":178.0}},\"resourceId\":\"Activity_10810pv\",\"childShapes\":[],\"stencil\":{\"id\":\"UserTask\"},\"properties\":{\"overrideid\":\"Activity_10810pv\",\"name\":\"方式2\",\"formproperties\":{\"formProperties\":[{\"id\":\"1624624365132_23209\",\"name\":\"单行文本\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"isforcompensation\":false,\"tasklisteners\":{\"taskListeners\":[]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_01h467o\"}]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_0kxxs74\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":50.0,\"y\":40.0},{\"x\":50.0,\"y\":40.0}],\"outgoing\":[{\"resourceId\":\"Activity_10810pv\"}],\"target\":{\"resourceId\":\"Activity_10810pv\"},\"properties\":{\"overrideid\":\"Flow_0kxxs74\"}},{\"bounds\":{\"lowerRight\":{\"x\":1010.0,\"y\":130.0},\"upperLeft\":{\"x\":910.0,\"y\":50.0}},\"resourceId\":\"Activity_1i46ta4\",\"childShapes\":[],\"stencil\":{\"id\":\"UserTask\"},\"properties\":{\"overrideid\":\"Activity_1i46ta4\",\"name\":\"方式3\",\"formproperties\":{\"formProperties\":[{\"id\":\"1624624365132_23209\",\"name\":\"单行文本\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"isforcompensation\":false,\"tasklisteners\":{\"taskListeners\":[]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_1x5wxzy\"}]},{\"bounds\":{\"lowerRight\":{\"x\":1010.0,\"y\":400.0},\"upperLeft\":{\"x\":910.0,\"y\":320.0}},\"resourceId\":\"Activity_03trwm6\",\"childShapes\":[],\"stencil\":{\"id\":\"UserTask\"},\"properties\":{\"overrideid\":\"Activity_03trwm6\",\"name\":\"方式4\",\"formproperties\":{\"formProperties\":[{\"id\":\"1624624365132_23209\",\"name\":\"单行文本\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"isforcompensation\":false,\"tasklisteners\":{\"taskListeners\":[]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_00r5t9o\"}]},{\"bounds\":{\"lowerRight\":{\"x\":1178.0,\"y\":236.0},\"upperLeft\":{\"x\":1142.0,\"y\":200.0}},\"resourceId\":\"Event_0uefnoo\",\"childShapes\":[],\"stencil\":{\"id\":\"EndNoneEvent\"},\"properties\":{\"overrideid\":\"Event_0uefnoo\",\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[]},{\"bounds\":{\"lowerRight\":{\"x\":865.0,\"y\":243.0},\"upperLeft\":{\"x\":815.0,\"y\":193.0}},\"resourceId\":\"Gateway_0mtj57e\",\"childShapes\":[],\"stencil\":{\"id\":\"ExclusiveGateway\"},\"properties\":{\"overrideid\":\"Gateway_0mtj57e\",\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_0kdt4xu\"},{\"resourceId\":\"Flow_0jw1ae2\"}]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_01h467o\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":50.0,\"y\":40.0},{\"x\":25.0,\"y\":25.0}],\"outgoing\":[{\"resourceId\":\"Gateway_0mtj57e\"}],\"target\":{\"resourceId\":\"Gateway_0mtj57e\"},\"properties\":{\"overrideid\":\"Flow_01h467o\"}},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_0kdt4xu\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":25.0,\"y\":25.0},{\"x\":840.0,\"y\":90.0},{\"x\":50.0,\"y\":40.0}],\"outgoing\":[{\"resourceId\":\"Activity_1i46ta4\"}],\"target\":{\"resourceId\":\"Activity_1i46ta4\"},\"properties\":{\"overrideid\":\"Flow_0kdt4xu\",\"conditionsequenceflow\":\"${wfCustomUserHandler.condition(execution, \''对\'')}\"}},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_0jw1ae2\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":25.0,\"y\":25.0},{\"x\":840.0,\"y\":360.0},{\"x\":50.0,\"y\":40.0}],\"outgoing\":[{\"resourceId\":\"Activity_03trwm6\"}],\"target\":{\"resourceId\":\"Activity_03trwm6\"},\"properties\":{\"overrideid\":\"Flow_0jw1ae2\",\"conditionsequenceflow\":\"${wfCustomUserHandler.condition(execution, \''错\'')}\"}},{\"bounds\":{\"lowerRight\":{\"x\":1105.0,\"y\":243.0},\"upperLeft\":{\"x\":1055.0,\"y\":193.0}},\"resourceId\":\"Gateway_0ha0m7b\",\"childShapes\":[],\"stencil\":{\"id\":\"ExclusiveGateway\"},\"properties\":{\"overrideid\":\"Gateway_0ha0m7b\",\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_1fun2ye\"}]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_1x5wxzy\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":50.0,\"y\":40.0},{\"x\":1080.0,\"y\":90.0},{\"x\":25.0,\"y\":25.0}],\"outgoing\":[{\"resourceId\":\"Gateway_0ha0m7b\"}],\"target\":{\"resourceId\":\"Gateway_0ha0m7b\"},\"properties\":{\"overrideid\":\"Flow_1x5wxzy\"}},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_1fun2ye\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":25.0,\"y\":25.0},{\"x\":18.0,\"y\":18.0}],\"outgoing\":[{\"resourceId\":\"Event_0uefnoo\"}],\"target\":{\"resourceId\":\"Event_0uefnoo\"},\"properties\":{\"overrideid\":\"Flow_1fun2ye\"}},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_00r5t9o\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":50.0,\"y\":40.0},{\"x\":1080.0,\"y\":360.0},{\"x\":25.0,\"y\":25.0}],\"outgoing\":[{\"resourceId\":\"Gateway_0ha0m7b\"}],\"target\":{\"resourceId\":\"Gateway_0ha0m7b\"},\"properties\":{\"overrideid\":\"Flow_00r5t9o\"}}]}', NULL, '0', '000000', NULL);
