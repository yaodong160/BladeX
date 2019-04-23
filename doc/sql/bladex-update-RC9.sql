-- ----------------------------
-- 流程菜单增加
-- ----------------------------
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (0, 'flow', '流程管理', 'menu', '/flow', 'stock', 5, 1, 0, 1, NULL, 0);

set @flowid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@flowid, 'flow_model', '模型管理', 'menu', '/flow/model', NULL, 1, 1, 0, 1, NULL, 0);
set @modelid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@modelid, 'flow_model_create', '创建', 'create', '', 'plus', 1, 2, 1, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@modelid, 'flow_model_update', '编辑', 'update', '', 'form', 2, 2, 2, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@modelid, 'flow_model_deploy', '部署', 'deploy', '', 'cloud-upload', 3, 2, 2, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@modelid, 'flow_model_download', '下载', 'download', '', 'download', 4, 2, 2, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@modelid, 'flow_model_delete', '删除', 'delete', '/api/blade-flow/model/remove', 'delete', 5, 2, 3, 1, NULL, 0);

INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@flowid, 'flow_deploy', '流程部署', 'menu', '/flow/deploy', NULL, 2, 1, 0, 1, NULL, 0);

INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@flowid, 'flow_manager', '流程管理', 'menu', '/flow/manager', NULL, 3, 1, 0, 1, NULL, 0);
set @managerid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@managerid, 'flow_manager_state', '变更状态', 'state', '', 'plus', 1, 2, 2, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@managerid, 'flow_manager_image', '流程图', 'image', '', 'image', 2, 2, 2, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@managerid, 'flow_manager_remove', '删除', 'remove', '', 'delete', 3, 2, 3, 1, NULL, 0);

INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@flowid, 'flow_status', '流程状态', 'menu', '/flow/status', NULL, 4, 1, 0, 1, NULL, 0);
set @statueid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@statueid, 'flow_status_delete', '删除', 'delete', '', 'delete', 1, 2, 3, 1, NULL, 0);

INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (0, 'work', '我的事务', 'work', '/work', 'bell', 2, 1, 0, 1, NULL, 0);
set @workid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@workid, 'work_start', '发起事务', 'menu', '/work/start', NULL, 1, 1, 0, 1, NULL, 0);
set @startid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@startid, 'work_start_flow', '发起', 'flow', '', 'flow', 1, 2, 2, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@startid, 'work_start_image', '流程图', 'image', '', 'image', 2, 2, 2, 1, NULL, 0);

INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@workid, 'work_todo', '代办事务', 'menu', '/work/todo', NULL, 2, 1, 0, 1, NULL, 0);
set @todoid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@todoid, 'work_todo_handle', '办理', 'handle', '', 'handle', 1, 2, 2, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@todoid, 'work_todo_follow', '跟踪', 'follow', '', 'follow', 2, 2, 2, 1, NULL, 0);


INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@workid, 'work_send', '已发事务', 'menu', '/work/send', NULL, 3, 1, 0, 1, NULL, 0);
set @sendid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@sendid, 'work_send_detail', '详情', 'detail', '', 'detail', 1, 2, 2, 1, NULL, 0);
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@sendid, 'work_send_follow', '跟踪', 'follow', '', 'follow', 2, 2, 2, 1, NULL, 0);


INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@workid, 'work_done', '办结事务', 'menu', '/work/done', NULL, 4, 1, 0, 1, NULL, 0);
set @doneid = (SELECT LAST_INSERT_ID());
INSERT INTO `blade_menu`(`parent_id`, `code`, `name`, `alias`, `path`, `source`, `sort`, `category`, `action`, `is_open`, `remark`, `is_deleted`)
VALUES (@doneid, 'work_done_detail', '详情', 'detail', '', 'detail', 1, 2, 2, 1, NULL, 0);

-- ----------------------------
-- 更新系统管理排序
-- ----------------------------
UPDATE `blade_menu` set `sort` = 99 WHERE `code` = 'system';

-- ----------------------------
-- 字典数据增加
-- ----------------------------
INSERT INTO `blade_dict`(`parent_id`, `code`, `dict_key`, `dict_value`, `sort`, `remark`, `is_deleted`)
VALUES (0, 'flow', -1, '流程类型', 5, NULL, 0);
set @dictid = (SELECT LAST_INSERT_ID());
INSERT INTO `bladex`.`blade_dict`(`parent_id`, `code`, `dict_key`, `dict_value`, `sort`, `remark`, `is_deleted`)
VALUES (@dictid, 'flow', 1, '请假流程', 1, NULL, 0);
INSERT INTO `bladex`.`blade_dict`(`parent_id`, `code`, `dict_key`, `dict_value`, `sort`, `remark`, `is_deleted`)
VALUES (@dictid, 'flow', 2, '报销流程', 2, NULL, 0);