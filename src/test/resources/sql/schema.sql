-- 创建t_user表
DROP TABLE IF EXISTS t_user;
CREATE TABLE t_user
(
    id           SERIAL PRIMARY KEY, -- '用户id'
    username     TEXT UNIQUE NOT NULL, -- '用户名'
    password     CHAR(60) NOT NULL, -- '密码'
    phone_number CHAR(11) UNIQUE, -- '手机号'
    province     TEXT, -- '省份'
    score        SMALLINT, -- '分数'
    subject      SMALLINT, -- '理=1/文=0'
    created      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建t_role表
DROP TABLE IF EXISTS t_role;
CREATE TABLE t_role
(
    id          SERIAL PRIMARY KEY, -- '角色id'
    name        TEXT UNIQUE NOT NULL, -- '角色名'
    description TEXT NOT NULL, -- '角色描述'
    created     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建t_user_role表
DROP TABLE IF EXISTS t_user_role;
CREATE TABLE t_user_role
(
    user_id INT NOT NULL, -- '用户id'
    role_id INT NOT NULL, -- '角色id'
    PRIMARY KEY (user_id, role_id)
);
ALTER TABLE t_user_role ADD CONSTRAINT fk_user_role_userId FOREIGN KEY (user_id) REFERENCES t_user (id);
ALTER TABLE t_user_role ADD CONSTRAINT fk_user_role_roleId FOREIGN KEY (role_id) REFERENCES t_role (id);

-- 创建t_permission表
DROP TABLE IF EXISTS t_permission;
CREATE TABLE t_permission
(
    id          SERIAL PRIMARY KEY, -- '权限id'
    name        TEXT NOT NULL, -- '权限名'
    url         TEXT NOT NULL, -- '权限url'
    description TEXT NOT NULL, -- '权限描述'
    created     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建t_role_permission表
DROP TABLE IF EXISTS t_role_permission;
CREATE TABLE t_role_permission
(
    role_id       INT NOT NULL, -- '角色id'
    permission_id INT NOT NULL, -- '权限id'
    PRIMARY KEY (role_id, permission_id)
);
ALTER TABLE t_role_permission ADD CONSTRAINT fk_role_permission_roleId FOREIGN KEY (role_id) REFERENCES t_role (id);
ALTER TABLE t_role_permission ADD CONSTRAINT fk_role_permission_permissionId FOREIGN KEY (permission_id) REFERENCES t_permission (id);

-- 专业门类表
DROP TABLE IF EXISTS t_category;
CREATE TABLE t_category
(
    id      SERIAL PRIMARY KEY, -- '门类代码'
    name    TEXT UNIQUE NOT NULL, -- '门类名称'
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 专业类别表
DROP TABLE IF EXISTS t_class;
CREATE TABLE t_class
(
    id      SERIAL PRIMARY KEY, -- '专业类代码'
    name    TEXT UNIQUE NOT NULL, -- '名称'
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- '更新时间'
);

-- 专业门类-专业类别关联表
DROP TABLE IF EXISTS t_category_class;
CREATE TABLE t_category_class
(
    category_id INT NOT NULL, -- '门类代码'
    class_id    INT NOT NULL, -- '专业类别'
    PRIMARY KEY (category_id, class_id)
);
ALTER TABLE t_category_class ADD CONSTRAINT fk_category_class_categoryId FOREIGN KEY (category_id) REFERENCES t_category (id) ON DELETE CASCADE;
ALTER TABLE t_category_class ADD CONSTRAINT fk_category_class_classId FOREIGN KEY (class_id) REFERENCES t_class (id);

-- 专业表
DROP TABLE IF EXISTS t_major;
CREATE TABLE t_major
(
    id      SERIAL PRIMARY KEY, -- 'id'
    code    TEXT UNIQUE NOT NULL, -- '专业代码'
    name    TEXT UNIQUE NOT NULL, -- '专业名称'
    created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
    updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- '更新时间'
);

-- 专业-专业类别关联表
DROP TABLE IF EXISTS t_class_major;
CREATE TABLE t_class_major
(
    class_id INT NOT NULL, -- '专业类代码'
    major_id INT NOT NULL, -- '专业代码'
    PRIMARY KEY (class_id, major_id)
);
ALTER TABLE t_class_major ADD CONSTRAINT fk_class_major_classId FOREIGN KEY (class_id) REFERENCES t_class (id) ON DELETE CASCADE;
ALTER TABLE t_class_major ADD CONSTRAINT fk_class_major_majorId FOREIGN KEY (major_id) REFERENCES t_major (id);

-- 学校表
DROP TABLE IF EXISTS t_school;
CREATE TABLE t_school
(
    id         SERIAL PRIMARY KEY, -- 'id'
    code       TEXT UNIQUE NOT NULL, -- '院校代码'
    name       TEXT UNIQUE NOT NULL, -- '院校名称'
    province   TEXT, -- '所在省份'
    department TEXT, -- '所属部门'
    img_url    TEXT, -- '院校图片地址'
    mold       TEXT, -- '院校类型'
    evaluation NUMERIC(2, 1), -- '院校评价，0.0-5.0'
    created    TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
    updated    TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- '更新时间'
);

-- 数线
CREATE TABLE t_score_line
(
    id            SERIAL PRIMARY KEY, -- 'id'
    school_name   TEXT NOT NULL, -- '学校名称'
    "year"          SMALLINT NOT NULL, -- '年份'
    batch         SMALLINT NOT NULL, -- '录取批次'
    subject       SMALLINT NOT NULL, -- '文0/理1'
    total_score   SMALLINT NOT NULL, -- '总分'
    chinese       SMALLINT, -- '语文'
    math          SMALLINT, -- '数学'
    comprehensive SMALLINT, -- '理科综合/文科综合'
    created       TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- '创建时间'
    updated       TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- '更新时间'
);
ALTER TABLE t_score_line ADD CONSTRAINT fk_score_line_schoolName FOREIGN KEY (school_name) REFERENCES t_school (name);