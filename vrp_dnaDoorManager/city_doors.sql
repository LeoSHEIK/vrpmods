SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `city_doors`
-- ----------------------------
DROP TABLE IF EXISTS `city_doors`;
CREATE TABLE `city_doors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locked` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of city_doors
-- ----------------------------
INSERT INTO `city_doors` VALUES ('1', '1');
INSERT INTO `city_doors` VALUES ('2', '1');
INSERT INTO `city_doors` VALUES ('3', '1');
INSERT INTO `city_doors` VALUES ('4', '1');
INSERT INTO `city_doors` VALUES ('5', '1');
INSERT INTO `city_doors` VALUES ('6', '0');
INSERT INTO `city_doors` VALUES ('7', '0');
INSERT INTO `city_doors` VALUES ('8', '1');
INSERT INTO `city_doors` VALUES ('9', '0');
INSERT INTO `city_doors` VALUES ('10', '1');
INSERT INTO `city_doors` VALUES ('11', '0');
INSERT INTO `city_doors` VALUES ('12', '0');
INSERT INTO `city_doors` VALUES ('13', '1');
