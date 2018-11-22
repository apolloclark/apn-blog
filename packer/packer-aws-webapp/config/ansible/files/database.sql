-- MySQL dump 10.13  Distrib 5.6.30, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: testdb
-- ------------------------------------------------------
-- Server version	5.1.69

-- Delete any existing test-user, create them
DROP USER IF EXISTS 'test-user'@'localhost';
FLUSH PRIVILEGES;
CREATE USER 'test-user'@'localhost' IDENTIFIED BY 'H7SCw60iKG2jjW%G';
FLUSH PRIVILEGES;

-- Drop any existing testdb database
DROP DATABASE IF EXISTS testdb;
CREATE DATABASE testdb;
USE testdb;

-- Grant access to the test-user
GRANT SELECT,UPDATE,INSERT,DELETE ON *.* TO 'test-user'@'localhost';
FLUSH PRIVILEGES;



/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `account_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_email` varchar(255) NOT NULL COMMENT 'Email address of this user',
  `account_pass` varchar(32) NOT NULL COMMENT 'MD5 + Hash, encrypted password',
  `account_added` datetime NOT NULL COMMENT 'Date and time this account was added',
  `account_lastactive` datetime DEFAULT NULL COMMENT 'Date and time this account was last active.',
  `role_id` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1 COMMENT='Individual user accounts. They should be assigned to individ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES
(1,'admin@test.com','21232F297A57A5A743894A0E4A801FC3','2013-04-23 17:41:02',NULL,11),
(2,'user1@test.com','5F4DCC3B5AA765D61D8327DEB882CF99','2013-04-23 17:41:02',NULL,11),
(3,'user2@test.com','E10ADC3949BA59ABBE56E057F20F883E','2013-04-23 17:41:02',NULL,11),
(4,'user3@test.com','E99A18C428CB38D5F260853678922E03','2013-04-23 17:41:02',NULL,11),
(5,'user4@test.com','0D107D09F5BBE40CADE3DE5C71E9E9B7','2013-04-23 17:41:02',NULL,11);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `set_account_added` BEFORE INSERT ON `accounts`
FOR EACH ROW BEGIN
SET NEW.account_added = (
    SELECT NOW()
);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
