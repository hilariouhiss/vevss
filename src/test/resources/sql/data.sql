-- 插入system用户数据
INSERT INTO t_user (username, password, phone_number, province, score, subject)
VALUES ('system', '$2a$10$akh36WsghbiuqJY7UJFu.uRXqnW63zgKt8tSSYa5uK7SWV8VU5S02', '12345678901', '北京', 750, 1);

-- 插入role数据
INSERT INTO t_role (name, description)
VALUES ('ROLE_SYSTEM', '系统管理员'),
       ('ROLE_USER', '普通用户');

-- 插入user_role数据
INSERT INTO t_user_role (user_id, role_id)
SELECT t_user.id, t_role.id
FROM t_user,
     t_role
WHERE t_user.username = 'system'
  AND t_role.name = 'ROLE_SYSTEM';

-- 插入permission数据
INSERT INTO t_permission (name, url, description)
VALUES ('category:add', '/category', '添加专业门类'),
       ('category:delete', '/category/{name}', '通过名称删除专业门类'),
       ('category:update', '/category', '更新专业门类'),
       ('class:add', '/class', '添加专业类别'),
       ('class:delete', '/class/{name}', '通过名称删除专业类别'),
       ('class:update', '/class/{name}', '通过名称更新专业类别'),
       ('major:add', '/major', '添加专业'),
       ('major:delete', '/major/name/{name}', '通过名称删除专业'),
       ('major:delete', '/major/code/{code}', '通过代码删除专业'),
       ('major:update', '/major', '更新专业'),
       ('school:add', '/school', '添加学校'),
       ('school:delete', '/school/name/{name}', '通过名称删除学校'),
       ('school:delete', '/school/code/{code}', '通过代码删除学校'),
       ('school:update', '/school', '通过名称更新学校'),
       ('score_line:add', '/score_line', '添加分数线'),
       ('score_line:delete', '/score_line/{name}', '通过名称删除分数线'),
       ('score_line:update', '/score_line/{name}', '通过名称更新分数线'),
       ('score_line:query', '/score_line', '查询分数线'),
       ('permission:all', '/permission/**', '对权限的所有操作'),
       ('role:all', '/role/**', '对角色的所有操作'),
       ('user:get', '/user/all', '获取所有用户'),
       ('user:get', '/user/{username}', '通过名称获取用户'),
       ('user:delete', '/user/{username}', '通过名称删除用户'),
       ('user:update', '/user', '更新用户'),
       ('data:initialize', '/data/initialize', '初始化数据');

-- 插入role_permission数据
INSERT INTO t_role_permission (role_id, permission_id)
SELECT t_role.id, t_permission.id
FROM t_role,
     t_permission
WHERE t_role.name = 'ROLE_USER'
  AND t_permission.name = 'user:update';

-- 插入category数据
INSERT INTO t_category (id, name)
values (1, '哲学');

-- 插入class数据
insert into t_class (id, name)
values (1, '哲学');

-- 插入major数据
insert into t_major(code, name)
values ('0101', '哲学');

insert into t_category_class(category_id, class_id)
values (1, 1);
insert into t_class_major(class_id, major_id)
values (1, 1);

insert into t_school(code, name, province, department, img_url, mold, evaluation)
values ('1001', '北京大学', '北京', '教育部', 'http://www.baidu.com', '综合', 4.5);

insert into t_score_line(school_name,
                         "year",
                         batch,
                         subject,
                         total_score,
                         chinese,
                         math,
                         comprehensive)
values ('北京大学', 2020, 1, 1, 750, 150, 150, 450);

