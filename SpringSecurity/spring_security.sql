/*
 Navicat MySQL Data Transfer

 Source Server         : niechangan
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : spring_security

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65003

 Date: 09/02/2021 23:45:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_api`;
CREATE TABLE `sys_api`  (
  `id` bigint(45) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `api_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'API名称',
  `api_url` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'API请求地址',
  `api_method` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'API请求方式：GET、POST、PUT、DELETE',
  `parent_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父ID',
  `api_sort` int(11) NOT NULL COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `available` int(11) NULL DEFAULT 1 COMMENT '0：不可用，1：可用',
  `description` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台接口表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_api
-- ----------------------------
INSERT INTO `sys_api` VALUES (1, '所有API', '/**', 'GET,POST,PUT,DELETE', '0', 1, '2021-03-07 22:16:41', '2021-03-07 22:16:44', 1, '所有API');
INSERT INTO `sys_api` VALUES (2, '用户管理接口', 'none', '', '1', 1, '2021-03-07 22:19:22', '2021-03-07 22:19:09', 1, '用户管理下所有API');
INSERT INTO `sys_api` VALUES (3, '添加用户', '/users/add', 'POST', '2', 1, '2021-03-07 22:20:03', '2021-03-07 22:20:04', 1, NULL);
INSERT INTO `sys_api` VALUES (4, '分配角色', '/users/assignRoles/?', 'POST', '2', 2, '2021-03-07 22:21:00', '2021-03-07 22:21:10', 1, NULL);
INSERT INTO `sys_api` VALUES (5, '删除用户', '/users/delete/?', 'DELETE', '2', 3, '2021-03-07 22:22:19', '2021-03-07 22:22:21', 1, NULL);
INSERT INTO `sys_api` VALUES (6, '编辑用户', '/users/edit/?', 'GET', '2', 4, '2021-03-07 22:24:13', '2021-03-07 22:24:15', 1, NULL);
INSERT INTO `sys_api` VALUES (7, '导出excel', '/users/excel', 'POST', '2', 5, '2021-03-07 22:24:47', '2021-03-07 22:24:49', 1, NULL);
INSERT INTO `sys_api` VALUES (8, '用户信息', '/users/getUserInfo', 'GET', '2', 6, '2021-03-07 22:25:25', '2021-03-07 22:25:28', 1, NULL);
INSERT INTO `sys_api` VALUES (9, '用户列表', '/users/getUserList', 'POST', '2', 7, '2021-03-07 22:25:58', '2021-03-07 22:26:00', 1, NULL);
INSERT INTO `sys_api` VALUES (10, '已有角色', '/users/roles/?', 'GET', '2', 8, '2021-03-07 22:26:31', '2021-03-07 22:26:33', 1, NULL);
INSERT INTO `sys_api` VALUES (11, '更新用户', '/users/update/?', 'PUT', '2', 9, '2021-03-07 22:27:03', '2021-03-07 22:27:03', 1, NULL);
INSERT INTO `sys_api` VALUES (12, '用户状态', '/users/updateStatus/?/?', 'PUT', '2', 10, '2021-03-07 22:27:43', '2021-03-07 22:27:47', 1, NULL);
INSERT INTO `sys_api` VALUES (13, '角色管理接口', 'none', '', '1', 2, '2021-03-07 22:19:22', '2021-03-07 22:19:09', 1, '角色管理下所有API');
INSERT INTO `sys_api` VALUES (14, '添加角色', '/role/add', 'POST', '13', 1, '2021-03-07 22:36:27', '2021-03-07 22:36:29', 1, NULL);
INSERT INTO `sys_api` VALUES (15, '角色授权', '/role/authority/?', 'POST', '13', 2, '2021-03-07 22:37:24', '2021-03-07 22:37:27', 1, NULL);
INSERT INTO `sys_api` VALUES (16, '删除角色', '/role/delete/?', 'DELETE', '13', 3, '2021-03-07 22:39:17', '2021-03-07 22:39:20', 1, NULL);
INSERT INTO `sys_api` VALUES (17, '编辑角色', '/role/edit/?', 'GET', '13', 4, '2021-03-07 22:40:05', '2021-03-07 22:40:07', 1, NULL);
INSERT INTO `sys_api` VALUES (18, '导出excel', '/role/excel', 'POST', '13', 5, '2021-03-07 22:42:36', '2021-03-07 22:42:38', 1, NULL);
INSERT INTO `sys_api` VALUES (19, '角色列表', '/role/findRoleList', 'GET', '13', 6, '2021-03-07 22:43:29', '2021-03-07 22:43:32', 1, NULL);
INSERT INTO `sys_api` VALUES (20, '角色菜单', '/role/findRoleMenu/?', 'GET', '13', 7, '2021-03-07 22:44:04', '2021-03-07 22:44:08', 1, NULL);
INSERT INTO `sys_api` VALUES (21, '更新角色', '/role/update/?', 'PUT', '13', 8, '2021-03-07 22:44:33', '2021-03-07 22:44:35', 1, NULL);
INSERT INTO `sys_api` VALUES (22, '更新状态', '/role/updateStatus/?/?', 'PUT', '13', 9, '2021-03-07 22:45:03', '2021-03-07 22:45:05', 1, NULL);
INSERT INTO `sys_api` VALUES (23, '菜单管理接口', 'none', '', '1', 3, '2021-03-07 22:19:22', '2021-03-07 22:19:09', 1, '菜单管理下所有API');
INSERT INTO `sys_api` VALUES (24, '新增菜单', '/menu/addMenu', 'POST', '23', 1, '2021-03-07 22:47:13', '2021-03-07 22:47:15', 1, NULL);
INSERT INTO `sys_api` VALUES (25, '删除菜单', '/menu/delete/?', 'DELETE', '23', 2, '2021-03-07 22:47:47', '2021-03-07 22:47:49', 1, NULL);
INSERT INTO `sys_api` VALUES (26, '菜单详情', '/menu/edit/?', 'GET', '23', 3, '2021-03-07 22:48:40', '2021-03-07 22:48:42', 1, NULL);
INSERT INTO `sys_api` VALUES (27, '导出excel', '/menu/excel', 'POST', '23', 4, '2021-03-07 22:49:13', '2021-03-07 22:49:15', 1, NULL);
INSERT INTO `sys_api` VALUES (28, '加载菜单树 ', '/menu/getTree', 'GET', '23', 5, '2021-03-07 22:49:45', '2021-03-07 22:49:47', 1, NULL);
INSERT INTO `sys_api` VALUES (29, '更新菜单', '/menu/update/?', 'PUT', '23', 6, '2021-03-07 22:50:14', '2021-03-07 22:50:16', 1, NULL);
INSERT INTO `sys_api` VALUES (30, 'API管理接口', 'none', '', '1', 4, '2021-03-07 22:19:22', '2021-03-07 22:19:09', 1, '菜单管理下所有API');
INSERT INTO `sys_api` VALUES (31, '新增API', '/api/addApi', 'POST', '30', 1, '2021-03-07 22:47:13', '2021-03-07 22:47:15', 1, NULL);
INSERT INTO `sys_api` VALUES (32, '删除API', '/api/delete/?', 'DELETE', '30', 2, '2021-03-07 22:47:47', '2021-03-07 22:47:49', 1, NULL);
INSERT INTO `sys_api` VALUES (33, 'API详情', '/api/edit/?', 'GET', '30', 3, '2021-03-07 22:48:40', '2021-03-07 22:48:42', 1, NULL);
INSERT INTO `sys_api` VALUES (34, '导出excel', '/api/excel', 'POST', '30', 4, '2021-03-07 22:49:13', '2021-03-07 22:49:15', 1, NULL);
INSERT INTO `sys_api` VALUES (35, '加载API树 ', '/api/getTree', 'GET', '30', 5, '2021-03-07 22:49:45', '2021-03-07 22:49:47', 1, NULL);
INSERT INTO `sys_api` VALUES (36, '更新API', '/api/update/?', 'PUT', '30', 6, '2021-03-07 22:50:14', '2021-03-07 22:50:16', 1, NULL);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单/按钮ID',
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '上级菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单/按钮名称',
  `router_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '前端菜单路由URL',
  `perms` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '权限标识',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `type` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型 0菜单 1按钮',
  `order_num` bigint(20) NULL DEFAULT NULL COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `available` int(11) NULL DEFAULT 1 COMMENT '0：不可用，1：可用',
  `open` int(1) NULL DEFAULT 1 COMMENT '0:不展开，1：展开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 330 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', NULL, NULL, 'el-icon-setting', '0', 1, '2021-03-07 21:33:05', '2021-03-07 21:33:08', 1, 1);
INSERT INTO `sys_menu` VALUES (2, 1, '用户管理', '/users', '', 'el-icon-user', '0', 1, '2021-03-07 21:35:03', '2021-03-07 21:35:03', 1, 1);
INSERT INTO `sys_menu` VALUES (3, 2, '用户添加', NULL, 'user:add', 'el-icon-plus', '1', NULL, '2021-03-07 21:40:40', '2021-03-07 21:40:42', 1, 0);
INSERT INTO `sys_menu` VALUES (4, 2, '用户删除', NULL, 'user:delete', 'el-icon-picture', '1', NULL, '2021-03-07 21:42:09', '2021-03-07 21:42:12', 1, 0);
INSERT INTO `sys_menu` VALUES (5, 2, '用户编辑', NULL, 'user:edit', 'el-icon-video-camera-solid', '1', NULL, '2021-03-07 21:42:54', '2021-03-07 21:42:56', 1, 0);
INSERT INTO `sys_menu` VALUES (6, 2, '分配角色', NULL, 'user:assign', 'el-icon-s-tools', '1', NULL, '2021-03-07 21:44:09', '2021-03-07 21:44:11', 1, 0);
INSERT INTO `sys_menu` VALUES (7, 2, '禁用用户', NULL, 'user:status', 'el-icon-circle-close', '1', NULL, '2021-03-07 21:44:46', '2021-03-07 21:44:48', 1, 0);
INSERT INTO `sys_menu` VALUES (8, 2, '用户更新', NULL, 'user:update', 'el-icon-refresh', '1', NULL, '2021-03-07 21:46:14', '2021-03-07 21:46:16', 1, 0);
INSERT INTO `sys_menu` VALUES (9, 2, '导出表格', NULL, 'user:export', 'el-icon-edit', '1', NULL, '2021-03-07 21:46:59', '2021-03-07 21:47:02', 1, 0);
INSERT INTO `sys_menu` VALUES (10, 1, '角色管理', '/roles', '', 'el-icon-postcard', '0', 2, '2020-03-10 05:51:28', '2020-05-16 16:37:58', 1, 1);
INSERT INTO `sys_menu` VALUES (11, 10, '角色编辑', '', 'role:edit', 'el-icon-s-promotion', '1', NULL, '2020-03-10 06:11:03', '2020-03-11 11:40:19', 1, 0);
INSERT INTO `sys_menu` VALUES (12, 10, '角色删除', '', 'role:delete', 'el-icon-s-marketing', '1', NULL, '2020-03-10 06:15:29', '2020-03-11 11:43:36', 1, 0);
INSERT INTO `sys_menu` VALUES (13, 10, '分配权限', '', 'role:authority', 'el-icon-document-add', '1', NULL, '2020-03-10 08:13:22', '2020-03-11 11:39:30', 1, 0);
INSERT INTO `sys_menu` VALUES (14, 10, '添加角色', '', 'role:add', 'el-icon-help', '1', NULL, '2020-03-11 03:34:18', '2020-03-11 03:34:18', 1, 0);
INSERT INTO `sys_menu` VALUES (15, 10, '角色更新', '', 'role:update', 'el-icon-refresh-left', '1', NULL, '2020-03-11 11:45:20', '2020-03-11 11:45:20', 1, 0);
INSERT INTO `sys_menu` VALUES (16, 10, '状态更新', '', 'role:status', 'el-icon-refresh', '1', NULL, '2020-03-14 05:07:02', '2020-03-14 05:07:24', 1, 0);
INSERT INTO `sys_menu` VALUES (17, 1, '菜单管理', '/menus', NULL, 'el-icon-menu', '0', 3, '2020-03-07 18:57:42', '2020-03-20 11:50:46', 1, 1);
INSERT INTO `sys_menu` VALUES (18, 17, '添加菜单', '', 'menu:add', 'el-icon-s-opportunity', '1', NULL, '2020-03-10 07:55:10', '2020-04-27 09:59:43', 1, 0);
INSERT INTO `sys_menu` VALUES (19, 17, '修改菜单', '', 'menu:update', 'el-icon-share', '1', NULL, '2020-03-10 07:56:55', '2020-03-15 13:29:29', 1, 0);
INSERT INTO `sys_menu` VALUES (20, 17, '删除菜单', '', 'menu:delete', 'el-icon-folder-opened', '1', NULL, '2020-03-10 07:57:38', '2020-03-15 13:29:41', 1, 0);
INSERT INTO `sys_menu` VALUES (21, 17, '编辑菜单', '', 'menu:edit', 'el-icon-edit', '1', NULL, '2020-03-22 23:12:25', '2020-03-22 23:12:25', 1, 0);
INSERT INTO `sys_menu` VALUES (22, 17, '导出菜单', NULL, 'menu:export', 'el-icon-edit', '1', NULL, '2020-04-27 17:26:40', '2020-04-27 17:26:40', 1, 0);
INSERT INTO `sys_menu` VALUES (23, 1, 'API管理', '/apis', NULL, 'el-icon-document', '0', 4, '2020-03-07 18:57:42', '2020-03-20 11:50:46', 1, 1);
INSERT INTO `sys_menu` VALUES (24, 23, '添加API', NULL, 'api:add', 'el-icon-s-opportunity', '1', NULL, '2021-03-07 22:07:14', '2021-03-07 22:07:17', 1, 0);
INSERT INTO `sys_menu` VALUES (25, 23, '修改API', NULL, 'api:update', 'el-icon-share', '1', NULL, '2021-03-07 22:07:57', '2021-03-07 22:07:59', 1, 0);
INSERT INTO `sys_menu` VALUES (26, 23, '删除API', NULL, 'api:delete', 'el-icon-folder-opened', '1', NULL, '2021-03-07 22:08:57', '2021-03-07 22:08:59', 1, 0);
INSERT INTO `sys_menu` VALUES (27, 23, '编辑API', NULL, 'api:edit', 'el-icon-edit', '1', NULL, '2021-03-07 22:09:54', '2021-03-07 22:09:56', 1, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编码',
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `enabled` int(1) NULL DEFAULT 1 COMMENT '是否可用,0:不可用，1：可用',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'admin', '超级管理员', '2021-03-07 21:25:18', '2021-03-07 21:25:20', 1, NULL);
INSERT INTO `sys_role` VALUES (2, 'teacher', '老师', '2021-03-07 21:25:49', '2021-03-07 21:25:51', 1, NULL);
INSERT INTO `sys_role` VALUES (3, 'student', '学生', '2021-03-07 21:26:42', '2021-03-07 21:26:45', 1, NULL);

-- ----------------------------
-- Table structure for sys_role_api
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_api`;
CREATE TABLE `sys_role_api`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色ID',
  `api_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'API管理表ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色接口表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_api
-- ----------------------------
INSERT INTO `sys_role_api` VALUES (1, '1', '1', '2021-03-07 22:16:41', '2021-03-07 22:16:44');
INSERT INTO `sys_role_api` VALUES (2, '1', '2', '2021-03-07 22:19:22', '2021-03-07 22:19:09');
INSERT INTO `sys_role_api` VALUES (3, '1', '3', '2021-03-07 22:20:03', '2021-03-07 22:20:04');
INSERT INTO `sys_role_api` VALUES (4, '1', '4', '2021-03-07 22:21:00', '2021-03-07 22:21:10');
INSERT INTO `sys_role_api` VALUES (5, '1', '5', '2021-03-07 22:22:19', '2021-03-07 22:22:21');
INSERT INTO `sys_role_api` VALUES (6, '1', '6', '2021-03-07 22:24:13', '2021-03-07 22:24:15');
INSERT INTO `sys_role_api` VALUES (7, '1', '7', '2021-03-07 22:24:47', '2021-03-07 22:24:49');
INSERT INTO `sys_role_api` VALUES (8, '1', '8', '2021-03-07 22:25:25', '2021-03-07 22:25:28');
INSERT INTO `sys_role_api` VALUES (9, '1', '9', '2021-03-07 22:25:58', '2021-03-07 22:26:00');
INSERT INTO `sys_role_api` VALUES (10, '1', '10', '2021-03-07 22:26:31', '2021-03-07 22:26:33');
INSERT INTO `sys_role_api` VALUES (11, '1', '11', '2021-03-07 22:27:03', '2021-03-07 22:27:03');
INSERT INTO `sys_role_api` VALUES (12, '1', '12', '2021-03-07 22:27:43', '2021-03-07 22:27:47');
INSERT INTO `sys_role_api` VALUES (13, '1', '13', '2021-03-07 22:19:22', '2021-03-07 22:19:09');
INSERT INTO `sys_role_api` VALUES (14, '1', '14', '2021-03-07 22:36:27', '2021-03-07 22:36:29');
INSERT INTO `sys_role_api` VALUES (15, '1', '15', '2021-03-07 22:37:24', '2021-03-07 22:37:27');
INSERT INTO `sys_role_api` VALUES (16, '1', '16', '2021-03-07 22:39:17', '2021-03-07 22:39:20');
INSERT INTO `sys_role_api` VALUES (17, '1', '17', '2021-03-07 22:40:05', '2021-03-07 22:40:07');
INSERT INTO `sys_role_api` VALUES (18, '1', '18', '2021-03-07 22:42:36', '2021-03-07 22:42:38');
INSERT INTO `sys_role_api` VALUES (19, '1', '19', '2021-03-07 22:43:29', '2021-03-07 22:43:32');
INSERT INTO `sys_role_api` VALUES (20, '1', '20', '2021-03-07 22:44:04', '2021-03-07 22:44:08');
INSERT INTO `sys_role_api` VALUES (21, '1', '21', '2021-03-07 22:44:33', '2021-03-07 22:44:35');
INSERT INTO `sys_role_api` VALUES (22, '1', '22', '2021-03-07 22:45:03', '2021-03-07 22:45:05');
INSERT INTO `sys_role_api` VALUES (23, '1', '23', '2021-03-07 22:19:22', '2021-03-07 22:19:09');
INSERT INTO `sys_role_api` VALUES (24, '1', '24', '2021-03-07 22:47:13', '2021-03-07 22:47:15');
INSERT INTO `sys_role_api` VALUES (25, '1', '25', '2021-03-07 22:47:47', '2021-03-07 22:47:49');
INSERT INTO `sys_role_api` VALUES (26, '1', '26', '2021-03-07 22:48:40', '2021-03-07 22:48:42');
INSERT INTO `sys_role_api` VALUES (27, '1', '27', '2021-03-07 22:49:13', '2021-03-07 22:49:15');
INSERT INTO `sys_role_api` VALUES (28, '1', '28', '2021-03-07 22:49:45', '2021-03-07 22:49:47');
INSERT INTO `sys_role_api` VALUES (29, '1', '29', '2021-03-07 22:50:14', '2021-03-07 22:50:16');
INSERT INTO `sys_role_api` VALUES (30, '1', '30', '2021-03-07 22:19:22', '2021-03-07 22:19:09');
INSERT INTO `sys_role_api` VALUES (31, '1', '31', '2021-03-07 22:47:13', '2021-03-07 22:47:15');
INSERT INTO `sys_role_api` VALUES (32, '1', '32', '2021-03-07 22:47:47', '2021-03-07 22:47:49');
INSERT INTO `sys_role_api` VALUES (33, '1', '33', '2021-03-07 22:48:40', '2021-03-07 22:48:42');
INSERT INTO `sys_role_api` VALUES (34, '1', '34', '2021-03-07 22:49:13', '2021-03-07 22:49:15');
INSERT INTO `sys_role_api` VALUES (35, '1', '35', '2021-03-07 22:49:45', '2021-03-07 22:49:47');
INSERT INTO `sys_role_api` VALUES (36, '1', '36', '2021-03-07 22:50:14', '2021-03-07 22:50:16');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单/按钮ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1, 1, '2021-03-07 22:16:41', '2021-03-07 22:16:41');
INSERT INTO `sys_role_menu` VALUES (2, 1, 2, '2021-03-07 22:19:22', '2021-03-07 22:19:22');
INSERT INTO `sys_role_menu` VALUES (3, 1, 3, '2021-03-07 22:20:03', '2021-03-07 22:20:03');
INSERT INTO `sys_role_menu` VALUES (4, 1, 4, '2021-03-07 22:21:00', '2021-03-07 22:21:00');
INSERT INTO `sys_role_menu` VALUES (5, 1, 5, '2021-03-07 22:22:19', '2021-03-07 22:22:19');
INSERT INTO `sys_role_menu` VALUES (6, 1, 6, '2021-03-07 22:24:13', '2021-03-07 22:24:13');
INSERT INTO `sys_role_menu` VALUES (7, 1, 7, '2021-03-07 22:24:47', '2021-03-07 22:24:47');
INSERT INTO `sys_role_menu` VALUES (8, 1, 8, '2021-03-07 22:25:25', '2021-03-07 22:25:25');
INSERT INTO `sys_role_menu` VALUES (9, 1, 9, '2021-03-07 22:25:58', '2021-03-07 22:25:58');
INSERT INTO `sys_role_menu` VALUES (10, 1, 10, '2021-03-07 22:26:31', '2021-03-07 22:26:31');
INSERT INTO `sys_role_menu` VALUES (11, 1, 11, '2021-03-07 22:27:03', '2021-03-07 22:27:03');
INSERT INTO `sys_role_menu` VALUES (12, 1, 12, '2021-03-07 22:27:43', '2021-03-07 22:27:43');
INSERT INTO `sys_role_menu` VALUES (13, 1, 13, '2021-03-07 22:19:22', '2021-03-07 22:19:22');
INSERT INTO `sys_role_menu` VALUES (14, 1, 14, '2021-03-07 22:36:27', '2021-03-07 22:36:27');
INSERT INTO `sys_role_menu` VALUES (15, 1, 15, '2021-03-07 22:37:24', '2021-03-07 22:37:24');
INSERT INTO `sys_role_menu` VALUES (16, 1, 16, '2021-03-07 22:39:17', '2021-03-07 22:39:17');
INSERT INTO `sys_role_menu` VALUES (17, 1, 17, '2021-03-07 22:40:05', '2021-03-07 22:40:05');
INSERT INTO `sys_role_menu` VALUES (18, 1, 18, '2021-03-07 22:42:36', '2021-03-07 22:42:36');
INSERT INTO `sys_role_menu` VALUES (19, 1, 19, '2021-03-07 22:43:29', '2021-03-07 22:43:29');
INSERT INTO `sys_role_menu` VALUES (20, 1, 20, '2021-03-07 22:44:04', '2021-03-07 22:44:04');
INSERT INTO `sys_role_menu` VALUES (21, 1, 21, '2021-03-07 22:44:33', '2021-03-07 22:44:33');
INSERT INTO `sys_role_menu` VALUES (22, 1, 22, '2021-03-07 22:45:03', '2021-03-07 22:45:03');
INSERT INTO `sys_role_menu` VALUES (23, 1, 23, '2021-03-07 22:19:22', '2021-03-07 22:19:22');
INSERT INTO `sys_role_menu` VALUES (24, 1, 24, '2021-03-07 22:47:13', '2021-03-07 22:47:13');
INSERT INTO `sys_role_menu` VALUES (25, 1, 25, '2021-03-07 22:47:47', '2021-03-07 22:47:47');
INSERT INTO `sys_role_menu` VALUES (26, 1, 26, '2021-03-07 22:48:40', '2021-03-07 22:48:40');
INSERT INTO `sys_role_menu` VALUES (27, 1, 27, '2021-03-07 22:49:13', '2021-03-07 22:49:13');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `avatar` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '头像',
  `phone_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `enabled` int(1) NOT NULL COMMENT '账户是否禁用 默认为1（可用）',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `sex` int(1) NULL DEFAULT NULL COMMENT '性别 1男 0女 2保密',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '0:超级管理员，1：系统用户',
  `birth` date NULL DEFAULT NULL COMMENT '生日',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后一次登录时间',
  `token` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'token令牌',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$z9kizbquVHRNk1jEdGy7suTI3JxWBCnXOd6GkLg.RmZQszZRxD26.', '超级管理员', '1351261434@qq.com', 'https://xinguan-parent.oss-cn-hangzhou.aliyuncs.com/2020/10/23/327fdad160b840f8b14611f4d00d94bd.png', '17675753912', 1, '2020-12-28 15:51:23', '2020-12-28 15:51:23', 1, 0, '1998-04-22', NULL, '');
INSERT INTO `sys_user` VALUES (2, 'niechangan', '$2a$10$MjeE7I6gJO6pgAcZn4AOlOTWMQoKeu5jmnAoylgrw4usoAB8HoGiW', '聂长安', '1351261434@qq.com', 'https://xinguan-parent.oss-cn-hangzhou.aliyuncs.com/2020/10/23/327fdad160b840f8b14611f4d00d94bd.png', '17675753912', 1, '2021-03-07 21:17:47', '2021-03-07 21:17:47', 1, 1, '1999-04-22', NULL, NULL);
INSERT INTO `sys_user` VALUES (3, 'test', '$2a$10$MtuhoRzKwr.wM71paPzYLO.8l2ADCWsm1Z5o0jjHn1bjgQrkP6.xe', '测试用户', '1351261434@qq.com', 'https://xinguan-parent.oss-cn-hangzhou.aliyuncs.com/2020/10/23/327fdad160b840f8b14611f4d00d94bd.png', '17675753912', 1, '2020-12-28 15:51:50', '2020-12-28 15:51:50', 1, 1, '1999-04-22', NULL, '');
INSERT INTO `sys_user` VALUES (4, 'xiaoge', '$2a$10$2NwLFBb2k9B60yqawlHAZebdXxgL8UktSwDVcgUYA0RO5JOQIJfWG', '小哥', '1351261434@qq.com', 'https://xinguan-parent.oss-cn-hangzhou.aliyuncs.com/2020/10/23/327fdad160b840f8b14611f4d00d94bd.png', '17675753912', 1, '2020-12-28 15:48:31', '2020-12-28 15:48:31', 1, 1, '1993-04-22', NULL, '');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` bigint(10) NULL DEFAULT NULL COMMENT '角色ID',
  `user_id` bigint(10) NULL DEFAULT NULL COMMENT '用户ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统管理 - 用户角色关联表 ' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1, '2021-03-07 21:29:22', '2021-03-07 21:29:25');
INSERT INTO `sys_user_role` VALUES (2, 2, 2, '2021-03-07 21:29:42', '2021-03-07 21:29:44');
INSERT INTO `sys_user_role` VALUES (3, 3, 3, '2021-03-07 21:30:06', '2021-03-07 21:30:10');
INSERT INTO `sys_user_role` VALUES (4, 3, 4, '2021-03-07 21:30:22', '2021-03-07 21:30:25');

SET FOREIGN_KEY_CHECKS = 1;
