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

 Date: 27/02/2026 17:13:48
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台操作日志' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 730 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台菜单表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台确定单点登陆' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户所有上一级' ROW_FORMAT = DYNAMIC;

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
-- Table structure for ntp_common_article_type
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_article_type`;
CREATE TABLE `ntp_common_article_type`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
  `buy_num` int(11) NOT NULL DEFAULT 0 COMMENT '0无限次 可以购买次数',
  `level_vip` int(11) NOT NULL DEFAULT 0 COMMENT '可购买等级  0 随便购买',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ntp_common_goods_copy1
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_goods_copy1`;
CREATE TABLE `ntp_common_goods_copy1`  (
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
  `buy_num` int(11) NOT NULL DEFAULT 0 COMMENT '0无限次 可以购买次数',
  `level_vip` int(11) NOT NULL DEFAULT 0 COMMENT '可购买等级  0 随便购买',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目天数表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品订单表' ROW_FORMAT = Dynamic;

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
-- Table structure for ntp_common_home_token
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_home_token`;
CREATE TABLE `ntp_common_home_token`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登陆凭证',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `user_id` int(10) NULL DEFAULT NULL COMMENT '管理员ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '前台token' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '邀请奖励表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '登陆日志' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公告' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '提现表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '资金流水表' ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '银行卡' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台配置表' ROW_FORMAT = DYNAMIC;

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
  `sfz` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `is_withdraw` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可提现。0不可 1可以',
  `agent_id_1` int(12) NOT NULL DEFAULT 0 COMMENT '1级',
  `agent_id_2` int(12) NOT NULL DEFAULT 0 COMMENT '2级',
  `agent_id_3` int(12) NOT NULL DEFAULT 0,
  `agent_id` int(12) NOT NULL DEFAULT 0 COMMENT '上级代理，防止以后用到无限级',
  `level_vip` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'vip等级',
  `current_experience` int(11) NOT NULL DEFAULT 0 COMMENT '当前经验(已经获得的经验)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sel`(`user_name`, `phone`, `agent_id_1`, `agent_id_2`, `agent_id_3`, `agent_id`) USING BTREE,
  INDEX `agent_id`(`agent_id`) USING BTREE,
  INDEX `is_real_name`(`is_real_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

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
) ENGINE = MyISAM AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户签到' ROW_FORMAT = Fixed;

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
-- Table structure for ntp_common_vip
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_vip`;
CREATE TABLE `ntp_common_vip`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `experience` int(11) NOT NULL DEFAULT 0 COMMENT '需要经验',
  `vip` int(11) NOT NULL DEFAULT 0 COMMENT 'vip等级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Table structure for ntp_common_vip_log
-- ----------------------------
DROP TABLE IF EXISTS `ntp_common_vip_log`;
CREATE TABLE `ntp_common_vip_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `start_exp` int(11) NOT NULL DEFAULT 0 COMMENT '开始经验',
  `end_exp` int(11) NOT NULL DEFAULT 0 COMMENT '结束经验',
  `start_level` int(11) NOT NULL DEFAULT 0 COMMENT '开始等级',
  `end_level` int(11) NOT NULL DEFAULT 0 COMMENT '结束等级',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公益文章表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ntp_is_sfz
-- ----------------------------
DROP TABLE IF EXISTS `ntp_is_sfz`;
CREATE TABLE `ntp_is_sfz`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sfzcode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `se`(`sfzcode`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户返佣表' ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '产品收益表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ntp_verify
-- ----------------------------
DROP TABLE IF EXISTS `ntp_verify`;
CREATE TABLE `ntp_verify`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `verify` int(11) NOT NULL,
  `ctime` datetime NOT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10000 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Fixed;

SET FOREIGN_KEY_CHECKS = 1;
