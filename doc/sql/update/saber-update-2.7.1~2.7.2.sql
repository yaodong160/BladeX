-- -----------------------------------------------------------
-- 默认不弹出新tab，只需要saber对应数据库执行，若使用sword可忽略
-- -----------------------------------------------------------
UPDATE blade_menu SET is_open = 1 WHERE is_deleted = 0;
