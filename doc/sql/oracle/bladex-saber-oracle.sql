/*
 Navicat Premium Data Transfer

 Source Server         : oracle_test
 Source Server Type    : Oracle
 Source Server Version : 110200
 Source Host           : 221.181.92.171:49161
 Source Schema         : BLADEX_BOOT

 Target Server Type    : Oracle
 Target Server Version : 110200
 File Encoding         : 65001

 Date: 27/07/2019 13:11:38
*/


-- ----------------------------
-- Table structure for BLADE_CLIENT
-- ----------------------------
-- DROP TABLE "BLADE_CLIENT";
CREATE TABLE "BLADE_CLIENT" (
  "ID" NUMBER(20) NOT NULL ,
  "CLIENT_ID" NVARCHAR2(48) NOT NULL ,
  "CLIENT_SECRET" NVARCHAR2(256) NOT NULL ,
  "RESOURCE_IDS" NVARCHAR2(256) ,
  "SCOPE" NVARCHAR2(256) NOT NULL ,
  "AUTHORIZED_GRANT_TYPES" NVARCHAR2(256) NOT NULL ,
  "WEB_SERVER_REDIRECT_URI" NVARCHAR2(256) ,
  "AUTHORITIES" NVARCHAR2(256) ,
  "ACCESS_TOKEN_VALIDITY" NUMBER(11) NOT NULL ,
  "REFRESH_TOKEN_VALIDITY" NUMBER(11) NOT NULL ,
  "ADDITIONAL_INFORMATION" NCLOB ,
  "AUTOAPPROVE" NVARCHAR2(256) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) NOT NULL ,
  "IS_DELETED" NUMBER(11) NOT NULL 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_CLIENT"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_CLIENT"."CLIENT_ID" IS '客户端ID';
COMMENT ON COLUMN "BLADE_CLIENT"."CLIENT_SECRET" IS '客户端密钥';
COMMENT ON COLUMN "BLADE_CLIENT"."RESOURCE_IDS" IS '资源集合';
COMMENT ON COLUMN "BLADE_CLIENT"."SCOPE" IS '授权范围';
COMMENT ON COLUMN "BLADE_CLIENT"."AUTHORIZED_GRANT_TYPES" IS '授权类型';
COMMENT ON COLUMN "BLADE_CLIENT"."WEB_SERVER_REDIRECT_URI" IS '回调地址';
COMMENT ON COLUMN "BLADE_CLIENT"."AUTHORITIES" IS '权限';
COMMENT ON COLUMN "BLADE_CLIENT"."ACCESS_TOKEN_VALIDITY" IS '令牌过期秒数';
COMMENT ON COLUMN "BLADE_CLIENT"."REFRESH_TOKEN_VALIDITY" IS '刷新令牌过期秒数';
COMMENT ON COLUMN "BLADE_CLIENT"."ADDITIONAL_INFORMATION" IS '附加说明';
COMMENT ON COLUMN "BLADE_CLIENT"."AUTOAPPROVE" IS '自动授权';
COMMENT ON COLUMN "BLADE_CLIENT"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_CLIENT"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_CLIENT"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_CLIENT"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_CLIENT"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_CLIENT"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_CLIENT"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_CLIENT" IS '客户端表';

