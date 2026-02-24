/*
 Navicat Premium Dump SQL

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50726 (5.7.26)
 Source Host           : localhost:3306
 Source Schema         : v2

 Target Server Type    : MySQL
 Target Server Version : 50726 (5.7.26)
 File Encoding         : 65001

 Date: 24/02/2026 16:39:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ntp_common_address
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_address`;
CREATE TABLE `ntp_common_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `is_default` tinyint(2) NULL DEFAULT 0 COMMENT '1默认',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `province` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '市',
  `county` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '县',
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '详细地址',
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 314 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_common_address
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_admin
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_admin`;
CREATE TABLE `ntp_common_admin`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理员账号',
  `pwd` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `role` int(2) NULL DEFAULT 1 COMMENT '角色',
  `market_level` int(11) NULL DEFAULT NULL COMMENT '市场部级别',
  `remarks` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '备注',
  `phone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '手机号码',
  `invitation_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '邀请码',
  `market_uid` int(11) NULL DEFAULT NULL,
  `operate_pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户余额变更使用的操作密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_admin
-- ----------------------------
INSERT INTO `ntp_common_admin` VALUES (1, 'admin', 'd3Q1ODg4ODg=', '2021-03-11 16:15:26', 1, 1, '123', '0', '0', NULL, 'd3Q1ODg4ODg=');
INSERT INTO `ntp_common_admin` VALUES (5, 'admin1', 'MTIzNDU2', '2023-04-12 13:01:51', 1, 0, '0', '0', 'NFMWT5IJHS655DJC', NULL, 'YWExMjM0NTY=');
INSERT INTO `ntp_common_admin` VALUES (6, 'admin2', 'MTIzNDU2', '2023-04-12 13:01:51', 1, 0, '0', '0', 'NFMWT5IJHS655DJC', NULL, 'YWExMjM0NTY=');
INSERT INTO `ntp_common_admin` VALUES (7, 'wangxi', 'MTIzNDU2', '2023-05-31 15:07:12', 1, 0, '0', '0', 'KJDT5QBSRDF4XZDT', NULL, 'YWExMjM0NTY=');
INSERT INTO `ntp_common_admin` VALUES (8, 'kefu1', 'MTIzNDU2', '2023-06-06 01:40:22', 7, 0, '0', '0', 'KLBXPJZMCCY7V6LA', NULL, 'YWExMjM0NTY=');
INSERT INTO `ntp_common_admin` VALUES (9, 'kefu2', 'MTIzNDU2', '2023-06-06 02:17:03', 7, 0, '0', '0', 'WWATVGMBCDLOTEUX', NULL, 'YWExMjM0NTY=');
INSERT INTO `ntp_common_admin` VALUES (10, 'kefu3', 'MTIzNDU2', '2023-06-06 02:17:17', 7, 0, '0', '0', '4CKTGKYFIQN23ZQT', NULL, 'YWExMjM0NTY=');
INSERT INTO `ntp_common_admin` VALUES (11, 'kefu4', 'MTIzNDU2', '2023-06-06 02:17:32', 7, 0, '0', '0', 'RBC5X2NXX3HID3I5', NULL, 'YWExMjM0NTY=');
INSERT INTO `ntp_common_admin` VALUES (12, 'admin101', 'YWRtaW4xMjM=', '2023-06-11 22:13:38', 1, 0, '0', '0', '3UFIDAYDNMNY4KGC', NULL, 'MTIzNDU2');

-- ----------------------------
-- Table structure for ntp_common_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_admin_log`;
CREATE TABLE `ntp_common_admin_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `admin_uid` int(10) NULL DEFAULT NULL COMMENT '管理员id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `mark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `city` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区',
  `system` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作浏览器',
  `action` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_admin_menu`;
CREATE TABLE `ntp_common_admin_menu`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pid` int(10) NULL DEFAULT 0 COMMENT '上级菜单,0为顶级菜单',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单名',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '菜单状态 1正常 0下架',
  `admin_uid` int(10) NULL DEFAULT NULL COMMENT '管理员ID，编辑者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单路径',
  `icon` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标地址',
  `sort` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 729 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台菜单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_admin_menu
-- ----------------------------
INSERT INTO `ntp_common_admin_menu` VALUES (1, 0, '控制面板', 1, 0, '2021-03-25 14:19:22', '2021-04-15 14:02:35', NULL, NULL, 1);
INSERT INTO `ntp_common_admin_menu` VALUES (2, 0, '权限管理', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '', '', 8);
INSERT INTO `ntp_common_admin_menu` VALUES (3, 0, '用户管理', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', NULL, NULL, 2);
INSERT INTO `ntp_common_admin_menu` VALUES (4, 0, '财务管理', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', NULL, NULL, 3);
INSERT INTO `ntp_common_admin_menu` VALUES (5, 0, '市场管理', 0, 0, '2021-03-25 14:19:22', '2023-04-10 14:12:46', NULL, NULL, 4);
INSERT INTO `ntp_common_admin_menu` VALUES (6, 0, '代理商管理', 0, 0, '2021-03-25 14:19:22', '2023-04-10 14:12:50', NULL, NULL, 5);
INSERT INTO `ntp_common_admin_menu` VALUES (7, 0, '公告管理', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', NULL, NULL, 6);
INSERT INTO `ntp_common_admin_menu` VALUES (8, 0, '产品管理', 1, 0, '2021-03-25 14:19:22', '2023-04-10 14:13:08', NULL, NULL, 7);
INSERT INTO `ntp_common_admin_menu` VALUES (9, 0, '日志管理', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', NULL, NULL, 9);
INSERT INTO `ntp_common_admin_menu` VALUES (10, 0, '系统配置', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', NULL, NULL, 10);
INSERT INTO `ntp_common_admin_menu` VALUES (11, 0, '视频管理', 0, 0, '2021-03-30 17:03:32', '2023-04-10 14:12:57', NULL, NULL, 7);
INSERT INTO `ntp_common_admin_menu` VALUES (28, 5, '市场部等级列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/platform/marketLevelList', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (29, 5, '市场部关系列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/platform/marketRelationsList', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (30, 6, '代理商信息', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/platform/agent', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (31, 8, '提现列表', 0, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/user/withdrawal', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (32, 2, '菜单列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/systemset/menulist', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (34, 2, '角色权限管理', 0, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/systemset/role', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (35, 3, '用户列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/user/userlist', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (36, 2, '控制器管理', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/systemset/controllerlist', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (37, 2, '角色列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/systemset/roleadminlist', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (38, 2, '管理员列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/systemset/adminlist', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (39, 1, '控制面板', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/dashboard/console', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (40, 9, '操作日志', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/log/actionlog', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (41, 4, '资金流动', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/log/moneylog', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (42, 9, '登陆日志', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/log/loginlog', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (43, 10, '配置列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/systemmng/configList', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (45, 7, '公告列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/notice/noticeList', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (46, 7, '通知列表', 0, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/notice/notifyList', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (47, 7, '文章分类', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/extension/articleType', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (48, 7, '文章内容列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/extension/articleList', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (49, 11, '产品分类', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/extension/videoType', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (50, 11, '产品列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/extension/videoList', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (52, 6, '代理资金流动', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/platform/moneylog', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (53, 6, '代理充值列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/platform/rechargelog', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (54, 6, '代理提现列表', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/platform/withdrawallog', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (55, 6, '代理推广列表', 1, 0, '2021-03-30 17:03:28', '2021-03-30 17:03:30', '/platform/promotionlog', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (56, 6, '代理用户列表', 0, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/platform/userlist', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (57, 10, '客服设置', 1, NULL, '2022-11-04 12:05:31', '2022-11-04 12:05:33', '/systemmng/customer', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (708, 4, '充值列表', 0, 0, '2021-03-25 14:19:22', '2023-06-07 20:44:59', '/log/rechargelog', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (709, 4, '提现列表', 1, 0, '2021-03-25 14:19:22', '2023-06-07 20:44:48', '/log/withdrawallog', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (714, 4, '订单列表', 1, NULL, '2021-03-30 17:03:28', '2021-03-30 17:03:30', '/log/order', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (715, 11, '套餐列表', 1, NULL, '2021-03-30 17:03:32', '2021-03-30 17:03:33', '/extension/videovipList', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (717, 8, '产品列表', 1, NULL, '2022-11-02 14:37:36', '2022-11-02 14:37:38', '/extension/product', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (718, 10, '轮播图列表', 1, NULL, '2022-11-02 14:42:55', '2022-11-02 14:42:57', '/extension/ads', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (719, 8, '产品分类', 1, NULL, '2022-11-08 10:17:51', '2022-11-08 10:17:53', '/extension/productClass', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (720, 8, '产品天数', 1, NULL, '2022-11-08 10:27:04', '2022-11-08 10:27:05', '/extension/productLev', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (721, 8, '积分商品列表', 1, 1, '2023-04-24 13:05:49', '2023-04-24 13:05:49', '/extension/wareslist', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (722, 4, '资金审查', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/log/rexaminationlog', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (723, 7, '公益列表', 1, 0, NULL, NULL, '/extension/welfareList', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (724, 7, '邀请奖励', 1, 0, '2021-03-25 14:19:22', '2021-03-25 14:19:22', '/extension/invitation', '', 0);
INSERT INTO `ntp_common_admin_menu` VALUES (725, 4, '积分商品兑换列表', 1, 5, '2023-05-24 19:21:58', '2023-05-24 19:21:58', '/log/exchange', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (726, 3, '用户充值', 1, 5, '2023-05-28 18:58:54', '2023-05-28 18:58:54', '/user/recharge', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (727, 3, '用户金额修改', 1, 5, '2023-05-28 18:59:10', '2023-05-28 18:59:10', '/user/amountEdit', NULL, 0);
INSERT INTO `ntp_common_admin_menu` VALUES (728, 8, '产品价格列表', 1, 5, '2023-05-28 23:14:48', '2023-05-28 23:14:48', '/extension/productMoney', NULL, 0);

-- ----------------------------
-- Table structure for ntp_common_admin_power
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_admin_power`;
CREATE TABLE `ntp_common_admin_power`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路径',
  `type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方式 get post put update detele',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 111 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_admin_power
-- ----------------------------
INSERT INTO `ntp_common_admin_power` VALUES (1, '用户列表', '/admin/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (2, '用户添加', '/admin/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (3, '用户删除', '/admin/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (4, '用户详情', '/admin/detail', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (5, '用户信息修改', '/admin/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (6, '文章内容新增', '/article/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (7, '文章内容查询', '/article/detail', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (8, '文章内容修改', '/article/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (9, '文章内容列表', '/article/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (10, '文章内容删除', '/article/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (11, '文章分类删除', '/article_type/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (12, '文章分类查询', '/article_type/detail', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (13, '文章分类添加', '/article_type/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (14, '文章分类列表', '/article_type/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (15, '文章分类修改', '/article_type/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (16, '资金流动日志', '/money/log', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (17, '登陆日志', '/login/log', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (18, '菜单删除', '/menu/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (19, '菜单查询', '/menu/detail', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (20, '菜单栏目树', '/menu/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (21, '菜单修改', '/menu/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (22, '菜单添加', '/menu/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (23, '通知修改', '/notify/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (25, '通知类型', '/notify/notify', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (26, '通知添加', '/notify/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (27, '通知删除', '/notify/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (28, '通知状态切换', '/notify/status', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (29, '通知查询详情', '/notify/detail', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (30, '公告删除', '/notice/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (31, '公告查询', '/notice/detail', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (32, '公告列表', '/notice/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (33, '公告状态切换', '/notice/status', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (34, '公告位置', '/notice/position', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (35, '公告修改', '/notice/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (36, '公告新增', '/notice/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (37, '充值列表', '/recharge/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (38, '充值确认', '/recharge/status', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (39, '提现列表', '/pay/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (40, '提现成功失败修改', '/pay/status', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (41, '设置支付银行卡默认', '/paybank/default', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (42, '支付银行卡列表', '/paybank/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (43, '支付银行卡删除', '/paybank/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (44, '设置银行卡默认', '/bank/default', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (45, '银行卡列表', '/bank/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (46, '银行卡删除', '/bank/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (47, '配置删除', '/config/del', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (48, '配置列表', '/config/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (49, '配置详情', '/config/detail', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (50, '配置修改', '/config/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (51, '配置新增', '/config/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (52, '用户真实信息', '/userreal/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (53, '用户状态修改', '/user/status', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (54, '用户信息修改', '/user/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (55, '用户详情', '/user/detail', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (56, '用户列表', '/user/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (60, '角色修改', '/role/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (61, '角色列表', '/role/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (62, '角色新增', '/role/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (63, '角色菜单权限列表', '/rolemenu/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (64, '角色菜单权限新增', '/rolemenu/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (65, '角色菜单权限改', '/rolemenu/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (66, '角色API权限添加', '/power/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (67, '角色API权限修改', '/power/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (68, '角色API权限列表', '/power/list', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (69, '代理列表', '/user/agent', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (70, '代理添加', '/agent/add', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (71, '代理修改', '/agent/edit', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (72, '代理状态修改', '/agent/status', 'post');
INSERT INTO `ntp_common_admin_power` VALUES (92, '代理用户列表', '/user/list', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (93, '代理资金流动列表', '/money/log', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (94, '代理充值列表', '/recharge/list', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (95, '代理提现列表', '/pay/list', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (96, '代理订单列表', '/order/list', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (97, '用户新增', '/user/add', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (98, '代理查看资金记录', '/money/getFund', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (99, '代理充值资金记录', '/money/userRecharge', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (100, '代理提现记录', '/money/userWithdrawal', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (101, '用户推广记录', '/money/userPromotion', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (102, '用户充值', '/user/recharge', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (103, '用户金额修改', '/money/edit', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (104, '后台控制显示', '/action/con', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (105, '代理商信息', '/user/agent', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (106, '审查余额', '/examine/log', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (107, '兑换订单列表', '/exchange/list', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (108, '用户产品订单', '/touzi_order/index', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (109, '统计', '/index/statistics', NULL);
INSERT INTO `ntp_common_admin_power` VALUES (110, '用户操作密码验证', '/money/operate', NULL);

-- ----------------------------
-- Table structure for ntp_common_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_admin_role`;
CREATE TABLE `ntp_common_admin_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `status` int(10) NULL DEFAULT NULL COMMENT '状态 1正常 0冻结',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_admin_role
-- ----------------------------
INSERT INTO `ntp_common_admin_role` VALUES (1, '超级管理员', 1, NULL, NULL);
INSERT INTO `ntp_common_admin_role` VALUES (2, '代理商使用', 1, '2021-04-13 10:59:55', '2021-04-13 16:51:49');
INSERT INTO `ntp_common_admin_role` VALUES (7, '客服', 1, '2023-06-06 01:36:48', '2023-06-06 01:36:48');

-- ----------------------------
-- Table structure for ntp_common_admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_admin_role_menu`;
CREATE TABLE `ntp_common_admin_role_menu`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` int(10) NULL DEFAULT NULL COMMENT '角色ID',
  `auth_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限组',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_admin_role_menu
-- ----------------------------
INSERT INTO `ntp_common_admin_role_menu` VALUES (1, 1, '708,28,26,25,709,29');
INSERT INTO `ntp_common_admin_role_menu` VALUES (2, 6, '30,6,32');
INSERT INTO `ntp_common_admin_role_menu` VALUES (3, 5, '11,715,50,49');
INSERT INTO `ntp_common_admin_role_menu` VALUES (4, 2, '6,52,53,54,55');
INSERT INTO `ntp_common_admin_role_menu` VALUES (5, 7, '3,4,726,727,35,722,725,41,708,709,714');

-- ----------------------------
-- Table structure for ntp_common_admin_role_power
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_admin_role_power`;
CREATE TABLE `ntp_common_admin_role_power`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` int(10) NULL DEFAULT NULL COMMENT '角色ID',
  `auth_ids` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限集',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_admin_role_power
-- ----------------------------
INSERT INTO `ntp_common_admin_role_power` VALUES (1, 1, '72,71,70,69');
INSERT INTO `ntp_common_admin_role_power` VALUES (2, 6, '69,1,71,70,20');
INSERT INTO `ntp_common_admin_role_power` VALUES (3, 5, '90,89,88,87,85,86,84,82,81,80,79,77,76,75,74,20,91');
INSERT INTO `ntp_common_admin_role_power` VALUES (4, 2, '20,101,100,99,98');
INSERT INTO `ntp_common_admin_role_power` VALUES (5, 7, '103,102,56,54,53,20,52,55,39,37,16,105,104,106,107,108,109,110');

-- ----------------------------
-- Table structure for ntp_common_admin_token
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_admin_token`;
CREATE TABLE `ntp_common_admin_token`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登陆凭证',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `admin_uid` int(10) NULL DEFAULT NULL COMMENT '管理员ID',
  `type` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台确定单点登陆' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_admin_token
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_ads
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_ads`;
CREATE TABLE `ntp_common_ads`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示 1是 ',
  `img` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图片地址',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '轮播图',
  `is_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '类型：0：图片；1：文章',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '轮播图' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_common_ads
-- ----------------------------
INSERT INTO `ntp_common_ads` VALUES (22, '2023-05-26 11:59:53', 1, 'topic/20230608/28020b27b57664aaf3d10a8aed3cc04d.jpg', 3, 1, 0, NULL, '');
INSERT INTO `ntp_common_ads` VALUES (27, '2023-06-08 16:50:08', 1, 'topic/20230608/b61bbc83377a25c460a00d63b7caa542.jpg', 2, 1, 0, NULL, '');
INSERT INTO `ntp_common_ads` VALUES (26, '2023-05-26 12:29:14', 1, 'topic/20230601/72486e64721f8abbe32fada4810d6a66.jpg', 4, 1, 0, NULL, '');
INSERT INTO `ntp_common_ads` VALUES (25, '2023-05-26 12:29:03', 0, 't', 3, 5, 0, NULL, '');
INSERT INTO `ntp_common_ads` VALUES (29, '2023-06-11 22:00:05', 1, 'topic/20230611/e798d33d36a6054a13970be0d8d5c723.png', 1, 1, 0, NULL, '');
INSERT INTO `ntp_common_ads` VALUES (24, '2023-05-26 12:17:45', 0, 't', 2, 5, 0, NULL, '');
INSERT INTO `ntp_common_ads` VALUES (28, '2023-06-08 17:44:19', 1, 't', 1, 5, 1, NULL, '&lt;p&gt;&lt;img src=&quot;https://www.dahxn.cn/storage/topic/20230611/aee39a7b26e5e8d3211e991e95e8ea8f.png&quot;&gt;&lt;/p&gt;');

-- ----------------------------
-- Table structure for ntp_common_agent_path
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_agent_path`;
CREATE TABLE `ntp_common_agent_path`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户所有上一级',
  `agent_id` int(11) NOT NULL COMMENT '直属代理ID',
  `times` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33679 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户所有上一级' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_common_agent_path
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_article
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_article`;
CREATE TABLE `ntp_common_article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '分类',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `thumb_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4425 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_article
-- ----------------------------
INSERT INTO `ntp_common_article` VALUES (157, 2, '　　上海市崇明西沙湿地，游客在蓝天绿水间游玩。严大明摄（影像中国）&nbsp;甘肃省武威市民勤县，蓝天如碧，干部职工参加义务治沙。', '2022-12-28 09:00:00', '2023-05-07 16:29:38', '/static/xinwen/MAIN202212110859000283914058571.jpg', '蓝天保卫战交出优异答卷（新时代画卷）', '人民网环保', '');
INSERT INTO `ntp_common_article` VALUES (158, 2, '　　只有持续强化生态环境治理，持之以恒护绿增绿，才能让水质更好、生物种类更丰富、城乡居民生活更美好		尊重自然、顺应自然、保护自然，是全面建设社会主义现代化国家的内在要求。党的二十大报告提出：“必须牢固树立和践行绿水青山就是金山银山的理念，站在人与自然和谐共生的高度谋划发展。', '2022-12-28 09:00:00', '2023-05-07 16:29:38', '/static/xinwen/MAIN202212110901000292674030880.jpg', '找准生态保护与经济发展的结合点（治理者说）', '人民网环保', '');
INSERT INTO `ntp_common_article` VALUES (159, 2, '　　新华社北京12月27日电（记者严赋憬、高敬）野生动物保护法修订草案三审稿27日提请十三届全国人大常委会第三十八次会议审议。根据各方建议，草案三审稿对进一步加强防止外来物种侵害进行规定。', '2022-12-28 09:00:00', '2023-05-07 16:29:38', '/static/xinwen/MAIN202212110907000042701293440.jpg', '野生动物保护法修订草案三审稿加强防止外来物种侵害', '人民网环保', '');
INSERT INTO `ntp_common_article` VALUES (160, 2, '&lt;p&gt;新华社北京12月27日电（记者&amp;nbsp;高敬）青藏高原生态保护法草案二审稿27日提请十三届全国人大常委会第三十八次会议审议。根据各方对草案一审稿提出的意见建议，草案二审稿增加了相应规定，促进青藏高原生态安全及生物多样性保护。&lt;/p&gt;', '2022-12-28 09:00:00', '2023-05-23 08:10:36', '/topic/20230523/417b711f738a6ffaf701fb2dd055b0ed.jpg', '青藏高原生态保护法草案进一步加强生物多样性保护', '人民网环保', '');
INSERT INTO `ntp_common_article` VALUES (161, 2, '&lt;p&gt;新华社北京12月27日电（记者&amp;nbsp;高敬）海洋环境保护法修订草案27日初次提请十三届全国人大常委会第三十八次会议审议。	全国人大环境与资源保护委员会副主任委员王洪尧在作草案说明时介绍，现行海洋环境保护法于1982年通过，1999年修订，2013年、2016年、2017年先后三次进行了修正。&lt;/p&gt;', '2022-12-28 09:00:00', '2023-05-23 08:11:08', '/topic/20230523/04c42cf3aa89a22f038dc228ee84fb71.jpg', '我国拟修订法律以持续改善海洋生态环境质量', '人民网环保', '');
INSERT INTO `ntp_common_article` VALUES (163, 2, '&lt;p&gt;全国电力安委会各成员单位：&lt;/p&gt;&lt;p&gt;今年6月是第22个全国“安全生产月”，主题是“人人讲安全、个个会应急”。依据《国务院安委会办公室 应急管理部关于印发〈2023年全国“安全生产月”活动方案〉的通知》（安委办〔2023〕5号），国家能源局同步开展电力行业2023年“安全生产月”活动。现将有关事项通知如下。&lt;/p&gt;&lt;p&gt;&lt;strong&gt; 一、总体思路&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;以习近平新时代中国特色社会主义思想为指导，深入宣传贯彻党的二十大精神和习近平总书记关于安全生产重要论述，坚持人民至上、生命至上，坚持统筹发展和安全，坚持安全第一、预防为主，以“人人讲安全、个个会应急”为主题，采取线上线下相结合的方式开展一系列宣贯学习、交流研讨、案例警示、应急演练等活动，引导电力行业进一步提高政治站位，强化安全意识，压实各方责任，落实防范措施，守牢安全底线，确保电力系统安全稳定运行和电力可靠供应，保持电力安全生产形势稳定。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;二、主要活动内容&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（一）开展习近平总书记关于安全生产重要论述宣贯活动&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;各单位要紧紧围绕宣传贯彻习近平总书记关于安全生产特别是安全红线重要论述开展学习宣讲活动，全国电力安委会成员单位负责同志要组织开展宣讲活动，发表评论文章或心得体会；各电力企业要通过“公开课”“大家谈”“班组会”等形式广泛开展专题研讨、宣讲授课、培训辅导、案例警示等活动，教育引导广大从业人员强化安全红线意识。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（二）以“人人讲安全、个个会应急”为主题，推动安全宣传“五进”&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;各单位要紧紧围绕主题开展系列宣教活动，要加强教育警示，通过观看典型事故警示教育片、参观事故警示教育展览等方式，以案说法、以案为戒，强化安全意识；要规范作业现场，针对事故高发易发的高空作业、带电作业、密闭空间作业等，强化安全措施落实，规范现场管理；要抓好外委队伍，围绕外包队伍、临时用工人员强化安全培训，补齐能力短板；要提高应急能力，针对各类自然灾害加强安全风险提示，制定避险措施，开展疏散演练。各单位要深入开展安全宣传，广泛张贴或悬挂安全标语、横幅、挂图等，形成强大宣传声势，组织群众喜闻乐见、便于参与的安全生产法规线上答题、安全防护器具操作体验等宣教培训活动，推动电力安全宣传“五进”。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（三）聚焦专项排查整治，企业负责人落实“五带头”&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;各单位要持续宣贯《安全生产法》，督促落实安全生产“第一责任人”法定职责，开展企业主要负责人“安全承诺践诺”活动，建立完善全员安全生产责任制，营造人人讲安全、人人守规章的浓厚氛围。各单位要深入开展全国电力安全生产重大事故隐患专项排查整治，企业主要负责人要落实好“五带头”（带头研究组织本企业重大事故隐患排查整治、带头落实全员安全生产岗位责任、带头参加动火等高危作业安全风险排查整治、带头对外包外租等生产经营活动开展排查整治、带头参加安全应急演练），切实通过专项排查整治发现一批隐患，解决一批问题。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（四）全员参与隐患排查，加强监督检查和曝光警示&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;各派出机构要牵头组织当地政府主管部门、安全生产专家和媒体记者，深入小散远电力企业和存有危化品的重点部位进行“四不两直”检查和采访曝光，结合“安全生产大检查”“明察暗访”等工作，曝光重大事故隐患和突出问题。各派出机构要加强安全监管执法，定期报送执法案例，加强公示曝光。各电力企业要畅通安全生产问题隐患举报渠道，鼓励全员参与查找身边的安全隐患，并对消除隐患、避免事故的个人给予奖励。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（五）组织开展常态化应急演练&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;各地要结合安全宣传“五进”工作，组织开展有效管用的全员应急演练。国家能源局将择机开展跨省区大面积停电事件应急演练，提升区域电网大面积停电事件的协同能力、应急能力和处置能力。各电力企业要结合迎峰度夏保供、防汛防台抗灾等重点工作，广泛开展应急与安全培训，组织一次突发事件应急演练，让全体从业人员时刻牢记安全生产岗位责任，进一步提升自救互救能力和应急处置能力。各派出机构和地方政府有关部门要积极参与和指导企业演练活动，加强宣传报道力度，促进提升应急避险能力。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（六）开展“6·16安全宣传咨询日”活动&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;国家能源局在中国能源新闻网（http://www.cpnn.com.cn/）电力安全云上展厅开设“6·16安全宣传咨询日”活动专栏，分设 安全吹哨人、安全微讲堂、安全随手拍、应急直播间四个子栏目，各单位要广泛组织安全知识答题竞答活动，以安全法规、应急管理、自救互救、紧急避险等内容为重点，让广大参与者在线上线下答题互动中，学习安全知识，掌握安全技能。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（七）开展电力安全技术与管理系列交流活动&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;国家能源局将以线上线下结合方式举办第三届电力安全技术和管理论坛，立足新型电力系统建设发展需要，搭建电力企业交流平台，研讨技术与管理前沿问题，助力行业转型发展。各电力企业要认真总结近年来电力安全技术与管理工作，充分展示先进经验和优秀成果，积极踊跃参与；中能传媒要充分发挥全媒体平台作用，全面做好宣传报道。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（八）持续深化电力安全齐抓共管工作机制&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;在安全生产月期间，国家能源局各派出机构要会同地方政府电力管理部门共同开展“五个一”活动（共同会商一次电力安全生产形势、共同组织或参加一次应急演练或演习、共同组织一次安全风险隐患排查治理、共同开展一次联合执法检查、共同参与一次电力企业“安全生产月”活动），不断强化齐抓共管工作合力。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong&gt;三、有关要求&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（一）加强组织领导。各单位要高度重视、加强组织、积极参与，把“安全生产月”活动作为阶段性重点工作，专题研究部署，细化活动方案，明确时间节点和进度安排，确保层层有人抓，事事有人管。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（二）营造安全氛围。各单位要组织协调主流媒体、行业媒体及新媒体加大宣传力度，开设活动专题专栏，增加宣传报道，&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;张贴悬挂安全生产标语、海报、挂图，增强安全生产月活动的影响力、感染力。国家能源局将通过中国能源新闻网网站（http://www.cpnn.com.cn/）和《中国电力报》等媒体大力宣传本次“安全生产月”活动，以及各单位工作进展和成果。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;（三）确保活动实效。各单位要把安全生产月活动与企业生产经营活动相结合，与安全生产专项整治等重点工作相结合，与破解安全发展难点问题相结合，推动防范化解重大风险，促进安全生产水平提升，增强人民群众的获得感、幸福感、安全感。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;请各单位于5月26日前确定1名联络员（附件1），并及时提供活动期间好的做法、特色项目、重要事项以及视频、图片、文字等电子版资料，6月期间每周四12:00前报送活动进展情况统计表（附件2）。上述材料同步报送国家能源局和中能传媒。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;国家能源局联系人：张雷，马楠&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;联系电话：010-81929627，010-81929622&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;电子邮箱：dianlianquan@163.com&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;中能传媒联系人：孟肖虎，赵飞&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;联系电话：13910165692，13511058150&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;strong style=&quot;color: rgb(0, 0, 0);&quot;&gt;电子邮箱：392735633@qq.com&lt;/strong&gt;&lt;/p&gt;', '2022-12-12 14:00:00', '2023-05-29 13:34:08', '/static/xinwen/MAIN202212121316000229582265899.jpg', '国家能源局综合司关于开展2023年电力行业“安全生产月”活动的通知', '人民网环保', '');
INSERT INTO `ntp_common_article` VALUES (4408, 24, '&lt;p&gt;			1. 注册并完善个人信息：在环保网站上注册并完善个人信息可以享受更多的服务和优惠。&lt;/p&gt;&lt;p&gt;			&amp;lt;br&amp;gt;&lt;/p&gt;&lt;p&gt;			2. 了解平台内容：浏览网站上的内容，了解平台上提供的各类服务，包括环保产品、环保教育、环境监测等方面的内容。&lt;/p&gt;&lt;p&gt;			&amp;lt;br&amp;gt;&lt;/p&gt;&lt;p&gt;			3. 智能搜索：通过网站提供的智能搜索功能快速查找您所需的内容。&lt;/p&gt;&lt;p&gt;			&amp;lt;br&amp;gt;&lt;/p&gt;&lt;p&gt;			4. 交流互动：在平台上可以与其他网友交流和互动，分享自己的环保经验，获取和学习其他环保知识和方法。&lt;/p&gt;&lt;p&gt;			&amp;lt;br&amp;gt;&lt;/p&gt;&lt;p&gt;			5. 参加活动：在平台上可以参加各类环保活动，包括主题论坛、宣传活动、环保公益等，获取奖励和认证。&lt;/p&gt;&lt;p&gt;			&amp;lt;br&amp;gt;&lt;/p&gt;&lt;p&gt;			6. 定制服务：如果您有特殊的环保需求或问题，可以通过平台联系专业的环保顾问提供专业的服务和方案。&lt;/p&gt;&lt;p&gt;			&amp;lt;br&amp;gt;&lt;/p&gt;&lt;p&gt;			7. 安全支付：在网站上购买环保产品或服务时，一定要保证网站的安全，选择信誉好、口碑良好的平台，确保支付的安全。&lt;/p&gt;', '2023-05-11 15:59:10', '2023-05-11 15:59:10', '/topic/20230511/de3061e2ba1226bac41c5bfc16a11641.jpg', '平台攻略', '官方', '平台攻略');
INSERT INTO `ntp_common_article` VALUES (4409, 25, '&lt;p&gt;绿色中国发展，坚持执行绿色社会&lt;/p&gt;', '2023-05-11 19:29:41', '2023-05-11 19:29:41', '/topic/20230511/4466274eeb959edee290e4d4278b843d.jpg', '今日最新政策', '央视最新报道', NULL);
INSERT INTO `ntp_common_article` VALUES (4410, 2, '&lt;p&gt;2023年5月15日，中国环境监测总站联合中央气象台、国家大气污染防治攻关联合中心、东北、华南、西南、西北、长三角区域空气质量预测预报中心和北京市生态环境监测中心，开展5月下半月（16—31日）全国空气质量预报会商。&lt;/p&gt;&lt;p&gt;5月下半月，全国大部空气质量以良至轻度污染为主，局地可能出现中度及以上污染。华北中南部、华东中北部、成都平原和川南部分地区可能出现臭氧中度及以上污染；受沙尘天气影响，新疆东疆及内蒙古西部可能出现中度污染，新疆南疆可能出现重度及以上污染。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;京津冀及周边区域：&lt;/strong&gt;5月下半月，区域大部空气质量以良至轻度污染为主，局地部分时段可能出现中度及以上污染。其中，16日，区域大部气象条件有利于臭氧生成和累积，京津冀中南部、山西中南部、山东西部和河南中北部可能出现中度及以上污染；17—20日，区域北部扩散条件有所改善，中南部可能出现中度污染；23—24日，区域中南部温度有所升高，河北中部可能出现中度污染；25—31日，区域扩散条件一般，空气质量以良至轻度污染为主。首要污染物为臭氧。&lt;/p&gt;&lt;p&gt;北京市：5月下半月，北京市空气质量以良为主，部分时段可能出现轻度污染。其中，16日，扩散条件不利，可能出现轻至中度污染过程；17—22日，扩散条件改善，空气质量为良；23—31日，扩散条件一般，可能出现轻度污染过程。首要污染物为臭氧。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;长三角区域：&lt;/strong&gt;5月下半月，区域大部空气质量以良至轻度污染为主，局地部分时段可能出现中度污染。其中，16日，区域中北部以轻度污染为主，南部为良至轻度污染；17日，中南部以良为主，北部为良至轻度污染；18—21日，整体为良至轻度污染，中北部局地可能出现中度污染；22日，中北部局地为轻度污染；23—27日，区域气温上升，整体为良至轻度污染；28—29日，整体以良为主；30—31日，整体为良至轻度污染，中北部局地可能出现中度污染。首要污染物为臭氧。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;苏皖鲁豫交界：&lt;/strong&gt;5月下半月，区域大部空气质量以良至轻度污染为主，局地部分时段可能出现中度污染。其中，16—17日，整体以轻度污染为主，山东、河南局地可能出现中度污染；18—21日，整体为良至轻度污染，中北部局地可能出现中度污染；22日，整体以良至轻度污染为主；23—27日，整体以良至轻度污染为主，局地可能出现中度污染；28—29日，整体以良为主；30—31日，整体以良至轻度污染为主，局地可能出现中度污染。首要污染物为臭氧。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;汾渭平原：&lt;/strong&gt;5月下半月，区域大部空气质量以良至轻度污染为主，局地部分时段可能出现中度污染。其中，16—17日，区域大部空气质量以轻度污染为主，陕西关中及山西西南部分城市可能出现中度污染；18—20日，陕西关中地区空气质量以轻度污染为主，山西西南及河南西北部以良至轻度污染为主；21—22日，区域大部空气质量以良为主，局地可能出现轻度污染；23—26日、28—31日，区域大部空气质量以良至轻度污染为主；27日，陕西关中及山西西南部空气质量以良为主，河南西北部可能出现轻至中度污染。首要污染物为臭氧。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;　东北区域：&lt;/strong&gt;5月下半月，区域大部空气质量以优良为主，局地可能出现轻至中度污染。其中，16日，内蒙古东部偏南盟市、吉林大部空气质量以良至轻度污染为主，辽宁大部以轻至中度污染为主；19日，内蒙古东部偏南盟市、辽宁中西部空气质量以良至轻度污染为主，内蒙东部局地可能出现短时沙尘天气；24—27日，吉林大部、辽宁大部以良至轻度污染为主；31日，吉林中部、辽宁中西部以良至轻度污染为主。首要污染物为臭氧或颗粒物。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;　华南区域：&lt;/strong&gt;5月下半月，区域总体大气扩散条件较好，空气质量以优良为主，局地可能出现轻度污染。其中，16日，福建南部沿海为良至轻度污染；21日，湖南中部为良至轻度污染；24日、27—29日，珠三角和粤东为良至轻度污染；28—31日，湖北中东部为良至轻度污染。首要污染物为臭氧或颗粒物。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;西南区域：&lt;/strong&gt;5月下半月，成渝地区可能出现臭氧轻度污染过程，局部城市可能出现中度污染，西南区域其余地区以优良为主。16—20日，成渝地区大部可能出现轻度污染，成都平原、川南和川东北可能出现中度污染。24—27日，成渝地区大部可能出现轻度污染，成都平原部分城市可能出现中度污染。28—31日，成都平原、川南、川东北部分城市可能出现轻度污染。首要污染物为臭氧。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;西北区域：&lt;/strong&gt;5月下半月，西北区域大部空气质量以良为主，局地可能出现轻度及以上污染。其中，16—17日，区域大部空气质量以良为主，部分地区可能出现轻度污染，陕西关中可能出现中度污染；18—20日，区域大部空气质量以良为主，部分地区可能出现轻度污染；新疆东疆及内蒙古西部局地19日可能出现中度污染；新疆南疆可能出现重度及以上污染；21—22日，区域大部空气质量以优良为主，部分地区可能出现轻度污染；新疆南疆以重度污染为主，部分时段可能出现严重污染；23—31日，区域大部空气质量以良为主，部分地区可能出现轻度污染。受沙尘天气影响，新疆东疆16—17日、19日可能出现中度污染，新疆南疆19—22日可能出现重度及以上污染。首要污染物为颗粒物或臭氧。&lt;/p&gt;', '2023-05-20 13:02:32', '2023-05-20 14:37:16', '/topic/20230520/4737649ace7798d6d355229812f96268.jpg', '生态环境部发布5月下半月全国空气质量预报会商结果', '中国人民共和国生态环境部', '');
INSERT INTO `ntp_common_article` VALUES (4411, 2, '&lt;p&gt;为贯彻落实黄河流域生态保护和高质量发展国家重大战略，严厉打击黄河流域固体废物非法转移和倾倒等违法犯罪行为，保障黄河流域生态环境安全，生态环境部于近日印发《关于深入开展2023—2024年黄河流域固体废物倾倒排查整治工作的通知》，全面部署黄河流域固体废物倾倒排查整治工作。&lt;/p&gt;&lt;p&gt;2021年以来，生态环境部连续2年组织开展黄河流域“清废行动”，对黄河干流及部分支流（段）的固体废物倾倒情况进行了全面排查整治，共排查黄河流域9省（自治区）55地市（自治州），排查面积约13.3万平方公里，累计排查问题点位2049个，共计清理各类固体废物8888.2万吨。通过整治，有效预防了黄河流域生态环境安全风险，为贯彻落实黄河流域生态保护和高质量发展国家重大战略打下了坚实基础。&lt;/p&gt;&lt;p&gt;2023—2024年，生态环境部将在巩固好2021—2022年黄河流域“清废行动”的基础上，进一步加大整治力度，将黄河流域9省（自治区）的重要支流、重要湖库、重点工业园区、国家级自然保护区、国家级风景名胜区等区域纳入排查整治范围，覆盖面积近20万平方公里，对固体废物倾倒情况进行全面排查整治，不断把黄河流域“清废行动”推向深入。&lt;/p&gt;&lt;p&gt;深入开展黄河流域固体废物倾倒排查整治，是从源头推动污染治理、改善黄河生态环境的重要举措。本次黄河流域“清废行动”将进一步强化源头治理，倒逼地方加强固体废物处置能力建设，督促固体废物产生及处置单位强化自身管理，同时保持严厉打击固体废物违法犯罪行为的高压态势，形成有力震慑，从而达到标本兼治的目的。&lt;/p&gt;', '2023-05-20 13:21:52', '2023-05-20 14:37:24', '/topic/20230520/fb4ed85c3343a0b6b44d1f7dfc967461.jpg', '2023—2024年黄河流域“清废行动”正式启动', '中国人民共和国生态环境部', '');
INSERT INTO `ntp_common_article` VALUES (4412, 2, '&lt;p&gt;5月10日，“一带一路”绿色发展圆桌会暨“一带一路”绿色发展国际联盟会员大会在京举行。生态环境部部长、“一带一路”绿色发展国际联盟（简称联盟）联合主席黄润秋在线出席活动并致辞。新加坡永续发展与环境部部长、联盟联合主席傅海燕，世界自然基金会特使、联盟联合主席兰博蒂尼，贝索斯地球基金总裁兼首席执行官、联盟联合主席斯蒂尔在现场或以视频形式出席论坛并致辞。生态环境部副部长、联盟咨询委员会主任委员赵英民主持会议开幕式。&lt;/p&gt;&lt;p class=&quot;ql-align-center&quot;&gt;黄润秋在致辞中指出，10年前，习近平主席首次提出人类命运共同体的重要理念，此后进一步提出共建“一带一路”倡议、全球发展倡议、全球安全倡议、全球文明倡议，呼吁国际社会用团结代替分裂、合作代替对抗、包容代替排他，推动实现更加强劲、绿色、健康的全球发展，共同建设持久和平、普遍安全、共同繁荣、开放包容、清洁美丽的世界。推动共建绿色“一带一路”，正是中国秉持人类命运共同体理念，支持发展中国家绿色低碳发展，推动共建清洁美丽世界的重要举措。&lt;/p&gt;&lt;p&gt;黄润秋表示，作为世界上最大的发展中国家，中国坚持绿水青山就是金山银山的理念，坚持山水林田湖草沙一体化保护和系统治理，推进建设人与自然和谐共生的现代化，生态环境保护发生历史性、转折性、全局性变化，创造了举世瞩目的生态奇迹和绿色发展奇迹，这本身就是对世界的贡献。&lt;/p&gt;&lt;p&gt;黄润秋强调，近年来，中国始终秉持绿色发展理念，发起系列绿色行动倡议，启动“一带一路”生态环保大数据服务平台，推动实施绿色丝路使者计划和“一带一路”应对气候变化南南合作计划，取得扎实成效。特别是习近平主席倡议建立的“一带一路”绿色发展国际联盟，通过开展对话交流、联合研究、能力建设和产业合作，不断推动绿色发展国际共识和共同行动，并为中国政府绿色“一带一路”有关政策的制定提供了重要技术支撑。当前，联盟已成为推进“一带一路”绿色发展国际合作的主要平台，在提升共建国家环境治理能力、推动共同实现2030年可持续发展目标中的作用日益凸显。中方愿与各方携手，坚定不移支持联盟在新的历史阶段发挥更重要作用，为高质量推进共建“一带一路”，落实全球发展倡议，推动共建国家绿色发展转型做出更大贡献。&lt;/p&gt;&lt;p&gt;外交部国际经济司司长李克新、国家发展改革委区域开放司一级巡视员丁杰出席论坛并致辞。世界资源研究所高级顾问、联盟咨询委员会主任委员索尔海姆，儿童投资基金会（英国）首席执行官、联盟咨询委员会主任委员韩佩东，能源基金会首席执行官兼中国区总裁、联盟咨询委员会委员邹骥等嘉宾围绕“一带一路”绿色发展展望、绿色低碳转型等主题进行发言。&lt;/p&gt;&lt;p&gt;“一带一路”绿色发展国际联盟将作为首个在绿色“一带一路”框架下由全球生态环境与可持续发展相关领域的非政府组织、研究机构和企业等共同发起成立的国际性环保社会组织，为推动共建国家绿色低碳转型、携手实现联合国2030年可持续发展议程、共建人与自然生命共同体搭建机制性的、国际性的多边合作平台。本次会议也是联盟的首次会员大会，42家中外机构作为首批成员单位加入联盟，通过了联盟理事人选和章程。会上发布了联盟《“一带一路”绿色交通案例报告》《“一带一路”项目绿色发展指南（三期）》，以及“一带一路”绿色低碳转型、绿色交通、城市气候合作等报告，并启动2023年“绿色丝路行”活动。&lt;/p&gt;&lt;p&gt;联盟中外合作伙伴及会员单位代表，地方政府、中外专家、媒体及其他嘉宾200余人参加论坛。&lt;/p&gt;', '2023-05-20 13:22:36', '2023-05-20 14:37:34', '/topic/20230520/b09139b5ff8dae189c8c7695ec2340e1.jpg', '“一带一路”绿色发展圆桌会暨“一带一路”绿色发展国际联盟会员大会在京召开', '中国人民共和国生态环境部', '');
INSERT INTO `ntp_common_article` VALUES (4413, 2, '&lt;p&gt;青海省全面推行河湖长制工作领导小组会议暨厅际联席会议在西宁召开。会议深入学习贯彻党的二十大精神，全面落实党中央、国务院关于强化河湖长制的决策部署，坚持问题导向、目标导向、结果导向，研究青海省河湖长制及河湖管理重点事项，安排部署下一阶段重点工作。&lt;/p&gt;&lt;p&gt;会议强调，要把做好河湖长制工作作为贯彻落实习近平生态文明思想的有力实践。要坚决扛牢责任，强化担当作为，履行好水资源保护、河湖水域岸线管理保护、水污染综合防治、河湖水环境治理、水生态修复、河湖水生态执法监管等重要职责，守护好青藏高原的河湖安澜。要切实完善体制机制，上下联动、联防联控、群防群控，推动河湖长制工作在纵向上步调一致，在横向上协同高效，在社会面上共建共治，坚定不移当好“中华水塔”守护人。 夏连琪 刘红&lt;/p&gt;', '2023-05-20 13:23:20', '2023-05-20 14:36:18', '/topic/20230520/d2409c82c153ddceaa78bd4395fdac61.jpg', '青海全面推行河湖长制工作领导小组会议召开坚定不移当好“中华水塔”守护人', '中国人民共和国生态环境部', '');
INSERT INTO `ntp_common_article` VALUES (4414, 2, '&lt;p&gt;学习贯彻习近平新时代中国特色社会主义思想主题教育开展以来，各地生态环境部门按照“学思想、强党性、重实践、建新功”的总要求，注重高起点谋划、强力度推进、严标准落实，既认真做好“规定动作”，又结合生态环境保护工作特点，积极创新“自选动作”。&lt;/p&gt;&lt;p&gt;江西省生态环境厅开展主题教育始终围绕中心、服务大局，制定了主题教育工作明细表、作战图，由厅领导定期调度，把主题教育融入深入全面加强生态文明建设和生态环境保护工作中，既推动工作，又促进发展，同时为民解难纾困。在加强理论学习的同时，江西省生态环境厅领导班子成员带头转作风、抓调研，实行领导干部领题调研，厅领导共明确调研选题17个，以“贯彻落实党中央决策部署和习近平总书记对江西工作的重要要求”“生态环境高水平保护促进经济高质量发展”“推进美丽江西建设”“维护生态安全和社会稳定”“打造生态环保铁军”“生态环境领域长期未解决的老大难问题”等6个方面为重点调研方向，广泛开展调查研究，推动江西生态环境高水平保护。江西省生态环境厅还汇总形成了第一批问题清单5项，涉及调查研究发现问题3项，巡视对照梳理问题清单的要求，巡察、审计监督发现问题两项。&lt;/p&gt;&lt;p&gt;作为吉林省第一批开展主题教育的单位，吉林省生态环境厅召开动员部署会、厅党组成员领学主题教育专题读书班、邀请高校专家讲座、开设主题教育学习角、深入一线与企业面对面调研……为了将学习成果转化为助推全省高质量发展的实际工作，吉林省生态环境厅开展扎实的调研工作，与22家企业代表调研座谈。专家为企业现场“问诊把脉”，了解工作中遇到的相关难题，解答企业在环评、固废等工作中困惑。面对调研中需要帮扶的企业，吉林省生态环境厅聘请专家组，深入调研中反馈问题的长春一汽红旗新能源工厂，与工程师在生产流水线现场“面对面”解决问题，有效将主题教育学习成果在生态环境保护工作中落实。&lt;/p&gt;&lt;p&gt;四川省生态环境厅进行整体性谋划、系统性设计、统筹性推进。聚焦调查研究解难题，围绕生态环境突出问题明确大气污染防治、长江黄河上游生态屏障建设等10个方面调研方向。聚焦当前重点工作，开展迎接成都世界大学生运动会环境质量保障专项行动，拧紧“责任链条”，向世界展示“雪山下的公园城市”独特魅力。聚焦“我为群众办实事”实践活动，围绕群众身边噪声、油烟等生态环境突出问题开展暗查暗访，开展送法入企帮扶、集中式饮用水水源保护等行动。聚焦服务高质量发展，动态更新环评重点服务保障清单，开通重大项目“绿色通道”，做好政策性开发性金融工具项目环评服务保障。聚焦深化生态环境治理，对白酒、电解铝、烤烟、陶瓷等四川典型特色行业开展减污降碳路径研究，探索美丽中国建设四川路径，启动10个左右美丽四川建设先行县（市、区）试点，新建一批国家生态文明建设示范区、“两山”基地，不断擦亮四川“生态大省”金字招牌。&lt;/p&gt;&lt;p&gt;江剑平 张林霞 霍晓 薛文安&amp;nbsp;&lt;/p&gt;', '2023-05-20 13:24:43', '2023-05-20 14:35:03', '/topic/20230520/e66265bdbc479136c79cc5f0881b9c86.jpg', '各地生态环境部门扎实开展学习贯彻习近平新时代中国特色社会主义思想 主题教育 在学习中结合生态环保工作特点创新“自选动作”', '中国人民共和国生态环境部', '');
INSERT INTO `ntp_common_article` VALUES (4415, 2, '&lt;p&gt;广西壮族自治区生态环境保护委员会日前召开第二次全体会议，听取了2022年全区生态环境保护工作情况和党政领导生态环境保护目标责任书考核情况汇报，审议了2022年全区生态环境保护工作考核评价结果，通过了《2023年度党政领导生态环境保护目标责任书》和《自治区生态环境保护委员会2023年工作要点》。&lt;/p&gt;&lt;p&gt;会议指出，要深入贯彻落实习近平生态文明思想，保护好广西的山山水水，加强山水林田湖草海湿地系统治理和修复，努力在推动绿色发展上实现更大进展，促进人与自然和谐共生，加快建设美丽广西和生态文明强区。&lt;/p&gt;&lt;p&gt;会议强调，要严守环境安全底线，坚持系统治理、源头治理、综合治理，持续打好蓝天、碧水、净土保卫战，持续改善生态环境质量，筑牢我国南方生态安全屏障。要统筹考虑、一体推进，抓好中央生态环境保护督察反馈意见和自治区发现问题整改，做到责任不落实不放过、整改不到位不放过、群众不满意不放过。要坚决落实“双碳”工作战略部署，深入实施碳达峰十大行动，协同推进降碳、减污、扩绿、增长，加快生态产业化和产业生态化步伐，加快绿色低碳发展。要严格落实河长制、湖长制、林长制，健全党委领导、政府主导、企业主体、社会参与的现代环境治理体系，持续压紧压实党政主要领导生态环境保护第一责任人责任，用好考核“指挥棒”，持续提升生态环境治理能力，确保中央和自治区各项决策部署落地见效。 蓝皓璟&lt;/p&gt;', '2023-05-20 13:25:15', '2023-05-20 14:37:59', '/topic/20230520/b4dac3c0f9ad0fe963a6aed8054574c5.jpg', '广西通过今年党政领导生态环保目标责任书 持续压紧压实党政主要领导第一责任人责任', '中国环境报', '');
INSERT INTO `ntp_common_article` VALUES (4416, 2, '&lt;p&gt;&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;5月19日，生态环境部部长黄润秋主持召开部常务会议，审议并原则通过《广西白龙核电厂1、2号机组环境影响报告书（选址阶段）》、《广西防城港核电厂5、6号机组环境影响报告书（选址阶段）》、《2022中国生态环境状况公报》（以下简称《环境公报》）、《2022中国海洋生态环境状况公报》（以下简称《海洋环境公报》）、《海水、海洋沉积物和海洋生物质量评价技术规范》（以下简称《技术规范》）、《电子工业水污染防治可行技术指南》（以下简称《技术指南》）、《关于〈《关于持久性有机污染物的斯德哥尔摩公约》列入多氯萘等三种类持久性有机污染物修正案〉和〈《关于持久性有机污染物的斯德哥尔摩公约》列入短链氯化石蜡等三种类持久性有机污染物修正案〉生效的公告》（以下简称《生效公告》）、43种化学物质增补列入《中国现有化学物质名录》。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;会议指出，党中央、国务院高度重视核安全，作出在确保安全的前提下积极有序发展核电的重大战略部署。要坚决扛起保障核安全的政治责任，持续加强在建和运行核电厂的安全监管，确保核电厂建造质量和运行安全，切实筑牢核安全屏障。要持续加强在建项目的经验反馈工作，监督营运单位经验反馈体系的有效运转情况，督促持续完善经验反馈体系，确保工程建造质量。&lt;/p&gt;&lt;p&gt;会议强调，编制发布《环境公报》、《海洋环境公报》是环境保护法、海洋环境保护法的法定要求。《环境公报》总结生态环境、自然资源、交通运输、农业农村等相关部门工作成果，客观反映了2022年全国生态环境状况及变化情况，同时在结构、内容、形式和表征上积极创新，展示了生态环境保护工作的新进展、新特色。《海洋公报》全面反映了2022年我国管辖海域、近岸海域海洋生态质量及变化情况，内容全面、数据翔实、科学规范。下一步，要做好新闻发布会筹备等工作，多渠道、多途径对外发布，加强宣传解读，进一步增强全社会对深入打好污染防治攻坚战、持续改善生态环境质量的信心。&lt;/p&gt;&lt;p&gt;会议指出，海水、海洋沉积物和海洋生物是构成海洋生态环境的三大介质。《技术规范》规定了海水、海洋沉积物和海洋生物质量状况评价的主要内容、技术要求和方法，有助于科学规范评价海洋生态环境质量状况，将为美丽海湾建设、重点海域综合治理攻坚战等重点工作推进提供重要支撑。《技术规范》印发后，要开展人员培训与技术指导，加强跟踪问效。&lt;/p&gt;&lt;p&gt;会议强调，我国是电子信息制造业大国。电子工业生产废水含有机溶剂和重金属，具有污染物浓度高、环境危害大等特点。有效防治电子工业水污染，事关水生态环境质量持续改善和电子工业高质量发展。《技术指南》提供了电子工业废水治理的可行技术，可为电子工业水污染物排放标准实施、排污许可证申领与核发等提供技术支持。要加强《技术指南》的宣传解读，全面做好技术指导，推动《技术指南》发挥实效。&lt;/p&gt;&lt;p&gt;会议指出，党中央、国务院高度重视国际公约履约工作。制定印发《生效公告》是贯彻落实党中央、国务院有关决策部署和全国人大常委会有关决定的具体举措。《生效公告》明确了新增列持久性有机污染物的履约要求，对有效防范持久性有机污染物环境风险，促进高质量发展具有重要意义。《生效公告》印发后，要强化督促指导，加大监督执法力度，提升履约能力，稳步推进各项履约工作落实落地。&lt;/p&gt;&lt;p&gt;会议强调，《中国现有化学物质名录》是判定一种化学物质是否需要进行新化学物质环境管理登记的依据，是全面落实新化学物质环境管理登记工作的重要基础。要按照《新污染物治理行动方案》有关要求，严格依法依规审批登记新化学物质，不断完善《中国现有化学物质名录》，夯实新化学物质环境管理基础。&lt;/p&gt;&lt;p&gt;会议还研究了其他事项。&lt;/p&gt;&lt;p&gt;生态环境部副部长赵英民，中央纪委国家监委驻生态环境部纪检监察组组长廖西元，生态环境部副部长董保同出席会议。&lt;/p&gt;&lt;p&gt;驻部纪检监察组负责同志，机关各部门，应急中心、机关服务中心、信息中心主要负责同志列席会议。&lt;/p&gt;', '2023-05-20 13:28:30', '2023-05-25 15:09:58', '/topic/20230520/7578813b506910103c30e0df3fb9825e.jpg', '生态环境部召开部常务会议', '生态环境部', '');
INSERT INTO `ntp_common_article` VALUES (4417, 2, '&lt;p&gt;河北省省长王正谱近日主持召开省推进华北地下水超采综合治理行动领导小组会议，总结前一阶段工作，部署下一步重点任务。&lt;/p&gt;&lt;p&gt;会议指出，实施地下水超采综合治理，是党中央作出的重大决策部署。全省各地各部门要积极践行习近平生态文明思想，落实省委、省政府部署，站在对历史、对人民负责的高度，深刻认识地下水超采综合治理的极端重要性和紧迫性，处理好发展与压采、稳粮与压采的关系，坚持“节水优先、空间均衡、系统治理、两手发力”，在谋实招、求实效上下功夫，全力推动各项治理措施落实。&lt;/p&gt;&lt;p&gt;在节水方面，大力推广工业节水新技术、新工艺、新产品，持续推进供水管网建设和更新改造，深入推进农业节水增效。在换水方面，继续实施城乡生活生产水源置换，在深层超采区谋划新建一批置换工程，巩固提升置换成效。在补水方面，加强引江引黄调水干线、补水河道渠道整治，扎实推进河湖补水，引足用好外调水。在管水方面，严格取水许可审批，强化取水井管理，推进农业水价综合改革，把好用水“总阀门”。要层层压实责任，强化省级统筹调度，省有关部门加强研究和指导，市县切实履行主体责任，把工作举措抓得更实更细，确保圆满完成各项目标任务。&lt;/p&gt;&lt;p&gt;中国环境报记者张铭贤&lt;/p&gt;', '2023-05-20 14:03:16', '2023-05-20 14:34:44', '/topic/20230520/050f0c7bdbee698d55c4f61ebf10e946.jpg', '河北省省长王正谱部署推进华北地下水超采综合治理 在节水换水补水管水方面加压发力', '中国环境报', '');
INSERT INTO `ntp_common_article` VALUES (4418, 2, '&lt;p&gt;陕西省委理论学习中心组日前召开扩大会议，围绕习近平生态文明思想开展集体学习。陕西省委书记赵一德主持并讲话，陕西省省长赵刚出席。&lt;/p&gt;&lt;p&gt;会议指出，习近平生态文明思想为新时代生态文明建设提供了根本遵循和行动指南。全省上下要把学习贯彻习近平生态文明思想作为学习贯彻习近平新时代中国特色社会主义思想主题教育的重要内容，与学习贯彻习近平总书记来陕考察重要讲话重要指示精神结合起来，以更高站位、更大力度、更实作风建设美丽陕西，为奋进中国式现代化新征程、谱写陕西高质量发展新篇章提供有力生态支撑。&lt;/p&gt;&lt;p&gt;会议强调，要深刻汲取秦岭违建事件教训，扛牢生态环境保护政治责任，提高生态环境领域治理体系和治理能力现代化水平，以实际行动坚定捍卫“两个确立”、坚决做到“两个维护”。要筑牢生态屏障，坚持山水林田湖草沙一体化保护和系统治理，在深化整治、加强监管、系统保护中当好秦岭生态卫士，围绕解决水浑、水脏、水少、水多问题保护治理黄河。要解决突出问题，以最硬举措推进关中地区大气污染治理，以最优策略推进水污染治理，以最严标准推进土壤污染治理，让老百姓实实在在感受到生态环境质量的改善。要落实“双碳”战略，协同推进降碳、减污、扩绿、增长，深入调整产业、能源、交通三大结构，持续完善技术和市场两个支撑，不断提升生态碳汇能力，加快推动绿色低碳发展。&lt;/p&gt;&lt;p&gt;普毛毛 肖颖&lt;/p&gt;', '2023-05-20 14:05:17', '2023-05-20 14:34:37', '/topic/20230520/f5ad2fde77024d777947d83c5e6aaaf1.jpg', '陕西省委理论学习中心组深入学习贯彻习近平生态文明思想 硬举措优策略严标准推进污染治理', '中国环境报', '');
INSERT INTO `ntp_common_article` VALUES (4419, 2, '&lt;p&gt;5月24日，由国家能源局主办、厦门市人民政府承办的第三届“一带一路”能源合作伙伴关系论坛在福建厦门成功召开，国家能源局副局长任京东和厦门市市长黄文辉出席开幕式并致辞。&lt;/p&gt;&lt;p&gt;任京东在致辞中指出，习近平总书记提出共建“一带一路”倡议10年以来，“一带一路”能源合作持续走深走实，取得了实实在在的丰硕成果，更多惠及沿线各国人民。当前世界能源转型发展面临诸多新挑战，中国愿与各方一道，不断加强“一带一路”能源合作伙伴关系机制建设，共同推动“一带一路”能源合作高质量发展，共同维护国际能源资源产业链供应链安全，助力“一带一路”沿线国家绿色低碳发展，为构建更加绿色、包容的能源未来，促进世界经济和社会发展贡献更多力量。&lt;/p&gt;&lt;p&gt;黄文辉表示，作为21世纪海上丝绸之路战略支点城市，近年来，厦门主动融入“一带一路”建设，以绿色低碳为发展方向，大力发展新能源产业。面向未来，厦门将持续创造能源合作新机遇，推动能源基础设施建设，促进新能源产业高质量发展，为“一带一路”能源合作贡献更多厦门力量。&lt;/p&gt;&lt;p&gt;伙伴关系有关成员国政要、能源部长、驻华大使在致辞中一致表示，“一带一路”能源合作对沿线各国经济、社会发展发挥了积极作用，各国愿继续加强在“一带一路”能源合作伙伴关系下的交流，积极发展绿色低碳能源，促进更多能源领域务实合作。&lt;/p&gt;&lt;p&gt;本届论坛主题为“迈向能源高质量发展之路”，参会各国能源部长和驻华大使、国际组织、能源企业、金融机构、智库高校等代表，围绕“加强高质量‘一带一路’能源合作，携手应对能源发展的共同挑战”等重要议题进行充分交流，达成广泛共识，为后续务实合作奠定基础。&lt;/p&gt;&lt;p&gt;今年是共建“一带一路”倡议提出10周年，能源合作是共建“一带一路”的重点领域。论坛期间，举办了“‘一带一路’能源合作十周年回顾与展望”主题展览，观看了“‘一带一路’能源合作这十年”主题视频，发布了伙伴关系合作网络代表单位与智库的最新研究成果与倡议。会议一系列成果，集中展示了“一带一路”能源合作10年取得的重大标志性成就，切实增强了“一带一路”能源合作的国际吸引力、影响力、感召力。&lt;/p&gt;&lt;p&gt;来自16个国家和地区的政要、能源部长、驻华大使和高级官员，5个能源国际组织负责人和高级别代表，能源企业和智库高校的负责人，线上或线下参加会议。国家能源局有关司和派出机构负责同志参加会议。&lt;/p&gt;', '2023-05-29 11:19:50', '2023-06-01 20:09:36', '/topic/20230601/1e28fba989da8c8e63048e4c79e4b58f.jpeg', '第三届“一带一路”能源合作伙伴关系论坛在厦门成功召开', '国家能源局', '');
INSERT INTO `ntp_common_article` VALUES (4420, 2, '&lt;p&gt;各省（自治区、直辖市）能源局，有关省（自治区、直辖市）及新疆生产建设兵团发展改革委，国家电网公司、中国南方电网有限公司，水电水利规划设计总院、电力规划设计总院、中国国际工程咨询有限公司，中国水力发电工程学会抽水蓄能行业分会：&lt;/p&gt;&lt;p&gt;自《抽水蓄能中长期发展规划（2021—2035年）》发布实施以来，抽水蓄能规划建设成效显著，进入新发展阶段。为贯彻落实党的二十大精神，加快规划建设新型能源体系，助力碳达峰碳中和目标实现，推动抽水蓄能高质量发展，针对当前抽水蓄能规划建设以及行业发展新形势新情况，现就进一步做好有关工作通知如下。&lt;/p&gt;&lt;p&gt;一、充分认识推进抽水蓄能高质量发展的重要意义&lt;/p&gt;&lt;p&gt;抽水蓄能是电力系统重要的绿色低碳清洁灵活调节电源，合理规划建设抽水蓄能电站，可为新能源大规模接入电力系统安全稳定运行提供有效支撑，有利于新能源大规模高比例高质量发展，对构建新型电力系统、促进能源绿色低碳转型意义重大。但同时，与其他常规电源不同，抽水蓄能电站本身并不增加电力供应，其功能作用主要是为电力系统提供调节服务，应根据新能源发展和电力系统运行需要，科学规划、合理布局、有序建设，以抽水蓄能高质量发展促进、保障能源高质量发展。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;　&lt;/strong&gt;二、抓紧开展抽水蓄能发展需求论证&lt;/p&gt;&lt;p&gt;电力系统调节需求是抽水蓄能规划建设的重要前提和基本依据。针对目前部分地区前期论证不够、工作不深、需求不清、项目申报过热等情况，坚持需求导向，深入开展抽水蓄能发展需求研究论证工作。力争今年上半年全面完成。&lt;/p&gt;&lt;p&gt;（一）分省分区域开展需求论证。各省级能源主管部门要会同电网企业组织开展本行政区域需求论证工作，按程序上报；国家能源局充分利用各方工作成果，组织国家电网、南方电网和相关机构开展各区域电网以及主要流域水风光一体化基地、以沙漠、戈壁、荒漠地区为重点的大型风电光伏基地等特定电源的需求论证，并形成全国抽水蓄能发展需求论证成果。&lt;/p&gt;&lt;p&gt;（二）科学研究分析未来合理需求。要客观系统分析本地区电力系统发展现状和存在问题，科学分析预测不同规划水平年负荷水平、特性和电源结构等，统筹各类调节电源，按相关规程规范和要求，多方案分析论证抽水蓄能的技术需求、经济合理需求，统筹考虑规划水平年新能源合理利用率、电价承受能力等因素，研究提出抽水蓄能的合理需求规模建议。&lt;/p&gt;&lt;p&gt;（三）突出重点开展需求论证。要重点聚焦“十四五”、统筹“十五五”开工项目规模开展需求论证，以2030年和2035年为规划水平年，并对2040年进行初步分析和展望。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;　&lt;/strong&gt;　三、有序开展新增项目纳规工作&lt;/p&gt;&lt;p&gt;经深入开展需求论证并按程序确认的合理建设规模是各地区开展项目纳规工作的基础。在抽水蓄能发展需求研究论证基础上，各省级能源主管部门要对本行政区域已纳规项目开展全面评估，统筹已建、在建和已纳规项目，区分抽水蓄能为本省服务、为区域电网服务以及为特定电源服务的不同功能定位，组织开展站址比选、布局优化和项目纳规工作，布局项目要落实到计划核准年度。对于需求确有缺口的省份，按有关要求有序纳规。对于经深入论证、需求没有缺口的省份，暂时不予新增纳规，但可根据实际情况，按照“框定总量、提高质量、优中选优、有进有出、动态调整”的原则，提出项目调整建议。国家能源局根据需求论证情况和实际需要，及时对全国或部分区域的中长期规划进行滚动调整，保持适度超前，支撑发展。&lt;/p&gt;&lt;p&gt;四、大力提升产业链支撑能力&lt;/p&gt;&lt;p&gt;为适应抽水蓄能快速跃升发展需要，组织行业协会、研究机构及重点企业等加强行业监测评估，对抽水蓄能投资、设计、施工、设备制造、运行、管理等产业链各环节进行监测和能力评估，针对开发建设规模、时序不协同和产业链薄弱环节，研究应对措施，加快各方面能力提升，更好支撑行业加快发展。&lt;/p&gt;&lt;p&gt;请各省级能源主管部门、行业组织、电网企业以及各有关单位，按照上述要求认真做好抽水蓄能发展的各项工作，共同促进抽水蓄能行业平稳有序、高质量发展。&lt;/p&gt;&lt;p class=&quot;ql-align-right&quot;&gt;国家能源局综合司&lt;/p&gt;', '2023-05-29 11:21:28', '2023-06-01 20:09:59', '/topic/20230601/6736bd6e9bcd8b686be21e13a76ebf45.jpeg', '国家能源局综合司关于进一步做好抽水蓄能规划建设工作有关事项的通知', '国能综通新能〔2023〕47号', '');
INSERT INTO `ntp_common_article` VALUES (4421, 2, '&lt;p&gt;为深入探索构建以信用为基础的新型能源监管机制，进一步提升电力业务资质许可监管效能，维护电力市场准入秩序，促进能源行业健康发展，根据国家能源局《2023年能源监管重点任务清单》（国能发监管〔2023〕5号）和《2023年资质管理和信用工作要点》（国能综通资质〔2023〕2号）有关部署和工作要求，2023年2月至6月，国家能源局组织开展了电力业务资质许可信用专项监管（以下简称专项监管）。根据专项监管情况，形成本报告。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;一、基本情况&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;根据国家能源局综合司印发的《2023年电力业务资质许可信用专项监管工作方案》，本次专项监管在陕西、湖北、广东、新疆、浙江、福建、湖南、四川、贵州等9个省（区）开展，监管范围包括2022至2023年并网的可再生能源发电项目（豁免电力业务许可的项目除外）、在建可再生能源发电项目（豁免电力业务许可的项目除外）涉网工程、在建220（330）千伏电网工程以及2022年报装的35千伏及以上用户受电工程。&lt;/p&gt;&lt;p&gt;纳入本次专项监管的项目（工程）共2547个，其中，发电项目1006个，在建可再生能源发电项目涉网工程258个，在建220（330）千伏电网工程343个，35千伏及以上用户受电工程940个，共涉及企业2069家。依据《国家能源局关于实施电力业务许可信用监管的通知》（国能发资质〔2023〕79号）规定，相关派出机构按照电力企业不同信用类别共抽取检查对象377家（发电企业156家、电网企业44家、承装（修、试）电力设施企业135家、相关电力用户42家）；电力企业中，信用良好及守信企业320家、失信企业13家，尚未确定信用类别的企业2家。本次专项监管对无证企业、“失信”或“严重失信”企业全部开展现场检查，“信用良好”及“守信”企业按比例抽取现场检查，共计现场检查企业228家，其余被检对象采取非现场检查。&lt;/p&gt;&lt;p&gt;从专项监管整体情况看，绝大部分受检企业能够按照专项监管有关工作要求，及时报送相关材料，如实报告执行许可制度情况，并积极配合开展现场检查等相关工作。大部分受检企业能够遵守许可制度，做到规范持证、依法经营，信用状况良好。&lt;/p&gt;&lt;p&gt;检查中发现，部分企业存在无证运营、超越许可范围从事相关业务活动、违法分包、不实承诺以及未持续保持许可条件等违反许可制度的行为。&lt;/p&gt;&lt;p&gt;从信用情况看，13家“失信”企业中，9家企业存在问题，占比69.2%；320家“信用良好”及“守信”企业中，69家存在问题，占比21.6%，（另有1家尚未确定信用类别的企业存在问题）。本次专项监管共有14家企业因存在问题被行政处罚后，信用等级从“信用良好”或“守信”降低为“失信”。上述数据反映出在电力行业中，信用等级高的企业，违反电力领域规章制度的行为相对较少，这说明，对持证企业进行信用综合评价，并以此为基础开展分级分类监管，有助于提高监管的精准性、靶向性，有效提升监管效能。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;二、存在问题&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;本次专项监管共发现8类问题（共89项），涉及企业79家（发电企业48家、电网企业7家、承装（修、试）电力设施企业24家），约占被抽检企业的21%，其中，同时存在两项问题的企业8家，同时存在三项问题的企业1家。本报告对上述问题中的六类典型问题予以披露。&lt;/p&gt;&lt;p&gt;（一）未取得许可从事电力业务&lt;/p&gt;&lt;p&gt;8家可再生能源发电企业未取得许可从事电力业务，违反《电力业务许可证管理规定》（电监会9号令）第四条规定。&lt;/p&gt;&lt;p&gt;专栏1：&lt;/p&gt;&lt;p&gt;■湖北孝感优泰能源科技有限公司运营的优泰能源应城城北80兆瓦渔光互补光伏电站项目，于2021年12月并网发电，截至本次专项监管现场检查阶段仍未按规定取得电力业务许可证。&lt;/p&gt;&lt;p&gt;■四川宝兴县旺平水电有限公司运营的土巴沟电站（3×8兆瓦）项目于2020年6月并网发电，截至本次专项监管现场检查阶段仍未按规定取得电力业务许可证。&lt;/p&gt;&lt;p&gt;（二）超越许可范围从事许可业务活动&lt;/p&gt;&lt;p&gt;7家可再生能源发电企业超越许可范围从事电力业务、6家承装（修、试）电力设施企业超越许可范围从事承装（修、试）电力设施活动，违反《电力业务许可证管理规定》第二十六条、《承装（修、试）电力设施许可证管理办法》（国家发展改革委令2020年第36号）第七条规定。&lt;/p&gt;&lt;p&gt;专栏2：&lt;/p&gt;&lt;p&gt;■湖南五凌沅陵电力有限公司运营的圣人山风电场项目，于 2021年5月取得电力业务许可证，许可机组为#6机组。该项目#1-#5、#7-#17机组于2021年7月并网发电，截至本次专项监管现场检查阶段仍未按规定取得电力业务许可证，企业超越许可范围从事电力业务。&lt;/p&gt;&lt;p&gt;■贵州黔送送变电工程有限公司（承装四级、承修四级、承试五级），超越许可范围承揽应由承装三级企业承担的册亨县丫他板其农业光伏电站110千伏送出线路及对侧间隔改造工程。&lt;/p&gt;&lt;p&gt;（三）违法分包承装（修、试）电力设施业务&lt;/p&gt;&lt;p&gt;6家承装（修、试）电力设施企业违法分包承装（修、试）电力设施业务，违反《建设工程质量管理条例》（中华人民共和国国务院令第279号）第二十五条规定。&lt;/p&gt;&lt;p&gt;专栏3：&lt;/p&gt;&lt;p&gt;■中国能源建设集团广东火电工程有限公司将其承揽的福建华电福清海坛海峡300兆瓦海上风电项目220千伏升压站机电设备安装工程的电气安装部分以劳务分包名义违法分包给其他施工企业。&lt;/p&gt;&lt;p&gt;■新疆大明德电力有限公司将承揽的潞安准东电厂35千伏输变电工程的电缆敷设、杆塔组立、智能开关及断路器安装、电缆终端头制作等电力主体工程以劳务分包名义违法分包给其他施工企业。&lt;/p&gt;&lt;p&gt;（四）申请许可证时提供虚假材料或作出不实承诺&lt;/p&gt;&lt;p&gt;2家承装（修、试）电力设施企业在申请许可证时，采取欺骗手段取得许可证；3家承装（修、试）电力设施企业通过告知承诺制申请许可证时，通过作出不实承诺取得许可证。上述行为违反《中华人民共和国行政许可法》第三十一条。&lt;/p&gt;&lt;p&gt;专栏4：&lt;/p&gt;&lt;p&gt;■浙江金三角电气安装有限公司于2021年4月取得承装（修、试）电力设施许可证。检查发现，企业在申请承装（修、试）电力设施许可证时提供虚假人员从业材料。&lt;/p&gt;&lt;p&gt;■新疆恒源建设工程有限公司于2021年11月通过告知承诺制方式取得承装（修、试）电力设施许可证。检查发现，企业承诺不实，专业技术人员不满足许可要求。&lt;/p&gt;&lt;p&gt;（五）企业运营机组实际情况与许可证登记信息不一致&lt;/p&gt;&lt;p&gt;17家可再生能源发电企业运营的发电项目，机组实际投产情况与电力业务许可证登记机组信息（容量、日期）不一致，违反《中华人民共和国行政许可法》第三十一条规定。&lt;/p&gt;&lt;p&gt;专栏5：&lt;/p&gt;&lt;p&gt;■华电湖北发电有限公司黄石光伏发电分公司运营的黄石阳新太子镇渔光互补光伏发电项目，首次并网时间为2021年12月，申请办理许可证时登记的容量为98兆瓦，截至本次专项监管现场检查阶段，实际并网容量为60兆瓦，与许可证登记信息不一致。&lt;/p&gt;&lt;p&gt;■中广核永寿新能源有限公司运营的陕西永寿200兆瓦光伏项目，申请电力业务许可证时，填报的全部机组（单元）投产日期为2021年3月。经核实， 2021年3月该项目机组（单元）未全部投产，机组（单元）实际投产时间与许可证登记信息不一致。&lt;/p&gt;&lt;p&gt;（六）电网企业落实许可制度不规范&lt;/p&gt;&lt;p&gt;1家电网企业将承装（修、试）电力设施业务发包给不具备相应资质的企业进行施工；6家电网企业未核实并网发电机组是否取得电力业务许可或机组信息是否与电力业务许可证记录一致。上述行为违反《建设工程质量管理条例》第七条、《电力业务许可证监督管理办法》第二十二条规定。&lt;/p&gt;&lt;p&gt;专栏6：&lt;/p&gt;&lt;p&gt;■广东电网有限责任公司阳江供电局将含有220千伏调试业务的阳江220千伏旗鼓岭站扩建第二台主变及配套线路工程和阳江220千伏薄荷（城北）输变电工程（第一标段）发包给不具有承试二级资质的阳江凯源电力工程有限公司（承装二级、承修二级、承试三级）。&lt;/p&gt;&lt;p&gt;■国网雅安电力（集团）公司调度、并由四川宝兴县旺平水电有限公司运营的土巴沟电站（3×8兆瓦）于2020年6月并网发电，截至本次专项监管现场检查阶段仍未取得电力业务许可，电网企业未按规定核实发电机组许可情况。&lt;/p&gt;&lt;p&gt;除上述典型问题外，本次专项监管还发现了未持续保持许可条件以及发生变更事项未按规定办理变更或未向所在地派出机构报告等问题，因违规行为较轻，不在本报告中披露。&lt;/p&gt;&lt;p&gt;&lt;strong&gt;三、监管意见&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;针对专项监管发现的79家问题企业，国家能源局相关派出机构分别采取了责令整改、监管约谈、撤销许可、行政处罚等监管措施，其中依法对17家存在违法违规行为的企业采取警告、罚款（涉及处罚金额183.83万元）等行政处罚措施。违法违规行为已纳入市场主体信用记录，按照《能源行业市场主体信用行为清单（2023年版）》认定“轻微失信”行为4项、“较重失信”行为8项、“严重失信”行为5项，对相关企业分别采取了“失信提示”“重点关注”等信用监管措施。针对本次专项监管发现的问题，现提出如下监管意见。&lt;/p&gt;&lt;p&gt;（一）可再生能源发电企业要依法持证经营&lt;/p&gt;&lt;p&gt;可再生能源发电企业应当在项目并网后规定时间内（风电、光伏项目为并网后6个月内，其他项目为机组完成启动试运后3个月内）取得电力业务许可证，申请许可时机组容量、投产时间等信息应当与实际一致；不得超越许可范围从事发电业务，新建（改建）、取得（转让）或退役发电机组应当按规定要求办理许可事项变更；企业名称、住所或者法定代表人等登记事项发生变化的，应当及时办理登记事项变更手续；企业安全、生产运行、技术、财务负责人发生变化的，应当通过国家能源局资质和信用信息系统及时向所在地国家能源局派出机构报告；发电项目应当按照环境保护的有关法律法规，完成环境保护设施竣工验收；应当将承装（修、试）电力设施许可证列入发电项目涉网工程招标条件，由具备相应资质企业施工。&lt;/p&gt;&lt;p&gt;（二）承装（修、试）电力设施企业要严格遵守承装（修、试）电力设施许可制度&lt;/p&gt;&lt;p&gt;承装（修、试）电力设施企业应当依法取得许可证并在许可范围内从事相关活动；不得出租、出借许可证，不得以任何形式转包或违法分包工程；持证企业应当持续保持许可条件，人员和资产等发生重大变化的，应当通过国家能源局资质和信用信息系统及时向国家能源局派出机构报告，不符合许可证法定条件和标准的，应当及时整改；企业名称、住所或者法定代表人等登记事项发生变更应当及时办理登记事项变更手续。&lt;/p&gt;&lt;p&gt;（三）电网企业要认真落实电力业务许可管理各项要求&lt;/p&gt;&lt;p&gt;电网企业及其调度机构应当严格执行《电力业务许可证管理规定》《电力业务许可证监督管理办法》有关要求，切实规范发电企业持证上网交易秩序，按时报送并网发电机组清单等信息，核实发电企业是否在规定时间内取得电力业务许可证、机组信息是否与许可证记录相符，如存在问题，应及时向国家能源局派出机构反映情况；应当加强所属单位项目管理，将承装（修、试）电力设施许可证列入电网工程招标条件，不得将工程发包给无证或超越许可范围的企业施工。&lt;/p&gt;&lt;p&gt;（四）相关电力企业要牢固树立诚信经营意识&lt;/p&gt;&lt;p&gt;相关电力企业应当认识到“守信者一路畅通、失信者寸步难行”，杜绝虚假材料申请许可和虚假承诺等失信行为，树立诚信经营理念，在生产经营、安全管理、财务管理和劳动用工管理等各环节强化企业诚信自律；要加强对下属企业的诚信教育和管理，着力加强信用文化建设，全面增强诚信经营意识。对本次专项监管中受到行政处罚的企业，有关违法违规行为纳入信用记录。相关企业要按照《能源行业市场主体信用修复管理办法（试行）》有关规定，主动纠正失信行为并消除不良影响，积极申请信用修复，形成更加良好的行业诚信氛围。&lt;/p&gt;', '2023-05-29 11:22:16', '2023-06-01 00:51:07', '/topic/20230601/d8c6f7f6c97699d7dda4aa952cadb30b.jpeg', '2023年度电力业务资质许可信用专项监管报告', '监管公告﹝2023﹞第1号', '');
INSERT INTO `ntp_common_article` VALUES (4422, 2, '&lt;p&gt;&lt;span style=&quot;color: rgb(0, 0, 0);&quot;&gt;5月31日，由新京报社和武汉市委网信办联合主办、新京报&lt;/span&gt;&lt;a href=&quot;http://quote.eastmoney.com/unify/r/106.BEKE&quot; rel=&quot;noopener noreferrer&quot; target=&quot;_blank&quot; style=&quot;color: rgb(74, 144, 226);&quot;&gt;贝壳&lt;/a&gt;&lt;span style=&quot;color: rgb(0, 0, 0);&quot;&gt;财经承办的“城市（武汉）高质量发展论坛”在武汉&lt;/span&gt;&lt;a href=&quot;http://quote.eastmoney.com/unify/r/1.600133&quot; rel=&quot;noopener noreferrer&quot; target=&quot;_blank&quot; style=&quot;color: rgb(74, 144, 226);&quot;&gt;东湖高新&lt;/a&gt;&lt;span style=&quot;color: rgb(0, 0, 0);&quot;&gt;区举办。在主旨演讲中，国务院发展研究中心资源与环境政策研究所副所长、研究员常纪文表示，目前，我们国家已经进入以降碳为重点战略，协同推进降碳、减污、扩绿、增长，促进经济社会发展全面绿色转型，实现生态环境质量改善由量变到质变的关键时期。区域的绿色低碳转型，包括武汉新城，应该与中国的碳达峰、碳中和路径、污染防治攻坚战路径保持一致，在一致中通过创新求发展。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/topic/20230601/13a802f74b359af9211bc3a609b64355.jpg&quot;&gt;&lt;/p&gt;&lt;p&gt;国务院发展研究中心资源与环境政策研究所副所长、研究员常纪文&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;“我们以前的优势在现在还能不能继续成为优势，是一个值得思考的问题。事实上在绿色低碳发展方面，区域的差异正在重新洗牌。因此，每个地方要结合自己的基础、特色和优势，找到适合自己的路径和方法。每个地方应当确定合适自己的阶段性目标，稳中求进地推进，不可过慢过急。”常纪文说道。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;常纪文表示，绿色转型最重要的就是低碳化。在低碳化发展方面，最重要的三点是产业结构的低碳化、能源结构的低碳化和交通运输结构的低碳化。每个地方应当围绕这三方面做好产业创新和创新发展的新文章。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;针对武汉新城的规划，常纪文建议，第一，要巩固污染防治成效，把&lt;a href=&quot;http://quote.eastmoney.com/unify/r/90.BK0873&quot; rel=&quot;noopener noreferrer&quot; target=&quot;_blank&quot; style=&quot;color: rgb(74, 144, 226);&quot;&gt;垃圾分类&lt;/a&gt;等基础性的工作做好，包括污水处理、固废的收集与集中处理，夯实生态环境保护的基础，扩大区域绿色低碳发展的环境容量；第二，在新型能源体系的构建过程之中，要加强新技术研发，推进能源和产业结构的调整和优化。要开展低碳化的新型基础设施建设，发展氢能、氢化工、光伏、风电等新型能源和&lt;a href=&quot;http://quote.eastmoney.com/unify/r/0.300832&quot; rel=&quot;noopener noreferrer&quot; target=&quot;_blank&quot; style=&quot;color: rgb(74, 144, 226);&quot;&gt;新产业&lt;/a&gt;的技术研发和应用示范；第三，要严格执法，在绿色低碳转型发展上加强社会参与和监督，营造良好的绿色发展监管环境和社会守法的氛围，巩固生态环境保护成效；第四，在流域和区域一体化或者协同发展的格局内，优化产业结构，形成产业互补和各自特色优势发展的格局，把优势做强做大。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;常纪文表示，绿色发展、低碳发展的重点就是要结合国家生态环境保护的阶段性的目标，设立企业可预期的环境保护新要求，逐步对工业企业进行提质改造，并开启新的工业发展赛道。这一点湖北省一直是做得不错的。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;常纪文认为，在区域绿色发展转型中，要开展生态修复，保护湿地、草原、森林、河流、湖泊、海岸，维护生物多样性，增加碳汇，把绿水青山转化为金山银山。湖北省在这个方面一直做得不错，生态也保护得好，绿色农业等做得也不错，&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;“我们以前是在经济持续较大幅度增长的过程中开展生态环境保护，现在则是稳增长、保民生的背景下开展生态环境保护，开展低碳转型，所以工作的逻辑可能发生较大的改变，工作难度变大。这就需要每个地方对于转型的思路和方法做出相应的调整，统筹处理好各方面的关系。”常纪文说道。&lt;/p&gt;', '2023-06-01 00:41:44', '2023-06-01 20:06:57', '/topic/20230601/be1ba34edc2298ed6b12f2a1f4bfe886.jpg', '常纪文：绿色发展推动地方调整转型思路', '新京报 白华兵', '');
INSERT INTO `ntp_common_article` VALUES (4423, 2, '&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;6月5日，生态环境部、中央精神文明建设办公室、山东省人民政府在济南联合举办2023年六五环境日国家主场活动。生态环境部党组书记孙金龙，山东省委书记林武，中国作协党组书记张宏森出席开幕式并讲话；山东省委副书记、省长周乃翔致辞；山东省政协主席葛慧君出席。生态环境部党组成员、副部长翟青主持活动。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;img src=&quot;/topic/20230610/f0ef231e11b9b1c4acc1306fb7186630.png&quot;&gt;&lt;/p&gt;&lt;p&gt;		今年六五环境日的主题是“建设人与自然和谐共生的现代化”，旨在展示新时代我国生态环境保护发生的历史性、转折性、全局性变化和全社会共同参与美丽中国建设的生动场景，为深入打好污染防治攻坚战、推进人与自然和谐共生的现代化凝聚共识、汇聚力量。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		孙金龙发表主旨讲话。他指出，党的十八大以来，以习近平同志为核心的党中央把生态文明建设摆在全局工作的突出位置，全方位、全地域、全过程加强生态环境保护，绿色发展成效不断显现，生态环境质量改善明显，全球环境治理影响力大幅跃升，为实现人与自然和谐共生的现代化奠定坚实基础。要坚持以习近平新时代中国特色社会主义思想为指导，全面贯彻党的二十大精神，坚定践行习近平生态文明思想，加快发展方式绿色转型，深入打好污染防治攻坚战，提升生态系统多样性、稳定性、持续性，积极稳妥推进碳达峰碳中和，坚定不移推进人与自然和谐共生的现代化建设。希望社会各界积极参与生态环境保护，自觉践行简约适度、绿色低碳、文明健康的生活理念和生活方式，共同将美丽中国建设的宏伟蓝图变成美好现实。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		林武指出，党的十八大以来，以习近平同志为核心的党中央以前所未有的力度抓生态文明建设，推动生态环境保护发生历史性、转折性、全局性变化。山东深入贯彻落实习近平生态文明思想和党中央决策部署，美丽山东建设取得显著成效，优良生态环境名片更加亮丽。去年国家赋予山东建设绿色低碳高质量发展先行区的历史使命，这是对山东发展的高度信任和殷切期望，更是我们必须坚决扛起的重大政治责任。面向未来，我们将深入贯彻习近平总书记重要指示要求，坚持高质量发展首要任务，以绿色低碳高质量发展先行区建设为抓手，协同推进降碳、减污、扩绿、增长，聚力深化动能转换，聚力推动科技创新，聚力改善环境质量，聚力推进节能降碳，推动经济社会全面绿色转型，奋力谱写中国式现代化山东实践的新篇章。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		张宏森代表中国作家协会，对活动的举办表示热烈祝贺。他说，在刚刚召开的文化传承发展座谈会上，习近平总书记强调，中国式现代化赋予中国文明以现代力量，中华文明赋予中国式现代化以深厚底蕴。传承中华文明，建设中华民族现代文明，必然蕴含着对中国传统自然观念的继承弘扬，彰显着新时代生态文明建设的胸襟与追求。中国作协将主动担负起新的文化使命，团结引领广大作家用自强不息、厚德载物的文学创作，深入贯彻习近平生态文明思想，大力弘扬生态文化；生动书写生态文明建设史诗，凝聚强大精神力量；讲好中国生态文明故事，展现可信、可爱、可敬的中国形象，为推动生态文明建设，实现美丽中国提供更加强大的价值引导力、文化凝聚力、精神推动力。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		周乃翔在致辞时说，山东是我国的人口大省、经济大省、文化大省，这里是闻名遐迩的“文化圣地”、动能澎湃的“发展高地”、岱青海蓝的“生态福地”。如今的山东，绿水青山就是金山银山的理念深入人心，优良的生态环境成为亮丽底色，一幅人与自然和谐共生的生态画卷正徐徐展开。新征程上，我们将认真践行习近平生态文明思想，深入贯彻落实习近平总书记重要指示要求，加快美丽山东建设。我们愿与各方一道，携手并肩、深化合作，以生态环境高水平保护推动经济社会高质量发展，为建设美丽中国作出新的更大贡献。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		联合国环境规划署执行主任英格·安德森视频致辞。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		活动宣布2024年六五环境日国家主场活动将在广西壮族自治区举办。现场授旗仪式后，广西壮族自治区人民政府副主席眭国华表示，广西将以承办2024年六五环境日国家主场活动为契机，全力筑牢我国南方重要生态安全屏障，为建设人与自然和谐共生的现代化贡献广西力量。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		活动现场播放了2023年六五环境日主题宣传片、国家主场宣传片，揭晓了2023年“美丽中国，我是行动者”提升公民生态文明意识行动计划先进典型宣传推选活动百名最美生态环保志愿者、十佳公众参与案例、十佳环保设施开放单位名单，并向10名2023年生态环境特邀观察员颁授聘书。2022年生态环境特邀观察员余刚发表观察感言。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		活动上，生态环境部、中央精神文明建设办公室、教育部、共青团中央、全国妇联等五部门联合发布新修订的《公民生态环境行为规范十条》，全面深入引领公众在工作、生活等各方面的生态环境行为，促进全社会牢固树立生态价值观，增强公众践行绿色低碳生活方式的行动自觉。&lt;/p&gt;&lt;p&gt;活动前，与会嘉宾们集体参观了“建设人与自然和谐共生的现代化”主题展览。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		当天下午举行的绿色低碳高质量发展先行区建设山东论坛，通过了由沿黄9省（自治区）生态环境部门共同发起的《黄河流域生态保护和高质量发展济南宣言》（以下简称《宣言》），旨在深入学习贯彻习近平总书记有关重要指示要求，扎实推动黄河流域生态保护和高质量发展。《宣言》提出，要共同抓好黄河大保护，协同推进黄河大治理，真抓实干，久久为功，让绿色成为黄河流域最鲜明、最厚重、最牢靠的底色，绘就壮美黄河画卷，为美丽中国增光添彩。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		今年六五环境日国家主场活动践行绿色低碳理念，组织碳中和公益行动，落实大中型活动碳中和有关要求。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		中国作协相关负责同志，相关省市政府负责同志，中央国家机关及群团组织有关部门负责同志，部分省市生态环境部门负责同志，科研院所、高校、社会组织、企业和媒体代表参加活动。&lt;/p&gt;', '2023-06-10 12:44:24', '2023-06-10 12:44:24', '/topic/20230610/75c84c9feae6c31c81c39894c4263e61.png', '2023年六五环境日国家主场活动在济南举办', '生态环境部', NULL);
INSERT INTO `ntp_common_article` VALUES (4424, 2, '&lt;p class=&quot;ql-align-center&quot;&gt;&lt;span style=&quot;color: rgb(0, 71, 178);&quot;&gt;建设人与自然和谐共生现代化&lt;/span&gt;&lt;/p&gt;&lt;p class=&quot;ql-align-center&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p class=&quot;ql-align-center&quot;&gt;&lt;span style=&quot;color: rgb(0, 71, 178);&quot;&gt;——认真学习《习近平著作选读》第一卷、第二卷&lt;/span&gt;&lt;/p&gt;&lt;p class=&quot;ql-align-center&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p class=&quot;ql-align-center&quot;&gt;&lt;span style=&quot;color: rgb(0, 71, 178);&quot;&gt;生态环境部党组理论学习中心组&lt;/span&gt;&lt;/p&gt;&lt;p class=&quot;ql-align-center&quot;&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;《习近平著作选读》第一卷、第二卷集中反映了我们党推进马克思主义中国化时代化取得的重大理论创新成果，是深入学习贯彻习近平新时代中国特色社会主义思想的权威教材。生态环境部系统要把学好用好《习近平著作选读》作为重大政治任务，紧密结合学习贯彻党的二十大精神，结合正在开展的主题教育，坚持不懈用习近平新时代中国特色社会主义思想凝心铸魂，更加自觉投身建设人与自然和谐共生现代化的伟大实践，引领美丽中国建设不断迈出新的坚实步伐。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;strong style=&quot;color: rgb(76, 76, 76);&quot;&gt;深刻领悟习近平生态文明思想丰富内涵&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;习近平生态文明思想是习近平新时代中国特色社会主义思想的重要组成部分。《习近平著作选读》收入了习近平总书记关于生态文明建设和生态环境保护的多篇重要讲话和重要批示，集中体现了习近平生态文明思想的丰富内涵，深刻回答了为什么建设生态文明、建设什么样的生态文明、怎样建设生态文明等重大理论和实践问题，是新时代新征程上推进人与自然和谐共生现代化的根本遵循和行动指南。我们要坚持读原著学原文悟原理，坚持多思多想、学深悟透，不断从习近平总书记关于生态文明建设的重要著作中汲取营养、深化认识，做到真学真懂真信真用。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;第一，深刻把握人与自然是生命共同体。大自然是包括人在内一切生物的摇篮，是人类赖以生存发展的基本条件。人与自然相互影响、相互制约、相互作用，是不可分割的生命共同体。生态兴则文明兴，生态衰则文明衰，无止境地向自然索取甚至破坏自然必然会遭到大自然的报复。大自然遭到系统性破坏，人类生存发展就成了无源之水、无本之木。必须尊重自然、顺应自然、保护自然，站在人与自然和谐共生的高度来谋划经济社会发展，在尊重自然规律的前提下修复和利用自然，把人类活动限制在生态环境能够承受的限度内，取之有时、用之有度，坚定不移走生产发展、生活富裕、生态良好的文明发展道路。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;第二，深刻把握绿水青山就是金山银山。良好生态本身蕴含着无穷的经济价值。绿水青山既是自然财富、生态财富，又是社会财富、经济财富，还是水库、粮库、钱库、碳库。保护生态环境就是保护自然价值和增值自然资本，就是保护生产力，改善生态环境就是发展生产力。发展不能以破坏生态环境为代价，保护好生态环境，生态也会回馈我们，生态本身就是经济。推动经济社会发展绿色化、低碳化是实现高质量发展的关键环节，也是解决我国生态环境问题的根本出路。必须牢固树立绿水青山就是金山银山理念，坚决摒弃损害甚至破坏生态环境的发展模式和以牺牲生态环境换取一时一地经济增长的做法，坚定不移走生态优先、绿色发展之路，加快形成绿色低碳生产方式和生活方式，以高品质的生态环境支撑高质量发展。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;第三，深刻把握良好生态环境是最普惠的民生福祉。环境就是民生，青山就是美丽，蓝天也是幸福，良好生态环境是最公平的公共产品。发展经济是为了民生，保护生态环境也是为了民生，生态环境是关系民生的重大社会问题。对人的生存来说，生态环境是人民幸福生活的重要内容，是金钱不能代替的。进入新时代，我国社会主要矛盾已经转化为人民日益增长的美好生活需要和不平衡不充分的发展之间的矛盾，人民群众对优美生态环境的需要成为这一矛盾的重要方面。必须坚持以人民为中心的发展思想，解决好人民群众身边的突出生态环境问题，推动生态惠民、生态利民、生态为民，提供更多优质生态产品，让人民群众的获得感、幸福感、安全感更加充实、更有保障、更可持续，望得见山、看得见水、记得住乡愁。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;第四，深刻把握统筹山水林田湖草沙系统治理。山水林田湖草是生命共同体，是各自然要素相互依存、紧密联系的有机整体，人的命脉在田、田的命脉在水、水的命脉在山、山的命脉在土、土的命脉在林和草。如果种树的只管种树、治水的只管治水、护田的单纯护田，就很容易顾此失彼，最终造成生态的系统性破坏。必须坚持系统观念，按照生态系统的整体性及其内在规律，从系统工程和全局角度推进山水林田湖草沙一体化保护和系统治理，更加注重综合治理、系统治理、源头治理，更加注重算大账、算长远账、算整体账、算综合账，不能头痛医头、脚痛医脚，不能因小失大、顾此失彼，切实提升生态系统的多样性、稳定性、持续性，筑牢美丽中国的生态根基。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;第五，深刻把握用最严格制度最严密法治保护生态环境。当前，我国生态环境保护中存在的突出问题大多同体制不健全、制度不严格、法治不严密、执行不到位、惩处不得力有关。只有实行最严格的制度、最严密的法治，才能为生态文明建设提供可靠保障。建设生态文明，重在建章立制，必须把制度建设、法治建设作为重中之重，坚持有法必依、执法必严、违法必究，持续深化生态文明体制改革，建立健全源头预防、过程控制、损害赔偿、责任追究的生态环境保护体系以及党委领导、政府主导、企业主体、社会组织和公众共同参与的现代环境治理体系，把建设美丽中国转化为全民自觉行动，让制度成为刚性约束和不可触碰的高压线。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;span style=&quot;color: rgb(76, 76, 76);&quot;&gt;第六，深刻把握共建清洁美丽世界。地球是人类赖以生存的共同家园。面对气候变化、生物多样性丧失、荒漠化加剧、极端气候事件频发等全球生态环境挑战，人类是一荣俱荣、一损俱损的命运共同体，没有哪个国家能独善其身。生态文明是人类文明发展的历史趋势，建设美丽家园是人类的共同梦想。必须秉持人类命运共同体理念，推动落实全球发展倡议、全球安全倡议、全球文明倡议，深度参与全球生态环境治理，维护公平合理的全球环境治理体系，为共建地球生命共同体、共建清洁美丽世界贡献中国智慧、中国方案、中国力量。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;strong style=&quot;color: rgb(76, 76, 76);&quot;&gt;新时代我国生态环境保护发生历史性、转折性、全局性变化。&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		党的十八大以来，以习近平同志为核心的党中央将生态文明建设作为关系中华民族永续发展的根本大计，从思想、法律、体制、组织、作风上全面发力，全方位、全地域、全过程加强生态环境保护，决心之大、力度之大、成效之大前所未有，推动美丽中国建设迈出重大步伐，创造了举世瞩目的生态奇迹和绿色发展奇迹。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		一是把生态文明建设摆在全局工作突出位置，谋篇布局更加成熟。我们党把“美丽中国”纳入社会主义现代化强国目标，把生态文明建设纳入“五位一体”总体布局，把“坚持人与自然和谐共生”纳入新时代坚持和发展中国特色社会主义基本方略，把“促进人与自然和谐共生”纳入中国式现代化的本质要求，把“绿色”纳入新发展理念，把“污染防治”纳入三大攻坚战。生态文明建设和生态环境保护逐步纳入经济社会发展各方面和全过程，绿水青山就是金山银山理念已经成为全党全社会的共识和行动。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		二是完整准确全面贯彻新发展理念，绿色循环低碳发展步履坚实。将碳达峰、碳中和纳入生态文明建设整体布局和经济社会发展全局，建立“1+N”政策体系。划定生态保护红线、环境质量底线、资源利用上线，推动经济社会发展建立在资源高效利用和绿色低碳发展的基础之上。2022年，我国煤炭占能源消费总量比重由2005年的72.4%下降至56.2%，可再生能源发电装机历史性超过煤电，新能源汽车产销量稳居世界第一。全球规模最大的碳排放权交易市场平稳运行。新时代十年，我国以年均3%的能源消费增速支撑了超过6%的经济增长，能耗强度累计下降26.2%，相当于少用14亿吨标准煤，少排放29.4亿吨二氧化碳，绿色日益成为高质量发展的鲜明底色。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		三是协同推进污染防治和生态保护，生态环境质量改善成效显著。坚持精准治污、科学治污、依法治污，推动污染防治攻坚战阶段性目标任务圆满完成，人民群众生态环境获得感显著增强。2022年，我国地级及以上城市细颗粒物（PM2.5）平均浓度下降至29微克/立方米，首次降低到30微克/立方米以内，优良天数比率达到86.5%，成为全球大气质量改善速度最快的国家。全国地表水Ⅰ—Ⅲ类断面比例上升至87.9%，接近发达国家水平。土壤环境风险得到有效管控。全面禁止洋垃圾入境，顺利实现固体废物“零进口”目标。陆域生态保护红线面积占陆域国土面积比例超过30%，300多种珍稀濒危野生动植物野外种群数量稳中有升。云南野象“自由旅行”、长江江豚“频频微笑”、青藏高原“万羊齐奔”，生动体现了我国生态保护的显著成效。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		四是深化生态文明体制改革，生态文明制度体系更加健全。重塑和重构生态环境保护体系，建立实施生态文明建设目标评价考核和责任追究制度、排污许可制度、生态保护红线制度、环境保护“党政同责”“一岗双责”等制度。建立并实施中央生态环境保护督察制度，实现对两轮31个省（区、市）以及新疆生产建设兵团的督察全覆盖，并对6家中央企业和2个国务院有关部门开展督察，解决一批人民群众反映强烈的突出生态环境问题，成为推动地方党委政府及其相关部门落实生态环境保护责任的硬招实招。制修订30多部生态环境领域法律和行政法规，形成由1部综合性的环境保护法、N部涉及生态环境要素的专门法律、4部特殊区域法律组成的“1+N+4”法律制度体系。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		五是践行人类命运共同体理念，全球环境治理影响力大幅跃升。推动《巴黎协定》达成、签署、生效和实施。宣布二氧化碳排放力争于2030年前达到峰值，努力争取2060年前实现碳中和，不再新建境外煤电项目，充分展现负责任大国担当。成功举办《生物多样性公约》第十五次缔约方大会（COP15），推动达成历史性的兼具雄心和务实平衡的“昆明—蒙特利尔全球生物多样性框架”，开启了全球生物多样性治理新篇章。积极开展应对气候变化南南合作，在发展中国家启动10个低碳示范区、100个减缓和适应气候变化项目、1000个应对气候变化培训名额的合作项目。深入开展绿色“一带一路”建设，建立“一带一路”绿色发展国际联盟，与31个共建国家共同发起“一带一路”绿色发展伙伴关系倡议。我国已成为全球生态文明建设的重要参与者、贡献者、引领者。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		回顾新时代以来的奋斗历程，我国生态文明建设和生态环境保护工作得到全国人民普遍认可、国际社会广泛肯定，为推进中国式现代化奠定坚实基础，根本在于有习近平总书记作为党中央的核心、全党的核心掌舵领航，在于有习近平新时代中国特色社会主义思想特别是习近平生态文明思想科学指引，充分彰显了习近平生态文明思想的真理力量和实践伟力。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		&lt;strong&gt;在建设人与自然和谐共生现代化新征程上展现新担当新作为&lt;/strong&gt;&lt;/p&gt;&lt;p&gt;		当前，强国建设、民族复兴的接力棒，历史地落在我们这一代人身上。我们要建设的现代化，是人与自然和谐共生的现代化。新时代新征程上，我们要以习近平新时代中国特色社会主义思想为指导，深入学习贯彻习近平生态文明思想，统筹产业结构调整、污染治理、生态保护、应对气候变化，协同推进降碳、减污、扩绿、增长，推进生态优先、节约集约、绿色低碳发展，不断书写人与自然和谐共生的现代化新篇章。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		一是保持战略定力，推动绿色低碳高质量发展。更好统筹经济社会发展和生态环境保护，坚持减污降碳协同增效，充分发挥生态环境保护的引领、优化和倒逼作用，加快推动产业结构、能源结构、交通运输结构等调整优化，坚决遏制高耗能、高排放、低水平项目盲目上马。积极稳妥推进碳达峰碳中和，推动能源消耗总量和强度调控逐步转向碳排放总量和强度“双控”制度，健全碳排放权交易市场制度。加强生态环境分区管控，构建国土空间开发保护新格局。聚焦重大国家战略实施，打造绿色发展高地和美丽中国先行区。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		二是突出问题导向，持续深入推进污染防治攻坚。巩固污染防治攻坚成果，聚焦突出问题和短板弱项，保持力度、延伸深度、拓宽广度，以改善生态环境质量为核心，以更高标准打好蓝天、碧水、净土保卫战，着力打好重污染天气消除、柴油货车污染治理、城市黑臭水体治理、长江保护修复、黄河生态保护治理、重点海域综合治理、农业农村污染治理等标志性战役，加强新污染物治理，推动污染防治在重点区域、重要领域、关键指标上实现新突破。严密防控环境风险，确保核与辐射安全。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		三是坚持系统观念，着力提升生态系统质量和稳定性。坚持山水林田湖草沙一体化保护和系统治理，加强自然保护地和生态保护红线监管，依法加大生态破坏问题监督和查处力度，持续推进“绿盾”自然保护地强化监督专项行动。实施生物多样性保护重大工程，推进以国家公园为主体的自然保护地体系建设。开展生态文明示范创建，积极打造人与自然和谐共生的美丽中国示范样板。加强生物安全管理，防治外来物种侵害，守住自然生态安全边界。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		四是深化国际合作，推动构建地球生命共同体。秉持人类命运共同体理念，践行真正的多边主义，落实全球发展倡议，积极参与全球环境治理，加强应对气候变化、海洋生态环境保护、生物多样性保护等领域国际合作，认真履行国际公约，不断增强制度性权利。继续履行好COP15主席国职责，推动“昆蒙框架”目标落地。深入推进绿色“一带一路”建设，持续实施应对气候变化南南合作。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;		五是加快改革创新，健全现代环境治理体系。持续加大技术、政策、管理创新力度，不断提升精准、科学、依法治污水平和环境治理能力。深化生态文明体制改革，推动中央生态环境保护督察向纵深发展。完善生态环境管理制度，健全生态产品价值实现机制，深化生态保护补偿制度改革，加快构建以排污许可制为核心的固定污染源执法监管体系，全力提升生态环境执法、监测、信息、科研、人才队伍等各方面能力。一刻不停推进全面从严治党，把严的基调、严的措施、严的氛围长期坚持下去，持之以恒纠“四风”树新风，全面打造生态环境保护铁军。&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;', '2023-06-10 12:53:38', '2023-06-10 12:53:38', '/topic/20230610/3503b97ad8ec18a96ab984d6d6c1bb08.jpeg', '生态环境部党组理论学习中心组在《经济日报》发表署名文章《建设人与自然和谐共生现代化——认真学习〈习近平著作选读〉第一卷、第二卷》', '经济日报', NULL);

-- ----------------------------
-- Table structure for ntp_common_article_type
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_article_type`;
CREATE TABLE `ntp_common_article_type`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_article_type
-- ----------------------------
INSERT INTO `ntp_common_article_type` VALUES (2, '平台文章');
INSERT INTO `ntp_common_article_type` VALUES (24, '平台攻略');
INSERT INTO `ntp_common_article_type` VALUES (25, '今日最新政策');

-- ----------------------------
-- Table structure for ntp_common_goods
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_goods`;
CREATE TABLE `ntp_common_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_type_id` int(12) NOT NULL COMMENT '商品分类',
  `goods_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名称',
  `goods_money` decimal(20, 2) NOT NULL COMMENT '投注价格，最低价格，起投金额',
  `project_scale` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '万元 项目规模',
  `day_red` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '每日分红 展示，实际分红以天数为准 每日收益',
  `period` int(12) NOT NULL DEFAULT 0 COMMENT '投资周期  展示，实际周期以天数为准',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 下架，1 上架',
  `red_way` int(12) NOT NULL DEFAULT 1 COMMENT '1 到期还本还息 ',
  `warrant` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '担保公司',
  `create_time` datetime NOT NULL,
  `head_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面图，顶部图',
  `bottom_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '详情下图',
  `is_examine` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 是新手体验产品',
  `sort` int(12) NOT NULL DEFAULT 0 COMMENT '商品排序',
  `is_coupon` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可用优惠卷，0 不可用。1可用',
  `del` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 正常，1 删除',
  `progress_rate` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '投资进度',
  `goods_agent_1` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '一级返佣',
  `goods_agent_2` decimal(12, 2) NOT NULL DEFAULT 0.00,
  `goods_agent_3` decimal(12, 2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_goods
-- ----------------------------
INSERT INTO `ntp_common_goods` VALUES (1, 5, '清洁能源', 1000.00, 13860.00, 220.00, 120, 1, 1, '中国人民保险机构', '2023-04-12 09:47:20', '///////topic/20230531/ded24f9fbabfee4c40e4a83c9f84e927.jpg', '///topic/20230607/d2816f88ee2a4652ff2e648a7df77b8f.png', 0, 0, 1, 0, 1000.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (2, 3, '新手体验', 1000.00, 1000.00, 220.00, 120, 0, 1, '中国人民保险机构', '2023-04-12 10:03:03', 'topic/20230601/b049dfd7ae0cd7ec67609d36dd174798.jpg', '/topic/1000.png', 1, 0, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (3, 5, '清洁能源', 3000.00, 36650.00, 650.00, 120, 1, 1, '中国人民保险机构', '2023-04-12 09:47:20', '////topic/20230531/7e6734d3db3063bf17cfa8b5988cb14b.jpg', '///topic/20230603/8fa9a62e7f882e3184c93ecec6aa98dd.png', 0, 0, 1, 0, 1500.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (4, 5, '清洁能源', 5000.00, 54280.00, 1280.00, 120, 1, 1, '中国人民保险机构', '2023-04-12 09:47:20', '//topic/20230531/21dc50e47a5a69107c9b064a4ce64944.jpg', '/topic/20230603/9ae8aa8774b173e612d6b430d5d85a1b.png', 0, 0, 1, 0, 2000.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (5, 5, '清洁能源', 8000.00, 118000.00, 2040.00, 120, 1, 1, '中国人民保险机构', '2023-04-12 09:47:20', '//topic/20230531/d9befcadf877f395519ccd57bb88651a.jpg', '/topic/20230603/28dc545af2216cf0a6719f6c6567dff7.png', 0, 0, 1, 0, 3000.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (6, 5, '清洁能源', 10000.00, 158600.00, 2560.00, 120, 1, 1, '中国人民保险机构', '2023-04-12 09:47:20', '///topic/20230531/1fecfa7798ae6e440e9c5653df243c5e.jpg', '/topic/20230606/c481aeca24a794ce2efb3572866dd0fc.png', 0, 0, 1, 0, 4000.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (7, 3, '新手体验', 3000.00, 2000.00, 650.00, 120, 0, 1, '中国人民保险机构', '2023-04-12 10:03:03', 'topic/20230601/b49f2774740eef9d244a104d29b4e07a.jpg', '/topic/3000.png', 1, 0, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (8, 3, '新手体验', 5000.00, 3000.00, 1280.00, 120, 0, 1, '中国人民保险机构', '2023-04-12 10:03:03', 'topic/20230601/316dc75dc562b981510f973959c65ea9.jpg', '/topic/5000.png', 1, 0, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (9, 3, '新手体验', 8000.00, 5000.00, 2040.00, 120, 0, 1, '中国人民保险机构', '2023-04-12 10:03:03', 'topic/20230601/d5421f5c06fb1455c14579f9fd1eec8f.jpg', '/topic/8000.png', 1, 0, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (10, 3, '新手体验', 10000.00, 10000.00, 2560.00, 120, 0, 1, '中国人民保险机构', '2023-04-12 10:03:03', 'topic/20230601/e6723aceb63ac83e5c032f526f6e4181.jpg', '/topic/10000.png', 1, 0, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (11, 1, '污水处理1', 1000.00, 1000.00, 100.00, 1, 1, 1, '中国环境监测', '2023-05-28 22:27:02', '/topic/20230531/37bc39cddac65bd30d1aae70b7404ce8.jpg', 'topic/20230604/f99f9acd701c2327140483595b6ab640.png', 1, 5, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (12, 1, '污水处理2', 3000.00, 3000.00, 300.00, 1, 1, 1, '中国环境监测', '2023-05-28 22:28:46', '/topic/20230531/37bc39cddac65bd30d1aae70b7404ce8.jpg', 'topic/20230604/39338b5d894d13d44189892111eaed91.png', 1, 4, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (13, 1, '污水处理3', 5000.00, 5000.00, 500.00, 1, 1, 1, '中国环境监测', '2023-05-28 22:29:27', '/topic/20230531/37bc39cddac65bd30d1aae70b7404ce8.jpg', 'topic/20230604/b07b74742501567092be0e4345de0b11.png', 1, 3, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (14, 1, '污水处理4', 8000.00, 8000.00, 800.00, 1, 1, 1, '中国环境监测', '2023-05-28 22:30:13', '/topic/20230531/37bc39cddac65bd30d1aae70b7404ce8.jpg', 'topic/20230604/18c1f06da63714eed48003326a1cd39b.png', 1, 2, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (15, 1, '污水处理5', 10000.00, 10000.00, 1000.00, 1, 1, 1, '中国环境监测', '2023-05-28 22:31:17', '/topic/20230531/37bc39cddac65bd30d1aae70b7404ce8.jpg', 'topic/20230604/4bd3f77772802b666e7848083480f5dc.png', 1, 1, 1, 1, 100.00, 0.00, 0.00, 0.00);
INSERT INTO `ntp_common_goods` VALUES (16, 3, '新用户体验', 588.00, 1500.00, 128.00, 120, 0, 1, '平安银行', '2023-05-29 10:19:10', 'topic/20230611/222c7cd97fa234bd1413f1776da6e07e.png', '//topic/20230607/e73007ae97f7e08a46e755d08aaa2a0e.png', 1, 0, 1, 0, 10.00, 0.00, 0.00, 0.00);

-- ----------------------------
-- Table structure for ntp_common_goods_coupon
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_goods_coupon`;
CREATE TABLE `ntp_common_goods_coupon`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_on` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '优惠卷号码',
  `coupon_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 现金卷，直接当现金使用',
  `uid` int(11) NOT NULL DEFAULT 0 COMMENT '领取人',
  `coupon_money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '优惠卷金额',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0新建，1已领取，2已使用。3过期 9删除',
  `goods_id` int(11) NOT NULL DEFAULT 0 COMMENT '优惠卷使用的商品ID',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `draw_time` datetime NULL DEFAULT NULL COMMENT '领取日期',
  `effect_time` datetime NULL DEFAULT NULL COMMENT '有效期',
  `success_time` datetime NULL DEFAULT NULL COMMENT '使用时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品优惠卷表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_goods_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_goods_day
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_goods_day`;
CREATE TABLE `ntp_common_goods_day`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) NOT NULL COMMENT '项目ID',
  `mid` int(11) NOT NULL DEFAULT 0 COMMENT '商品价格ID',
  `project_day` int(11) NOT NULL DEFAULT 0 COMMENT '项目对应天数',
  `income` decimal(12, 2) NOT NULL COMMENT '项目每日收益',
  `total_red_money` decimal(20, 2) NOT NULL COMMENT '项目可以获得多少分红，天数X每日分红=总收益',
  `create_time` datetime NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `withdrawable_money` decimal(12, 2) NOT NULL COMMENT '到天数释放可提现金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目天数表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_goods_day
-- ----------------------------
INSERT INTO `ntp_common_goods_day` VALUES (1, 1, 1, 7, 220.00, 1540.00, '2023-04-12 09:50:15', '', 105.00);
INSERT INTO `ntp_common_goods_day` VALUES (2, 1, 1, 15, 220.00, 3300.00, '2023-04-12 09:51:20', NULL, 257.00);
INSERT INTO `ntp_common_goods_day` VALUES (3, 1, 1, 30, 220.00, 6600.00, '2023-04-27 13:43:21', NULL, 990.00);
INSERT INTO `ntp_common_goods_day` VALUES (4, 1, 1, 60, 220.00, 13200.00, '2023-04-27 13:43:25', NULL, 3168.00);
INSERT INTO `ntp_common_goods_day` VALUES (5, 1, 1, 90, 220.00, 19800.00, '2023-04-27 14:22:11', NULL, 8019.00);
INSERT INTO `ntp_common_goods_day` VALUES (6, 1, 1, 120, 220.00, 26400.00, '2023-04-27 14:22:34', NULL, 26400.00);
INSERT INTO `ntp_common_goods_day` VALUES (7, 3, 2, 7, 650.00, 4550.00, '2023-04-27 14:22:58', NULL, 312.00);
INSERT INTO `ntp_common_goods_day` VALUES (8, 3, 2, 15, 650.00, 9750.00, '2023-04-27 14:23:18', NULL, 737.00);
INSERT INTO `ntp_common_goods_day` VALUES (9, 3, 2, 30, 650.00, 19500.00, '2023-04-27 13:43:21', NULL, 2925.00);
INSERT INTO `ntp_common_goods_day` VALUES (10, 3, 2, 60, 650.00, 39000.00, '2023-04-27 13:43:21', NULL, 9360.00);
INSERT INTO `ntp_common_goods_day` VALUES (11, 3, 2, 90, 650.00, 58500.00, '2023-04-27 13:43:21', NULL, 23693.00);
INSERT INTO `ntp_common_goods_day` VALUES (12, 3, 2, 120, 650.00, 78000.00, '2023-04-27 13:43:21', NULL, 78000.00);
INSERT INTO `ntp_common_goods_day` VALUES (13, 4, 3, 7, 1280.00, 8960.00, '2023-04-12 09:50:15', '', 596.00);
INSERT INTO `ntp_common_goods_day` VALUES (14, 4, 3, 15, 1280.00, 19200.00, '2023-04-12 09:51:20', '', 1296.00);
INSERT INTO `ntp_common_goods_day` VALUES (15, 4, 3, 30, 1280.00, 38400.00, '2023-04-27 13:43:21', '', 5760.00);
INSERT INTO `ntp_common_goods_day` VALUES (16, 4, 3, 60, 1280.00, 76800.00, '2023-04-27 13:43:25', '', 18432.00);
INSERT INTO `ntp_common_goods_day` VALUES (17, 4, 3, 90, 1280.00, 115200.00, '2023-04-27 14:22:11', '', 46656.00);
INSERT INTO `ntp_common_goods_day` VALUES (18, 4, 3, 120, 1280.00, 153600.00, '2023-04-27 14:22:34', '', 153600.00);
INSERT INTO `ntp_common_goods_day` VALUES (19, 5, 4, 7, 2040.00, 14280.00, '2023-04-12 09:50:15', '', 981.00);
INSERT INTO `ntp_common_goods_day` VALUES (20, 5, 4, 15, 2040.00, 30600.00, '2023-04-12 09:51:20', '', 2525.00);
INSERT INTO `ntp_common_goods_day` VALUES (21, 5, 4, 30, 2040.00, 61200.00, '2023-04-27 13:43:21', '', 9180.00);
INSERT INTO `ntp_common_goods_day` VALUES (22, 5, 4, 60, 2040.00, 122400.00, '2023-04-27 13:43:25', '', 29376.00);
INSERT INTO `ntp_common_goods_day` VALUES (23, 5, 4, 90, 2040.00, 183600.00, '2023-04-27 14:22:11', '', 74358.00);
INSERT INTO `ntp_common_goods_day` VALUES (24, 5, 4, 120, 2040.00, 244800.00, '2023-04-27 14:22:34', '', 244800.00);
INSERT INTO `ntp_common_goods_day` VALUES (25, 6, 5, 7, 2560.00, 17920.00, '2023-04-12 09:50:15', '', 1205.00);
INSERT INTO `ntp_common_goods_day` VALUES (26, 6, 5, 15, 2560.00, 38400.00, '2023-04-12 09:51:20', '', 3139.00);
INSERT INTO `ntp_common_goods_day` VALUES (27, 6, 5, 30, 2560.00, 76800.00, '2023-04-27 13:43:21', '', 11520.00);
INSERT INTO `ntp_common_goods_day` VALUES (28, 6, 5, 60, 2560.00, 153600.00, '2023-04-27 13:43:25', '', 36864.00);
INSERT INTO `ntp_common_goods_day` VALUES (29, 6, 5, 90, 2560.00, 230400.00, '2023-04-27 14:22:11', '', 93312.00);
INSERT INTO `ntp_common_goods_day` VALUES (30, 6, 5, 120, 2560.00, 307200.00, '2023-04-27 14:22:34', '', 307200.00);
INSERT INTO `ntp_common_goods_day` VALUES (31, 2, 6, 7, 220.00, 1540.00, '2023-04-12 09:50:15', '', 105.00);
INSERT INTO `ntp_common_goods_day` VALUES (32, 2, 6, 15, 220.00, 3300.00, '2023-04-12 09:51:20', '', 257.00);
INSERT INTO `ntp_common_goods_day` VALUES (33, 2, 6, 30, 220.00, 6600.00, '2023-04-27 13:43:21', '', 990.00);
INSERT INTO `ntp_common_goods_day` VALUES (34, 2, 6, 60, 220.00, 13200.00, '2023-04-27 13:43:25', '', 3168.00);
INSERT INTO `ntp_common_goods_day` VALUES (35, 2, 6, 90, 220.00, 19800.00, '2023-04-27 14:22:11', '', 8019.00);
INSERT INTO `ntp_common_goods_day` VALUES (36, 2, 6, 120, 220.00, 26400.00, '2023-04-27 14:22:34', '', 26400.00);
INSERT INTO `ntp_common_goods_day` VALUES (37, 7, 7, 7, 650.00, 4550.00, '2023-04-27 14:22:58', '', 312.00);
INSERT INTO `ntp_common_goods_day` VALUES (38, 7, 7, 15, 650.00, 9750.00, '2023-04-27 14:23:18', '', 737.00);
INSERT INTO `ntp_common_goods_day` VALUES (39, 7, 7, 30, 650.00, 19500.00, '2023-04-27 13:43:21', '', 2925.00);
INSERT INTO `ntp_common_goods_day` VALUES (40, 7, 7, 60, 650.00, 39000.00, '2023-04-27 13:43:21', '', 9360.00);
INSERT INTO `ntp_common_goods_day` VALUES (41, 7, 7, 90, 650.00, 58500.00, '2023-04-27 13:43:21', '', 23693.00);
INSERT INTO `ntp_common_goods_day` VALUES (42, 7, 7, 120, 650.00, 78000.00, '2023-04-27 13:43:21', '', 78000.00);
INSERT INTO `ntp_common_goods_day` VALUES (43, 8, 8, 7, 1280.00, 8960.00, '2023-04-12 09:50:15', '', 596.00);
INSERT INTO `ntp_common_goods_day` VALUES (44, 8, 8, 15, 1280.00, 19200.00, '2023-04-12 09:51:20', '', 1296.00);
INSERT INTO `ntp_common_goods_day` VALUES (45, 8, 8, 30, 1280.00, 38400.00, '2023-04-27 13:43:21', '', 5760.00);
INSERT INTO `ntp_common_goods_day` VALUES (46, 8, 8, 60, 1280.00, 76800.00, '2023-04-27 13:43:25', '', 18432.00);
INSERT INTO `ntp_common_goods_day` VALUES (47, 8, 8, 90, 1280.00, 115200.00, '2023-04-27 14:22:11', '', 46656.00);
INSERT INTO `ntp_common_goods_day` VALUES (48, 8, 8, 120, 1280.00, 153600.00, '2023-04-27 14:22:34', '', 153600.00);
INSERT INTO `ntp_common_goods_day` VALUES (49, 9, 9, 7, 2040.00, 14280.00, '2023-04-12 09:50:15', '', 981.00);
INSERT INTO `ntp_common_goods_day` VALUES (50, 9, 9, 15, 2040.00, 30600.00, '2023-04-12 09:51:20', '', 2525.00);
INSERT INTO `ntp_common_goods_day` VALUES (51, 9, 9, 30, 2040.00, 61200.00, '2023-04-27 13:43:21', '', 9180.00);
INSERT INTO `ntp_common_goods_day` VALUES (52, 9, 9, 60, 2040.00, 122400.00, '2023-04-27 13:43:25', '', 29376.00);
INSERT INTO `ntp_common_goods_day` VALUES (53, 9, 9, 90, 2040.00, 183600.00, '2023-04-27 14:22:11', '', 74358.00);
INSERT INTO `ntp_common_goods_day` VALUES (54, 9, 9, 120, 2040.00, 244800.00, '2023-04-27 14:22:34', '', 244800.00);
INSERT INTO `ntp_common_goods_day` VALUES (55, 10, 10, 7, 2560.00, 17920.00, '2023-04-12 09:50:15', '', 1205.00);
INSERT INTO `ntp_common_goods_day` VALUES (56, 10, 10, 15, 2560.00, 38400.00, '2023-04-12 09:51:20', '', 3139.00);
INSERT INTO `ntp_common_goods_day` VALUES (57, 10, 10, 30, 2560.00, 76800.00, '2023-04-27 13:43:21', '', 11520.00);
INSERT INTO `ntp_common_goods_day` VALUES (58, 10, 10, 60, 2560.00, 153600.00, '2023-04-27 13:43:25', '', 36864.00);
INSERT INTO `ntp_common_goods_day` VALUES (59, 10, 10, 90, 2560.00, 230400.00, '2023-04-27 14:22:11', '', 93312.00);
INSERT INTO `ntp_common_goods_day` VALUES (60, 10, 10, 120, 2560.00, 307200.00, '2023-04-27 14:22:34', '', 307200.00);
INSERT INTO `ntp_common_goods_day` VALUES (62, 15, 15, 1, 1000.00, 1000.00, '2023-05-28 22:40:19', NULL, 1000.00);
INSERT INTO `ntp_common_goods_day` VALUES (63, 14, 14, 1, 800.00, 800.00, '2023-05-28 22:40:41', NULL, 800.00);
INSERT INTO `ntp_common_goods_day` VALUES (64, 13, 13, 1, 500.00, 500.00, '2023-05-28 22:40:57', NULL, 500.00);
INSERT INTO `ntp_common_goods_day` VALUES (65, 12, 12, 1, 300.00, 300.00, '2023-05-28 22:41:14', NULL, 300.00);
INSERT INTO `ntp_common_goods_day` VALUES (66, 11, 11, 1, 100.00, 100.00, '2023-05-28 22:41:26', NULL, 100.00);
INSERT INTO `ntp_common_goods_day` VALUES (67, 16, 16, 7, 128.00, 896.00, '2023-05-29 10:22:29', NULL, 13.00);
INSERT INTO `ntp_common_goods_day` VALUES (68, 16, 16, 15, 128.00, 1920.00, '2023-05-29 10:23:30', NULL, 29.00);
INSERT INTO `ntp_common_goods_day` VALUES (69, 16, 16, 30, 128.00, 3840.00, '2023-05-29 10:23:56', NULL, 61.00);
INSERT INTO `ntp_common_goods_day` VALUES (70, 16, 16, 60, 128.00, 7680.00, '2023-05-29 10:24:37', NULL, 127.00);
INSERT INTO `ntp_common_goods_day` VALUES (71, 16, 16, 90, 128.00, 11520.00, '2023-05-29 10:24:58', NULL, 196.00);
INSERT INTO `ntp_common_goods_day` VALUES (72, 16, 16, 120, 128.00, 15360.00, '2023-05-29 10:25:17', NULL, 15360.00);

-- ----------------------------
-- Table structure for ntp_common_goods_money
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_goods_money`;
CREATE TABLE `ntp_common_goods_money`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL COMMENT '商品ID',
  `money` decimal(12, 2) NOT NULL COMMENT '商品投注价格',
  `sort` int(255) NOT NULL DEFAULT 0 COMMENT '商品排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品价格表' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of ntp_common_goods_money
-- ----------------------------
INSERT INTO `ntp_common_goods_money` VALUES (1, 1, 1000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (2, 3, 3000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (3, 4, 5000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (4, 5, 8000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (5, 6, 10000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (6, 2, 1000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (7, 7, 3000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (8, 8, 5000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (9, 9, 8000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (10, 10, 10000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (11, 11, 1000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (12, 12, 3000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (13, 13, 5000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (14, 14, 8000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (15, 15, 10000.00, 0);
INSERT INTO `ntp_common_goods_money` VALUES (16, 16, 588.00, 0);

-- ----------------------------
-- Table structure for ntp_common_goods_order
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_goods_order`;
CREATE TABLE `ntp_common_goods_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `mid` int(11) NOT NULL COMMENT '商品价格的ID',
  `uname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `goods_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `goods_id` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `day_id` int(11) NOT NULL,
  `goods_type_id` int(11) NOT NULL,
  `goods_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `total_red_money` decimal(20, 2) NOT NULL COMMENT '全部应该获得的 分红金额',
  `already_red_money` decimal(20, 2) NOT NULL COMMENT '已经获得的分红金额',
  `surplus_red_money` decimal(20, 2) NOT NULL COMMENT '剩余应该获得的分红',
  `red_day` int(12) NOT NULL DEFAULT 0 COMMENT '总分红天数',
  `already_red_day` int(11) NOT NULL COMMENT '已经分红的天数',
  `surplus_red_day` int(11) NOT NULL COMMENT '剩余分红的天数',
  `next_red_date` datetime NOT NULL COMMENT '下次分红日期',
  `last_red_date` datetime NOT NULL COMMENT '上次分红时间，默认是创建时间',
  `order_money` decimal(20, 2) NOT NULL COMMENT '订单金额',
  `order_number` int(11) NOT NULL DEFAULT 0 COMMENT '商品数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `is_coupon` tinyint(1) NOT NULL DEFAULT 0 COMMENT ' 使用优惠卷的优惠卷 ID  0表示没使用优惠卷',
  `coupon_money` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '使用优惠卷时优惠卷金额',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0正常 1 返佣完成，正在分红中，2 分红完成利息返回完成  3 本金返回完成 -1删除',
  `order_no` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `one_money` decimal(20, 0) NOT NULL DEFAULT 0 COMMENT '商品单价 单件商品价',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_goods_order
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_goods_type`;
CREATE TABLE `ntp_common_goods_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 隐藏， 1显示',
  `create_time` datetime NOT NULL,
  `sort` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目表分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_goods_type
-- ----------------------------
INSERT INTO `ntp_common_goods_type` VALUES (1, '可再生资源', 1, '2023-04-12 09:48:26', 0);
INSERT INTO `ntp_common_goods_type` VALUES (2, '航空航天', 1, '2023-04-12 09:49:06', 0);
INSERT INTO `ntp_common_goods_type` VALUES (3, '新手体验专区', 1, '2023-04-30 12:29:14', 0);
INSERT INTO `ntp_common_goods_type` VALUES (4, '新能源汽车', 1, '2023-05-22 14:48:15', 0);
INSERT INTO `ntp_common_goods_type` VALUES (5, '清洁能源', 1, '2023-05-22 14:48:25', 0);
INSERT INTO `ntp_common_goods_type` VALUES (6, '植树造林', 1, '2023-05-22 14:48:46', 0);
INSERT INTO `ntp_common_goods_type` VALUES (7, '数字化城市', 1, '2023-05-22 14:48:57', 0);
INSERT INTO `ntp_common_goods_type` VALUES (8, '节能减排', 1, '2023-05-22 14:49:05', 0);

-- ----------------------------
-- Table structure for ntp_common_home_token
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_home_token`;
CREATE TABLE `ntp_common_home_token`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登陆凭证',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `user_id` int(10) NULL DEFAULT NULL COMMENT '管理员ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12429 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '前台token' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_home_token
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_invitation
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_invitation`;
CREATE TABLE `ntp_common_invitation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `number` int(11) NOT NULL COMMENT '邀请会员数量',
  `reward` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '邀请会员达标奖励',
  `status` tinyint(1) NOT NULL COMMENT '0 禁用  1启用',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `admin_uid` int(11) NOT NULL COMMENT '管理员ID',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '奖励币种类型  1 团队工资',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '邀请奖励表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_common_invitation
-- ----------------------------
INSERT INTO `ntp_common_invitation` VALUES (1, '绿色中国守护者直推50人岗位津贴2000元/月', 50, 2000.00, 1, '2023-05-18 11:02:58', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (2, '绿色中国守护者直推100人岗位津贴4000元/月', 100, 4000.00, 1, '2023-05-18 11:02:58', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (3, '绿色中国守护者直推150人岗位津贴6000元/月', 150, 6000.00, 1, '2023-05-18 11:02:58', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (5, '绿色中国守护者直推200人岗位津贴8000元/月', 200, 8000.00, 1, '2023-05-18 11:02:58', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (6, '绿色中国守护者直推250人岗位津贴10000元/月', 250, 10000.00, 1, '2023-05-18 11:02:58', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (7, '绿色中国守护者直推300人岗位津贴12000元/月', 300, 12000.00, 1, '2023-05-18 11:02:58', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (8, '绿色中国守护者直推350人岗位津贴14000元/月', 350, 14000.00, 1, '2023-05-18 11:02:58', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (9, '绿色中国守护者直推400人岗位津贴16000元/月', 400, 16000.00, 1, '2023-05-18 11:02:58', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (10, '绿色中国守护者直推450人岗位津贴18000元/月', 450, 18000.00, 1, '2023-05-19 09:52:11', 1, 1, '');
INSERT INTO `ntp_common_invitation` VALUES (11, '绿色中国守护者直推500人岗位津贴20000元/月', 500, 20000.00, 1, '2023-06-02 13:20:45', 7, 1, '');

-- ----------------------------
-- Table structure for ntp_common_kefu
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_kefu`;
CREATE TABLE `ntp_common_kefu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sid` int(11) NOT NULL COMMENT '绑定的业务员ID',
  `create_time` datetime NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客服表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_kefu
-- ----------------------------
INSERT INTO `ntp_common_kefu` VALUES (1, 'https://kefu.dahxn.cn', 2000, '2023-04-17 17:22:44', '1', '11111111111');
INSERT INTO `ntp_common_kefu` VALUES (4, 'https://ekf.wangzhankefu.net/web/im?cptid=2fe7cbbcc324', 0, '2023-06-08 14:09:28', '', '1231');

-- ----------------------------
-- Table structure for ntp_common_login_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_login_log`;
CREATE TABLE `ntp_common_login_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `unique` int(10) NULL DEFAULT NULL COMMENT '管理员、用户id',
  `login_type` tinyint(1) NULL DEFAULT 1 COMMENT '类型 1后台管理员 2用户 3代理',
  `login_time` datetime NULL DEFAULT NULL COMMENT '登陆时间',
  `login_ip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登陆IP',
  `login_equipment` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登陆设备',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28992 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '登陆日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_notice
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_notice`;
CREATE TABLE `ntp_common_notice`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '公告内容',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '公告状态 1上架 0下架',
  `position` tinyint(2) NULL DEFAULT NULL COMMENT '公告位置 xxx',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_common_notice
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_pay_cash
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_pay_cash`;
CREATE TABLE `ntp_common_pay_cash`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NULL DEFAULT NULL COMMENT '提现时间',
  `success_time` datetime NULL DEFAULT NULL COMMENT '到账时间（审核时间）',
  `money` decimal(20, 2) NULL DEFAULT NULL COMMENT '提现金额',
  `money_before` decimal(20, 2) NULL DEFAULT NULL COMMENT '用户开始金额',
  `money_end` decimal(20, 2) NULL DEFAULT NULL COMMENT '用户结束金额，余额',
  `money_fee` decimal(20, 2) NULL DEFAULT NULL COMMENT '手续费',
  `money_actual` decimal(20, 2) NULL DEFAULT NULL COMMENT '实际到账金额',
  `msg` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `u_id` int(10) NOT NULL COMMENT '用户ID',
  `u_ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户IP',
  `u_city` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户地区',
  `admin_uid` int(10) NULL DEFAULT NULL COMMENT '管理员ID',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态 0申请提现。1打款成功。 2拒绝',
  `pay_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `u_bank_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户收款银行名',
  `u_back_card` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户收款账号',
  `u_back_user_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户收款名',
  `market_uid` int(10) NULL DEFAULT 0 COMMENT '业务员ID',
  `trilateral_order` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '三方订单号',
  `order_on` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `is_status` tinyint(255) NOT NULL DEFAULT 0 COMMENT '1 提交到平台',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '提现表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_pay_cash
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_pay_money_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_pay_money_log`;
CREATE TABLE `ntp_common_pay_money_log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NULL DEFAULT NULL COMMENT '时间',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '类型 1收入 2支出 3后台修改金额 4提现退款',
  `status` int(3) NULL DEFAULT NULL COMMENT '详细类型 101充值  102 签到 103 用户每日收益 104 代理返佣  110 购买商品消费金额  111 购买商品消耗积分 201 提现 ',
  `money_before` decimal(30, 2) NULL DEFAULT 0.00 COMMENT '变化前金额',
  `money_end` decimal(30, 2) NULL DEFAULT 0.00 COMMENT '变化后金额',
  `money` decimal(30, 2) NULL DEFAULT NULL COMMENT '变化金额',
  `uid` int(10) NULL DEFAULT NULL COMMENT '用户ID',
  `source_id` int(10) NULL DEFAULT NULL COMMENT '源头ID',
  `market_uid` int(10) NULL DEFAULT 0 COMMENT '业务员ID',
  `mark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sel`(`create_time`, `type`, `status`, `uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 162111 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资金流水表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_pay_money_log
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_pay_recharge
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_pay_recharge`;
CREATE TABLE `ntp_common_pay_recharge`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NULL DEFAULT NULL COMMENT '充值时间',
  `success_time` datetime NULL DEFAULT NULL COMMENT '到账时间(审核时间)',
  `money` decimal(20, 2) NULL DEFAULT NULL COMMENT '充值金额',
  `admin_uid` int(10) NULL DEFAULT NULL COMMENT '管理员ID',
  `uid` int(10) NULL DEFAULT NULL COMMENT '用户ID',
  `u_ip` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户ip',
  `u_city` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区',
  `sys_bank_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款账号',
  `u_bank_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打款银行名',
  `u_bank_user_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打款用户名',
  `u_bank_card` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '打款银行卡号',
  `market_uid` int(10) NULL DEFAULT 0 COMMENT '业务员ID',
  `order_no` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值订单编号',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '充值订单状态 0创建订单  1待支付  2支付成功 3支付失败，拒绝支付',
  `trilateral_order` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '三方订单号',
  `money_end` decimal(20, 2) NULL DEFAULT NULL,
  `money_before` decimal(20, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '充值表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_pay_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_pay_sys_bank
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_pay_sys_bank`;
CREATE TABLE `ntp_common_pay_sys_bank`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行名',
  `card` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行卡号',
  `account_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户名',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态 -1删除 1正常',
  `is_default` tinyint(1) NULL DEFAULT NULL COMMENT '是否默认 1默认',
  `u_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1403 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '银行卡' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_common_pay_sys_bank
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_sys_config
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_sys_config`;
CREATE TABLE `ntp_common_sys_config`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置中文名称',
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '约束条件',
  `mark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `type` int(11) NULL DEFAULT 1 COMMENT '类型 1文字 2图片  3富文本',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sel`(`name`(191)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_common_sys_config
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_user
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_user`;
CREATE TABLE `ntp_common_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nickname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `pwd` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码 算法加密',
  `withdraw_pwd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '提现密码 默认和密码一样 base64加密',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 正常 0冻结 -1 删除',
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 在线 0 不在线',
  `head_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '头像',
  `is_real_name` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否实名 0未实名 1提交申请  2 通过申请 3拒绝申请',
  `market_uid` int(12) NOT NULL DEFAULT 0 COMMENT '业务员ID',
  `is_fictitious` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否虚拟账号 1是 0否',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号码',
  `money_freeze` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '冻结金额',
  `money_balance` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '用户余额',
  `money_integral` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '积分',
  `money_green` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '绿币',
  `money_hire` decimal(20, 2) NOT NULL DEFAULT 0.00 COMMENT '佣金。个人获得的返佣',
  `money_approve` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '可提现金额。就是 设定的 它可以提现金额',
  `admin_money_approve` decimal(12, 0) NOT NULL DEFAULT 0 COMMENT '后台增加的可提现金额',
  `money_team` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '团队佣金',
  `money_thigh` int(12) NOT NULL DEFAULT 0 COMMENT '用户股权',
  `money_vote` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '碳票',
  `money_purchase` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '购买产品的余额，可充值，手动上分',
  `money_converge` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '碳汇',
  `user_team` int(12) NOT NULL COMMENT '所属团队',
  `ip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '注册的ID地址',
  `total_withdraw` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '累计提现',
  `total_recharge` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '累计充值',
  `total_red` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '分红',
  `sfz` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '身份证号',
  `is_withdraw` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可提现。0不可 1可以',
  `agent_id_1` int(12) NOT NULL DEFAULT 0 COMMENT '1级',
  `agent_id_2` int(12) NOT NULL DEFAULT 0 COMMENT '2级',
  `agent_id_3` int(12) NOT NULL DEFAULT 0,
  `agent_id` int(12) NOT NULL DEFAULT 0 COMMENT '上级代理，防止以后用到无限级',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sel`(`user_name`, `phone`, `agent_id_1`, `agent_id_2`, `agent_id_3`, `agent_id`) USING BTREE,
  INDEX `agent_id`(`agent_id`) USING BTREE,
  INDEX `is_real_name`(`is_real_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102076 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_user
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_user_sign_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_user_sign_log`;
CREATE TABLE `ntp_common_user_sign_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `money` decimal(12, 2) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `money`(`uid`, `money`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11828 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户签到' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of ntp_common_user_sign_log
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_user_welfare_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_user_welfare_log`;
CREATE TABLE `ntp_common_user_welfare_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL DEFAULT 0 COMMENT '用户ID',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `wid` int(10) NOT NULL DEFAULT 0 COMMENT '公益文章ID',
  `amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '捐款金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `wid`(`wid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公益捐款记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_user_welfare_log
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_wares
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_wares`;
CREATE TABLE `ntp_common_wares`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wares_type_id` int(11) NOT NULL COMMENT '商品分类',
  `wares_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名称',
  `wares_money` decimal(12, 2) NOT NULL COMMENT '商品需要积分',
  `wares_spec` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品规格，大，小，',
  `head_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '商品图片',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品介绍',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 下架，1 上架',
  `sort` int(12) NOT NULL DEFAULT 0,
  `is_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 积分兑换',
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '积分兑换商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_wares
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_wares_order
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_wares_order`;
CREATE TABLE `ntp_common_wares_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wares_id` int(11) NOT NULL COMMENT '商品ID',
  `wares_type_id` int(11) NOT NULL COMMENT '分类ID',
  `wares_spec` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品规格',
  `head_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品图片',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `address_id` int(11) NOT NULL COMMENT '商品购买地址',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '购买地址',
  `wares_money` decimal(12, 2) NOT NULL COMMENT '商品价格',
  `create_time` datetime NULL DEFAULT NULL,
  `wares_no` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单号',
  `success_time` datetime NULL DEFAULT NULL COMMENT '收获成功日期',
  `status` tinyint(255) NOT NULL COMMENT '0 下单，1 发货中 2 运输中 3 签收 4 拒签 ',
  `phone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `wares_no`(`wares_no`(191)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_wares_order
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_common_welfare
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_welfare`;
CREATE TABLE `ntp_common_welfare`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `labels` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文字标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章内容',
  `img_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章封面',
  `people` int(10) NOT NULL DEFAULT 0 COMMENT '捐款人数',
  `amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '捐款总金额',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态：是否上架：0：未上架；1：已上架',
  `record_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备案编号',
  `initiate_time` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公益发起时间',
  `collection_agency` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收款机构',
  `collection_agency_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收款机构loge',
  `executing_agency` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '执行机构',
  `executing_agency_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行机构loge',
  `progress_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '公益活动详情',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE,
  INDEX `amount`(`amount`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公益文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_common_welfare
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_is_sfz
-- ----------------------------
DROP TABLE IF EXISTS `ntp_is_sfz`;
CREATE TABLE `ntp_is_sfz`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sfzcode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `se`(`sfzcode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 31078 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ntp_is_sfz
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_money_fanyong_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_money_fanyong_log`;
CREATE TABLE `ntp_money_fanyong_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID 主键 自增',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `money_amount` decimal(30, 2) NOT NULL COMMENT '返佣金额',
  `money_type` int(11) NOT NULL COMMENT '返佣类型 1一直推返佣 2二级直推返佣 3三级直推返佣',
  `money_type_text` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '返佣类型 文字',
  `is_add_to_user_account` int(11) NOT NULL COMMENT '是否已经添加到用户账户0 否 1 是',
  `remark` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '信息完整备注',
  `user_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新到用户账户时间',
  `product_id` int(11) NULL DEFAULT 0 COMMENT '产品ID',
  `product_lev` int(11) NULL DEFAULT 0 COMMENT '产品等级ID',
  `sub_id` int(11) NULL DEFAULT 0 COMMENT '下级ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sel`(`user_id`, `money_type`, `is_add_to_user_account`, `user_name`, `create_time`, `product_id`, `sub_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 317 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户返佣表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_money_fanyong_log
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_money_invitation_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_money_invitation_log`;
CREATE TABLE `ntp_money_invitation_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `number` int(11) NOT NULL COMMENT '邀请会员数量',
  `reward` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '邀请会员达标奖励',
  `grade` int(11) NOT NULL COMMENT '邀请等级',
  `status` tinyint(1) NOT NULL COMMENT '0 禁用  1启用',
  `create_time` datetime NOT NULL COMMENT '产品添加时间',
  `iid` int(11) NULL DEFAULT NULL COMMENT '领取的档次ID',
  `type` tinyint(1) NULL DEFAULT 1 COMMENT '奖励币种类型 1本地货币',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '描述',
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '邀请奖励表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_money_invitation_log
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_money_send_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_money_send_log`;
CREATE TABLE `ntp_money_send_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号 主键 自增',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_order_id` int(11) NOT NULL COMMENT '产品订单ID',
  `user_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `product_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名字',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `is_send` int(11) NOT NULL DEFAULT 0 COMMENT '发送状态0 未发送 1已发送',
  `send_money` decimal(30, 2) NOT NULL COMMENT '发送金额',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sel`(`user_id`, `product_id`, `product_order_id`, `user_name`, `create_time`, `send_time`, `is_send`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 130080 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品收益表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ntp_money_send_log
-- ----------------------------

-- ----------------------------
-- Table structure for ntp_verify
-- ----------------------------
DROP TABLE IF EXISTS `ntp_verify`;
CREATE TABLE `ntp_verify`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `verify` int(11) NOT NULL,
  `ctime` datetime NOT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 42669 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of ntp_verify
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
