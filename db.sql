/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : db

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 03/06/2024 22:56:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `cno` int(0) NOT NULL AUTO_INCREMENT,
  `cname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL,
  PRIMARY KEY (`cno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, '软件工程');
INSERT INTO `course` VALUES (2, '软件测试');
INSERT INTO `course` VALUES (3, '工业互联网导论');

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`  (
  `eid` int(0) NOT NULL AUTO_INCREMENT COMMENT '考试表',
  `pname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '考试名字--2024年上半年某某考试',
  `cno` int(0) NOT NULL COMMENT '那个课程',
  `userid` int(0) NOT NULL COMMENT '出题老师id',
  `classid` int(0) NOT NULL COMMENT '班级id',
  `singlenumber` int(0) NOT NULL COMMENT '单选的题目数量',
  `singlecore` int(0) NOT NULL COMMENT '单选的题目每小题分数',
  `multiplenumber` int(0) NOT NULL COMMENT '多选的题目数量',
  `multiplecore` int(0) NOT NULL COMMENT '多选的题目每小题分数',
  `examdate` date NOT NULL COMMENT '考试开始时间',
  `examtime` date NOT NULL COMMENT '考试结束时间',
  `testtime` int(0) NOT NULL COMMENT '考试时长',
  PRIMARY KEY (`eid`) USING BTREE,
  INDEX `fk_relationship_2`(`userid`) USING BTREE,
  INDEX `fk_relationship_3`(`classid`) USING BTREE,
  INDEX `fk_relationship_4`(`cno`) USING BTREE,
  CONSTRAINT `fk_relationship_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_3` FOREIGN KEY (`classid`) REFERENCES `pjclass` (`classid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_4` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES (6, 'A', 1, 2, 1, 10, 2, 10, 5, '2019-11-15', '2025-12-04', 60);
INSERT INTO `exam` VALUES (8, 'C', 1, 2, 1, 10, 2, 5, 5, '2019-11-15', '2024-12-24', 60);
INSERT INTO `exam` VALUES (9, 'C++', 1, 2, 1, 10, 2, 5, 5, '2019-11-15', '2024-03-16', 60);
INSERT INTO `exam` VALUES (10, '计算机应用', 1, 2, 1, 10, 2, 5, 5, '2019-11-15', '2028-08-19', 60);
INSERT INTO `exam` VALUES (12, 'CB', 1, 2, 1, 10, 2, 2, 2, '2019-11-15', '2024-05-07', 60);
INSERT INTO `exam` VALUES (13, '123', 1, 2, 1, 0, 0, 2, 2, '2019-11-15', '2024-05-31', 60);
INSERT INTO `exam` VALUES (14, '软件工程导论', 1, 2, 1, 10, 5, 0, 0, '2019-11-15', '2024-06-01', 1);

-- ----------------------------
-- Table structure for paper
-- ----------------------------
DROP TABLE IF EXISTS `paper`;
CREATE TABLE `paper`  (
  `pid` int(0) NOT NULL AUTO_INCREMENT COMMENT '考卷表',
  `eid` int(0) NOT NULL COMMENT 'exam考试表id',
  `sid` int(0) NOT NULL COMMENT 'subject题库表对应的题',
  `cno` int(0) NOT NULL COMMENT 'course课程表id',
  `stype` int(0) NOT NULL COMMENT '题型单选多选',
  `scontent` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '题目',
  `sa` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '选项a的内容',
  `sb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '选项b的内容',
  `sc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '选项c的内容',
  `sd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '选项d的内容',
  `skey` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '答案',
  PRIMARY KEY (`pid`) USING BTREE,
  INDEX `fk_relationship_13`(`eid`) USING BTREE,
  INDEX `fk_relationship_14`(`sid`) USING BTREE,
  CONSTRAINT `fk_relationship_13` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_14` FOREIGN KEY (`sid`) REFERENCES `subject` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 81 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of paper
-- ----------------------------
INSERT INTO `paper` VALUES (21, 6, 4, 0, 1, '某机字长32位，其中1位符号位，31位表示尾数。若用定点小数表示，则最大正小数为', '+（1 – 2-32）', '+（1 – 2-31）', '2-32', '2-31', 'B');
INSERT INTO `paper` VALUES (22, 6, 3, 0, 1, '计算机系统中的存贮器系统是指', 'RAM存贮器', 'ROM存贮器', '主存贮器', 'cache、主存贮器和外存贮器', 'D');
INSERT INTO `paper` VALUES (23, 6, 6, 0, 1, '存储单元是指', '存放一个二进制信息位的存贮元', '存放一个机器字的所有存贮元集合', '存放一个字节的所有存贮元集合', '存放两个字节的所有存贮元集合；', 'B');
INSERT INTO `paper` VALUES (24, 6, 5, 0, 1, '算术 / 逻辑运算单元74181ALU可完成', '16种算术运算功能', '16种逻辑运算功能', '16种算术运算功能和16种逻辑运算功能', '4位乘法运算和除法运算功能', 'C');
INSERT INTO `paper` VALUES (27, 8, 9, 0, 1, 'IDEF0图不反映出系统(  )', '系统做什么', '系统功能如何实现', '系统由谁来做', '系统实现的约束条件', 'B');
INSERT INTO `paper` VALUES (28, 8, 3, 0, 1, '计算机系统中的存贮器系统是指', 'RAM存贮器', 'ROM存贮器', '主存贮器', 'cache、主存贮器和外存贮器', 'D');
INSERT INTO `paper` VALUES (29, 8, 7, 0, 1, '1.开发软件所需高成本和产品的低质量之间有着尖锐的矛盾，这种现象称做()', '软件工程.', '软件周期', '软件危机', '软件产生', 'C');
INSERT INTO `paper` VALUES (30, 8, 6, 0, 1, '存储单元是指', '存放一个二进制信息位的存贮元', '存放一个机器字的所有存贮元集合', '存放一个字节的所有存贮元集合', '存放两个字节的所有存贮元集合；', 'B');
INSERT INTO `paper` VALUES (31, 8, 10, 0, 1, '模块的内聚性最高的是', '逻辑内聚', '时间内聚', '偶然内聚', '功能内聚', 'D');
INSERT INTO `paper` VALUES (32, 8, 8, 0, 1, '研究开发所需要的成本和资源是属于可行性研究中的(  )研究的一方面。', '技术可行性', '经济可行性', '社会可行性', '法律可行性', 'B');
INSERT INTO `paper` VALUES (33, 8, 4, 0, 1, '某机字长32位，其中1位符号位，31位表示尾数。若用定点小数表示，则最大正小数为', '+（1 – 2-32）', '+（1 – 2-31）', '2-32', '2-31', 'B');
INSERT INTO `paper` VALUES (34, 8, 5, 0, 1, '算术 / 逻辑运算单元74181ALU可完成', '16种算术运算功能', '16种逻辑运算功能', '16种算术运算功能和16种逻辑运算功能', '4位乘法运算和除法运算功能', 'C');
INSERT INTO `paper` VALUES (35, 9, 4, 0, 1, '某机字长32位，其中1位符号位，31位表示尾数。若用定点小数表示，则最大正小数为', '+（1 – 2-32）', '+（1 – 2-31）', '2-32', '2-31', 'B');
INSERT INTO `paper` VALUES (36, 9, 9, 0, 1, 'IDEF0图不反映出系统(  )', '系统做什么', '系统功能如何实现', '系统由谁来做', '系统实现的约束条件', 'B');
INSERT INTO `paper` VALUES (37, 9, 3, 0, 1, '计算机系统中的存贮器系统是指', 'RAM存贮器', 'ROM存贮器', '主存贮器', 'cache、主存贮器和外存贮器', 'D');
INSERT INTO `paper` VALUES (38, 9, 5, 0, 1, '算术 / 逻辑运算单元74181ALU可完成', '16种算术运算功能', '16种逻辑运算功能', '16种算术运算功能和16种逻辑运算功能', '4位乘法运算和除法运算功能', 'C');
INSERT INTO `paper` VALUES (39, 9, 8, 0, 1, '研究开发所需要的成本和资源是属于可行性研究中的(  )研究的一方面。', '技术可行性', '经济可行性', '社会可行性', '法律可行性', 'B');
INSERT INTO `paper` VALUES (40, 9, 10, 0, 1, '模块的内聚性最高的是', '逻辑内聚', '时间内聚', '偶然内聚', '功能内聚', 'D');
INSERT INTO `paper` VALUES (41, 9, 7, 0, 1, '1.开发软件所需高成本和产品的低质量之间有着尖锐的矛盾，这种现象称做()', '软件工程.', '软件周期', '软件危机', '软件产生', 'C');
INSERT INTO `paper` VALUES (42, 9, 6, 0, 1, '存储单元是指', '存放一个二进制信息位的存贮元', '存放一个机器字的所有存贮元集合', '存放一个字节的所有存贮元集合', '存放两个字节的所有存贮元集合；', 'B');
INSERT INTO `paper` VALUES (43, 10, 4, 0, 1, '某机字长32位，其中1位符号位，31位表示尾数。若用定点小数表示，则最大正小数为', '+（1 – 2-32）', '+（1 – 2-31）', '2-32', '2-31', 'B');
INSERT INTO `paper` VALUES (44, 10, 6, 0, 1, '存储单元是指', '存放一个二进制信息位的存贮元', '存放一个机器字的所有存贮元集合', '存放一个字节的所有存贮元集合', '存放两个字节的所有存贮元集合；', 'B');
INSERT INTO `paper` VALUES (45, 10, 3, 0, 1, '计算机系统中的存贮器系统是指', 'RAM存贮器', 'ROM存贮器', '主存贮器', 'cache、主存贮器和外存贮器', 'D');
INSERT INTO `paper` VALUES (46, 10, 10, 0, 1, '模块的内聚性最高的是', '逻辑内聚', '时间内聚', '偶然内聚', '功能内聚', 'D');
INSERT INTO `paper` VALUES (47, 10, 8, 0, 1, '研究开发所需要的成本和资源是属于可行性研究中的(  )研究的一方面。', '技术可行性', '经济可行性', '社会可行性', '法律可行性', 'B');
INSERT INTO `paper` VALUES (48, 10, 7, 0, 1, '1.开发软件所需高成本和产品的低质量之间有着尖锐的矛盾，这种现象称做()', '软件工程.', '软件周期', '软件危机', '软件产生', 'C');
INSERT INTO `paper` VALUES (49, 10, 5, 0, 1, '算术 / 逻辑运算单元74181ALU可完成', '16种算术运算功能', '16种逻辑运算功能', '16种算术运算功能和16种逻辑运算功能', '4位乘法运算和除法运算功能', 'C');
INSERT INTO `paper` VALUES (50, 10, 9, 0, 1, 'IDEF0图不反映出系统(  )', '系统做什么', '系统功能如何实现', '系统由谁来做', '系统实现的约束条件', 'B');
INSERT INTO `paper` VALUES (61, 12, 6, 0, 1, '存储单元是指', '存放一个二进制信息位的存贮元', '存放一个机器字的所有存贮元集合', '存放一个字节的所有存贮元集合', '存放两个字节的所有存贮元集合；', 'B');
INSERT INTO `paper` VALUES (62, 12, 10, 0, 1, '模块的内聚性最高的是', '逻辑内聚', '时间内聚', '偶然内聚', '功能内聚', 'D');
INSERT INTO `paper` VALUES (63, 12, 8, 0, 1, '研究开发所需要的成本和资源是属于可行性研究中的(  )研究的一方面。', '技术可行性', '经济可行性', '社会可行性', '法律可行性', 'B');
INSERT INTO `paper` VALUES (64, 12, 3, 0, 1, '计算机系统中的存贮器系统是指', 'RAM存贮器', 'ROM存贮器', '主存贮器', 'cache、主存贮器和外存贮器', 'D');
INSERT INTO `paper` VALUES (65, 12, 7, 0, 1, '1.开发软件所需高成本和产品的低质量之间有着尖锐的矛盾，这种现象称做()', '软件工程.', '软件周期', '软件危机', '软件产生', 'C');
INSERT INTO `paper` VALUES (66, 12, 18, 0, 1, '20.以下哪些选项是属于内容耦合[ ]。\r\n', '一个模块直接访问另一 个模块的内部数据\r\n', '一个模块有多个入口\r\n', '一个模块不通过正常入口转到另一模块内部\r\n', '一个模块只有一个入口\r\n', 'A');
INSERT INTO `paper` VALUES (67, 12, 4, 0, 1, '某机字长32位，其中1位符号位，31位表示尾数。若用定点小数表示，则最大正小数为', '+（1 – 2-32）', '+（1 – 2-31）', '2-32', '2-31', 'B');
INSERT INTO `paper` VALUES (68, 12, 9, 0, 1, 'IDEF0图不反映出系统(  )', '系统做什么', '系统功能如何实现', '系统由谁来做', '系统实现的约束条件', 'B');
INSERT INTO `paper` VALUES (69, 12, 5, 0, 1, '算术 / 逻辑运算单元74181ALU可完成', '16种算术运算功能', '16种逻辑运算功能', '16种算术运算功能和16种逻辑运算功能', '4位乘法运算和除法运算功能', 'C');
INSERT INTO `paper` VALUES (70, 13, 19, 0, 2, '10. Jackson图中-般可能包含[ ]。\r\n', '表头', '表体', '表名', '字段名', 'ABCD');
INSERT INTO `paper` VALUES (71, 13, 11, 0, 2, '软件工程的目标有( )。', 'A.  \r\n易于维护', 'B.  \r\n低的开发成', 'C.  \r\n高性能', 'D.  \r\n短的开发期', 'ABC');
INSERT INTO `paper` VALUES (72, 14, 18, 0, 1, '20.以下哪些选项是属于内容耦合[ ]。\r\n', '一个模块直接访问另一 个模块的内部数据\r\n', '一个模块有多个入口\r\n', '一个模块不通过正常入口转到另一模块内部\r\n', '一个模块只有一个入口\r\n', 'A');
INSERT INTO `paper` VALUES (73, 14, 8, 0, 1, '研究开发所需要的成本和资源是属于可行性研究中的(  )研究的一方面。', '技术可行性', '经济可行性', '社会可行性', '法律可行性', 'B');
INSERT INTO `paper` VALUES (74, 14, 7, 0, 1, '1.开发软件所需高成本和产品的低质量之间有着尖锐的矛盾，这种现象称做()', '软件工程.', '软件周期', '软件危机', '软件产生', 'C');
INSERT INTO `paper` VALUES (75, 14, 10, 0, 1, '模块的内聚性最高的是', '逻辑内聚', '时间内聚', '偶然内聚', '功能内聚', 'D');
INSERT INTO `paper` VALUES (76, 14, 3, 0, 1, '计算机系统中的存贮器系统是指', 'RAM存贮器', 'ROM存贮器', '主存贮器', 'cache、主存贮器和外存贮器', 'D');
INSERT INTO `paper` VALUES (77, 14, 5, 0, 1, '算术 / 逻辑运算单元74181ALU可完成', '16种算术运算功能', '16种逻辑运算功能', '16种算术运算功能和16种逻辑运算功能', '4位乘法运算和除法运算功能', 'C');
INSERT INTO `paper` VALUES (78, 14, 9, 0, 1, 'IDEF0图不反映出系统(  )', '系统做什么', '系统功能如何实现', '系统由谁来做', '系统实现的约束条件', 'B');
INSERT INTO `paper` VALUES (79, 14, 4, 0, 1, '某机字长32位，其中1位符号位，31位表示尾数。若用定点小数表示，则最大正小数为', '+（1 – 2-32）', '+（1 – 2-31）', '2-32', '2-31', 'B');
INSERT INTO `paper` VALUES (80, 14, 6, 0, 1, '存储单元是指', '存放一个二进制信息位的存贮元', '存放一个机器字的所有存贮元集合', '存放一个字节的所有存贮元集合', '存放两个字节的所有存贮元集合；', 'B');

-- ----------------------------
-- Table structure for pjclass
-- ----------------------------
DROP TABLE IF EXISTS `pjclass`;
CREATE TABLE `pjclass`  (
  `classid` int(0) NOT NULL AUTO_INCREMENT,
  `classname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`classid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pjclass
-- ----------------------------
INSERT INTO `pjclass` VALUES (1, '软件17-1');
INSERT INTO `pjclass` VALUES (2, '软件17-2');
INSERT INTO `pjclass` VALUES (3, '计网17-1');
INSERT INTO `pjclass` VALUES (5, '计科20-1');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `roleid` int(0) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`roleid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '老师');
INSERT INTO `role` VALUES (2, '学生');
INSERT INTO `role` VALUES (3, '管理员');

-- ----------------------------
-- Table structure for studentexam
-- ----------------------------
DROP TABLE IF EXISTS `studentexam`;
CREATE TABLE `studentexam`  (
  `seid` int(0) NOT NULL AUTO_INCREMENT COMMENT '考生考试信息表',
  `userid` int(0) NOT NULL COMMENT '考生id',
  `classid` int(0) NOT NULL COMMENT '考生班级',
  `eid` int(0) NOT NULL COMMENT '考试id',
  `pname` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT 'paper试卷id',
  `zscore` int(0) NOT NULL COMMENT 'z分数',
  `score` int(0) NOT NULL COMMENT '分数',
  `tjtime` datetime(0) NOT NULL COMMENT '考试时间',
  PRIMARY KEY (`seid`) USING BTREE,
  INDEX `fk_relationship_6`(`userid`) USING BTREE,
  INDEX `fk_relationship_7`(`classid`) USING BTREE,
  INDEX `fk_relationship_8`(`eid`) USING BTREE,
  CONSTRAINT `fk_relationship_6` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_7` FOREIGN KEY (`classid`) REFERENCES `pjclass` (`classid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_8` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of studentexam
-- ----------------------------
INSERT INTO `studentexam` VALUES (5, 14, 1, 6, 'A', 8, 4, '2024-04-07 20:09:30');
INSERT INTO `studentexam` VALUES (6, 16, 1, 6, 'A', 8, 2, '2024-04-08 18:07:45');
INSERT INTO `studentexam` VALUES (7, 16, 1, 8, 'C', 16, 4, '2024-04-08 18:07:59');
INSERT INTO `studentexam` VALUES (8, 16, 1, 9, 'C++', 16, 10, '2024-04-08 18:08:17');
INSERT INTO `studentexam` VALUES (9, 3, 1, 6, 'A', 8, 4, '2024-05-10 22:00:23');
INSERT INTO `studentexam` VALUES (10, 16, 1, 10, '计算机应用', 16, 8, '2024-05-19 04:13:12');
INSERT INTO `studentexam` VALUES (12, 16, 1, 12, 'CB', 18, 8, '2024-05-31 16:00:04');
INSERT INTO `studentexam` VALUES (13, 16, 1, 14, '软件工程导论', 45, 0, '2024-06-01 12:05:08');

-- ----------------------------
-- Table structure for studentsubject
-- ----------------------------
DROP TABLE IF EXISTS `studentsubject`;
CREATE TABLE `studentsubject`  (
  `ssid` int(0) NOT NULL AUTO_INCREMENT COMMENT '考生对试卷答题内容表',
  `seid` int(0) NOT NULL COMMENT '哪个考试信息id',
  `userid` int(0) NOT NULL COMMENT '谁考的试，考生id',
  `eid` int(0) NOT NULL COMMENT 'exam表id。考的哪门考试',
  `sid` int(0) NOT NULL COMMENT '内容对应考库-具体的考题id',
  `studentkey` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '学生填写的答案',
  PRIMARY KEY (`ssid`) USING BTREE,
  INDEX `fk_relationship_9`(`seid`) USING BTREE,
  INDEX `fk_relationship_10`(`userid`) USING BTREE,
  INDEX `fk_relationship_11`(`eid`) USING BTREE,
  INDEX `fk_relationship_12`(`sid`) USING BTREE,
  CONSTRAINT `fk_relationship_10` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_11` FOREIGN KEY (`eid`) REFERENCES `exam` (`eid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_12` FOREIGN KEY (`sid`) REFERENCES `subject` (`sid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_relationship_9` FOREIGN KEY (`seid`) REFERENCES `studentexam` (`seid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of studentsubject
-- ----------------------------
INSERT INTO `studentsubject` VALUES (11, 5, 14, 6, 4, 'D');
INSERT INTO `studentsubject` VALUES (12, 5, 14, 6, 3, 'D');
INSERT INTO `studentsubject` VALUES (13, 5, 14, 6, 6, 'D');
INSERT INTO `studentsubject` VALUES (14, 5, 14, 6, 5, 'C');
INSERT INTO `studentsubject` VALUES (15, 6, 16, 6, 4, 'C');
INSERT INTO `studentsubject` VALUES (16, 6, 16, 6, 3, 'D');
INSERT INTO `studentsubject` VALUES (17, 6, 16, 6, 6, 'C');
INSERT INTO `studentsubject` VALUES (18, 6, 16, 6, 5, 'A');
INSERT INTO `studentsubject` VALUES (19, 7, 16, 8, 9, 'A');
INSERT INTO `studentsubject` VALUES (20, 7, 16, 8, 3, 'A');
INSERT INTO `studentsubject` VALUES (21, 7, 16, 8, 7, 'C');
INSERT INTO `studentsubject` VALUES (22, 7, 16, 8, 6, 'C');
INSERT INTO `studentsubject` VALUES (23, 7, 16, 8, 10, 'A');
INSERT INTO `studentsubject` VALUES (24, 7, 16, 8, 8, 'A');
INSERT INTO `studentsubject` VALUES (25, 7, 16, 8, 4, 'B');
INSERT INTO `studentsubject` VALUES (26, 7, 16, 8, 5, 'B');
INSERT INTO `studentsubject` VALUES (27, 8, 16, 9, 4, 'B');
INSERT INTO `studentsubject` VALUES (28, 8, 16, 9, 9, 'B');
INSERT INTO `studentsubject` VALUES (29, 8, 16, 9, 3, 'C');
INSERT INTO `studentsubject` VALUES (30, 8, 16, 9, 5, 'A');
INSERT INTO `studentsubject` VALUES (31, 8, 16, 9, 8, 'B');
INSERT INTO `studentsubject` VALUES (32, 8, 16, 9, 7, 'C');
INSERT INTO `studentsubject` VALUES (33, 8, 16, 9, 6, 'B');
INSERT INTO `studentsubject` VALUES (34, 9, 3, 6, 4, 'D');
INSERT INTO `studentsubject` VALUES (35, 9, 3, 6, 3, 'B');
INSERT INTO `studentsubject` VALUES (36, 9, 3, 6, 6, 'B');
INSERT INTO `studentsubject` VALUES (37, 9, 3, 6, 5, 'C');
INSERT INTO `studentsubject` VALUES (38, 10, 16, 10, 4, 'A');
INSERT INTO `studentsubject` VALUES (39, 10, 16, 10, 6, 'A');
INSERT INTO `studentsubject` VALUES (40, 10, 16, 10, 3, 'B');
INSERT INTO `studentsubject` VALUES (41, 10, 16, 10, 10, 'C');
INSERT INTO `studentsubject` VALUES (42, 10, 16, 10, 8, 'B');
INSERT INTO `studentsubject` VALUES (43, 10, 16, 10, 7, 'C');
INSERT INTO `studentsubject` VALUES (44, 10, 16, 10, 5, 'C');
INSERT INTO `studentsubject` VALUES (45, 10, 16, 10, 9, 'B');
INSERT INTO `studentsubject` VALUES (56, 12, 16, 12, 6, 'B');
INSERT INTO `studentsubject` VALUES (57, 12, 16, 12, 10, 'B');
INSERT INTO `studentsubject` VALUES (58, 12, 16, 12, 8, 'B');
INSERT INTO `studentsubject` VALUES (59, 12, 16, 12, 3, 'C');
INSERT INTO `studentsubject` VALUES (60, 12, 16, 12, 7, 'D');
INSERT INTO `studentsubject` VALUES (61, 12, 16, 12, 18, 'B');
INSERT INTO `studentsubject` VALUES (62, 12, 16, 12, 4, 'D');
INSERT INTO `studentsubject` VALUES (63, 12, 16, 12, 9, 'B');
INSERT INTO `studentsubject` VALUES (64, 12, 16, 12, 5, 'C');

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`  (
  `sid` int(0) NOT NULL AUTO_INCREMENT COMMENT '试题库表',
  `cno` int(0) NOT NULL COMMENT 'course表那门课',
  `stype` int(0) NOT NULL COMMENT '题型1是单选2是多选',
  `scontent` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '题目',
  `sa` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '选项a的内容',
  `sb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '选项b的内容',
  `sc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '选项c的内容',
  `sd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '选项d的内容',
  `skey` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL COMMENT '答案',
  PRIMARY KEY (`sid`) USING BTREE,
  UNIQUE INDEX `scontent`(`scontent`) USING BTREE,
  INDEX `fk_relationship_5`(`cno`) USING BTREE,
  CONSTRAINT `fk_relationship_5` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES (1, 2, 1, '软件测试的目的是(___)', '试验性运行软件', '发现软件错误', '证明软件正确', '找出软件中全部错误', 'B');
INSERT INTO `subject` VALUES (2, 2, 1, '在一个长度为n的顺序表的表尾插入一个新元素的渐进时间复杂度为', 'O (n)', 'O (1)', 'O (n2 )', 'O (log2 n)', 'A');
INSERT INTO `subject` VALUES (3, 1, 1, '计算机系统中的存贮器系统是指', 'RAM存贮器', 'ROM存贮器', '主存贮器', 'cache、主存贮器和外存贮器', 'D');
INSERT INTO `subject` VALUES (4, 1, 1, '某机字长32位，其中1位符号位，31位表示尾数。若用定点小数表示，则最大正小数为', '+（1 – 2-32）', '+（1 – 2-31）', '2-32', '2-31', 'B');
INSERT INTO `subject` VALUES (5, 1, 1, '算术 / 逻辑运算单元74181ALU可完成', '16种算术运算功能', '16种逻辑运算功能', '16种算术运算功能和16种逻辑运算功能', '4位乘法运算和除法运算功能', 'C');
INSERT INTO `subject` VALUES (6, 1, 1, '存储单元是指', '存放一个二进制信息位的存贮元', '存放一个机器字的所有存贮元集合', '存放一个字节的所有存贮元集合', '存放两个字节的所有存贮元集合；', 'B');
INSERT INTO `subject` VALUES (7, 1, 1, '1.开发软件所需高成本和产品的低质量之间有着尖锐的矛盾，这种现象称做()', '软件工程.', '软件周期', '软件危机', '软件产生', 'C');
INSERT INTO `subject` VALUES (8, 1, 1, '研究开发所需要的成本和资源是属于可行性研究中的(  )研究的一方面。', '技术可行性', '经济可行性', '社会可行性', '法律可行性', 'B');
INSERT INTO `subject` VALUES (9, 1, 1, 'IDEF0图不反映出系统(  )', '系统做什么', '系统功能如何实现', '系统由谁来做', '系统实现的约束条件', 'B');
INSERT INTO `subject` VALUES (10, 1, 1, '模块的内聚性最高的是', '逻辑内聚', '时间内聚', '偶然内聚', '功能内聚', 'D');
INSERT INTO `subject` VALUES (11, 1, 2, '软件工程的目标有( )。', 'A.  \r\n易于维护', 'B.  \r\n低的开发成', 'C.  \r\n高性能', 'D.  \r\n短的开发期', 'ABC');
INSERT INTO `subject` VALUES (18, 1, 1, '20.以下哪些选项是属于内容耦合[ ]。\r\n', '一个模块直接访问另一 个模块的内部数据\r\n', '一个模块有多个入口\r\n', '一个模块不通过正常入口转到另一模块内部\r\n', '一个模块只有一个入口\r\n', 'A');
INSERT INTO `subject` VALUES (19, 1, 2, '10. Jackson图中-般可能包含[ ]。\r\n', '表头', '表体', '表名', '字段名', 'ABCD');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `stype` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NOT NULL,
  PRIMARY KEY (`stype`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (1, '一，单选题');
INSERT INTO `type` VALUES (2, '二，多选题');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `userid` int(0) NOT NULL AUTO_INCREMENT,
  `roleid` int(0) NULL DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NULL DEFAULT NULL,
  `userpwd` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NULL DEFAULT NULL,
  `truename` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_danish_ci NULL DEFAULT NULL,
  `classid` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `fk_relationship_1`(`roleid`) USING BTREE,
  CONSTRAINT `fk_relationship_1` FOREIGN KEY (`roleid`) REFERENCES `role` (`roleid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_danish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 3, 'admin', '12345', 'admin', 1);
INSERT INTO `users` VALUES (2, 1, '0001', '12345', '王鉴', 1);
INSERT INTO `users` VALUES (3, 2, '20205457', '12345', '楠方', 1);
INSERT INTO `users` VALUES (14, 2, '20205458', '12345', '楠升', 1);
INSERT INTO `users` VALUES (15, 1, '0002', '12345', 'WJ', 1);
INSERT INTO `users` VALUES (16, 2, '20205459', '12345', '凌才琦', 1);
INSERT INTO `users` VALUES (17, 2, '20205460', '12345', '楠仁', 1);
INSERT INTO `users` VALUES (23, 1, '0003', '12345', '王虎', 1);
INSERT INTO `users` VALUES (25, 2, '20205461', '12345', '楠杏', 5);

SET FOREIGN_KEY_CHECKS = 1;