-- ----------------------------
-- Records of BLADE_CLIENT
-- ----------------------------
INSERT INTO "BLADE_CLIENT" VALUES ('1123598811738675201', 'sword', 'sword_secret', NULL, 'all', 'refresh_token,password,authorization_code', 'http://localhost:8888', NULL, '3600', '604800', NULL, NULL, '1123598815738675201', '1123598813738675201', TO_DATE('2019-03-24 10:40:55', 'SYYYY-MM-DD HH24:MI:SS'), '1123598815738675201', TO_DATE('2019-03-24 10:40:59', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
INSERT INTO "BLADE_CLIENT" VALUES ('1123598811738675202', 'saber', 'saber_secret', NULL, 'all', 'refresh_token,password,authorization_code', 'http://localhost:8080', NULL, '3600', '604800', NULL, NULL, '1123598815738675201', '1123598813738675201', TO_DATE('2019-03-24 10:42:29', 'SYYYY-MM-DD HH24:MI:SS'), '1123598815738675201', TO_DATE('2019-03-24 10:42:32', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_CODE
-- ----------------------------
-- DROP TABLE "BLADE_CODE" IF EXISTS ;
CREATE TABLE "BLADE_CODE" (
  "ID" NUMBER(20) NOT NULL ,
  "SERVICE_NAME" NVARCHAR2(64) ,
  "CODE_NAME" NVARCHAR2(64) ,
  "TABLE_NAME" NVARCHAR2(64) ,
  "TABLE_PREFIX" NVARCHAR2(64) ,
  "PK_NAME" NVARCHAR2(32) ,
  "PACKAGE_NAME" NVARCHAR2(500) ,
  "API_PATH" NCLOB ,
  "WEB_PATH" NCLOB ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_CODE"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_CODE"."SERVICE_NAME" IS '服务名称';
COMMENT ON COLUMN "BLADE_CODE"."CODE_NAME" IS '模块名称';
COMMENT ON COLUMN "BLADE_CODE"."TABLE_NAME" IS '表名';
COMMENT ON COLUMN "BLADE_CODE"."TABLE_PREFIX" IS '表前缀';
COMMENT ON COLUMN "BLADE_CODE"."PK_NAME" IS '主键名';
COMMENT ON COLUMN "BLADE_CODE"."PACKAGE_NAME" IS '后端包名';
COMMENT ON COLUMN "BLADE_CODE"."API_PATH" IS '后端路径';
COMMENT ON COLUMN "BLADE_CODE"."WEB_PATH" IS '前端路径';
COMMENT ON COLUMN "BLADE_CODE"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_CODE" IS '代码生成表';

-- ----------------------------
-- Records of BLADE_CODE
-- ----------------------------
INSERT INTO "BLADE_CODE" VALUES ('1123598812738675201', 'blade-demo', '通知公告', 'BLADE_NOTICE', 'blade_', 'ID', 'org.springblade.desktop', 'D:\Develop\WorkSpace\Git\SpringBlade\blade-ops\blade-develop', 'D:\Develop\WorkSpace\Git\Sword', '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_DEPT
-- ----------------------------
-- DROP TABLE "BLADE_DEPT";
CREATE TABLE "BLADE_DEPT" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "PARENT_ID" NUMBER(20) ,
  "ANCESTORS" NCLOB ,
  "DEPT_CATEGORY" NUMBER(11) ,
  "DEPT_NAME" NVARCHAR2(45) ,
  "FULL_NAME" NVARCHAR2(45) ,
  "SORT" NUMBER(11) ,
  "REMARK" NVARCHAR2(255) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_DEPT"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_DEPT"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_DEPT"."PARENT_ID" IS '父主键';
COMMENT ON COLUMN "BLADE_DEPT"."ANCESTORS" IS '祖级列表';
COMMENT ON COLUMN "BLADE_DEPT"."DEPT_CATEGORY" IS '部门类型';
COMMENT ON COLUMN "BLADE_DEPT"."DEPT_NAME" IS '部门名';
COMMENT ON COLUMN "BLADE_DEPT"."FULL_NAME" IS '部门全称';
COMMENT ON COLUMN "BLADE_DEPT"."SORT" IS '排序';
COMMENT ON COLUMN "BLADE_DEPT"."REMARK" IS '备注';
COMMENT ON COLUMN "BLADE_DEPT"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_DEPT" IS '机构表';

-- ----------------------------
-- Records of BLADE_DEPT
-- ----------------------------
INSERT INTO "BLADE_DEPT" VALUES ('1123598813738675201', '000000', '0', '0', '1', '刀锋科技', '江苏刀锋科技有限公司', '1', NULL, '0');
INSERT INTO "BLADE_DEPT" VALUES ('1123598813738675202', '000000', '1123598813738675201', '0,1123598813738675201', '1', '常州刀锋', '常州刀锋科技有限公司', '1', NULL, '0');
INSERT INTO "BLADE_DEPT" VALUES ('1123598813738675203', '000000', '1123598813738675201', '0,1123598813738675201', '1', '苏州刀锋', '苏州刀锋科技有限公司', '1', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_DICT
-- ----------------------------
-- DROP TABLE "BLADE_DICT";
CREATE TABLE "BLADE_DICT" (
  "ID" NUMBER(20) NOT NULL ,
  "PARENT_ID" NUMBER(20) ,
  "CODE" NVARCHAR2(255) ,
  "DICT_KEY" NUMBER(11) ,
  "DICT_VALUE" NVARCHAR2(255) ,
  "SORT" NUMBER(11) ,
  "REMARK" NVARCHAR2(255) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_DICT"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_DICT"."PARENT_ID" IS '父主键';
COMMENT ON COLUMN "BLADE_DICT"."CODE" IS '字典码';
COMMENT ON COLUMN "BLADE_DICT"."DICT_KEY" IS '字典值';
COMMENT ON COLUMN "BLADE_DICT"."DICT_VALUE" IS '字典名称';
COMMENT ON COLUMN "BLADE_DICT"."SORT" IS '排序';
COMMENT ON COLUMN "BLADE_DICT"."REMARK" IS '字典备注';
COMMENT ON COLUMN "BLADE_DICT"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_DICT" IS '字典表';

-- ----------------------------
-- Records of BLADE_DICT
-- ----------------------------
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675201', '0', 'sex', '-1', '性别', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675202', '1123598814738675201', 'sex', '1', '男', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675203', '1123598814738675201', 'sex', '2', '女', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675204', '0', 'notice', '-1', '通知类型', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675205', '1123598814738675204', 'notice', '1', '发布通知', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675206', '1123598814738675204', 'notice', '2', '批转通知', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675207', '1123598814738675204', 'notice', '3', '转发通知', '3', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675208', '1123598814738675204', 'notice', '4', '指示通知', '4', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675209', '1123598814738675204', 'notice', '5', '任免通知', '5', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675210', '1123598814738675204', 'notice', '6', '事务通知', '6', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675211', '0', 'menu_category', '-1', '菜单类型', '3', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675212', '1123598814738675211', 'menu_category', '1', '菜单', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675213', '1123598814738675211', 'menu_category', '2', '按钮', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675214', '0', 'button_func', '-1', '按钮功能', '4', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675215', '1123598814738675214', 'button_func', '1', '工具栏', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675216', '1123598814738675214', 'button_func', '2', '操作栏', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675217', '1123598814738675214', 'button_func', '3', '工具操作栏', '3', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675218', '0', 'yes_no', '-1', '是否', '5', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675219', '1123598814738675218', 'yes_no', '1', '否', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675220', '1123598814738675218', 'yes_no', '2', '是', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675221', '0', 'flow', '-1', '流程类型', '5', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675222', '1123598814738675221', 'flow', '1', '请假流程', '1', 'leave', '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675223', '1123598814738675221', 'flow', '2', '报销流程', '2', 'expense', '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675224', '0', 'oss', '-1', '对象存储类型', '6', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675225', '1123598814738675224', 'oss', '1', 'minio', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675226', '1123598814738675224', 'oss', '2', 'qiniu', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675227', '0', 'org_category', '-1', '机构类型', '7', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675228', '1123598814738675227', 'org_category', '1', '公司', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675229', '1123598814738675227', 'org_category', '2', '部门', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675230', '1123598814738675227', 'org_category', '3', '小组', '3', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675231', '0', 'data_scope_type', '-1', '数据权限', '8', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675232', '1123598814738675231', 'data_scope_type', '1', '全部可见', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675233', '1123598814738675231', 'data_scope_type', '2', '本人可见', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675234', '1123598814738675231', 'data_scope_type', '3', '所在机构可见', '3', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675235', '1123598814738675231', 'data_scope_type', '4', '所在机构及子级可见', '4', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675236', '1123598814738675231', 'data_scope_type', '5', '自定义', '5', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675237', '0', 'api_scope_type', '-1', '接口权限', '10', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675238', '1123598814738675237', 'api_scope_type', '1', '系统接口', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675239', '1123598814738675237', 'api_scope_type', '2', '业务接口', '2', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675240', '0', 'scope_category', '-1', '权限类型', '10', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675241', '1123598814738675240', 'scope_category', '1', '数据权限', '1', NULL, '0');
INSERT INTO "BLADE_DICT" VALUES ('1123598814738675242', '1123598814738675240', 'scope_category', '2', '接口权限', '2', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_LOG_API
-- ----------------------------
-- DROP TABLE "BLADE_LOG_API";
CREATE TABLE "BLADE_LOG_API" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "SERVICE_ID" NVARCHAR2(32) ,
  "SERVER_HOST" NVARCHAR2(255) ,
  "SERVER_IP" NVARCHAR2(255) ,
  "ENV" NVARCHAR2(255) ,
  "TYPE" NCHAR(1) ,
  "TITLE" NVARCHAR2(255) ,
  "METHOD" NVARCHAR2(10) ,
  "REQUEST_URI" NVARCHAR2(255) ,
  "USER_AGENT" NVARCHAR2(1000) ,
  "REMOTE_IP" NVARCHAR2(255) ,
  "METHOD_CLASS" NVARCHAR2(255) ,
  "METHOD_NAME" NVARCHAR2(255) ,
  "PARAMS" NCLOB ,
  "TIME" NVARCHAR2(64) ,
  "CREATE_BY" NVARCHAR2(64) ,
  "CREATE_TIME" DATE 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_LOG_API"."ID" IS '编号';
COMMENT ON COLUMN "BLADE_LOG_API"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_LOG_API"."SERVICE_ID" IS '服务ID';
COMMENT ON COLUMN "BLADE_LOG_API"."SERVER_HOST" IS '服务器名';
COMMENT ON COLUMN "BLADE_LOG_API"."SERVER_IP" IS '服务器IP地址';
COMMENT ON COLUMN "BLADE_LOG_API"."ENV" IS '服务器环境';
COMMENT ON COLUMN "BLADE_LOG_API"."TYPE" IS '日志类型';
COMMENT ON COLUMN "BLADE_LOG_API"."TITLE" IS '日志标题';
COMMENT ON COLUMN "BLADE_LOG_API"."METHOD" IS '操作方式';
COMMENT ON COLUMN "BLADE_LOG_API"."REQUEST_URI" IS '请求URI';
COMMENT ON COLUMN "BLADE_LOG_API"."USER_AGENT" IS '用户代理';
COMMENT ON COLUMN "BLADE_LOG_API"."REMOTE_IP" IS '操作IP地址';
COMMENT ON COLUMN "BLADE_LOG_API"."METHOD_CLASS" IS '方法类';
COMMENT ON COLUMN "BLADE_LOG_API"."METHOD_NAME" IS '方法名';
COMMENT ON COLUMN "BLADE_LOG_API"."PARAMS" IS '操作提交的数据';
COMMENT ON COLUMN "BLADE_LOG_API"."TIME" IS '执行时间';
COMMENT ON COLUMN "BLADE_LOG_API"."CREATE_BY" IS '创建者';
COMMENT ON COLUMN "BLADE_LOG_API"."CREATE_TIME" IS '创建时间';
COMMENT ON TABLE "BLADE_LOG_API" IS '接口日志表';

-- ----------------------------
-- Table structure for BLADE_LOG_ERROR
-- ----------------------------
-- DROP TABLE "BLADE_LOG_ERROR";
CREATE TABLE "BLADE_LOG_ERROR" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "SERVICE_ID" NVARCHAR2(32) ,
  "SERVER_HOST" NVARCHAR2(255) ,
  "SERVER_IP" NVARCHAR2(255) ,
  "ENV" NVARCHAR2(255) ,
  "METHOD" NVARCHAR2(10) ,
  "REQUEST_URI" NVARCHAR2(255) ,
  "USER_AGENT" NVARCHAR2(1000) ,
  "STACK_TRACE" NCLOB ,
  "EXCEPTION_NAME" NVARCHAR2(255) ,
  "MESSAGE" NCLOB ,
  "LINE_NUMBER" NUMBER(11) ,
  "METHOD_CLASS" NVARCHAR2(255) ,
  "FILE_NAME" NVARCHAR2(1000) ,
  "METHOD_NAME" NVARCHAR2(255) ,
  "PARAMS" NCLOB ,
  "CREATE_BY" NVARCHAR2(64) ,
  "CREATE_TIME" DATE 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536
  NEXT 1048576
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_LOG_ERROR"."ID" IS '编号';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."SERVICE_ID" IS '服务ID';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."SERVER_HOST" IS '服务器名';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."SERVER_IP" IS '服务器IP地址';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."ENV" IS '系统环境';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."METHOD" IS '操作方式';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."REQUEST_URI" IS '请求URI';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."USER_AGENT" IS '用户代理';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."STACK_TRACE" IS '堆栈';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."EXCEPTION_NAME" IS '异常名';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."MESSAGE" IS '异常信息';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."LINE_NUMBER" IS '错误行数';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."METHOD_CLASS" IS '方法类';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."FILE_NAME" IS '文件名';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."METHOD_NAME" IS '方法名';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."PARAMS" IS '操作提交的数据';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."CREATE_BY" IS '创建者';
COMMENT ON COLUMN "BLADE_LOG_ERROR"."CREATE_TIME" IS '创建时间';
COMMENT ON TABLE "BLADE_LOG_ERROR" IS '错误日志表';

-- ----------------------------
-- Table structure for BLADE_LOG_USUAL
-- ----------------------------
-- DROP TABLE "BLADE_LOG_USUAL";
CREATE TABLE "BLADE_LOG_USUAL" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "SERVICE_ID" NVARCHAR2(32) ,
  "SERVER_HOST" NVARCHAR2(255) ,
  "SERVER_IP" NVARCHAR2(255) ,
  "ENV" NVARCHAR2(255) ,
  "LOG_LEVEL" NVARCHAR2(10) ,
  "LOG_ID" NVARCHAR2(100) ,
  "LOG_DATA" NCLOB ,
  "METHOD" NVARCHAR2(10) ,
  "REQUEST_URI" NVARCHAR2(255) ,
  "USER_AGENT" NVARCHAR2(1000) ,
  "PARAMS" NCLOB ,
  "CREATE_BY" NVARCHAR2(64) ,
  "CREATE_TIME" DATE 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_LOG_USUAL"."ID" IS '编号';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."SERVICE_ID" IS '服务ID';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."SERVER_HOST" IS '服务器名';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."SERVER_IP" IS '服务器IP地址';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."ENV" IS '系统环境';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."LOG_LEVEL" IS '日志级别';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."LOG_ID" IS '日志业务ID';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."LOG_DATA" IS '日志数据';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."METHOD" IS '操作方式';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."REQUEST_URI" IS '请求URI';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."USER_AGENT" IS '用户代理';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."PARAMS" IS '操作提交的数据';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."CREATE_BY" IS '创建者';
COMMENT ON COLUMN "BLADE_LOG_USUAL"."CREATE_TIME" IS '创建时间';
COMMENT ON TABLE "BLADE_LOG_USUAL" IS '通用日志表';

-- ----------------------------
-- Table structure for BLADE_MENU
-- ----------------------------
-- DROP TABLE "BLADE_MENU";
CREATE TABLE "BLADE_MENU" (
  "ID" NUMBER(20) NOT NULL ,
  "PARENT_ID" NUMBER(20) ,
  "CODE" NVARCHAR2(255) ,
  "NAME" NVARCHAR2(255) ,
  "ALIAS" NVARCHAR2(255) ,
  "PATH" NVARCHAR2(255) ,
  "SOURCE" NVARCHAR2(255) ,
  "SORT" NUMBER(11) ,
  "CATEGORY" NUMBER(11) ,
  "ACTION" NUMBER(11) ,
  "IS_OPEN" NUMBER(11) ,
  "REMARK" NVARCHAR2(255) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_MENU"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_MENU"."PARENT_ID" IS '父级菜单';
COMMENT ON COLUMN "BLADE_MENU"."CODE" IS '菜单编号';
COMMENT ON COLUMN "BLADE_MENU"."NAME" IS '菜单名称';
COMMENT ON COLUMN "BLADE_MENU"."ALIAS" IS '菜单别名';
COMMENT ON COLUMN "BLADE_MENU"."PATH" IS '请求地址';
COMMENT ON COLUMN "BLADE_MENU"."SOURCE" IS '菜单资源';
COMMENT ON COLUMN "BLADE_MENU"."SORT" IS '排序';
COMMENT ON COLUMN "BLADE_MENU"."CATEGORY" IS '菜单类型';
COMMENT ON COLUMN "BLADE_MENU"."ACTION" IS '操作按钮类型';
COMMENT ON COLUMN "BLADE_MENU"."IS_OPEN" IS '是否打开新页面';
COMMENT ON COLUMN "BLADE_MENU"."REMARK" IS '备注';
COMMENT ON COLUMN "BLADE_MENU"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_MENU" IS '菜单表';

-- ----------------------------
-- Records of BLADE_MENU
-- ----------------------------
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675201', '0', 'desk', '工作台', 'menu', '/desk', 'iconfont iconicon_airplay', '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675202', '1123598815738675201', 'notice', '通知公告', 'menu', '/desk/notice', 'iconfont iconicon_sms', '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675203', '0', 'system', '系统管理', 'menu', '/system', 'iconfont iconicon_setting', '99', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675204', '1123598815738675203', 'user', '用户管理', 'menu', '/system/user', 'iconfont iconicon_principal', '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675205', '1123598815738675203', 'dept', '机构管理', 'menu', '/system/dept', 'iconfont iconicon_group', '2', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675206', '1123598815738675203', 'dict', '字典管理', 'menu', '/system/dict', 'iconfont iconicon_addresslist', '3', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675207', '1123598815738675203', 'menu', '菜单管理', 'menu', '/system/menu', 'iconfont iconicon_subordinate', '4', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675208', '1123598815738675203', 'topmenu', '顶部菜单', 'menu', '/system/topmenu', 'iconfont icon-canshu', '5', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675209', '1123598815738675203', 'param', '参数管理', 'menu', '/system/param', 'iconfont iconicon_community_line', '6', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675210', '0', 'monitor', '系统监控', 'menu', '/monitor', 'iconfont icon-yanzhengma', '3', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675211', '1123598815738675210', 'doc', '接口文档', 'menu', 'http://localhost/doc.html', 'iconfont iconicon_study', '1', '1', '0', '2', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675212', '1123598815738675210', 'admin', '服务治理', 'menu', 'http://localhost:7002', 'iconfont icon-canshu', '2', '1', '0', '2', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675213', '1123598815738675210', 'log', '日志管理', 'menu', '/monitor/log', 'iconfont iconicon_doc', '3', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675214', '1123598815738675213', 'log_usual', '通用日志', 'menu', '/monitor/log/usual', NULL, '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675215', '1123598815738675213', 'log_api', '接口日志', 'menu', '/monitor/log/api', NULL, '2', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675216', '1123598815738675213', 'log_error', '错误日志', 'menu', '/monitor/log/error', NULL, '3', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675217', '0', 'tool', '研发工具', 'menu', '/tool', 'iconfont icon-wxbgongju', '4', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675218', '1123598815738675217', 'code', '代码生成', 'menu', '/tool/code', 'iconfont iconicon_savememo', '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675219', '1123598815738675202', 'notice_add', '新增', 'add', '/desk/notice/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675220', '1123598815738675202', 'notice_edit', '修改', 'edit', '/desk/notice/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675221', '1123598815738675202', 'notice_delete', '删除', 'delete', '/api/blade-desk/notice/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675222', '1123598815738675202', 'notice_view', '查看', 'view', '/desk/notice/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675223', '1123598815738675204', 'user_add', '新增', 'add', '/system/user/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675224', '1123598815738675204', 'user_edit', '修改', 'edit', '/system/user/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675225', '1123598815738675204', 'user_delete', '删除', 'delete', '/api/blade-user/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675226', '1123598815738675204', 'user_role', '角色配置', 'role', NULL, 'user-add', '4', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675227', '1123598815738675204', 'user_reset', '密码重置', 'reset-password', '/api/blade-user/reset-password', 'retweet', '5', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675228', '1123598815738675204', 'user_view', '查看', 'view', '/system/user/view', 'file-text', '6', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675229', '1123598815738675205', 'dept_add', '新增', 'add', '/system/dept/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675230', '1123598815738675205', 'dept_edit', '修改', 'edit', '/system/dept/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675231', '1123598815738675205', 'dept_delete', '删除', 'delete', '/api/blade-system/dept/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675232', '1123598815738675205', 'dept_view', '查看', 'view', '/system/dept/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675233', '1123598815738675206', 'dict_add', '新增', 'add', '/system/dict/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675234', '1123598815738675206', 'dict_edit', '修改', 'edit', '/system/dict/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675235', '1123598815738675206', 'dict_delete', '删除', 'delete', '/api/blade-system/dict/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675236', '1123598815738675206', 'dict_view', '查看', 'view', '/system/dict/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675237', '1123598815738675207', 'menu_add', '新增', 'add', '/system/menu/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675238', '1123598815738675207', 'menu_edit', '修改', 'edit', '/system/menu/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675239', '1123598815738675207', 'menu_delete', '删除', 'delete', '/api/blade-system/menu/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675240', '1123598815738675207', 'menu_view', '查看', 'view', '/system/menu/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675241', '1123598815738675308', 'role_add', '新增', 'add', '/authority/role/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675242', '1123598815738675308', 'role_edit', '修改', 'edit', '/authority/role/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675243', '1123598815738675308', 'role_delete', '删除', 'delete', '/api/blade-system/role/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675244', '1123598815738675308', 'role_view', '查看', 'view', '/authority/role/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675245', '1123598815738675209', 'param_add', '新增', 'add', '/system/param/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675246', '1123598815738675209', 'param_edit', '修改', 'edit', '/system/param/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675247', '1123598815738675209', 'param_delete', '删除', 'delete', '/api/blade-system/param/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675248', '1123598815738675209', 'param_view', '查看', 'view', '/system/param/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675249', '1123598815738675214', 'log_usual_view', '查看', 'view', '/monitor/log/usual/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675250', '1123598815738675215', 'log_api_view', '查看', 'view', '/monitor/log/api/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675251', '1123598815738675216', 'log_error_view', '查看', 'view', '/monitor/log/error/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675252', '1123598815738675218', 'code_add', '新增', 'add', '/tool/code/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675253', '1123598815738675218', 'code_edit', '修改', 'edit', '/tool/code/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675254', '1123598815738675218', 'code_delete', '删除', 'delete', '/api/blade-system/code/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675255', '1123598815738675218', 'code_view', '查看', 'view', '/tool/code/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675256', '1123598815738675203', 'tenant', '租户管理', 'menu', '/system/tenant', 'iconfont icon-quanxian', '7', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675257', '1123598815738675256', 'tenant_add', '新增', 'add', '/system/tenant/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675258', '1123598815738675256', 'tenant_edit', '修改', 'edit', '/system/tenant/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675259', '1123598815738675256', 'tenant_delete', '删除', 'delete', '/api/blade-system/tenant/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675260', '1123598815738675256', 'tenant_view', '查看', 'view', '/system/tenant/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675261', '1123598815738675203', 'client', '应用管理', 'menu', '/system/client', 'iconfont iconicon_mobilephone', '8', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675262', '1123598815738675261', 'client_add', '新增', 'add', '/system/client/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675263', '1123598815738675261', 'client_edit', '修改', 'edit', '/system/client/edit', 'form', '2', '2', '2', '2', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675264', '1123598815738675261', 'client_delete', '删除', 'delete', '/api/blade-system/client/remove', 'delete', '3', '2', '3', '3', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675265', '1123598815738675261', 'client_view', '查看', 'view', '/system/client/view', 'file-text', '4', '2', '2', '2', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675266', '0', 'flow', '流程管理', 'menu', '/flow', 'iconfont iconicon_send', '5', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675267', '1123598815738675266', 'flow_model', '模型管理', 'menu', '/flow/model', 'iconfont iconicon_discovery', '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675268', '1123598815738675267', 'flow_model_create', '创建', 'create', NULL, 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675269', '1123598815738675267', 'flow_model_update', '编辑', 'update', NULL, 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675270', '1123598815738675267', 'flow_model_deploy', '部署', 'deploy', NULL, 'cloud-upload', '3', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675271', '1123598815738675267', 'flow_model_download', '下载', 'download', NULL, 'download', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675272', '1123598815738675267', 'flow_model_delete', '删除', 'delete', '/api/blade-flow/model/remove', 'delete', '5', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675273', '1123598815738675266', 'flow_deploy', '流程部署', 'menu', '/flow/deploy', 'iconfont iconicon_cspace', '2', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675274', '1123598815738675266', 'flow_manager', '流程管理', 'menu', '/flow/manager', 'iconfont iconicon_cloud_history', '3', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675275', '1123598815738675274', 'flow_manager_state', '变更状态', 'state', NULL, 'plus', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675276', '1123598815738675274', 'flow_manager_image', '流程图', 'image', NULL, 'image', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675277', '1123598815738675274', 'flow_manager_remove', '删除', 'remove', NULL, 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675278', '1123598815738675266', 'flow_follow', '流程跟踪', 'menu', '/flow/follow', 'iconfont iconicon_GPS', '4', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675279', '1123598815738675278', 'flow_follow_delete', '删除', 'remove', NULL, 'remove', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675280', '0', 'work', '我的事务', 'menu', '/work', 'iconfont iconicon_notice', '2', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675281', '1123598815738675280', 'work_start', '发起事务', 'menu', '/work/start', 'iconfont iconicon_compile', '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675282', '1123598815738675281', 'work_start_flow', '发起', 'flow', NULL, 'flow', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675283', '1123598815738675281', 'work_start_image', '流程图', 'image', NULL, 'image', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675284', '1123598815738675280', 'work_claim', '待签事务', 'menu', '/work/claim', 'iconfont iconicon_ding', '2', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675285', '1123598815738675284', 'work_claim_sign', '签收', 'sign', NULL, 'sign', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675286', '1123598815738675284', 'work_claim_detail', '详情', 'detail', NULL, 'detail', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675287', '1123598815738675284', 'work_claim_follow', '跟踪', 'follow', NULL, 'follow', '3', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675288', '1123598815738675280', 'work_todo', '待办事务', 'menu', '/work/todo', 'iconfont iconicon_savememo', '2', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675289', '1123598815738675288', 'work_todo_handle', '办理', 'handle', NULL, 'handle', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675290', '1123598815738675288', 'work_todo_detail', '详情', 'detail', NULL, 'detail', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675291', '1123598815738675288', 'work_todo_follow', '跟踪', 'follow', NULL, 'follow', '3', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675292', '1123598815738675280', 'work_send', '已发事务', 'menu', '/work/send', 'iconfont iconicon_doc', '3', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675293', '1123598815738675292', 'work_send_detail', '详情', 'detail', NULL, 'detail', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675294', '1123598815738675292', 'work_send_follow', '跟踪', 'follow', NULL, 'follow', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675295', '1123598815738675280', 'work_done', '办结事务', 'menu', '/work/done', 'iconfont iconicon_dispose', '4', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675296', '1123598815738675295', 'work_done_detail', '详情', 'detail', NULL, 'detail', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675297', '1123598815738675295', 'work_done_follow', '跟踪', 'follow', NULL, 'follow', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675298', '0', 'resource', '资源管理', 'menu', '/resource', 'iconfont iconicon_coinpurse_line', '6', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675299', '1123598815738675298', 'oss', '对象存储', 'menu', '/resource/oss', 'iconfont iconicon_subordinate', '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675301', '1123598815738675299', 'oss_add', '新增', 'add', '/resource/oss/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675302', '1123598815738675299', 'oss_edit', '修改', 'edit', '/resource/oss/edit', 'form', '2', '2', '2', '2', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675303', '1123598815738675299', 'oss_delete', '删除', 'delete', '/api/blade-resource/oss/remove', 'delete', '3', '2', '3', '3', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675304', '1123598815738675299', 'oss_view', '查看', 'view', '/resource/oss/view', 'file-text', '4', '2', '2', '2', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675305', '1123598815738675299', 'oss_enable', '启用', 'enable', '/api/blade-resource/oss/enable', 'key', '5', '2', '2', '2', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675307', '0', 'authority', '权限管理', 'menu', '/authority', 'iconfont icon-bofangqi-suoping', '98', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675308', '1123598815738675307', 'role', '角色管理', 'menu', '/authority/role', 'iconfont iconicon_boss', '1', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675309', '1123598815738675307', 'data_scope', '数据权限', 'menu', '/authority/datascope', 'iconfont icon-shujuzhanshi2', '2', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675310', '1123598815738675309', 'data_scope_setting', '权限配置', 'setting', NULL, 'setting', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675311', '1123598815738675307', 'api_scope', '接口权限', 'menu', '/authority/apiscope', 'iconfont icon-iconset0216', '3', '1', '0', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675312', '1123598815738675311', 'api_scope_setting', '权限配置', 'setting', NULL, 'setting', '1', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675313', '1123598815738675208', 'topmenu_add', '新增', 'add', '/system/topmenu/add', 'plus', '1', '2', '1', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675314', '1123598815738675208', 'topmenu_edit', '修改', 'edit', '/system/topmenu/edit', 'form', '2', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675315', '1123598815738675208', 'topmenu_delete', '删除', 'delete', '/api/blade-system/topmenu/remove', 'delete', '3', '2', '3', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675316', '1123598815738675208', 'topmenu_view', '查看', 'view', '/system/topmenu/view', 'file-text', '4', '2', '2', '1', NULL, '0');
INSERT INTO "BLADE_MENU" VALUES ('1123598815738675317', '1123598815738675208', 'topmenu_setting', '菜单配置', 'setting', NULL, 'setting', '5', '2', '1', '1', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_NOTICE
-- ----------------------------
-- DROP TABLE "BLADE_NOTICE";
CREATE TABLE "BLADE_NOTICE" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "TITLE" NVARCHAR2(255) ,
  "CATEGORY" NUMBER(11) ,
  "RELEASE_TIME" DATE ,
  "CONTENT" NVARCHAR2(2000) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_NOTICE"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_NOTICE"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_NOTICE"."TITLE" IS '标题';
COMMENT ON COLUMN "BLADE_NOTICE"."CATEGORY" IS '类型';
COMMENT ON COLUMN "BLADE_NOTICE"."RELEASE_TIME" IS '发布时间';
COMMENT ON COLUMN "BLADE_NOTICE"."CONTENT" IS '内容';
COMMENT ON COLUMN "BLADE_NOTICE"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_NOTICE"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_NOTICE"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_NOTICE"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_NOTICE"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_NOTICE"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_NOTICE"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_NOTICE" IS '通知公告表';

-- ----------------------------
-- Records of BLADE_NOTICE
-- ----------------------------
INSERT INTO "BLADE_NOTICE" VALUES ('1123598818738675223', '000000', '测试公告', '3', TO_DATE('2018-12-31 20:03:31', 'SYYYY-MM-DD HH24:MI:SS'), '222', '1123598821738675201', '1123598813738675201', TO_DATE('2018-12-05 20:03:31', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2018-12-28 11:10:51', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
INSERT INTO "BLADE_NOTICE" VALUES ('1123598818738675224', '000000', '测试公告2', '1', TO_DATE('2018-12-05 20:03:31', 'SYYYY-MM-DD HH24:MI:SS'), '333', '1123598821738675201', '1123598813738675201', TO_DATE('2018-12-28 10:32:26', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2018-12-28 11:10:34', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
INSERT INTO "BLADE_NOTICE" VALUES ('1123598818738675225', '000000', '测试公告3', '6', TO_DATE('2018-12-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '11111', '1123598821738675201', '1123598813738675201', TO_DATE('2018-12-28 11:03:44', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2018-12-28 11:10:28', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_OSS
-- ----------------------------
-- DROP TABLE "BLADE_OSS";
CREATE TABLE "BLADE_OSS" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "CATEGORY" NUMBER(11) ,
  "ENDPOINT" NVARCHAR2(255) ,
  "ACCESS_KEY" NVARCHAR2(255) ,
  "SECRET_KEY" NVARCHAR2(255) ,
  "BUCKET_NAME" NVARCHAR2(255) ,
  "REMARK" NVARCHAR2(255) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_OSS"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_OSS"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_OSS"."CATEGORY" IS '分类';
COMMENT ON COLUMN "BLADE_OSS"."ENDPOINT" IS '资源地址';
COMMENT ON COLUMN "BLADE_OSS"."ACCESS_KEY" IS 'accessKey';
COMMENT ON COLUMN "BLADE_OSS"."SECRET_KEY" IS 'secretKey';
COMMENT ON COLUMN "BLADE_OSS"."BUCKET_NAME" IS '空间名';
COMMENT ON COLUMN "BLADE_OSS"."REMARK" IS '备注';
COMMENT ON COLUMN "BLADE_OSS"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_OSS"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_OSS"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_OSS"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_OSS"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_OSS"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_OSS"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_OSS" IS '对象存储表';

-- ----------------------------
-- Records of BLADE_OSS
-- ----------------------------
INSERT INTO "BLADE_OSS" VALUES ('1132486733992468482', '000000', '1', 'http://127.0.0.1:9000', 'D99KGE6ZTQXSATTJWU24', 'QyVqGnhIQQE734UYSUFlGOZViE6+ZlDEfUG3NjhJ', 'bladex', NULL, '1123598821738675201', '1123598813738675201', TO_DATE('2019-05-26 11:20:52', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2019-05-27 08:34:55', 'SYYYY-MM-DD HH24:MI:SS'), '2', '0');
INSERT INTO "BLADE_OSS" VALUES ('1132487155981393922', '000000', '2', 'ps458elcs.bkt.clouddn.com', 'N_Loh1ngBqcJovwiAJqR91Ifj2vgOWHOf8AwBA_h', 'AuzuA1KHAbkIndCU0dB3Zfii2O3crHNODDmpxHRS', 'bladex', NULL, '1123598821738675201', '1123598813738675201', TO_DATE('2019-05-26 11:22:33', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2019-05-26 23:27:56', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_PARAM
-- ----------------------------
-- DROP TABLE "BLADE_PARAM";
CREATE TABLE "BLADE_PARAM" (
  "ID" NUMBER(20) NOT NULL ,
  "PARAM_NAME" NVARCHAR2(255) ,
  "PARAM_KEY" NVARCHAR2(255) ,
  "PARAM_VALUE" NVARCHAR2(255) ,
  "REMARK" NVARCHAR2(255) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_PARAM"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_PARAM"."PARAM_NAME" IS '参数名';
COMMENT ON COLUMN "BLADE_PARAM"."PARAM_KEY" IS '参数键';
COMMENT ON COLUMN "BLADE_PARAM"."PARAM_VALUE" IS '参数值';
COMMENT ON COLUMN "BLADE_PARAM"."REMARK" IS '备注';
COMMENT ON COLUMN "BLADE_PARAM"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_PARAM"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_PARAM"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_PARAM"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_PARAM"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_PARAM"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_PARAM"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_PARAM" IS '参数表';

-- ----------------------------
-- Records of BLADE_PARAM
-- ----------------------------
INSERT INTO "BLADE_PARAM" VALUES ('1123598819738675201', '是否开启注册功能', 'ACCOUNT.registerUser', 'true', '开启注册', '1123598821738675201', '1123598813738675201', TO_DATE('2018-12-28 12:19:01', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2018-12-28 12:19:01', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
INSERT INTO "BLADE_PARAM" VALUES ('1123598819738675202', '账号初始密码', 'ACCOUNT.initPassword', '123456', '初始密码', '1123598821738675201', '1123598813738675201', TO_DATE('2018-12-28 12:19:01', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2018-12-28 12:19:01', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_PROCESS_LEAVE
-- ----------------------------
-- DROP TABLE "BLADE_PROCESS_LEAVE";
CREATE TABLE "BLADE_PROCESS_LEAVE" (
  "ID" NUMBER(20) NOT NULL ,
  "PROCESS_DEFINITION_ID" NVARCHAR2(64) ,
  "PROCESS_INSTANCE_ID" NVARCHAR2(64) ,
  "START_TIME" DATE ,
  "END_TIME" DATE ,
  "REASON" NVARCHAR2(255) ,
  "TASK_USER" NVARCHAR2(255) ,
  "apply_TIME" DATE ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."ID" IS '编号';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."PROCESS_DEFINITION_ID" IS '流程定义主键';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."PROCESS_INSTANCE_ID" IS '流程实例主键';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."START_TIME" IS '开始时间';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."END_TIME" IS '结束时间';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."REASON" IS '请假理由';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."TASK_USER" IS '第一级审批人';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."apply_TIME" IS '申请时间';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_PROCESS_LEAVE"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_PROCESS_LEAVE" IS '流程请假业务表';

-- ----------------------------
-- Table structure for BLADE_ROLE
-- ----------------------------
-- DROP TABLE "BLADE_ROLE";
CREATE TABLE "BLADE_ROLE" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "PARENT_ID" NUMBER(20) ,
  "ROLE_NAME" NVARCHAR2(255) ,
  "SORT" NUMBER(11) ,
  "ROLE_ALIAS" NVARCHAR2(255) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_ROLE"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_ROLE"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_ROLE"."PARENT_ID" IS '父主键';
COMMENT ON COLUMN "BLADE_ROLE"."ROLE_NAME" IS '角色名';
COMMENT ON COLUMN "BLADE_ROLE"."SORT" IS '排序';
COMMENT ON COLUMN "BLADE_ROLE"."ROLE_ALIAS" IS '角色别名';
COMMENT ON COLUMN "BLADE_ROLE"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_ROLE" IS '角色表';

-- ----------------------------
-- Records of BLADE_ROLE
-- ----------------------------
INSERT INTO "BLADE_ROLE" VALUES ('1123598816738675201', '000000', '0', '超级管理员', '1', 'administrator', '0');
INSERT INTO "BLADE_ROLE" VALUES ('1123598816738675202', '000000', '0', '用户', '2', 'user', '0');
INSERT INTO "BLADE_ROLE" VALUES ('1123598816738675203', '000000', '1123598816738675202', '人事', '1', 'hr', '0');
INSERT INTO "BLADE_ROLE" VALUES ('1123598816738675204', '000000', '1123598816738675202', '经理', '2', 'manager', '0');
INSERT INTO "BLADE_ROLE" VALUES ('1123598816738675205', '000000', '1123598816738675202', '老板', '3', 'boss', '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_ROLE_MENU
-- ----------------------------
-- DROP TABLE "BLADE_ROLE_MENU";
CREATE TABLE "BLADE_ROLE_MENU" (
  "ID" NUMBER(20) NOT NULL ,
  "MENU_ID" NUMBER(20) ,
  "ROLE_ID" NUMBER(20) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_ROLE_MENU"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_ROLE_MENU"."MENU_ID" IS '菜单ID';
COMMENT ON COLUMN "BLADE_ROLE_MENU"."ROLE_ID" IS '角色ID';
COMMENT ON TABLE "BLADE_ROLE_MENU" IS '角色菜单关联表';

-- ----------------------------
-- Records of BLADE_ROLE_MENU
-- ----------------------------
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675363', '1123598815738675201', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675364', '1123598815738675202', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675365', '1123598815738675219', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675366', '1123598815738675220', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675367', '1123598815738675221', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675368', '1123598815738675222', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675369', '1123598815738675280', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675370', '1123598815738675281', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675371', '1123598815738675282', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675372', '1123598815738675283', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675373', '1123598815738675284', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675374', '1123598815738675285', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675375', '1123598815738675286', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675376', '1123598815738675287', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675377', '1123598815738675288', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675378', '1123598815738675289', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675379', '1123598815738675290', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675380', '1123598815738675291', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675381', '1123598815738675292', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675382', '1123598815738675293', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675383', '1123598815738675294', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675384', '1123598815738675295', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675385', '1123598815738675296', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675386', '1123598815738675297', '1123598816738675202');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675387', '1123598815738675201', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675388', '1123598815738675202', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675389', '1123598815738675219', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675390', '1123598815738675220', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675391', '1123598815738675221', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675392', '1123598815738675222', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675393', '1123598815738675280', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675394', '1123598815738675281', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675395', '1123598815738675282', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675396', '1123598815738675283', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675397', '1123598815738675284', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675398', '1123598815738675285', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675399', '1123598815738675286', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675400', '1123598815738675287', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675401', '1123598815738675288', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675402', '1123598815738675289', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675403', '1123598815738675290', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675404', '1123598815738675291', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675405', '1123598815738675292', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675406', '1123598815738675293', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675407', '1123598815738675294', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675408', '1123598815738675295', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675409', '1123598815738675296', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675410', '1123598815738675297', '1123598816738675203');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675411', '1123598815738675201', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675412', '1123598815738675202', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675413', '1123598815738675219', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675414', '1123598815738675220', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675415', '1123598815738675221', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675416', '1123598815738675222', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675417', '1123598815738675280', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675418', '1123598815738675281', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675419', '1123598815738675282', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675420', '1123598815738675283', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675421', '1123598815738675284', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675422', '1123598815738675285', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675423', '1123598815738675286', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675424', '1123598815738675287', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675425', '1123598815738675288', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675426', '1123598815738675289', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675427', '1123598815738675290', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675428', '1123598815738675291', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675429', '1123598815738675292', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675430', '1123598815738675293', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675431', '1123598815738675294', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675432', '1123598815738675295', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675433', '1123598815738675296', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675434', '1123598815738675297', '1123598816738675204');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675435', '1123598815738675201', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675436', '1123598815738675202', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675437', '1123598815738675219', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675438', '1123598815738675220', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675439', '1123598815738675221', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675440', '1123598815738675222', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675441', '1123598815738675280', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675442', '1123598815738675281', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675443', '1123598815738675282', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675444', '1123598815738675283', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675445', '1123598815738675284', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675446', '1123598815738675285', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675447', '1123598815738675286', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675448', '1123598815738675287', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675449', '1123598815738675288', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675450', '1123598815738675289', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675451', '1123598815738675290', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675452', '1123598815738675291', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675453', '1123598815738675292', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675454', '1123598815738675293', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675455', '1123598815738675294', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675456', '1123598815738675295', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675457', '1123598815738675296', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1123598817738675458', '1123598815738675297', '1123598816738675205');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149888293856833539', '1123598815738675317', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666312130561', '1123598815738675201', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666370850818', '1123598815738675202', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666437959682', '1123598815738675219', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666505068546', '1123598815738675220', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666555400193', '1123598815738675221', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666614120449', '1123598815738675222', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666651869185', '1123598815738675280', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666723172353', '1123598815738675281', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666765115393', '1123598815738675282', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666815447041', '1123598815738675283', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666844807170', '1123598815738675284', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666886750210', '1123598815738675285', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666924498946', '1123598815738675286', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891666966441986', '1123598815738675287', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667012579330', '1123598815738675288', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667054522370', '1123598815738675289', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667109048322', '1123598815738675290', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667146797058', '1123598815738675291', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667197128706', '1123598815738675292', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667234877441', '1123598815738675293', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667272626178', '1123598815738675294', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667314569218', '1123598815738675295', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667343929346', '1123598815738675296', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667398455298', '1123598815738675297', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667440398338', '1123598815738675210', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667478147073', '1123598815738675211', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667524284417', '1123598815738675212', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667574616065', '1123598815738675213', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667608170498', '1123598815738675214', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667641724929', '1123598815738675249', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667671085058', '1123598815738675215', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667708833793', '1123598815738675250', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667746582529', '1123598815738675216', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667784331265', '1123598815738675251', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667822080001', '1123598815738675217', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667843051522', '1123598815738675218', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667889188865', '1123598815738675252', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667926937602', '1123598815738675253', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667947909121', '1123598815738675254', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891667989852161', '1123598815738675255', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668015017986', '1123598815738675266', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668061155330', '1123598815738675267', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668086321154', '1123598815738675268', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668136652802', '1123598815738675269', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668199567362', '1123598815738675270', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668262481922', '1123598815738675271', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668321202177', '1123598815738675272', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668367339521', '1123598815738675273', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668405088257', '1123598815738675274', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668438642689', '1123598815738675275', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668472197121', '1123598815738675276', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668509945858', '1123598815738675277', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668568666113', '1123598815738675278', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668631580673', '1123598815738675279', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668669329410', '1123598815738675298', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668719661057', '1123598815738675299', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668757409793', '1123598815738675301', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668803547138', '1123598815738675302', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668849684481', '1123598815738675303', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668883238913', '1123598815738675304', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668920987650', '1123598815738675305', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668950347777', '1123598815738675307', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891668983902209', '1123598815738675308', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669013262338', '1123598815738675241', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669034233857', '1123598815738675242', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669055205378', '1123598815738675243', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669105537025', '1123598815738675244', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669164257282', '1123598815738675309', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669210394626', '1123598815738675310', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669243949058', '1123598815738675311', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669285892097', '1123598815738675312', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669336223745', '1123598815738675203', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669365583873', '1123598815738675204', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669394944001', '1123598815738675223', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669441081346', '1123598815738675224', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669487218689', '1123598815738675225', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669533356033', '1123598815738675226', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669571104770', '1123598815738675227', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669642407937', '1123598815738675228', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669671768065', '1123598815738675205', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669696933889', '1123598815738675229', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669743071234', '1123598815738675230', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669797597186', '1123598815738675231', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669847928834', '1123598815738675232', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669919232001', '1123598815738675206', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891669973757954', '1123598815738675233', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670019895298', '1123598815738675234', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670045061121', '1123598815738675235', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670095392770', '1123598815738675236', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670137335809', '1123598815738675207', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670196056065', '1123598815738675237', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670229610498', '1123598815738675238', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670267359234', '1123598815738675239', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670292525057', '1123598815738675240', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670355439617', '1123598815738675306', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670380605442', '1123598815738675208', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670443520001', '1123598815738675313', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670481268737', '1123598815738675314', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670506434561', '1123598815738675315', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670569349121', '1123598815738675316', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670594514945', '1123598815738675209', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670657429506', '1123598815738675245', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670682595330', '1123598815738675246', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670711955457', '1123598815738675247', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670745509889', '1123598815738675248', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670804230146', '1123598815738675256', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670841978881', '1123598815738675257', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670879727617', '1123598815738675258', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670913282050', '1123598815738675259', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670959419394', '1123598815738675260', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891670988779521', '1123598815738675261', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891671039111170', '1123598815738675262', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891671068471297', '1123598815738675263', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891671110414338', '1123598815738675264', '1123598816738675201');
INSERT INTO "BLADE_ROLE_MENU" VALUES ('1149891671152357378', '1123598815738675265', '1123598816738675201');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_ROLE_SCOPE
-- ----------------------------
-- DROP TABLE "BLADE_ROLE_SCOPE";
CREATE TABLE "BLADE_ROLE_SCOPE" (
  "ID" NUMBER(20) NOT NULL ,
  "SCOPE_CATEGORY" NUMBER(11) ,
  "SCOPE_ID" NUMBER(20) ,
  "ROLE_ID" NUMBER(20) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_ROLE_SCOPE"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_ROLE_SCOPE"."SCOPE_CATEGORY" IS '权限类型(1:数据权限、2:接口权限)';
COMMENT ON COLUMN "BLADE_ROLE_SCOPE"."SCOPE_ID" IS '权限ID';
COMMENT ON COLUMN "BLADE_ROLE_SCOPE"."ROLE_ID" IS '角色ID';
COMMENT ON TABLE "BLADE_ROLE_SCOPE" IS '角色数据权限关联表';

-- ----------------------------
-- Table structure for BLADE_SCOPE_API
-- ----------------------------
-- DROP TABLE "BLADE_SCOPE_API";
CREATE TABLE "BLADE_SCOPE_API" (
  "ID" NUMBER(20) NOT NULL ,
  "MENU_ID" NUMBER(20) ,
  "RESOURCE_CODE" NVARCHAR2(255) ,
  "SCOPE_NAME" NVARCHAR2(255) ,
  "SCOPE_PATH" NVARCHAR2(255) ,
  "SCOPE_TYPE" NUMBER(11) ,
  "REMARK" NVARCHAR2(255) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_SCOPE_API"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_SCOPE_API"."MENU_ID" IS '菜单主键';
COMMENT ON COLUMN "BLADE_SCOPE_API"."RESOURCE_CODE" IS '资源编号';
COMMENT ON COLUMN "BLADE_SCOPE_API"."SCOPE_NAME" IS '接口权限名';
COMMENT ON COLUMN "BLADE_SCOPE_API"."SCOPE_PATH" IS '接口权限地址';
COMMENT ON COLUMN "BLADE_SCOPE_API"."SCOPE_TYPE" IS '接口权限类型';
COMMENT ON COLUMN "BLADE_SCOPE_API"."REMARK" IS '接口权限备注';
COMMENT ON COLUMN "BLADE_SCOPE_API"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_SCOPE_API"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_SCOPE_API"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_SCOPE_API"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_SCOPE_API"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_SCOPE_API"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_SCOPE_API"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_SCOPE_API" IS '接口权限表';

-- ----------------------------
-- Table structure for BLADE_SCOPE_DATA
-- ----------------------------
-- DROP TABLE "BLADE_SCOPE_DATA";
CREATE TABLE "BLADE_SCOPE_DATA" (
  "ID" NUMBER(20) NOT NULL ,
  "MENU_ID" NUMBER(20) ,
  "RESOURCE_CODE" NVARCHAR2(255) ,
  "SCOPE_NAME" NVARCHAR2(255) ,
  "SCOPE_FIELD" NVARCHAR2(255) ,
  "SCOPE_CLASS" NVARCHAR2(500) ,
  "SCOPE_COLUMN" NVARCHAR2(255) ,
  "SCOPE_TYPE" NUMBER(11) ,
  "SCOPE_VALUE" NCLOB ,
  "REMARK" NVARCHAR2(255) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."MENU_ID" IS '菜单主键';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."RESOURCE_CODE" IS '资源编号';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."SCOPE_NAME" IS '数据权限名称';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."SCOPE_FIELD" IS '数据权限字段';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."SCOPE_CLASS" IS '数据权限类名';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."SCOPE_COLUMN" IS '数据权限字段';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."SCOPE_TYPE" IS '数据权限类型';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."SCOPE_VALUE" IS '数据权限值域';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."REMARK" IS '数据权限备注';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_SCOPE_DATA"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_SCOPE_DATA" IS '数据权限表';

-- ----------------------------
-- Table structure for BLADE_TENANT
-- ----------------------------
-- DROP TABLE "BLADE_TENANT";
CREATE TABLE "BLADE_TENANT" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "TENANT_NAME" NVARCHAR2(50) NOT NULL ,
  "LINKMAN" NVARCHAR2(20) ,
  "CONTACT_NUMBER" NVARCHAR2(20) ,
  "ADDRESS" NVARCHAR2(255) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_TENANT"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_TENANT"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_TENANT"."TENANT_NAME" IS '租户名称';
COMMENT ON COLUMN "BLADE_TENANT"."LINKMAN" IS '联系人';
COMMENT ON COLUMN "BLADE_TENANT"."CONTACT_NUMBER" IS '联系电话';
COMMENT ON COLUMN "BLADE_TENANT"."ADDRESS" IS '联系地址';
COMMENT ON COLUMN "BLADE_TENANT"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_TENANT"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_TENANT"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_TENANT"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_TENANT"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_TENANT"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_TENANT"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_TENANT" IS '租户表';

-- ----------------------------
-- Records of BLADE_TENANT
-- ----------------------------
INSERT INTO "BLADE_TENANT" VALUES ('1123598820738675201', '000000', '管理组', 'admin', '666666', '管理组', '1123598821738675201', '1123598813738675201', TO_DATE('2019-01-01 00:00:39', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2019-01-01 00:00:39', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
COMMIT;

-- ----------------------------
-- Table structure for BLADE_TOP_MENU
-- ----------------------------
-- DROP TABLE "BLADE_TOP_MENU";
CREATE TABLE "BLADE_TOP_MENU" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "CODE" NVARCHAR2(255) ,
  "NAME" NVARCHAR2(255) ,
  "SOURCE" NVARCHAR2(255) ,
  "SORT" NUMBER(11) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_TOP_MENU"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_TOP_MENU"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_TOP_MENU"."CODE" IS '顶部菜单编号';
COMMENT ON COLUMN "BLADE_TOP_MENU"."NAME" IS '顶部菜单名';
COMMENT ON COLUMN "BLADE_TOP_MENU"."SOURCE" IS '顶部菜单资源';
COMMENT ON COLUMN "BLADE_TOP_MENU"."SORT" IS '顶部菜单排序';
COMMENT ON COLUMN "BLADE_TOP_MENU"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_TOP_MENU"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_TOP_MENU"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_TOP_MENU"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_TOP_MENU"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_TOP_MENU"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_TOP_MENU"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_TOP_MENU" IS '顶部菜单表';

-- ----------------------------
-- Table structure for BLADE_TOP_MENU_SETTING
-- ----------------------------
-- DROP TABLE "BLADE_TOP_MENU_SETTING";
CREATE TABLE "BLADE_TOP_MENU_SETTING" (
  "ID" NUMBER(20) NOT NULL ,
  "TOP_MENU_ID" NUMBER(20) ,
  "MENU_ID" NUMBER(20) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_TOP_MENU_SETTING"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_TOP_MENU_SETTING"."TOP_MENU_ID" IS '顶部菜单主键';
COMMENT ON COLUMN "BLADE_TOP_MENU_SETTING"."MENU_ID" IS '菜单主键';
COMMENT ON TABLE "BLADE_TOP_MENU_SETTING" IS '顶部菜单配置表';

-- ----------------------------
-- Table structure for BLADE_USER
-- ----------------------------
-- DROP TABLE "BLADE_USER";
CREATE TABLE "BLADE_USER" (
  "ID" NUMBER(20) NOT NULL ,
  "TENANT_ID" NVARCHAR2(12) ,
  "ACCOUNT" NVARCHAR2(45) ,
  "PASSWORD" NVARCHAR2(45) ,
  "NAME" NVARCHAR2(20) ,
  "REAL_NAME" NVARCHAR2(10) ,
  "EMAIL" NVARCHAR2(45) ,
  "PHONE" NVARCHAR2(45) ,
  "BIRTHDAY" DATE ,
  "SEX" NUMBER(6) ,
  "ROLE_ID" NVARCHAR2(1000) ,
  "DEPT_ID" NVARCHAR2(1000) ,
  "CREATE_USER" NUMBER(20) ,
  "CREATE_DEPT" NUMBER(20) ,
  "CREATE_TIME" DATE ,
  "UPDATE_USER" NUMBER(20) ,
  "UPDATE_TIME" DATE ,
  "STATUS" NUMBER(11) ,
  "IS_DELETED" NUMBER(11) 
)
TABLESPACE "BLADEX_BOOT"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "BLADE_USER"."ID" IS '主键';
COMMENT ON COLUMN "BLADE_USER"."TENANT_ID" IS '租户ID';
COMMENT ON COLUMN "BLADE_USER"."ACCOUNT" IS '账号';
COMMENT ON COLUMN "BLADE_USER"."PASSWORD" IS '密码';
COMMENT ON COLUMN "BLADE_USER"."NAME" IS '昵称';
COMMENT ON COLUMN "BLADE_USER"."REAL_NAME" IS '真名';
COMMENT ON COLUMN "BLADE_USER"."EMAIL" IS '邮箱';
COMMENT ON COLUMN "BLADE_USER"."PHONE" IS '手机';
COMMENT ON COLUMN "BLADE_USER"."BIRTHDAY" IS '生日';
COMMENT ON COLUMN "BLADE_USER"."SEX" IS '性别';
COMMENT ON COLUMN "BLADE_USER"."ROLE_ID" IS '角色ID';
COMMENT ON COLUMN "BLADE_USER"."DEPT_ID" IS '部门ID';
COMMENT ON COLUMN "BLADE_USER"."CREATE_USER" IS '创建人';
COMMENT ON COLUMN "BLADE_USER"."CREATE_DEPT" IS '创建部门';
COMMENT ON COLUMN "BLADE_USER"."CREATE_TIME" IS '创建时间';
COMMENT ON COLUMN "BLADE_USER"."UPDATE_USER" IS '修改人';
COMMENT ON COLUMN "BLADE_USER"."UPDATE_TIME" IS '修改时间';
COMMENT ON COLUMN "BLADE_USER"."STATUS" IS '状态';
COMMENT ON COLUMN "BLADE_USER"."IS_DELETED" IS '是否已删除';
COMMENT ON TABLE "BLADE_USER" IS '用户表';

-- ----------------------------
-- Records of BLADE_USER
-- ----------------------------
INSERT INTO "BLADE_USER" VALUES ('1123598821738675201', '000000', 'admin', '90b9aa7e25f80cf4f64e990b78a9fc5ebd6cecad', '管理员', '管理员', 'admin@bladex.vip', '123333333333', TO_DATE('2018-08-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '1', '1123598816738675201', '1123598813738675201', '1123598821738675201', '1123598813738675201', TO_DATE('2018-08-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2018-08-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
INSERT INTO "BLADE_USER" VALUES ('1123598821738675202', '000000', 'hr', '5e79b90f7bba52d54115f086e48f539016a27ec6', '人事', '人事', 'hr@bladex.vip', '123333333333', TO_DATE('2018-08-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '1', '1123598816738675203', '1123598813738675201', '1123598821738675201', '1123598813738675201', TO_DATE('2019-04-27 17:03:10', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2019-04-27 17:03:10', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
INSERT INTO "BLADE_USER" VALUES ('1123598821738675203', '000000', 'manager', 'dfbaa3b61caa3a319f463cc165085aa8c822d2ce', '经理', '经理', 'manager@bladex.vip', '123333333333', TO_DATE('2018-08-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '1', '1123598816738675204', '1123598813738675201', '1123598821738675201', '1123598813738675201', TO_DATE('2019-04-27 17:03:38', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2019-04-27 17:03:38', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
INSERT INTO "BLADE_USER" VALUES ('1123598821738675204', '000000', 'boss', 'abe57d23e18f7ad8ea99c86e430c90a05119a9d3', '老板', '老板', 'boss@bladex.vip', '123333333333', TO_DATE('2018-08-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '1', '1123598816738675205', '1123598813738675201', '1123598821738675201', '1123598813738675201', TO_DATE('2019-04-27 17:03:55', 'SYYYY-MM-DD HH24:MI:SS'), '1123598821738675201', TO_DATE('2019-04-27 17:03:55', 'SYYYY-MM-DD HH24:MI:SS'), '1', '0');
COMMIT;

-- ----------------------------
-- Primary Key structure for table BLADE_CLIENT
-- ----------------------------
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012757" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_CLIENT
-- ----------------------------
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012727" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012728" CHECK ("CLIENT_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012729" CHECK ("CLIENT_SECRET" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012730" CHECK ("SCOPE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012731" CHECK ("AUTHORIZED_GRANT_TYPES" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012732" CHECK ("ACCESS_TOKEN_VALIDITY" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012733" CHECK ("REFRESH_TOKEN_VALIDITY" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012734" CHECK ("STATUS" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_CLIENT" ADD CONSTRAINT "SYS_C0012735" CHECK ("IS_DELETED" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_CODE
-- ----------------------------
ALTER TABLE "BLADE_CODE" ADD CONSTRAINT "SYS_C0012758" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_CODE
-- ----------------------------
ALTER TABLE "BLADE_CODE" ADD CONSTRAINT "SYS_C0012736" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_DEPT
-- ----------------------------
ALTER TABLE "BLADE_DEPT" ADD CONSTRAINT "SYS_C0012759" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_DEPT
-- ----------------------------
ALTER TABLE "BLADE_DEPT" ADD CONSTRAINT "SYS_C0012737" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_DICT
-- ----------------------------
ALTER TABLE "BLADE_DICT" ADD CONSTRAINT "SYS_C0012760" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_DICT
-- ----------------------------
ALTER TABLE "BLADE_DICT" ADD CONSTRAINT "SYS_C0012738" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_LOG_API
-- ----------------------------
ALTER TABLE "BLADE_LOG_API" ADD CONSTRAINT "SYS_C0012761" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_LOG_API
-- ----------------------------
ALTER TABLE "BLADE_LOG_API" ADD CONSTRAINT "SYS_C0012739" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_LOG_ERROR
-- ----------------------------
ALTER TABLE "BLADE_LOG_ERROR" ADD CONSTRAINT "SYS_C0012762" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_LOG_ERROR
-- ----------------------------
ALTER TABLE "BLADE_LOG_ERROR" ADD CONSTRAINT "SYS_C0012740" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_LOG_USUAL
-- ----------------------------
ALTER TABLE "BLADE_LOG_USUAL" ADD CONSTRAINT "SYS_C0012763" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_LOG_USUAL
-- ----------------------------
ALTER TABLE "BLADE_LOG_USUAL" ADD CONSTRAINT "SYS_C0012741" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_MENU
-- ----------------------------
ALTER TABLE "BLADE_MENU" ADD CONSTRAINT "SYS_C0012764" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_MENU
-- ----------------------------
ALTER TABLE "BLADE_MENU" ADD CONSTRAINT "SYS_C0012742" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_NOTICE
-- ----------------------------
ALTER TABLE "BLADE_NOTICE" ADD CONSTRAINT "SYS_C0012765" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_NOTICE
-- ----------------------------
ALTER TABLE "BLADE_NOTICE" ADD CONSTRAINT "SYS_C0012743" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_OSS
-- ----------------------------
ALTER TABLE "BLADE_OSS" ADD CONSTRAINT "SYS_C0012766" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_OSS
-- ----------------------------
ALTER TABLE "BLADE_OSS" ADD CONSTRAINT "SYS_C0012744" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_PARAM
-- ----------------------------
ALTER TABLE "BLADE_PARAM" ADD CONSTRAINT "SYS_C0012767" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_PARAM
-- ----------------------------
ALTER TABLE "BLADE_PARAM" ADD CONSTRAINT "SYS_C0012745" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_PROCESS_LEAVE
-- ----------------------------
ALTER TABLE "BLADE_PROCESS_LEAVE" ADD CONSTRAINT "SYS_C0012768" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_PROCESS_LEAVE
-- ----------------------------
ALTER TABLE "BLADE_PROCESS_LEAVE" ADD CONSTRAINT "SYS_C0012746" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_ROLE
-- ----------------------------
ALTER TABLE "BLADE_ROLE" ADD CONSTRAINT "SYS_C0012769" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_ROLE
-- ----------------------------
ALTER TABLE "BLADE_ROLE" ADD CONSTRAINT "SYS_C0012747" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_ROLE_MENU
-- ----------------------------
ALTER TABLE "BLADE_ROLE_MENU" ADD CONSTRAINT "SYS_C0012770" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_ROLE_MENU
-- ----------------------------
ALTER TABLE "BLADE_ROLE_MENU" ADD CONSTRAINT "SYS_C0012748" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_ROLE_SCOPE
-- ----------------------------
ALTER TABLE "BLADE_ROLE_SCOPE" ADD CONSTRAINT "SYS_C0012771" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_ROLE_SCOPE
-- ----------------------------
ALTER TABLE "BLADE_ROLE_SCOPE" ADD CONSTRAINT "SYS_C0012749" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_SCOPE_API
-- ----------------------------
ALTER TABLE "BLADE_SCOPE_API" ADD CONSTRAINT "SYS_C0012772" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_SCOPE_API
-- ----------------------------
ALTER TABLE "BLADE_SCOPE_API" ADD CONSTRAINT "SYS_C0012750" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_SCOPE_DATA
-- ----------------------------
ALTER TABLE "BLADE_SCOPE_DATA" ADD CONSTRAINT "SYS_C0012773" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_SCOPE_DATA
-- ----------------------------
ALTER TABLE "BLADE_SCOPE_DATA" ADD CONSTRAINT "SYS_C0012751" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_TENANT
-- ----------------------------
ALTER TABLE "BLADE_TENANT" ADD CONSTRAINT "SYS_C0012774" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_TENANT
-- ----------------------------
ALTER TABLE "BLADE_TENANT" ADD CONSTRAINT "SYS_C0012752" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BLADE_TENANT" ADD CONSTRAINT "SYS_C0012753" CHECK ("TENANT_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_TOP_MENU
-- ----------------------------
ALTER TABLE "BLADE_TOP_MENU" ADD CONSTRAINT "SYS_C0012775" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_TOP_MENU
-- ----------------------------
ALTER TABLE "BLADE_TOP_MENU" ADD CONSTRAINT "SYS_C0012754" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_TOP_MENU_SETTING
-- ----------------------------
ALTER TABLE "BLADE_TOP_MENU_SETTING" ADD CONSTRAINT "SYS_C0012776" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_TOP_MENU_SETTING
-- ----------------------------
ALTER TABLE "BLADE_TOP_MENU_SETTING" ADD CONSTRAINT "SYS_C0012755" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BLADE_USER
-- ----------------------------
ALTER TABLE "BLADE_USER" ADD CONSTRAINT "SYS_C0012777" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table BLADE_USER
-- ----------------------------
ALTER TABLE "BLADE_USER" ADD CONSTRAINT "SYS_C0012756" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
