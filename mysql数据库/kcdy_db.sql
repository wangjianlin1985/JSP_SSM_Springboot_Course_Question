/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : kcdy_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-07-08 14:12:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_classinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_classinfo`;
CREATE TABLE `t_classinfo` (
  `classNo` varchar(20) NOT NULL COMMENT 'classNo',
  `colleageName` varchar(20) NOT NULL COMMENT '所在学院',
  `className` varchar(20) NOT NULL COMMENT '班级名称',
  `bornDate` varchar(20) default NULL COMMENT '成立日期',
  `mainTeacher` varchar(20) NOT NULL COMMENT '班主任',
  `classMemo` varchar(800) default NULL COMMENT '班级备注',
  PRIMARY KEY  (`classNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_classinfo
-- ----------------------------
INSERT INTO `t_classinfo` VALUES ('BJ001', '计算机学院', '计算机1班', '2018-03-06', '王忠强', '测试班级');
INSERT INTO `t_classinfo` VALUES ('BJ002', '计算机学院', '计算机2班', '2018-03-21', '杨梅', '学软件的');

-- ----------------------------
-- Table structure for `t_course`
-- ----------------------------
DROP TABLE IF EXISTS `t_course`;
CREATE TABLE `t_course` (
  `courseNo` varchar(20) NOT NULL COMMENT 'courseNo',
  `courseName` varchar(60) NOT NULL COMMENT '课程名称',
  `courseDesc` varchar(8000) NOT NULL COMMENT '课程介绍',
  `courseHours` int(11) NOT NULL COMMENT '总学时',
  `courseScore` float NOT NULL COMMENT '课程学分',
  `coursePlace` varchar(20) NOT NULL COMMENT '上课教室',
  `teacherObj` varchar(30) NOT NULL COMMENT '上课老师',
  PRIMARY KEY  (`courseNo`),
  KEY `teacherObj` (`teacherObj`),
  CONSTRAINT `t_course_ibfk_1` FOREIGN KEY (`teacherObj`) REFERENCES `t_teacher` (`teacherNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_course
-- ----------------------------
INSERT INTO `t_course` VALUES ('KC001', 'HTML5网站设计', '<p>讲解怎么设计一个HTML5网站</p>', '32', '3.5', '6A-203', 'TH001');
INSERT INTO `t_course` VALUES ('KC002', '安卓手机app开发', '<p>教同学们开发手机app应用哦，包括安卓和ios的开发！</p>', '45', '4.2', '7A-102', 'TH001');

-- ----------------------------
-- Table structure for `t_courseapply`
-- ----------------------------
DROP TABLE IF EXISTS `t_courseapply`;
CREATE TABLE `t_courseapply` (
  `applyId` int(11) NOT NULL auto_increment COMMENT '申请id',
  `courseObj` varchar(20) NOT NULL COMMENT '申请课程',
  `userObj` varchar(30) NOT NULL COMMENT '申请学生',
  `applyTime` varchar(20) default NULL COMMENT '申请时间',
  `shenHeState` varchar(20) NOT NULL COMMENT '审核状态',
  `shenHeResult` varchar(800) NOT NULL COMMENT '审核说明',
  `shenHeTime` varchar(20) NOT NULL COMMENT '审核时间',
  PRIMARY KEY  (`applyId`),
  KEY `courseObj` (`courseObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_courseapply_ibfk_1` FOREIGN KEY (`courseObj`) REFERENCES `t_course` (`courseNo`),
  CONSTRAINT `t_courseapply_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_courseapply
-- ----------------------------
INSERT INTO `t_courseapply` VALUES ('2', 'KC001', 'STU001', '2018-03-31 17:59:10', '待审核', '--', '--');
INSERT INTO `t_courseapply` VALUES ('3', 'KC002', 'STU001', '2018-03-31 22:40:45', '审核通过', '还可以选我的课程哈', '2018-03-31 22:51:46');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL auto_increment COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) default NULL COMMENT '留言时间',
  `replyContent` varchar(1000) default NULL COMMENT '老师解答',
  `teacherNo` varchar(20) NOT NULL COMMENT '解答老师',
  `replyTime` varchar(20) default NULL COMMENT '解答时间',
  PRIMARY KEY  (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '老师你好，后台一般用什么开发？', '老师你好，我是一个学前端UI的，最近想转后端开发,应当学啥呢？', 'STU001', '2018-03-26 18:47:16', '--', '--', '2018-03-26 18:47:25');
INSERT INTO `t_leaveword` VALUES ('2', '老师你好', '我有问题', 'STU001', '2018-03-31 18:50:37', '啥问题呢？', 'TH001', '2018-03-31 21:57:03');
INSERT INTO `t_leaveword` VALUES ('3', '老师你好，学安卓好吗', '我要是学习app的话，他们都说学安卓入门快是这样吗？', 'STU001', '2018-03-31 22:45:48', '学安卓是用java语言，ios是oc，你们接触过java更熟悉哈！', 'TH001', '2018-03-31 22:52:08');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '课程答疑网站成立了', '<p>同学们有不懂的问题都可以来这里提问哦，有老师负责解答的呢！</p>', '2018-03-26 18:47:36');

