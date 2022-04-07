CREATE DATABASE  IF NOT EXISTS `jejuair` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `jejuair`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: jejuair
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `additional_service`
--

DROP TABLE IF EXISTS `additional_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_service` (
  `Payment_id` int NOT NULL,
  `Pre_paid_baggage` tinyint(1) DEFAULT NULL,
  `Pre_ordered_meals` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Payment_id`),
  CONSTRAINT `additional_service_ibfk_1` FOREIGN KEY (`Payment_id`) REFERENCES `payment` (`Payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_service`
--

LOCK TABLES `additional_service` WRITE;
/*!40000 ALTER TABLE `additional_service` DISABLE KEYS */;
INSERT INTO `additional_service` VALUES (101,1,0),(102,0,1),(103,0,0),(104,1,1),(105,0,1);
/*!40000 ALTER TABLE `additional_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `Membership_number` int NOT NULL,
  `Name_` varchar(20) DEFAULT NULL,
  `Sex` tinyint(1) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Passport` varchar(20) DEFAULT NULL,
  `Email` varchar(20) DEFAULT NULL,
  `Phone_number` varchar(20) DEFAULT NULL,
  `ID` varchar(20) DEFAULT NULL,
  `Password_` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Membership_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (2017112173,'Park',0,24,'M101','park@gmail.com','77457429','park0417','dong256'),(2017112185,'Yang',1,24,'M202','yang@gmail.com','51172964','yang1720','Temoo'),(2017112200,'Ho',1,24,'M102','ho@gmail.com','48807780','ho1417','shin234'),(2017112205,'Jun',1,25,'M103','jun@gmail.com','26972143','jun0421','shin1'),(2017112207,'Lee',0,24,'M201','lee@gmail.com','25571649','lee0422','gun234');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `Flight_name` varchar(20) NOT NULL,
  `Origin` varchar(20) DEFAULT NULL,
  `Destination` varchar(20) DEFAULT NULL,
  `Time_` varchar(20) DEFAULT NULL,
  `Date_` date DEFAULT NULL,
  `Price` int DEFAULT NULL,
  `Remaining_seat` int DEFAULT NULL,
  PRIMARY KEY (`Flight_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES ('BO707','LA','TOK','17:00','2021-11-09',600000,98),('KE249','Jeju','ICN','11:40','2021-11-08',60000,100),('ME101','ICN','Jeju','21:00','2021-11-06',50000,99),('ND203','NY','ICN','05:30','2021-12-05',800000,99),('VD255','TOK','NY','15:20','2021-11-09',750000,98);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mileage`
--

DROP TABLE IF EXISTS `mileage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mileage` (
  `Available_mileage` int DEFAULT NULL,
  `Membership_number` int NOT NULL,
  PRIMARY KEY (`Membership_number`),
  CONSTRAINT `mileage_ibfk_1` FOREIGN KEY (`Membership_number`) REFERENCES `customer` (`Membership_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mileage`
--

LOCK TABLES `mileage` WRITE;
/*!40000 ALTER TABLE `mileage` DISABLE KEYS */;
INSERT INTO `mileage` VALUES (11675,2017112173),(250,2017112185),(5000,2017112200),(25000,2017112205),(15000,2017112207);
/*!40000 ALTER TABLE `mileage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package` (
  `Payment_id` int NOT NULL,
  `Hotel` tinyint(1) DEFAULT NULL,
  `Car_rental` tinyint(1) DEFAULT NULL,
  `Pocket_Wifi` tinyint(1) DEFAULT NULL,
  `Insurance` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`Payment_id`),
  CONSTRAINT `package_ibfk_1` FOREIGN KEY (`Payment_id`) REFERENCES `payment` (`Payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES (101,0,1,0,0),(102,1,1,1,1),(103,1,0,1,0),(104,0,0,1,0),(105,0,1,1,1);
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `Payment_id` int NOT NULL,
  `Membership_number` int NOT NULL,
  `Flight_name` varchar(20) NOT NULL,
  `Method` tinyint(1) DEFAULT NULL,
  `Amount` int DEFAULT NULL,
  `Accumulated_mileage` int DEFAULT NULL,
  PRIMARY KEY (`Payment_id`,`Membership_number`,`Flight_name`),
  KEY `Flight_name` (`Flight_name`),
  KEY `Membership_number` (`Membership_number`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`Flight_name`) REFERENCES `flight` (`Flight_name`),
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`Membership_number`) REFERENCES `customer` (`Membership_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (101,2017112173,'ME101',0,160000,1600),(102,2017112200,'ND203',0,1210000,12100),(103,2017112205,'VD255',1,950000,9500),(104,2017112207,'BO707',1,720000,7200),(105,2017112173,'BO707',0,910000,9100),(106,2017112173,'VD255',1,1167500,11675);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `Reservation_id` int NOT NULL,
  `Membership_number` int NOT NULL,
  `Payment_id` int DEFAULT NULL,
  `Flight_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Reservation_id`,`Membership_number`),
  KEY `Membership_number` (`Membership_number`),
  KEY `Payment_id` (`Payment_id`),
  KEY `Flight_name` (`Flight_name`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`Membership_number`) REFERENCES `customer` (`Membership_number`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`Payment_id`) REFERENCES `payment` (`Payment_id`),
  CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`Flight_name`) REFERENCES `flight` (`Flight_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (201,2017112173,101,'ME101'),(202,2017112200,102,'ND203'),(203,2017112205,103,'VD255'),(204,2017112207,104,'BO707'),(205,2017112173,105,'BO707'),(206,2017112173,106,'VD255');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'jejuair'
--

--
-- Dumping routines for database 'jejuair'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-19 20:58:18
