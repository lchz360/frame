-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.5.53 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win32
-- HeidiSQL 版本:                  9.5.0.5328
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 qframe.admin 结构
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `account` varchar(128) NOT NULL COMMENT '账号',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `is_disable` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '是否禁用',
  `create_time` int(10) unsigned NOT NULL COMMENT '创建日期',
  `update_time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accountUnique` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- 正在导出表  qframe.admin 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` (`id`, `account`, `password`, `name`, `is_disable`, `create_time`, `update_time`) VALUES
	(1, 'admin', '$2y$10$VsC9MW3JQBfdU.PtJCl7yePzvdx.T08EfILY12YqyfMWoYzS7KbdO', 'Shadow', 2, 1550059258, NULL),
	(2, '客服', '$2y$10$VsC9MW3JQBfdU.PtJCl7yePzvdx.T08EfILY12YqyfMWoYzS7KbdO', '客服', 2, 1550059258, NULL),
	(3, '财务', '$2y$10$VsC9MW3JQBfdU.PtJCl7yePzvdx.T08EfILY12YqyfMWoYzS7KbdO', '财务', 1, 1550059258, NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;

-- 导出  表 qframe.adminloginlog 结构
CREATE TABLE IF NOT EXISTS `adminloginlog` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `user` varchar(255) DEFAULT NULL COMMENT '登录用户',
  `ip` varchar(255) DEFAULT NULL COMMENT '登录ip',
  `port` varchar(255) DEFAULT NULL COMMENT '端口',
  `browser` varchar(255) DEFAULT NULL COMMENT '浏览器',
  `note` varchar(255) DEFAULT NULL COMMENT '注释',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '是否成功登录  0-未成功 1-成功登录',
  `create_time` datetime DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 正在导出表  qframe.adminloginlog 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `adminloginlog` DISABLE KEYS */;
INSERT INTO `adminloginlog` (`id`, `user`, `ip`, `port`, `browser`, `note`, `status`, `create_time`) VALUES
	(1, 'admin', '127.0.0.1', '80', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '登录成功！', 1, '2019-06-24 15:33:53');
/*!40000 ALTER TABLE `adminloginlog` ENABLE KEYS */;

-- 导出  表 qframe.authgroup 结构
CREATE TABLE IF NOT EXISTS `authgroup` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- 正在导出表  qframe.authgroup 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `authgroup` DISABLE KEYS */;
INSERT INTO `authgroup` (`id`, `title`, `status`, `rules`) VALUES
	(1, '管理员', 1, '1,2,19,18,17,16,5,3,22,21,20,4,25,24,23'),
	(5, '行政', 1, '6,10,13'),
	(6, '客服', 1, '1,3,6,10'),
	(8, '财务', 1, '1,4,6,13');
/*!40000 ALTER TABLE `authgroup` ENABLE KEYS */;

-- 导出  表 qframe.authgroupaccess 结构
CREATE TABLE IF NOT EXISTS `authgroupaccess` (
  `uid` int(20) unsigned NOT NULL,
  `group_id` int(20) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  UNIQUE KEY `uid_unique` (`uid`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  qframe.authgroupaccess 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `authgroupaccess` DISABLE KEYS */;
INSERT INTO `authgroupaccess` (`uid`, `group_id`) VALUES
	(1, 1),
	(2, 6),
	(3, 8);
/*!40000 ALTER TABLE `authgroupaccess` ENABLE KEYS */;

-- 导出  表 qframe.authrule 结构
CREATE TABLE IF NOT EXISTS `authrule` (
  `id` mediumint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '父级id',
  `name` varchar(80) DEFAULT NULL COMMENT '节点',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `pid` int(20) DEFAULT NULL,
  `condition` char(100) NOT NULL DEFAULT '',
  `faicon` varchar(255) DEFAULT '' COMMENT '图标',
  `sort` int(20) unsigned DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- 正在导出表  qframe.authrule 的数据：~19 rows (大约)
/*!40000 ALTER TABLE `authrule` DISABLE KEYS */;
INSERT INTO `authrule` (`id`, `name`, `title`, `type`, `status`, `pid`, `condition`, `faicon`, `sort`) VALUES
	(1, NULL, '权限管理', 1, 1, 0, '', 'glyphicon glyphicon-lock', 100),
	(2, 'admin/index', '管理员管理', 1, 1, 1, '', 'glyphicon glyphicon-home', NULL),
	(3, 'auth/group', '角色组', 1, 1, 1, '', 'fa fa-group', NULL),
	(4, 'auth/rule', '权限规则', 1, 1, 1, '', 'fa fa-bars', NULL),
	(5, 'admin/add', '管理员添加', 1, 1, 2, '', 'fa fa-list', NULL),
	(16, 'admin/edit', '编辑', 1, 1, 2, '', 'glyphicon glyphicon-edit', NULL),
	(17, 'admin/delete', '删除', 1, 1, 2, '', 'glyphicon glyphicon-trash', NULL),
	(18, 'admin/enable', '启用', 1, 1, 2, '', 'glyphicon glyphicon-check', NULL),
	(19, 'admin/disable', '禁用', 1, 1, 2, '', 'glyphicon glyphicon-remove', NULL),
	(20, 'auth/add', '添加', 1, 1, 3, '', 'glyphicon glyphicon-plus', NULL),
	(21, 'auth/edit', '编辑', 1, 1, 3, '', 'glyphicon glyphicon-edit', NULL),
	(22, 'auth/del', '删除', 1, 1, 3, '', 'glyphicon glyphicon-trash', NULL),
	(23, 'auth/addrule', '添加', 1, 1, 4, '', 'glyphicon glyphicon-plus', NULL),
	(24, 'auth/editrule', '编辑', 1, 1, 4, '', 'glyphicon glyphicon-edit', NULL),
	(25, 'auth/delrule', '删除', 1, 1, 4, '', 'glyphicon glyphicon-trash', NULL),
	(26, NULL, '会员管理', 1, 1, 0, '', 'glyphicon glyphicon-user', 300),
	(31, NULL, '系统设置', 1, 1, 0, '', 'glyphicon glyphicon-cog', 200),
	(32, 'user/index', '会员列表', 1, 1, 26, '', 'glyphicon glyphicon-menu-hamburger', 0),
	(33, 'setting/index', '系统配置列表', 1, 1, 31, '', 'glyphicon glyphicon-align-justify', NULL);
/*!40000 ALTER TABLE `authrule` ENABLE KEYS */;

-- 导出  表 qframe.dropdown 结构
CREATE TABLE IF NOT EXISTS `dropdown` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `module` varchar(30) DEFAULT NULL COMMENT '模块',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `code` int(11) DEFAULT NULL COMMENT '值',
  `val` varchar(50) DEFAULT NULL COMMENT '名称',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- 正在导出表  qframe.dropdown 的数据：~13 rows (大约)
/*!40000 ALTER TABLE `dropdown` DISABLE KEYS */;
INSERT INTO `dropdown` (`id`, `module`, `name`, `code`, `val`, `sort`) VALUES
	(1, 'isDisable', '是否禁用', 1, '禁用', 2),
	(2, 'isDisable', '是否禁用', 2, '启用', 1),
	(3, 'isDelete', '是否删除', 1, '已删除', 1),
	(4, 'isDelete', '是否删除', 2, '未删除', 2),
	(5, 'pageSize', '每页条数', 10, '10', 1),
	(6, 'pageSize', '每页条数', 20, '20', 2),
	(7, 'pageSize', '每页条数', 50, '50', 3),
	(8, 'pageSize', '每页条数', 100, '100', 4),
	(9, 'pageSize', '每页条数', 200, '200', 5),
	(10, 'pageSize', '每页条数', 500, '500', 6),
	(11, 'pageSize', '每页条数', 1000, '1000', 1000),
	(12, 'pageSize', '每页条数', 2000, '2000', 2000),
	(13, 'pageSize', '每页条数', 5000, '5000', 5000);
/*!40000 ALTER TABLE `dropdown` ENABLE KEYS */;

-- 导出  表 qframe.qtsms 结构
CREATE TABLE IF NOT EXISTS `qtsms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL COMMENT '手机号',
  `code` varchar(50) NOT NULL COMMENT '验证码',
  `ip` varchar(50) NOT NULL COMMENT '发送人ip',
  `scene` varchar(50) NOT NULL COMMENT '发送场景',
  `status` tinyint(3) NOT NULL DEFAULT '1' COMMENT '状态，1：待验证，2：已验证，3：已失效',
  `create_time` datetime NOT NULL COMMENT '发送时间',
  `end_time` datetime NOT NULL COMMENT '失效时间',
  PRIMARY KEY (`id`),
  KEY `phone_scene_status_end_time` (`phone`,`scene`,`status`,`end_time`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='短信发送记录';

-- 正在导出表  qframe.qtsms 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `qtsms` DISABLE KEYS */;
INSERT INTO `qtsms` (`id`, `phone`, `code`, `ip`, `scene`, `status`, `create_time`, `end_time`) VALUES
	(5, '15306368950', '2936', '127.0.0.1', 'login', 2, '2019-06-14 10:47:44', '2019-06-14 10:52:44'),
	(12, '15306368950', '1354', '192.168.1.104', 'login', 3, '2019-06-15 14:58:44', '2019-06-15 15:03:44'),
	(13, '15306368950', '3895', '192.168.1.104', 'login', 3, '2019-06-15 14:59:47', '2019-06-15 15:04:47'),
	(14, '15306368950', '4851', '192.168.1.104', 'login', 1, '2019-06-15 15:19:24', '2019-06-15 15:24:24');
/*!40000 ALTER TABLE `qtsms` ENABLE KEYS */;

-- 导出  表 qframe.setting 结构
CREATE TABLE IF NOT EXISTS `setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `module` varchar(50) DEFAULT NULL COMMENT '模块',
  `code` varchar(30) DEFAULT NULL COMMENT '值',
  `val` longtext COMMENT '名称',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni` (`module`,`code`),
  KEY `module` (`module`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- 正在导出表  qframe.setting 的数据：~13 rows (大约)
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` (`id`, `module`, `code`, `val`, `name`) VALUES
	(1, 'site', 'siteName', '桥通天下', '系统名称'),
	(2, 'version', 'version', '1.0.1', '版本'),
	(3, 'sms', 'key', '', '短信接口code'),
	(4, 'sms', 'tplId', '', '短信模板ID'),
	(5, 'sms', 'url', 'http://v.juhe.cn/sms/send', '短信url'),
	(6, 'wx_pay', 'appid', 'http://v.juhe.cn/sms/send', '微信app支付APPID'),
	(7, 'wx_pay', 'app_id', 'wxd9dd99130209d95c', '微信公众号支付APPID'),
	(8, 'wx_pay', 'miniapp_id', 'http://v.juhe.cn/sms/send', '微信小程序支付APPID'),
	(9, 'wx_pay', 'mch_id', '3213', '微信商户号'),
	(11, 'wx_pay', 'key', '42311', '微信秘钥'),
	(12, 'ali_pay', 'app_id', '423421', '支付宝APPID'),
	(13, 'ali_pay', 'ali_public_key', 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApmUHLdzjFw9YjO/cGUicR87BPzbzm4/4RPqHTcsITaUbEe8dUJ/0m7NmQYID4BiKsCalCdcAIi9N5UPXjuOopslSBpuJhFOvsx/4YON8l6MasCcrB/vpmMKf+gtoHg0rKQeOkvaYs5nYFthWHWBV7FVksq0LLLAzIgfklu9+5Awzw19x/6pBfjCNOdfCsD6f5peQLeNGsynjg6752jUlDXGm2oAqei4hkXkgjq94hnTxTqxtCChoRaoJ+O6sObRlXfW7yGKeEdWvUnjXTXIJ2GUAwGC8UVwA8e4WREvmLGYfUvl0WFFFF2r1EaXoc+kA8XmhaZZDTGE9gENPfCB8HwIDAQAB', '支付宝公钥'),
	(15, 'ali_pay', 'private_key', 'MIIEpgIBAAKCAQEAtpUoXI5Xcg6rGME/9HGvXWAfyk9sSrwuTdeetfKzAbPlrqTCazTni+oWodca+vw6KnsWNhyRDOTgn9hpSQN74rYfQLwKzps8ZVhloe6u5HL2XCIq4RQB92M85FKGOXhG/b9b745Harhfp+uYJLi9JYc4tq0LMjWz5EY6IpN52IxpNW8+EDzWOCKH875hPKe4EW8qcTtCJA/mIbv4XtZw9itJBQUwf0LzMZ4M5WWNcS1ZTuiUvoj0wW9rM8Mki0ZK/cQPM0xYJmyC2LZbyNGo0/T82gLxyPzII1jFV1jvtsIsVpx/VeUzd62rivXnF9918gYoeEgVYIAaxrTM87+84QIDAQABAoIBAQCwt93A9+SbeKcR5rnIFuDtN8SNRCJEk68dmLz8zlOEKmL8jmu+6A3U1lXhfxmWI9sIkuoEpdGe8UiYbhY5nS2jWTMWrOqo3oeub8iu2x5b7wmUU129TGg60cp2E4nmxguwPi71xnhJSvsKxHUV1dj9Icw6w3I6vs/G+lH6dVNRy7Fl/dpOOJXh6zWHzc08oEx3uAfuwLhBiWLWBYHMik6+axnwrclLIcUdqDzlUgP4n+IcLCasfpvR7f9AI7InSiG0VeSvdWCsILfWJFSNFzv0V0Z3GaTHi8QPobUrsf3G3oA+JBWQIMK0S9UV0OizSKv563c4KJ9VxAUnorIanJUhAoGBAOtKbd9ydZSrOhVDYyyowDESBbH5GS6lI6qW5hlPXLiex07mobF07TA03CNTJCmvhItceW2CJv6gP2mndEIEIKBz0E3S6NXBTeXKWsnZ1TqjAbRi+BNcv1pjwZ1y6mkxSW6oQea5Ta6k6UVs2A6IpYvqEWRxU9V1xC9Gi75FQuSvAoGBAManHBoF9JHehiNAeE64VWTe6eAlcdPyX3ITodN+XPjISgRnIZ+tqQcU+6mnYA6CZP3gS9H/Laft8QKe/Xsy7TFn7Hyd6yUEKFDVCEKJAodDb/6h2p35XLtqhkAmZYL3ZMJYCNTn7FL8GZCyarGjJDh6F19PkTJUr1lCly4CqftvAoGBAMWIWu24vhXuGnk3dc9MbO3FX5qmsgmDAop43PxqsEEeq90FqsG8lFRgTGArsLR+chw9qoPRPMOP7SzaNLQnmuyZzktHwcmS278LP2Uux+DOcOPsIrC+sLdGAIoaq8lcY3XPNGRrNVhlgqGSW2D4P2NTQv68VdFjaSz3YOKAa0RpAoGBALpuYFgn2KQBA0AYJBA0vKeC8FiUq6PuZhbIR+oVQCmWxqglJZAWyXfFAH3yf5p+U0tTcbSt1+ouyy3biiZR3/qq/mzhQ6okobViiHLw5DePWY7N1T7GpHma+k0/+6qShLRDLF6rHcWvpEqAttLpOXfrVP30zV4/zaRmcz0R8PbvAoGBAJH+12oZtgGloKxt8/3bJ+nrgBZzM5Cwu79Yl4OTbMOfUOue4mpyeO9u84T6rS9RHJzFqMX0eWYXG1HTYooaczeKHAnGU+LaU2MvwhylK94g/TQYaCEE46aYiTxnakMuLVAta6E+rnNyErfYLMiHtTgAr01TcaOg1U1VYO2PsZ2N', '支付宝私钥');
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;

-- 导出  表 qframe.user 结构
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- 正在导出表  qframe.user 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `name`, `password`, `create_time`, `update_time`) VALUES
	(1, 'hxc', '$2y$10$H.kbD.glAyW6q5U2K2guzOpJvpd.Bnj/gD2an.Rw9Nqwh3K9BcwJC', 0, 1557970699);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
