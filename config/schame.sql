/*
DROP DATABASE IF EXISTS EDUSOHO;
CREATE DATABASE EDUSOHO;
USE EDUSOHO;*/


DROP TABLE IF EXISTS `NAVIGATION`;
CREATE TABLE `NAVIGATION` (
  `ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '导航ID',
  `NAME` VARCHAR(255) NOT NULL COMMENT '导航名称',
  `URL` VARCHAR(300) NOT NULL COMMENT '链接地址',
  `SEQUENCE` TINYINT(4) UNSIGNED NOT NULL COMMENT '显示顺序',
  `PID` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '父导航ID',
  `CREATETIME` VARCHAR(16) NOT NULL COMMENT '创建时间',
  `ISOPEN` TINYINT(2) NOT NULL DEFAULT '1' COMMENT '默认1，为开启',
  `ISNEWWIN` TINYINT(2) NOT NULL DEFAULT '1' COMMENT '默认为1,另开窗口',
  PRIMARY KEY  (`ID`)
)ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT='导航数据表';

DROP TABLE IF EXISTS `USER`;
CREATE TABLE `USER`(
	`ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
	`USERNAME` VARCHAR(128) NOT NULL COMMENT '用户名称',
	`PASSWORD` VARCHAR(255) NOT NULL COMMENT '用户密码',
	`NAME` VARCHAR(255) DEFAULT NULL COMMENT '用户姓名',
	`ROLE` VARCHAR(64)  DEFAULT 'STUDENT' COMMENT '用户角色',
	`SEX` CHAR(10) DEFAULT 'SCORI' COMMENT '用户性别',
	`EMAIL` VARCHAR(64) DEFAULT NULL COMMENT '用户邮件地址',
	`AVATAR` VARCHAR(255) DEFAULT '/resource/images/deault_head.png' COMMENT '用户头像',
	`LOCKED` INT(2) DEFAULT 0 COMMENT '是否被冻结',
	`CREATETIME` VARCHAR(32) NOT NULL COMMENT '用户创建时间',
	`PROMOTED`	INT(2) DEFAULT NULL COMMENT '该用户是否被推荐',
	`PROMOTEDTIME`	VARCHAR(32) DEFAULT NULL COMMENT '该用户被推荐的时间',
	PRIMARY KEY  (`ID`)
)ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT='用户信息表';

INSERT INTO `user` VALUES ('1', 'admin', '14e1b600b1fd579f47433b88e8d85291', '初始化管理员', 'SUPERADMIN','', 'admin@email.com', '/resource/images/deault_head.png', '0', NOW(),NULL,NULL);

DROP TABLE IF EXISTS `CATEGORY`;
CREATE TABLE `CATEGORY`(
	`ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
	`NAME` varchar(255) NOT NULL COMMENT '分类名称',
	`PID` int(11) unsigned NOT NULL COMMENT '分类的父分类ID',
	`SORT` int(5) DEFAULT 0 COMMENT '分类显示序号',
	`DESCRIPTION` TEXT COMMENT '分类描述',
	PRIMARY KEY  (`ID`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程分类表';

DROP TABLE IF EXISTS `LOGIN_LOG`;
CREATE TABLE `LOGIN_LOG`
(
	`ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '日志ID',
	`USERNAME` VARCHAR(128) NOT NULL COMMENT '用户名称',
	`LOGINIP`  VARCHAR(128) NOT NULL COMMENT '用户此次登录IP',
	`LOGINTIME` VARCHAR(32) NOT NULL COMMENT '用户此次登录时间',
	`LOGINRES`  INT(2) NOT NULL COMMENT '用户登录结果',
	 PRIMARY KEY  (`ID`)
)ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT='用户登录日志表';

DROP TABLE IF EXISTS `SITE`;
CREATE TABLE `SITE`
(
	`TITLE` VARCHAR(255) DEFAULT NULL COMMENT '站点名称',
	`SUBTITLE` VARCHAR(255) DEFAULT NULL COMMENT '站点副标题',
	`LOGOIMAGE` VARCHAR(128) DEFAULT NULL COMMENT 'logo图片路径',
	`ICOIMAGE` VARCHAR(128) DEFAULT NULL COMMENT 'ico图片路径',
	`ADMINEMAIL`  VARCHAR(64) DEFAULT NULL COMMENT '管理员邮件',
	`COPYRIGHT` VARCHAR(64) DEFAULT NULL COMMENT '版权方',
	`ICPNO` VARCHAR(64) DEFAULT NULL COMMENT 'icp号'
)ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT='用户登录日志表';

