ALTER TABLE "BLADE_WF_DEPLOYMENT_FORM"
    ADD ("TASK_KEY" VARCHAR2(255 BYTE))
ADD ("TASK_NAME" VARCHAR2(255 BYTE));

COMMENT ON COLUMN "BLADE_WF_DEPLOYMENT_FORM"."TASK_KEY" IS '节点key';

COMMENT ON COLUMN "BLADE_WF_DEPLOYMENT_FORM"."TASK_NAME" IS '节点名称'