-- ----------------------------
-- Table structure for `t_postinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_postinfo`;
CREATE TABLE `t_postinfo` (
  `postInfoId` int(11) NOT NULL auto_increment COMMENT '问题id',
  `title` varchar(80) NOT NULL COMMENT '问题标题',
  `content` varchar(5000) NOT NULL COMMENT '问题内容',
  `hitNum` int(11) NOT NULL COMMENT '浏览量',
  `userObj` varchar(30) NOT NULL COMMENT '提问人',
  `addTime` varchar(20) default NULL COMMENT '提问时间',
  PRIMARY KEY  (`postInfoId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_postinfo_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_postinfo
-- ----------------------------
INSERT INTO `t_postinfo` VALUES ('1', '网站开发好学吗？', '<p>我想学习计算机网站开发，容易吗？</p>', '7', 'STU001', '2018-03-26 18:46:51');
INSERT INTO `t_postinfo` VALUES ('2', 'aaa', '<p>bbb</p>', '0', 'STU001', '2018-03-31 18:24:02');
INSERT INTO `t_postinfo` VALUES ('3', '我还想要学习手机程序开发', '<p>目前市场上有安卓和ios两大阵营，我选哪个好呢？</p>', '7', 'STU001', '2018-03-31 22:42:11');

-- ----------------------------
-- Table structure for `t_reply`
-- ----------------------------
DROP TABLE IF EXISTS `t_reply`;
CREATE TABLE `t_reply` (
  `replyId` int(11) NOT NULL auto_increment COMMENT '回答id',
  `postInfoObj` int(11) NOT NULL COMMENT '被回问题',
  `content` varchar(2000) NOT NULL COMMENT '回答内容',
  `userObj` varchar(30) NOT NULL COMMENT '回答人',
  `replyTime` varchar(20) default NULL COMMENT '回答时间',
  PRIMARY KEY  (`replyId`),
  KEY `postInfoObj` (`postInfoObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_reply_ibfk_1` FOREIGN KEY (`postInfoObj`) REFERENCES `t_postinfo` (`postInfoId`),
  CONSTRAINT `t_reply_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_reply
-- ----------------------------
INSERT INTO `t_reply` VALUES ('1', '1', '那你要做好长期应战的准备，先从html学起', 'STU001', '2018-03-26 18:47:02');
INSERT INTO `t_reply` VALUES ('3', '3', '谁告诉我下？？？', 'STU001', '2018-03-31 22:42:58');
INSERT INTO `t_reply` VALUES ('4', '3', '我告诉你吧 学习安卓吧 入门快！', 'user2', '2018-03-31 22:43:31');

-- ----------------------------
-- Table structure for `t_teacher`
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher` (
  `teacherNo` varchar(30) NOT NULL COMMENT 'teacherNo',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '教师照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `teacherDesc` varchar(8000) NOT NULL COMMENT '教师简介',
  PRIMARY KEY  (`teacherNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teacher
-- ----------------------------
INSERT INTO `t_teacher` VALUES ('TH001', '123', '王占军', '男', '2018-03-26', 'upload/3243f70d-12f3-4958-bb58-c117d90d7664.jpg', '13808083085', 'zhanjun@163.com', '四川南充', '<p>计算机高级讲师</p>');
INSERT INTO `t_teacher` VALUES ('TH002', '123', '王旭明', '男', '2018-03-29', 'upload/6710f732-a766-4d91-9d57-0b41e5d31601.jpg', '13980830083', 'xuming@126.com', '四川攀枝花', '<p>老师上课认真负责，讲课思路清晰，对学生态度好！</p>');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `classObj` varchar(20) NOT NULL COMMENT '所在班级',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '学生照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`),
  KEY `classObj` (`classObj`),
  CONSTRAINT `t_userinfo_ibfk_1` FOREIGN KEY (`classObj`) REFERENCES `t_classinfo` (`classNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('STU001', '123', 'BJ001', '李明', '男', '2018-03-13', 'upload/b8438744-7a4b-4033-bca3-13611842c545.jpg', '13539804032', 'liming@163.com', '四川成都红星路13号', '2018-03-26 18:45:40');
INSERT INTO `t_userinfo` VALUES ('user2', '123', 'BJ002', '张晓月', '女', '2018-03-29', 'upload/a0711132-fb4b-4ed7-bc2e-ff14efd39a96.jpg', '13539804032', 'xiaoyue@163.com', '四川广安市代市镇', '2018-03-31 22:36:55');
