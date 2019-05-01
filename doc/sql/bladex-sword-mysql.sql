/*
 Navicat Premium Data Transfer

 Source Server         : mysql_localhost
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : bladex

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 01/05/2019 23:00:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blade_client
-- ----------------------------
DROP TABLE IF EXISTS `blade_client`;
CREATE TABLE `blade_client`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `client_id` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端id',
  `client_secret` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端密钥',
  `resource_ids` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资源集合',
  `scope` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权范围',
  `authorized_grant_types` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '授权类型',
  `web_server_redirect_uri` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回调地址',
  `authorities` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限',
  `access_token_validity` int(11) NOT NULL COMMENT '令牌过期秒数',
  `refresh_token_validity` int(11) NOT NULL COMMENT '刷新令牌过期秒数',
  `additional_information` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附加说明',
  `autoapprove` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自动授权',
  `create_user` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` int(2) NOT NULL COMMENT '状态',
  `is_deleted` int(2) NOT NULL COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_client
-- ----------------------------
BEGIN;
INSERT INTO `blade_client` VALUES (1, 'sword', 'sword_secret', NULL, 'all', 'refresh_token,password,authorization_code', 'http://localhost:8888', NULL, 3600, 604800, NULL, NULL, 1, '2019-03-24 10:40:55', 1, '2019-03-24 10:40:59', 1, 0), (2, 'saber', 'saber_secret', NULL, 'all', 'refresh_token,password,authorization_code', 'http://localhost:8080', NULL, 3600, 604800, NULL, NULL, 1, '2019-03-24 10:42:29', 1, '2019-03-24 10:42:32', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_code
-- ----------------------------
DROP TABLE IF EXISTS `blade_code`;
CREATE TABLE `blade_code`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `service_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务名称',
  `code_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模块名称',
  `table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表名',
  `table_prefix` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表前缀',
  `pk_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主键名',
  `package_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '后端包名',
  `api_path` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '后端路径',
  `web_path` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前端路径',
  `is_deleted` int(2) NULL DEFAULT 0 COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_code
-- ----------------------------
BEGIN;
INSERT INTO `blade_code` VALUES (1, 'blade-demo', '通知公告', 'blade_notice', 'blade_', 'id', 'org.springblade.desktop', 'D:\\Develop\\WorkSpace\\Git\\SpringBlade\\blade-ops\\blade-develop', 'D:\\Develop\\WorkSpace\\Git\\Sword', 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_dept
-- ----------------------------
DROP TABLE IF EXISTS `blade_dept`;
CREATE TABLE `blade_dept`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父主键',
  `dept_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门名',
  `full_name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门全称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_deleted` int(2) NULL DEFAULT 0 COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_dept
-- ----------------------------
BEGIN;
INSERT INTO `blade_dept` VALUES (1, '000000', 0, '刀锋科技', '江苏刀锋科技有限公司', 1, NULL, 0), (2, '000000', 1, '常州刀锋', '常州刀锋科技有限公司', 1, NULL, 0), (3, '000000', 1, '苏州刀锋', '苏州刀锋科技有限公司', 1, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_dict
-- ----------------------------
DROP TABLE IF EXISTS `blade_dict`;
CREATE TABLE `blade_dict`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父主键',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典码',
  `dict_key` int(2) NULL DEFAULT NULL COMMENT '字典值',
  `dict_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典名称',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字典备注',
  `is_deleted` int(2) NULL DEFAULT 0 COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_dict
-- ----------------------------
BEGIN;
INSERT INTO `blade_dict` VALUES (1, 0, 'sex', -1, '性别', 1, NULL, 0), (2, 1, 'sex', 1, '男', 1, NULL, 0), (3, 1, 'sex', 2, '女', 2, NULL, 0), (4, 0, 'notice', -1, '通知类型', 2, NULL, 0), (5, 4, 'notice', 1, '发布通知', 1, NULL, 0), (6, 4, 'notice', 2, '批转通知', 2, NULL, 0), (7, 4, 'notice', 3, '转发通知', 3, NULL, 0), (8, 4, 'notice', 4, '指示通知', 4, NULL, 0), (9, 4, 'notice', 5, '任免通知', 5, NULL, 0), (10, 4, 'notice', 6, '事务通知', 6, NULL, 0), (11, 0, 'menu_category', -1, '菜单类型', 3, NULL, 0), (12, 11, 'menu_category', 1, '菜单', 1, NULL, 0), (13, 11, 'menu_category', 2, '按钮', 2, NULL, 0), (14, 0, 'button_func', -1, '按钮功能', 4, NULL, 0), (15, 14, 'button_func', 1, '工具栏', 1, NULL, 0), (16, 14, 'button_func', 2, '操作栏', 2, NULL, 0), (17, 14, 'button_func', 3, '工具操作栏', 3, NULL, 0), (18, 0, 'yes_no', -1, '是否', 5, NULL, 0), (19, 18, 'yes_no', 1, '否', 1, NULL, 0), (20, 18, 'yes_no', 2, '是', 2, NULL, 0), (21, 0, 'flow', -1, '流程类型', 5, NULL, 0), (22, 21, 'flow', 1, '请假流程', 1, NULL, 0), (23, 21, 'flow', 2, '报销流程', 2, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_log_api
-- ----------------------------
DROP TABLE IF EXISTS `blade_log_api`;
CREATE TABLE `blade_log_api`  (
  `id` bigint(64) NOT NULL COMMENT '编号',
  `tenant_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `service_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `server_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器名',
  `server_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器IP地址',
  `env` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器环境',
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '日志标题',
  `method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `request_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `user_agent` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `remote_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作IP地址',
  `method_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法类',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '操作提交的数据',
  `time` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '执行时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_log_api
-- ----------------------------
BEGIN;
INSERT INTO `blade_log_api` VALUES (1123572995214229505, '000000', 'blade-api', 'smallchill-3.local', '192.168.1.103:80', 'dev', '1', '登录用户验证', 'POST', '/blade-auth/oauth/token', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', '127.0.0.1', 'org.springblade.modules.auth.AuthController', 'token', 'password=admin&grant_type=password&scope=all&tenantCode=000000&type=account&username=admin', '66', '', '2019-05-01 21:00:52');
COMMIT;

-- ----------------------------
-- Table structure for blade_log_error
-- ----------------------------
DROP TABLE IF EXISTS `blade_log_error`;
CREATE TABLE `blade_log_error`  (
  `id` bigint(64) NOT NULL COMMENT '编号',
  `tenant_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `service_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `server_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器名',
  `server_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器IP地址',
  `env` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统环境',
  `method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `request_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `user_agent` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `stack_trace` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '堆栈',
  `exception_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '异常名',
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常信息',
  `line_number` int(11) NULL DEFAULT NULL COMMENT '错误行数',
  `method_class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法类',
  `file_name` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '操作提交的数据',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_log_error
-- ----------------------------
BEGIN;
INSERT INTO `blade_log_error` VALUES (1123573092832460801, '000000', 'blade-api', 'smallchill-3.local', '192.168.1.103:80', 'dev', 'GET', '/blade-system/dict/dictionary', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', 'java.lang.RuntimeException: java.lang.ClassNotFoundException: org.springblade.system.entity.Dict\n	at io.protostuff.runtime.RuntimeEnv.loadClass(RuntimeEnv.java:258)\n	at io.protostuff.runtime.DefaultIdStrategy.getSchemaWrapper(DefaultIdStrategy.java:185)\n	at io.protostuff.runtime.DefaultIdStrategy.resolvePojoFrom(DefaultIdStrategy.java:524)\n	at io.protostuff.runtime.ObjectSchema.readObjectFrom(ObjectSchema.java:682)\n	at io.protostuff.runtime.IdStrategy$8.mergeFrom(IdStrategy.java:503)\n	at io.protostuff.ByteArrayInput.mergeObject(ByteArrayInput.java:503)\n	at io.protostuff.runtime.IdStrategy$10.mergeFrom(IdStrategy.java:583)\n	at io.protostuff.runtime.IdStrategy$10.mergeFrom(IdStrategy.java:528)\n	at io.protostuff.runtime.ObjectSchema.readObjectFrom(ObjectSchema.java:590)\n	at io.protostuff.runtime.ObjectSchema.mergeFrom(ObjectSchema.java:350)\n	at io.protostuff.ByteArrayInput.mergeObject(ByteArrayInput.java:503)\n	at io.protostuff.runtime.RuntimeUnsafeFieldFactory$15$1.mergeFrom(RuntimeUnsafeFieldFactory.java:1217)\n	at io.protostuff.runtime.RuntimeSchema.mergeFrom(RuntimeSchema.java:466)\n	at io.protostuff.IOUtil.mergeFrom(IOUtil.java:45)\n	at io.protostuff.ProtobufIOUtil.mergeFrom(ProtobufIOUtil.java:103)\n	at org.springblade.core.redis.serializer.ProtoStuffSerializer.deserialize(ProtoStuffSerializer.java:54)\n	at org.springframework.data.redis.serializer.DefaultRedisElementReader.read(DefaultRedisElementReader.java:48)\n	at org.springframework.data.redis.serializer.RedisSerializationContext$SerializationPair.read(RedisSerializationContext.java:226)\n	at org.springframework.data.redis.cache.RedisCache.deserializeCacheValue(RedisCache.java:254)\n	at org.springframework.data.redis.cache.RedisCache.lookup(RedisCache.java:88)\n	at org.springframework.cache.support.AbstractValueAdaptingCache.get(AbstractValueAdaptingCache.java:58)\n	at org.springframework.cache.interceptor.AbstractCacheInvoker.doGet(AbstractCacheInvoker.java:73)\n	at org.springframework.cache.interceptor.CacheAspectSupport.findInCaches(CacheAspectSupport.java:554)\n	at org.springframework.cache.interceptor.CacheAspectSupport.findCachedItem(CacheAspectSupport.java:519)\n	at org.springframework.cache.interceptor.CacheAspectSupport.execute(CacheAspectSupport.java:401)\n	at org.springframework.cache.interceptor.CacheAspectSupport.execute(CacheAspectSupport.java:345)\n	at org.springframework.cache.interceptor.CacheInterceptor.invoke(CacheInterceptor.java:61)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\n	at org.springblade.modules.system.service.impl.DictServiceImpl$$EnhancerBySpringCGLIB$$12543ba6.getList(<generated>)\n	at org.springblade.modules.system.controller.DictController.dictionary(DictController.java:122)\n	at org.springblade.modules.system.controller.DictController$$FastClassBySpringCGLIB$$558c2c59.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:749)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:88)\n	at org.springblade.core.log.aspect.RequestLogAspect.aroundApi(RequestLogAspect.java:159)\n	at sun.reflect.GeneratedMethodAccessor225.invoke(Unknown Source)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:644)\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:633)\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:175)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:93)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:688)\n	at org.springblade.modules.system.controller.DictController$$EnhancerBySpringCGLIB$$38bf6cbf.dictionary(<generated>)\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189)\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:892)\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:797)\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038)\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942)\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005)\n	at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:897)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:645)\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882)\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:750)\n	at io.undertow.servlet.handlers.ServletHandler.handleRequest(ServletHandler.java:74)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:129)\n	at com.github.xiaoymin.swaggerbootstrapui.filter.SecurityBasicAuthFilter.doFilter(SecurityBasicAuthFilter.java:84)\n	at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)\n	at com.github.xiaoymin.swaggerbootstrapui.filter.ProductionSecurityFilter.doFilter(ProductionSecurityFilter.java:53)\n	at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)\n	at org.springblade.core.tool.support.xss.XssFilter.doFilter(XssFilter.java:44)\n	at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:124)\n	at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:92)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\n	at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:61)\n	at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)\n	at io.undertow.servlet.handlers.FilterHandler.handleRequest(FilterHandler.java:84)\n	at io.undertow.servlet.handlers.security.ServletSecurityRoleHandler.handleRequest(ServletSecurityRoleHandler.java:62)\n	at io.undertow.servlet.handlers.ServletChain$1.handleRequest(ServletChain.java:68)\n	at io.undertow.servlet.handlers.ServletDispatchingHandler.handleRequest(ServletDispatchingHandler.java:36)\n	at io.undertow.servlet.handlers.security.SSLInformationAssociationHandler.handleRequest(SSLInformationAssociationHandler.java:132)\n	at io.undertow.servlet.handlers.security.ServletAuthenticationCallHandler.handleRequest(ServletAuthenticationCallHandler.java:57)\n	at io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)\n	at io.undertow.security.handlers.AbstractConfidentialityHandler.handleRequest(AbstractConfidentialityHandler.java:46)\n	at io.undertow.servlet.handlers.security.ServletConfidentialityConstraintHandler.handleRequest(ServletConfidentialityConstraintHandler.java:64)\n	at io.undertow.security.handlers.AuthenticationMechanismsHandler.handleRequest(AuthenticationMechanismsHandler.java:60)\n	at io.undertow.servlet.handlers.security.CachedAuthenticatedSessionHandler.handleRequest(CachedAuthenticatedSessionHandler.java:77)\n	at io.undertow.security.handlers.AbstractSecurityContextAssociationHandler.handleRequest(AbstractSecurityContextAssociationHandler.java:43)\n	at io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)\n	at io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)\n	at io.undertow.servlet.handlers.SessionRestoringHandler.handleRequest(SessionRestoringHandler.java:119)\n	at io.undertow.servlet.handlers.ServletInitialHandler.handleFirstRequest(ServletInitialHandler.java:292)\n	at io.undertow.servlet.handlers.ServletInitialHandler.access$100(ServletInitialHandler.java:81)\n	at io.undertow.servlet.handlers.ServletInitialHandler$2.call(ServletInitialHandler.java:138)\n	at io.undertow.servlet.handlers.ServletInitialHandler$2.call(ServletInitialHandler.java:135)\n	at io.undertow.servlet.core.ServletRequestContextThreadSetupAction$1.call(ServletRequestContextThreadSetupAction.java:48)\n	at io.undertow.servlet.core.ContextClassLoaderSetupAction$1.call(ContextClassLoaderSetupAction.java:43)\n	at io.undertow.servlet.handlers.ServletInitialHandler.dispatchRequest(ServletInitialHandler.java:272)\n	at io.undertow.servlet.handlers.ServletInitialHandler.access$000(ServletInitialHandler.java:81)\n	at io.undertow.servlet.handlers.ServletInitialHandler$1.handleRequest(ServletInitialHandler.java:104)\n	at io.undertow.server.Connectors.executeRootHandler(Connectors.java:364)\n	at io.undertow.server.HttpServerExchange$1.run(HttpServerExchange.java:830)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.ClassNotFoundException: org.springblade.system.entity.Dict\n	at java.net.URLClassLoader.findClass(URLClassLoader.java:382)\n	at java.lang.ClassLoader.loadClass(ClassLoader.java:424)\n	at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:349)\n	at java.lang.ClassLoader.loadClass(ClassLoader.java:357)\n	at org.springframework.boot.devtools.restart.classloader.RestartClassLoader.loadClass(RestartClassLoader.java:148)\n	at java.lang.ClassLoader.loadClass(ClassLoader.java:357)\n	at io.protostuff.runtime.RuntimeEnv.loadClass(RuntimeEnv.java:251)\n	... 123 more\n', 'java.lang.RuntimeException', 'java.lang.ClassNotFoundException: org.springblade.system.entity.Dict', 258, 'io.protostuff.runtime.RuntimeEnv', 'RuntimeEnv.java', 'loadClass', 'code=flow', 'admin', '2019-05-01 21:01:15'), (1123573092966678530, '000000', 'blade-api', 'smallchill-3.local', '192.168.1.103:80', 'dev', 'GET', '/blade-flow/work/claim-list', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'current=1&size=10&dateRange=&beginDate=&endDate=', 'admin', '2019-05-01 21:01:15');
COMMIT;

-- ----------------------------
-- Table structure for blade_log_usual
-- ----------------------------
DROP TABLE IF EXISTS `blade_log_usual`;
CREATE TABLE `blade_log_usual`  (
  `id` bigint(64) NOT NULL COMMENT '编号',
  `tenant_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `service_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务ID',
  `server_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器名',
  `server_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器IP地址',
  `env` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统环境',
  `log_level` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志级别',
  `log_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志业务id',
  `log_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '日志数据',
  `method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `request_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `user_agent` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '操作提交的数据',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Table structure for blade_menu
-- ----------------------------
DROP TABLE IF EXISTS `blade_menu`;
CREATE TABLE `blade_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父级菜单',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单别名',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单资源',
  `sort` int(2) NULL DEFAULT NULL COMMENT '排序',
  `category` int(2) NULL DEFAULT NULL COMMENT '菜单类型',
  `action` int(2) NULL DEFAULT 0 COMMENT '操作按钮类型',
  `is_open` int(2) NULL DEFAULT 1 COMMENT '是否打开新页面',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_deleted` int(2) NULL DEFAULT 0 COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 98 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_menu
-- ----------------------------
BEGIN;
INSERT INTO `blade_menu` VALUES (1, 0, 'desk', '工作台', 'menu', '/desk', 'desktop', 1, 1, 0, 1, NULL, 0), (2, 1, 'notice', '通知公告', 'menu', '/desk/notice', NULL, 1, 1, 0, 1, NULL, 0), (3, 0, 'system', '系统管理', 'menu', '/system', 'setting', 99, 1, 0, 1, NULL, 0), (4, 3, 'user', '用户管理', 'menu', '/system/user', NULL, 1, 1, 0, 1, NULL, 0), (5, 3, 'dept', '部门管理', 'menu', '/system/dept', NULL, 2, 1, 0, 1, NULL, 0), (6, 3, 'dict', '字典管理', 'menu', '/system/dict', NULL, 3, 1, 0, 1, NULL, 0), (7, 3, 'menu', '菜单管理', 'menu', '/system/menu', NULL, 4, 1, 0, 1, NULL, 0), (8, 3, 'role', '角色管理', 'menu', '/system/role', NULL, 5, 1, 0, 1, NULL, 0), (9, 3, 'param', '参数管理', 'menu', '/system/param', NULL, 6, 1, 0, 1, NULL, 0), (10, 0, 'monitor', '系统监控', 'menu', '/monitor', 'fund', 3, 1, 0, 1, NULL, 0), (11, 10, 'doc', '接口文档', 'menu', 'http://localhost/doc.html', NULL, 1, 1, 0, 2, NULL, 0), (12, 10, 'admin', '服务治理', 'menu', 'http://localhost:7002', NULL, 2, 1, 0, 2, NULL, 0), (13, 10, 'log', '日志管理', 'menu', '/monitor/log', NULL, 3, 1, 0, 1, NULL, 0), (14, 13, 'log_usual', '通用日志', 'menu', '/monitor/log/usual', NULL, 1, 1, 0, 1, NULL, 0), (15, 13, 'log_api', '接口日志', 'menu', '/monitor/log/api', NULL, 2, 1, 0, 1, NULL, 0), (16, 13, 'log_error', '错误日志', 'menu', '/monitor/log/error', NULL, 3, 1, 0, 1, NULL, 0), (17, 0, 'tool', '研发工具', 'menu', '/tool', 'tool', 4, 1, 0, 1, NULL, 0), (18, 17, 'code', '代码生成', 'menu', '/tool/code', NULL, 1, 1, 0, 1, NULL, 0), (19, 2, 'notice_add', '新增', 'add', '/desk/notice/add', 'plus', 1, 2, 1, 1, NULL, 0), (20, 2, 'notice_edit', '修改', 'edit', '/desk/notice/edit', 'form', 2, 2, 2, 1, NULL, 0), (21, 2, 'notice_delete', '删除', 'delete', '/api/blade-desk/notice/remove', 'delete', 3, 2, 3, 1, NULL, 0), (22, 2, 'notice_view', '查看', 'view', '/desk/notice/view', 'file-text', 4, 2, 2, 1, NULL, 0), (23, 4, 'user_add', '新增', 'add', '/system/user/add', 'plus', 1, 2, 1, 1, NULL, 0), (24, 4, 'user_edit', '修改', 'edit', '/system/user/edit', 'form', 2, 2, 2, 1, NULL, 0), (25, 4, 'user_delete', '删除', 'delete', '/api/blade-user/remove', 'delete', 3, 2, 3, 1, NULL, 0), (26, 4, 'user_role', '角色配置', 'role', NULL, 'user-add', 4, 2, 1, 1, NULL, 0), (27, 4, 'user_reset', '密码重置', 'reset-password', '/api/blade-user/reset-password', 'retweet', 5, 2, 1, 1, NULL, 0), (28, 4, 'user_view', '查看', 'view', '/system/user/view', 'file-text', 6, 2, 2, 1, NULL, 0), (29, 5, 'dept_add', '新增', 'add', '/system/dept/add', 'plus', 1, 2, 1, 1, NULL, 0), (30, 5, 'dept_edit', '修改', 'edit', '/system/dept/edit', 'form', 2, 2, 2, 1, NULL, 0), (31, 5, 'dept_delete', '删除', 'delete', '/api/blade-system/dept/remove', 'delete', 3, 2, 3, 1, NULL, 0), (32, 5, 'dept_view', '查看', 'view', '/system/dept/view', 'file-text', 4, 2, 2, 1, NULL, 0), (33, 6, 'dict_add', '新增', 'add', '/system/dict/add', 'plus', 1, 2, 1, 1, NULL, 0), (34, 6, 'dict_edit', '修改', 'edit', '/system/dict/edit', 'form', 2, 2, 2, 1, NULL, 0), (35, 6, 'dict_delete', '删除', 'delete', '/api/blade-system/dict/remove', 'delete', 3, 2, 3, 1, NULL, 0), (36, 6, 'dict_view', '查看', 'view', '/system/dict/view', 'file-text', 4, 2, 2, 1, NULL, 0), (37, 7, 'menu_add', '新增', 'add', '/system/menu/add', 'plus', 1, 2, 1, 1, NULL, 0), (38, 7, 'menu_edit', '修改', 'edit', '/system/menu/edit', 'form', 2, 2, 2, 1, NULL, 0), (39, 7, 'menu_delete', '删除', 'delete', '/api/blade-system/menu/remove', 'delete', 3, 2, 3, 1, NULL, 0), (40, 7, 'menu_view', '查看', 'view', '/system/menu/view', 'file-text', 4, 2, 2, 1, NULL, 0), (41, 8, 'role_add', '新增', 'add', '/system/role/add', 'plus', 1, 2, 1, 1, NULL, 0), (42, 8, 'role_edit', '修改', 'edit', '/system/role/edit', 'form', 2, 2, 2, 1, NULL, 0), (43, 8, 'role_delete', '删除', 'delete', '/api/blade-system/role/remove', 'delete', 3, 2, 3, 1, NULL, 0), (44, 8, 'role_view', '查看', 'view', '/system/role/view', 'file-text', 4, 2, 2, 1, NULL, 0), (45, 9, 'param_add', '新增', 'add', '/system/param/add', 'plus', 1, 2, 1, 1, NULL, 0), (46, 9, 'param_edit', '修改', 'edit', '/system/param/edit', 'form', 2, 2, 2, 1, NULL, 0), (47, 9, 'param_delete', '删除', 'delete', '/api/blade-system/param/remove', 'delete', 3, 2, 3, 1, NULL, 0), (48, 9, 'param_view', '查看', 'view', '/system/param/view', 'file-text', 4, 2, 2, 1, NULL, 0), (49, 14, 'log_usual_view', '查看', 'view', '/monitor/log/usual/view', 'file-text', 4, 2, 2, 1, NULL, 0), (50, 15, 'log_api_view', '查看', 'view', '/monitor/log/api/view', 'file-text', 4, 2, 2, 1, NULL, 0), (51, 16, 'log_error_view', '查看', 'view', '/monitor/log/error/view', 'file-text', 4, 2, 2, 1, NULL, 0), (52, 18, 'code_add', '新增', 'add', '/tool/code/add', 'plus', 1, 2, 1, 1, NULL, 0), (53, 18, 'code_edit', '修改', 'edit', '/tool/code/edit', 'form', 2, 2, 2, 1, NULL, 0), (54, 18, 'code_delete', '删除', 'delete', '/api/blade-system/code/remove', 'delete', 3, 2, 3, 1, NULL, 0), (55, 18, 'code_view', '查看', 'view', '/tool/code/view', 'file-text', 4, 2, 2, 1, NULL, 0), (56, 3, 'tenant', '租户管理', 'menu', '/system/tenant', NULL, 7, 1, 0, 1, NULL, 0), (57, 56, 'tenant_add', '新增', 'add', '/system/tenant/add', 'plus', 1, 2, 1, 1, NULL, 0), (58, 56, 'tenant_edit', '修改', 'edit', '/system/tenant/edit', 'form', 2, 2, 2, 1, NULL, 0), (59, 56, 'tenant_delete', '删除', 'delete', '/api/blade-system/tenant/remove', 'delete', 3, 2, 3, 1, NULL, 0), (60, 56, 'tenant_view', '查看', 'view', '/system/tenant/view', 'file-text', 4, 2, 2, 1, NULL, 0), (61, 3, 'client', '应用管理', 'menu', '/system/client', NULL, 8, 1, 0, 1, NULL, 0), (62, 61, 'client_add', '新增', 'add', '/system/client/add', 'plus', 1, 2, 1, 1, NULL, 0), (63, 61, 'client_edit', '修改', 'edit', '/system/client/edit', 'form', 2, 2, 2, 2, NULL, 0), (64, 61, 'client_delete', '删除', 'delete', '/api/blade-system/client/remove', 'delete', 3, 2, 3, 3, NULL, 0), (65, 61, 'client_view', '查看', 'view', '/system/client/view', 'file-text', 4, 2, 2, 2, NULL, 0), (66, 0, 'flow', '流程管理', 'menu', '/flow', 'stock', 5, 1, 0, 1, NULL, 0), (67, 66, 'flow_model', '模型管理', 'menu', '/flow/model', NULL, 1, 1, 0, 1, NULL, 0), (68, 67, 'flow_model_create', '创建', 'create', '', 'plus', 1, 2, 1, 1, NULL, 0), (69, 67, 'flow_model_update', '编辑', 'update', '', 'form', 2, 2, 2, 1, NULL, 0), (70, 67, 'flow_model_deploy', '部署', 'deploy', '', 'cloud-upload', 3, 2, 2, 1, NULL, 0), (71, 67, 'flow_model_download', '下载', 'download', '', 'download', 4, 2, 2, 1, NULL, 0), (72, 67, 'flow_model_delete', '删除', 'delete', '/api/blade-flow/model/remove', 'delete', 5, 2, 3, 1, NULL, 0), (73, 66, 'flow_deploy', '流程部署', 'menu', '/flow/deploy', NULL, 2, 1, 0, 1, NULL, 0), (74, 66, 'flow_manager', '流程管理', 'menu', '/flow/manager', NULL, 3, 1, 0, 1, NULL, 0), (75, 74, 'flow_manager_state', '变更状态', 'state', '', 'plus', 1, 2, 2, 1, NULL, 0), (76, 74, 'flow_manager_image', '流程图', 'image', '', 'image', 2, 2, 2, 1, NULL, 0), (77, 74, 'flow_manager_remove', '删除', 'remove', '', 'delete', 3, 2, 3, 1, NULL, 0), (78, 66, 'flow_follow', '流程跟踪', 'menu', '/flow/follow', NULL, 4, 1, 0, 1, NULL, 0), (79, 78, 'flow_follow_delete', '删除', 'remove', '', 'remove', 1, 2, 2, 1, NULL, 0), (80, 0, 'work', '我的事务', 'work', '/work', 'bell', 2, 1, 0, 1, NULL, 0), (81, 80, 'work_start', '发起事务', 'menu', '/work/start', NULL, 1, 1, 0, 1, NULL, 0), (82, 81, 'work_start_flow', '发起', 'flow', '', 'flow', 1, 2, 2, 1, NULL, 0), (83, 81, 'work_start_image', '流程图', 'image', '', 'image', 2, 2, 2, 1, NULL, 0), (84, 80, 'work_claim', '待签事务', 'menu', '/work/claim', NULL, 2, 1, 0, 1, NULL, 0), (85, 84, 'work_claim_sign', '签收', 'sign', '', 'sign', 1, 2, 2, 1, NULL, 0), (86, 84, 'work_claim_detail', '详情', 'detail', '', 'detail', 2, 2, 2, 1, NULL, 0), (87, 84, 'work_claim_follow', '跟踪', 'follow', '', 'follow', 3, 2, 2, 1, NULL, 0), (88, 80, 'work_todo', '待办事务', 'menu', '/work/todo', NULL, 2, 1, 0, 1, NULL, 0), (89, 88, 'work_todo_handle', '办理', 'handle', '', 'handle', 1, 2, 2, 1, NULL, 0), (90, 88, 'work_todo_detail', '详情', 'detail', '', 'detail', 2, 2, 2, 1, NULL, 0), (91, 88, 'work_todo_follow', '跟踪', 'follow', '', 'follow', 3, 2, 2, 1, NULL, 0), (92, 80, 'work_send', '已发事务', 'menu', '/work/send', NULL, 3, 1, 0, 1, NULL, 0), (93, 92, 'work_send_detail', '详情', 'detail', '', 'detail', 1, 2, 2, 1, NULL, 0), (94, 92, 'work_send_follow', '跟踪', 'follow', '', 'follow', 2, 2, 2, 1, NULL, 0), (95, 80, 'work_done', '办结事务', 'menu', '/work/done', NULL, 4, 1, 0, 1, NULL, 0), (96, 95, 'work_done_detail', '详情', 'detail', '', 'detail', 1, 2, 2, 1, NULL, 0), (97, 95, 'work_done_follow', '跟踪', 'follow', '', 'follow', 2, 2, 2, 1, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_notice
-- ----------------------------
DROP TABLE IF EXISTS `blade_notice`;
CREATE TABLE `blade_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `category` int(11) NULL DEFAULT NULL COMMENT '类型',
  `release_time` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容',
  `create_user` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态',
  `is_deleted` int(2) NULL DEFAULT NULL COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_notice
-- ----------------------------
BEGIN;
INSERT INTO `blade_notice` VALUES (23, '000000', '测试公告', 3, '2018-12-31 20:03:31', '222', 1, '2018-12-05 20:03:31', 1, '2018-12-28 11:10:51', 1, 0), (24, '000000', '测试公告2', 1, '2018-12-05 20:03:31', '333', 1, '2018-12-28 10:32:26', 1, '2018-12-28 11:10:34', 1, 0), (25, '000000', '测试公告3', 6, '2018-12-29 00:00:00', '11111', 1, '2018-12-28 11:03:44', 1, '2018-12-28 11:10:28', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_param
-- ----------------------------
DROP TABLE IF EXISTS `blade_param`;
CREATE TABLE `blade_param`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `param_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数名',
  `param_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数键',
  `param_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数值',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_user` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态',
  `is_deleted` int(2) NULL DEFAULT 0 COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_param
-- ----------------------------
BEGIN;
INSERT INTO `blade_param` VALUES (1, '是否开启注册功能', 'account.registerUser', 'true', '开启注册', 1, '2018-12-28 12:19:01', 1, '2018-12-28 12:19:01', 1, 0), (2, '账号初始密码', 'account.initPassword', '123456', '初始密码', 1, '2018-12-28 12:19:01', 1, '2018-12-28 12:19:01', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_process_leave
-- ----------------------------
DROP TABLE IF EXISTS `blade_process_leave`;
CREATE TABLE `blade_process_leave`  (
  `id` bigint(64) NOT NULL COMMENT '编号',
  `process_definition_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程定义主键',
  `process_instance_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程实例主键',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请假理由',
  `task_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '第一级审批人',
  `apply_time` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `create_user` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态',
  `is_deleted` int(2) NULL DEFAULT NULL COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Table structure for blade_role
-- ----------------------------
DROP TABLE IF EXISTS `blade_role`;
CREATE TABLE `blade_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '父主键',
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `role_alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色别名',
  `is_deleted` int(2) NULL DEFAULT 0 COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_role
-- ----------------------------
BEGIN;
INSERT INTO `blade_role` VALUES (1, '000000', 0, '超级管理员', 1, 'administrator', 0), (2, '000000', 0, '用户', 2, 'user', 0), (3, '000000', 2, '人事', 1, 'hr', 0), (4, '000000', 2, '经理', 2, 'manager', 0), (5, '000000', 2, '老板', 3, 'boss', 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `blade_role_menu`;
CREATE TABLE `blade_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `menu_id` int(11) NULL DEFAULT NULL COMMENT '菜单id',
  `role_id` int(11) NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 259 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `blade_role_menu` VALUES (66, 1, 1), (67, 2, 1), (68, 3, 1), (69, 4, 1), (70, 5, 1), (71, 6, 1), (72, 7, 1), (73, 8, 1), (74, 9, 1), (75, 10, 1), (76, 11, 1), (77, 12, 1), (78, 13, 1), (79, 14, 1), (80, 15, 1), (81, 16, 1), (82, 17, 1), (83, 18, 1), (84, 19, 1), (85, 20, 1), (86, 21, 1), (87, 22, 1), (88, 23, 1), (89, 24, 1), (90, 25, 1), (91, 26, 1), (92, 27, 1), (93, 28, 1), (94, 29, 1), (95, 30, 1), (96, 31, 1), (97, 32, 1), (98, 33, 1), (99, 34, 1), (100, 35, 1), (101, 36, 1), (102, 37, 1), (103, 38, 1), (104, 39, 1), (105, 40, 1), (106, 41, 1), (107, 42, 1), (108, 43, 1), (109, 44, 1), (110, 45, 1), (111, 46, 1), (112, 47, 1), (113, 48, 1), (114, 49, 1), (115, 50, 1), (116, 51, 1), (117, 52, 1), (118, 53, 1), (119, 54, 1), (120, 55, 1), (121, 56, 1), (122, 57, 1), (123, 58, 1), (124, 59, 1), (125, 60, 1), (126, 61, 1), (127, 62, 1), (128, 63, 1), (129, 64, 1), (130, 65, 1), (131, 66, 1), (132, 67, 1), (133, 68, 1), (134, 69, 1), (135, 70, 1), (136, 71, 1), (137, 72, 1), (138, 73, 1), (139, 74, 1), (140, 75, 1), (141, 76, 1), (142, 77, 1), (143, 78, 1), (144, 79, 1), (145, 80, 1), (146, 81, 1), (147, 82, 1), (148, 83, 1), (149, 84, 1), (150, 85, 1), (151, 86, 1), (152, 87, 1), (153, 88, 1), (154, 89, 1), (155, 90, 1), (156, 91, 1), (157, 92, 1), (158, 93, 1), (159, 94, 1), (160, 95, 1), (161, 96, 1), (162, 97, 1), (163, 1, 2), (164, 2, 2), (165, 19, 2), (166, 20, 2), (167, 21, 2), (168, 22, 2), (169, 80, 2), (170, 81, 2), (171, 82, 2), (172, 83, 2), (173, 84, 2), (174, 85, 2), (175, 86, 2), (176, 87, 2), (177, 88, 2), (178, 89, 2), (179, 90, 2), (180, 91, 2), (181, 92, 2), (182, 93, 2), (183, 94, 2), (184, 95, 2), (185, 96, 2), (186, 97, 2), (187, 1, 3), (188, 2, 3), (189, 19, 3), (190, 20, 3), (191, 21, 3), (192, 22, 3), (193, 80, 3), (194, 81, 3), (195, 82, 3), (196, 83, 3), (197, 84, 3), (198, 85, 3), (199, 86, 3), (200, 87, 3), (201, 88, 3), (202, 89, 3), (203, 90, 3), (204, 91, 3), (205, 92, 3), (206, 93, 3), (207, 94, 3), (208, 95, 3), (209, 96, 3), (210, 97, 3), (211, 1, 4), (212, 2, 4), (213, 19, 4), (214, 20, 4), (215, 21, 4), (216, 22, 4), (217, 80, 4), (218, 81, 4), (219, 82, 4), (220, 83, 4), (221, 84, 4), (222, 85, 4), (223, 86, 4), (224, 87, 4), (225, 88, 4), (226, 89, 4), (227, 90, 4), (228, 91, 4), (229, 92, 4), (230, 93, 4), (231, 94, 4), (232, 95, 4), (233, 96, 4), (234, 97, 4), (235, 1, 5), (236, 2, 5), (237, 19, 5), (238, 20, 5), (239, 21, 5), (240, 22, 5), (241, 80, 5), (242, 81, 5), (243, 82, 5), (244, 83, 5), (245, 84, 5), (246, 85, 5), (247, 86, 5), (248, 87, 5), (249, 88, 5), (250, 89, 5), (251, 90, 5), (252, 91, 5), (253, 92, 5), (254, 93, 5), (255, 94, 5), (256, 95, 5), (257, 96, 5), (258, 97, 5);
COMMIT;

-- ----------------------------
-- Table structure for blade_tenant
-- ----------------------------
DROP TABLE IF EXISTS `blade_tenant`;
CREATE TABLE `blade_tenant`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户编号',
  `tenant_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户名称',
  `linkman` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `create_user` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态',
  `is_deleted` int(2) NULL DEFAULT 0 COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_tenant
-- ----------------------------
BEGIN;
INSERT INTO `blade_tenant` VALUES (1, '000000', '管理组', 'admin', '666666', '管理组', 1, '2019-01-01 00:00:39', 1, '2019-01-01 00:00:39', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for blade_user
-- ----------------------------
DROP TABLE IF EXISTS `blade_user`;
CREATE TABLE `blade_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `account` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `real_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真名',
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机',
  `birthday` datetime(0) NULL DEFAULT NULL COMMENT '生日',
  `sex` smallint(6) NULL DEFAULT NULL COMMENT '性别',
  `role_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `dept_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `create_user` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` int(11) NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `status` int(2) NULL DEFAULT NULL COMMENT '状态',
  `is_deleted` int(2) NULL DEFAULT 0 COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------
-- Records of blade_user
-- ----------------------------
BEGIN;
INSERT INTO `blade_user` VALUES (1, '000000', 'admin', '90b9aa7e25f80cf4f64e990b78a9fc5ebd6cecad', '管理员', '管理员', 'admin@bladex.vip', '22233322', '2018-08-08 00:00:00', 1, '1', '1', 1, '2018-08-08 00:00:00', 1, '2018-08-08 00:00:00', 1, 0), (2, '000000', 'hr', '5e79b90f7bba52d54115f086e48f539016a27ec6', '人事', '人事', NULL, NULL, NULL, NULL, '3', '1', 1, '2019-04-27 17:03:10', 1, '2019-04-27 17:03:10', 1, 0), (3, '000000', 'manager', 'dfbaa3b61caa3a319f463cc165085aa8c822d2ce', '经理', '经理', NULL, NULL, NULL, NULL, '4', '1', 1, '2019-04-27 17:03:38', 1, '2019-04-27 17:03:38', 1, 0), (4, '000000', 'boss', 'abe57d23e18f7ad8ea99c86e430c90a05119a9d3', '老板', '老板', NULL, NULL, NULL, NULL, '5', '1', 1, '2019-04-27 17:03:55', 1, '2019-04-27 17:03:55', 1, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
