-- MySQL dump 10.13  Distrib 5.6.24, for Win32 (x86)
--
-- Host: localhost    Database: drivedb
-- ------------------------------------------------------
-- Server version	5.6.17

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
-- Table structure for table `download_list`
--

DROP TABLE IF EXISTS `download_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `download_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(1000) NOT NULL,
  `url` text NOT NULL,
  `size` int(11) NOT NULL COMMENT 'size of file in Byte',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 = queue,\n1 = downloading,\n2 = finished,\n3 = failed',
  `progress` float NOT NULL DEFAULT '0',
  `fullpath` text,
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `download_list`
--

LOCK TABLES `download_list` WRITE;
/*!40000 ALTER TABLE `download_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `download_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `download_list_vw`
--

DROP TABLE IF EXISTS `download_list_vw`;
/*!50001 DROP VIEW IF EXISTS `download_list_vw`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `download_list_vw` AS SELECT 
 1 AS `id`,
 1 AS `user_id`,
 1 AS `name`,
 1 AS `url`,
 1 AS `size`,
 1 AS `status`,
 1 AS `progress`,
 1 AS `fullpath`,
 1 AS `is_deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `level`
--

DROP TABLE IF EXISTS `level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `quota` int(11) NOT NULL COMMENT 'default quota, dalam Byte',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;
/*!40000 ALTER TABLE `level` DISABLE KEYS */;
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `level_vw`
--

DROP TABLE IF EXISTS `level_vw`;
/*!50001 DROP VIEW IF EXISTS `level_vw`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `level_vw` AS SELECT 
 1 AS `id`,
 1 AS `name`,
 1 AS `quota`,
 1 AS `is_deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `auth_key` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `level_id` int(11) NOT NULL,
  `bonus_quota` int(11) NOT NULL DEFAULT '0' COMMENT 'bonus kuota berfungsi untuk menambah/mengurangi kuota seseorang bila terjadi sesuatu\nsatuan dalam byte',
  `is_deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_vw`
--

DROP TABLE IF EXISTS `user_vw`;
/*!50001 DROP VIEW IF EXISTS `user_vw`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `user_vw` AS SELECT 
 1 AS `id`,
 1 AS `username`,
 1 AS `password_hash`,
 1 AS `auth_key`,
 1 AS `name`,
 1 AS `level_id`,
 1 AS `bonus_quota`,
 1 AS `is_deleted`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'drivedb'
--
/*!50003 DROP FUNCTION IF EXISTS `getUserStorage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getUserStorage`(user_id INT) RETURNS int(11)
BEGIN
	DECLARE init_quota INT;
    DECLARE bonus_quota INT;
    
	SELECT l.quota INTO init_quota
    FROM level l, user u
    WHERE u.level_id = l.id
    AND u.id = user_id;
    
    
    SELECT bonus_quota INTO bonus_quota
    FROM user u
    WHERE u.id = user_id;
    
    
    
	RETURN init_quota + bonus_quota;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getUserUsage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getUserUsage`(user_id INT) RETURNS int(11)
BEGIN
	DECLARE total_usage INT;
    
    SET total_usage = 0;
    
	SELECT SUM(dl.size) INTO total_usage
    FROM download_list_vw dl, user u
    WHERE u.id = user_id
    AND dl.user_id = u.id;
    
    
    
	RETURN total_usage;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `download_list_vw`
--

/*!50001 DROP VIEW IF EXISTS `download_list_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `download_list_vw` AS select `download_list`.`id` AS `id`,`download_list`.`user_id` AS `user_id`,`download_list`.`name` AS `name`,`download_list`.`url` AS `url`,`download_list`.`size` AS `size`,`download_list`.`status` AS `status`,`download_list`.`progress` AS `progress`,`download_list`.`fullpath` AS `fullpath`,`download_list`.`is_deleted` AS `is_deleted` from `download_list` where (`download_list`.`is_deleted` <> 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `level_vw`
--

/*!50001 DROP VIEW IF EXISTS `level_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `level_vw` AS select `level`.`id` AS `id`,`level`.`name` AS `name`,`level`.`quota` AS `quota`,`level`.`is_deleted` AS `is_deleted` from `level` where (`level`.`is_deleted` <> 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_vw`
--

/*!50001 DROP VIEW IF EXISTS `user_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_vw` AS select `user`.`id` AS `id`,`user`.`username` AS `username`,`user`.`password_hash` AS `password_hash`,`user`.`auth_key` AS `auth_key`,`user`.`name` AS `name`,`user`.`level_id` AS `level_id`,`user`.`bonus_quota` AS `bonus_quota`,`user`.`is_deleted` AS `is_deleted` from `user` where (`user`.`is_deleted` <> 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-13 22:41:12