INSERT INTO SITE(`TITLE`,`SUBTITLE`,`LOGOIMAGE`,`ICOIMAGE`,`ADMINEMAIL`,`COPYRIGHT`,`ICPNO`)VALUES('','','','','','','');

DROP TABLE IF EXISTS `COURSE`;
CREATE TABLE `COURSE`
(
	`ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '课程ID',
	`TITLE` VARCHAR(128) NOT NULL COMMENT '课程标题',
	`SUBTITLE` VARCHAR(128) DEFAULT NULL COMMENT '课程副标题',
	`STATUS` ENUM('DRAFT','PUBLISHED','CLOSED') DEFAULT 'DRAFT' COMMENT '课程的状态',
	`TYPE` INT(11) DEFAULT NULL COMMENT '课程分类',
	`CREATETIME` VARCHAR(32) NOT NULL COMMENT '创建时间',
	`LEARNTIME` VARCHAR(10) DEFAULT NULL COMMENT '学习时长',
	`OPENLEARNER` INT(1) NOT NULL DEFAULT 0 COMMENT '显示学员的数量',
	`CREATER` INT(11) NOT NULL COMMENT '创建人的ID',
	`ABOUT` TEXT COMMENT '课程简介',
	`GOALS` TEXT COMMENT '课程目标',
	`LOGOIMAGE` VARCHAR(128) DEFAULT NULL COMMENT '课程logo图片',
	`AUDIENCES`  TEXT COMMENT '适应人群',
	`RECOMMENDED` INT(1) NOT NULL DEFAULT 0 COMMENT '是否为推荐的课程',
	`RECOMMENDEDTIME` VARCHAR(32) DEFAULT NULL COMMENT '推荐时间',
	`MAXSEQ` INT(10) NOT NULL DEFAULT 1,
	PRIMARY KEY (`ID`)
)ENGINE=INNODB DEFAULT CHARSET=UTF8 COMMENT='课程表';


DROP TABLE IF EXISTS `COURSE_CHAPTER`;
CREATE TABLE `COURSE_CHAPTER` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '课程章节ID',
  `COURSEID` INT(10) UNSIGNED NOT NULL COMMENT '章节所属课程ID',
  `TYPE` ENUM('1','2') NOT NULL DEFAULT '1' COMMENT '章节类型：1为章节，2为单元。',
  `PID` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'PARENTID大于0时为单元',
  `NUMBER` INT(10) UNSIGNED DEFAULT NULL COMMENT '章节编号',
  `SEQ` INT(10) UNSIGNED DEFAULT NULL COMMENT '章节序号',
  `TITLE` VARCHAR(255) NOT NULL COMMENT '章节名称',
  `CREATEDTIME` VARCHAR(32) NOT NULL COMMENT '章节创建时间',
  `CREATEDER` INT(10) UNSIGNED NOT NULL COMMENT '章节创建着',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS `COURSE_LESSON`;
CREATE TABLE `COURSE_LESSON`(
	`ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '课时ID',
	`COURSEID` INT(10) UNSIGNED NOT NULL COMMENT '章节所属课程ID',
	`PID` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'PARENTID大于0时为单元',
	`TITLE` VARCHAR(255) NOT NULL COMMENT '章节名称',
	`TYPE` INT(2) NOT NULL COMMENT '课时的类型：代码、MD、图文本信息',
	`CONTEXT` TEXT COMMENT '课时的内容',
	`STATUS` ENUM('published','unpublished') NOT NULL DEFAULT 'unpublished' NOT NULL COMMENT '课时的状态',
	`SUMMARY` TEXT COMMENT '摘要',
	`CREATEDTIME` VARCHAR(32) NOT NULL COMMENT '章节创建时间',
  	`CREATEDER` INT(10) UNSIGNED NOT NULL COMMENT '章节创建着',
	PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

DROP TABLE IF EXISTS `COURSE_FILE`;
CREATE TABLE `COURSE_FILE`
(
	`ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '课时文件ID',
	`COURSEID` INT(10) NOT NULL COMMENT '所属课程ID',
	`NAME` VARCHAR(255) NOT NULL COMMENT '文件名称',
	`TYPE` VARCHAR(64) NOT NULL COMMENT '文档属类',
	`FILETYPE` VARCHAR(10) NOT NULL COMMENT '文档类型',
	`CREATEDTIME` VARCHAR(32) NOT NULL COMMENT '创建时间',
	`CREATEDER` VARCHAR(100) NOT NULL COMMENT '创建着',
	`ISUSE` CHAR(1)	NOT NULL DEFAULT '0' COMMENT '是否已经使用',
	`FILESIZE` INT(11) DEFAULT '0'  COMMENT '文件大小',
	PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;