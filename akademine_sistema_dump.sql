-- MySQL dump 10.13  Distrib 9.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: AkademineSistema
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `destomidalykai`
--

DROP TABLE IF EXISTS `destomidalykai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destomidalykai` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `DalykoPavadinimas` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destomidalykai`
--

LOCK TABLES `destomidalykai` WRITE;
/*!40000 ALTER TABLE `destomidalykai` DISABLE KEYS */;
INSERT INTO `destomidalykai` VALUES (1,'Daugiagijis programavimas'),(2,'Saityno paslaugos'),(3,'Informacijos saugumas'),(4,'Verslo valdymo sistemos'),(5,'Kompiuteriai ir j┼│ tinklai'),(6,'Sociologija'),(7,'Duomen┼│ bazi┼│ praktika');
/*!40000 ALTER TABLE `destomidalykai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `destytojudalykai`
--

DROP TABLE IF EXISTS `destytojudalykai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destytojudalykai` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `DestytojasID` int DEFAULT NULL,
  `DalykasID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `DestytojasID` (`DestytojasID`),
  KEY `DalykasID` (`DalykasID`),
  CONSTRAINT `destytojudalykai_ibfk_1` FOREIGN KEY (`DestytojasID`) REFERENCES `naudotojai` (`ID`),
  CONSTRAINT `destytojudalykai_ibfk_2` FOREIGN KEY (`DalykasID`) REFERENCES `destomidalykai` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destytojudalykai`
--

LOCK TABLES `destytojudalykai` WRITE;
/*!40000 ALTER TABLE `destytojudalykai` DISABLE KEYS */;
/*!40000 ALTER TABLE `destytojudalykai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupesdalykai`
--

DROP TABLE IF EXISTS `grupesdalykai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupesdalykai` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `GrupeID` int DEFAULT NULL,
  `DalykasID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `GrupeID` (`GrupeID`),
  KEY `DalykasID` (`DalykasID`),
  CONSTRAINT `grupesdalykai_ibfk_1` FOREIGN KEY (`GrupeID`) REFERENCES `studentugrupes` (`ID`),
  CONSTRAINT `grupesdalykai_ibfk_2` FOREIGN KEY (`DalykasID`) REFERENCES `destomidalykai` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupesdalykai`
--

LOCK TABLES `grupesdalykai` WRITE;
/*!40000 ALTER TABLE `grupesdalykai` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupesdalykai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `naudotojai`
--

DROP TABLE IF EXISTS `naudotojai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `naudotojai` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Vardas` varchar(50) NOT NULL,
  `Pavarde` varchar(50) NOT NULL,
  `VartotojoTipas` enum('Administratorius','Destytojas','Studentas') NOT NULL,
  `PrisijungimoVardas` varchar(50) NOT NULL,
  `Slaptazodis` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PrisijungimoVardas` (`PrisijungimoVardas`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `naudotojai`
--

LOCK TABLES `naudotojai` WRITE;
/*!40000 ALTER TABLE `naudotojai` DISABLE KEYS */;
INSERT INTO `naudotojai` VALUES (1,'Petras','Petraitis','Studentas','Petras','Petras123'),(2,'Linas','Linauskas','Studentas','Linas','Linas123'),(3,'Matas','Matauskas','Studentas','Matas','Matas123'),(4,'Kazys','Kaziauskas','Destytojas','Kazys','Kazys123'),(5,'Lukas','Lukauskas','Administratorius','Admin','Admin123'),(6,'Kajus','Kajune','Studentas','Kajus','Kajus123');
/*!40000 ALTER TABLE `naudotojai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pazymiai`
--

DROP TABLE IF EXISTS `pazymiai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pazymiai` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `StudentasID` int DEFAULT NULL,
  `DalykasID` int DEFAULT NULL,
  `Pazymys` decimal(3,1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `StudentasID` (`StudentasID`),
  KEY `DalykasID` (`DalykasID`),
  CONSTRAINT `pazymiai_ibfk_1` FOREIGN KEY (`StudentasID`) REFERENCES `naudotojai` (`ID`),
  CONSTRAINT `pazymiai_ibfk_2` FOREIGN KEY (`DalykasID`) REFERENCES `destomidalykai` (`ID`),
  CONSTRAINT `pazymiai_chk_1` CHECK (((`Pazymys` >= 1) and (`Pazymys` <= 10)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pazymiai`
--

LOCK TABLES `pazymiai` WRITE;
/*!40000 ALTER TABLE `pazymiai` DISABLE KEYS */;
INSERT INTO `pazymiai` VALUES (1,6,7,8.0),(2,3,3,8.0);
/*!40000 ALTER TABLE `pazymiai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentugrupes`
--

DROP TABLE IF EXISTS `studentugrupes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentugrupes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `GrupesPavadinimas` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentugrupes`
--

LOCK TABLES `studentugrupes` WRITE;
/*!40000 ALTER TABLE `studentugrupes` DISABLE KEYS */;
/*!40000 ALTER TABLE `studentugrupes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-20 23:33:53
