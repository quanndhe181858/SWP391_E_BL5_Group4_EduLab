CREATE DATABASE  IF NOT EXISTS `edulab` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `edulab`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: edulab
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text,
  `parent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Lập trình','Các khóa học về lập trình và phát triển phần mềm',NULL),(2,'Thiết kế','Khóa học về thiết kế đồ họa và UI/UX',NULL),(3,'Kinh doanh','Các khóa học về quản trị và phát triển kinh doanh',NULL),(4,'Marketing','Khóa học về marketing và quảng cáo',NULL),(5,'Backend Development','Phát triển phía máy chủ',1),(6,'Frontend Development','Phát triển giao diện người dùng',1),(7,'Mobile Development','Phát triển ứng dụng di động',1),(8,'UI Design','Thiết kế giao diện người dùng',2),(9,'Graphic Design','Thiết kế đồ họa',2),(10,'Maketing Basic','Khóa học về marketing và quảng cáo',4),(11,'Kinh doanh cơ bản','Các khóa học về quản trị và phát triển kinh doanh',3),(18,'Marketing con','marketing con',17);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificate`
--

DROP TABLE IF EXISTS `certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `course_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `description` text,
  `code_prefix` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  KEY `category_id` (`category_id`),
  KEY `fk_certificate_created_by` (`created_by`),
  CONSTRAINT `certificate_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `certificate_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_certificate_created_by` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificate`
--

LOCK TABLES `certificate` WRITE;
/*!40000 ALTER TABLE `certificate` DISABLE KEYS */;
INSERT INTO `certificate` VALUES (8,'Certificate of Completion',17,NULL,'Auto-generated certificate','COURSE-17','Active','2025-12-16 08:25:52',NULL),(9,'Certificate of Completion',16,NULL,'Auto-generated certificate','COURSE-16','Active','2025-12-16 08:29:07',NULL),(10,'Certificate of Completion',5,NULL,'Auto-generated certificate','COURSE-5','Active','2025-12-16 08:32:22',NULL),(11,'Certificate of Completion',13,NULL,'Auto-generated certificate','COURSE-13','Active','2025-12-16 08:34:16',NULL),(12,'Certificate of Completion',9,NULL,'Auto-generated certificate','COURSE-9','Active','2025-12-16 08:37:02',NULL),(13,'Certificate of Completion',4,NULL,'Auto-generated certificate','COURSE-4','Active','2025-12-16 08:38:27',NULL);
/*!40000 ALTER TABLE `certificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uuid` char(36) NOT NULL DEFAULT (uuid()),
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text,
  `category_id` int NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Inactive',
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_by` int DEFAULT NULL,
  `thumbnail` varchar(2000) NOT NULL DEFAULT '/media/image/default-course-image.webp',
  `hide_by_admin` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'463e2e7b-d512-11f0-acc1-088fc35948df','Java Spring Boot từ Zero đến Hero','Khóa học toàn diện về Spring Boot, từ cơ bản đến nâng cao. Học cách xây dựng RESTful API, xác thực JWT, tích hợp database, và deploy ứng dụng production-ready.',5,'Active','2025-12-09 15:18:11','2025-12-14 08:40:04',1,1,'media/image/5a0c2c9c-c72c-42d3-8552-1392758d7fe3.png',_binary '\0'),(2,'463e3249-d512-11f0-acc1-088fc35948df','Node.js & Express - Backend Master','Xây dựng backend mạnh mẽ với Node.js và Express. Học MongoDB, authentication, real-time với Socket.io, và các best practices trong phát triển API.',5,'Inactive','2025-12-09 15:18:11','2025-12-14 08:39:34',1,1,'media/image/20d2f70d-7edf-4d04-b298-eb2440ede928.webp',_binary '\0'),(3,'463e3359-d512-11f0-acc1-088fc35948df','Python Django cho Web Development','Phát triển web application với Django framework. Từ MVC pattern, ORM, authentication đến deployment trên cloud platform.',5,'Inactive','2025-12-09 15:18:11','2025-12-14 08:38:56',1,1,'media/image/721674b3-9774-4128-82d9-28b27c059408.webp',_binary '\0'),(4,'463e3402-d512-11f0-acc1-088fc35948df','React.js - Modern Web Development','Làm chủ React.js với hooks, context API, Redux, và Next.js. Xây dựng ứng dụng web hiện đại, responsive và performance cao.',6,'Active','2025-12-09 15:18:11','2025-12-10 06:05:12',1,1,'media/image/71670499-960d-4e6f-b2f0-a350c3aafed7.jfif',_binary '\0'),(5,'463e34a8-d512-11f0-acc1-088fc35948df','Vue.js Complete Guide','Học Vue.js từ cơ bản đến nâng cao. Composition API, Vuex, Vue Router, và tích hợp với backend API.',6,'Active','2025-12-09 15:18:11','2025-12-16 06:06:02',1,1,'media/image/ed412d02-3074-4150-a64b-935cf9da61e9.jfif',_binary '\0'),(6,'463e3537-d512-11f0-acc1-088fc35948df','HTML, CSS & JavaScript Fundamentals','Nền tảng vững chắc cho web development. Học HTML5, CSS3, Flexbox, Grid, và JavaScript ES6+ với các project thực tế.',6,'Inactive','2025-12-09 15:18:11','2025-12-14 08:37:23',1,1,'media/image/8a67890d-0edf-4144-ab6d-18a82c7bf347.jfif',_binary '\0'),(7,'463e35df-d512-11f0-acc1-088fc35948df','Flutter - Xây dựng App Đa nền tảng','Phát triển ứng dụng iOS và Android với Flutter. Dart programming, widget system, state management, và deploy lên store.',7,'Active','2025-12-09 15:18:11','2025-12-10 06:04:50',1,1,'media/image/757e1975-cea8-435b-be87-14e80a270467.png',_binary '\0'),(8,'463e3682-d512-11f0-acc1-088fc35948df','React Native - Mobile App Development','Tạo native mobile apps với React Native. Navigation, API integration, push notifications, và app optimization.',7,'Inactive','2025-12-09 15:18:11','2025-12-18 09:23:29',1,1,'media/image/7869aad5-9b0a-40a4-91ef-1cd0ccdb4454.jfif',_binary ''),(9,'463e372a-d512-11f0-acc1-088fc35948df','UI/UX Design Bootcamp với Figma','Thiết kế giao diện chuyên nghiệp với Figma. Từ wireframe, prototype đến handoff cho developer. Học design system và accessibility.',8,'Active','2025-12-09 15:18:11','2025-12-10 06:04:37',1,1,'media/image/7d8b590c-9505-46c5-b50e-23be3366e760.png',_binary '\0'),(10,'463e37c0-d512-11f0-acc1-088fc35948df','Adobe XD - Thiết kế UI/UX Hiện đại','Sử dụng Adobe XD để tạo mockup, prototype interactive. Học các nguyên tắc thiết kế và user research.',8,'Inactive','2025-12-09 15:18:11','2025-12-14 08:37:54',1,1,'media/image/2fec032d-46f9-4eb9-8aff-40f06e1c5479.png',_binary '\0'),(11,'463e384e-d512-11f0-acc1-088fc35948df','Adobe Photoshop từ Cơ bản đến Nâng cao','Master Photoshop cho graphic design. Layer, mask, filter, color correction, và các kỹ thuật chỉnh sửa ảnh chuyên nghiệp.',9,'Inactive','2025-12-09 15:18:11','2025-12-14 08:38:03',1,1,'media/image/598ac933-0a2c-465e-ab99-11a9568b1aa6.jpg',_binary '\0'),(12,'463e38df-d512-11f0-acc1-088fc35948df','Adobe Illustrator - Vector Graphics Master','Thiết kế vector graphics với Illustrator. Logo design, icon design, typography, và illustration techniques.',9,'Inactive','2025-12-09 15:18:11','2025-12-18 08:55:35',1,1,'media/image/fed72298-2c73-4953-9c77-4f94ded91cff.jpg',_binary '\0'),(13,'463e397b-d512-11f0-acc1-088fc35948df','Digital Marketing Mastery','Chiến lược marketing toàn diện: SEO, SEM, Social Media Marketing, Email Marketing, Analytics và conversion optimization.',10,'Active','2025-12-09 15:18:11','2025-12-10 06:03:56',1,1,'media/image/f3ece4b1-f3ba-4db8-85d5-1e1ccb946922.png',_binary '\0'),(14,'463e3a23-d512-11f0-acc1-088fc35948df','Khởi nghiệp và Quản trị Startup','Từ ý tưởng đến sản phẩm. Lean startup, business model canvas, fundraising, và growth hacking strategies.',11,'Inactive','2025-12-09 15:18:11','2025-12-14 08:38:22',1,1,'media/image/a56b86c5-e0bc-45c7-82ac-e9ae02d8f4b3.jfif',_binary '\0'),(15,'463e3ab7-d512-11f0-acc1-088fc35948df','Content Marketing & Copywriting','Viết content thu hút và chuyển đổi. Storytelling, SEO writing, social media content, và email copywriting.',10,'Active','2025-12-09 15:18:11','2025-12-14 08:36:50',1,1,'media/image/12e554e7-2c1d-45cd-9e7f-cba2a65c9104.jfif',_binary '\0'),(16,'31df04c5-d91c-11f0-a65e-b48c9d550c76','Marketing Basic','Trong khóa học này, các bạn sẽ x10 lượng tiền trong 30 phút',11,'Active','2025-12-14 18:39:16','2025-12-16 06:10:16',16,16,'media/image/f885a802-1c6f-4f28-98ef-aa0f3eb5b65b.png',_binary '\0'),(17,'dd94a02b-d91c-11f0-a65e-b48c9d550c76','Khóa học gì đó','Cách để trở nên đẹp zai trong 1 tuần',11,'Active','2025-12-14 18:44:04','2025-12-16 05:57:11',16,16,'media/image/21a467ee-936e-4d3c-af90-b2ce7a9db2fa.png',_binary '\0');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_progress`
--

DROP TABLE IF EXISTS `course_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_progress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `course_id` int NOT NULL,
  `section_id` int NOT NULL,
  `progress_percent` int NOT NULL DEFAULT '0',
  `status` varchar(50) NOT NULL DEFAULT 'InProgress',
  `last_accessed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` timestamp NULL DEFAULT NULL,
  `test_done` bit(1) DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_section` (`user_id`,`section_id`),
  KEY `course_id` (`course_id`),
  KEY `section_id` (`section_id`),
  CONSTRAINT `course_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `course_progress_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `course_progress_ibfk_3` FOREIGN KEY (`section_id`) REFERENCES `course_section` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=491 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_progress`
--

LOCK TABLES `course_progress` WRITE;
/*!40000 ALTER TABLE `course_progress` DISABLE KEYS */;
INSERT INTO `course_progress` VALUES (1,2,9,15,100,'Completed','2025-12-18 06:21:34','2025-12-18 06:18:26',_binary '\0'),(2,2,9,16,100,'Completed','2025-12-18 06:18:54','2025-12-18 06:18:52',_binary ''),(3,2,9,17,100,'Completed','2025-12-18 06:18:56','2025-12-18 06:18:56',_binary '\0'),(4,2,9,18,100,'Completed','2025-12-18 06:18:58','2025-12-18 06:18:58',_binary '\0'),(5,2,1,1,0,'InProgress','2025-12-15 18:43:27','2025-12-15 07:25:00',_binary '\0'),(6,2,1,2,0,'InProgress','2025-12-15 07:25:05','2025-12-15 07:25:05',_binary '\0'),(7,2,1,3,0,'InProgress','2025-12-15 07:25:16','2025-12-15 07:25:15',_binary '\0'),(8,2,4,6,0,'InProgress','2025-12-13 17:31:19',NULL,_binary '\0'),(9,2,4,7,0,'InProgress','2025-12-10 15:32:02',NULL,_binary '\0'),(13,2,1,4,0,'InProgress','2025-12-15 07:25:18','2025-12-15 07:25:18',_binary '\0'),(14,2,1,5,0,'InProgress','2025-12-15 07:25:25','2025-12-15 07:25:23',_binary '\0'),(19,2,4,8,0,'InProgress','2025-12-10 15:32:04',NULL,_binary '\0'),(21,2,4,9,0,'InProgress','2025-12-10 15:32:05',NULL,_binary '\0'),(62,2,13,19,100,'Completed','2025-12-18 06:34:37','2025-12-16 08:32:36',_binary '\0'),(63,2,13,20,100,'Completed','2025-12-16 08:33:28','2025-12-16 08:33:26',_binary ''),(64,2,13,21,100,'Completed','2025-12-16 08:33:31','2025-12-16 08:33:31',_binary '\0'),(69,2,13,22,100,'Completed','2025-12-16 08:33:32','2025-12-16 08:33:32',_binary '\0'),(82,2,4,10,0,'InProgress','2025-12-10 15:32:05',NULL,_binary '\0'),(83,2,15,23,0,'InProgress','2025-12-10 17:30:03','2025-12-10 15:48:21',_binary '\0'),(98,2,15,24,0,'InProgress','2025-12-10 17:30:33',NULL,_binary '\0'),(175,11,4,6,0,'InProgress','2025-12-14 18:05:44',NULL,_binary '\0'),(176,11,4,7,0,'InProgress','2025-12-14 18:05:48',NULL,_binary '\0'),(181,11,4,8,0,'InProgress','2025-12-14 18:05:54','2025-12-14 18:05:54',_binary '\0'),(182,11,4,9,0,'InProgress','2025-12-14 18:05:56','2025-12-14 18:05:56',_binary '\0'),(188,11,4,10,0,'InProgress','2025-12-14 18:05:58','2025-12-14 18:05:58',_binary '\0'),(190,11,7,11,0,'InProgress','2025-12-14 18:06:05','2025-12-14 18:06:05',_binary '\0'),(192,11,7,12,0,'InProgress','2025-12-14 18:06:07','2025-12-14 18:06:07',_binary '\0'),(194,11,7,13,0,'InProgress','2025-12-14 18:06:09','2025-12-14 18:06:09',_binary '\0'),(196,17,1,1,0,'InProgress','2025-12-14 18:06:29',NULL,_binary '\0'),(197,17,1,2,0,'InProgress','2025-12-14 18:06:33','2025-12-14 18:06:33',_binary '\0'),(199,17,1,3,0,'InProgress','2025-12-14 18:06:58',NULL,_binary '\0'),(200,17,1,4,0,'InProgress','2025-12-14 18:06:36','2025-12-14 18:06:36',_binary '\0'),(202,17,1,5,0,'InProgress','2025-12-14 18:06:57',NULL,_binary '\0'),(204,18,1,1,100,'Completed','2025-12-18 06:22:12','2025-12-18 06:22:11',_binary '\0'),(205,18,1,2,0,'InProgress','2025-12-15 07:32:57','2025-12-14 18:08:32',_binary '\0'),(207,18,1,3,0,'InProgress','2025-12-15 07:33:07','2025-12-15 07:33:06',_binary '\0'),(208,18,1,5,0,'InProgress','2025-12-15 07:33:16','2025-12-15 07:33:15',_binary '\0'),(209,18,1,4,0,'InProgress','2025-12-15 07:33:08','2025-12-14 18:08:37',_binary '\0'),(211,18,7,11,0,'InProgress','2025-12-14 18:09:04','2025-12-14 18:08:44',_binary '\0'),(213,18,7,12,0,'InProgress','2025-12-14 18:09:03','2025-12-14 18:08:46',_binary '\0'),(215,18,7,13,0,'InProgress','2025-12-14 18:09:02','2025-12-14 18:08:48',_binary '\0'),(217,18,7,14,0,'InProgress','2025-12-14 18:09:05','2025-12-14 18:09:01',_binary '\0'),(223,18,15,23,0,'InProgress','2025-12-14 18:09:38','2025-12-14 18:09:38',_binary '\0'),(225,18,15,24,0,'InProgress','2025-12-14 18:09:42','2025-12-14 18:09:42',_binary '\0'),(246,2,16,25,0,'InProgress','2025-12-15 04:22:10',NULL,_binary '\0'),(247,2,16,27,0,'InProgress','2025-12-15 04:22:11',NULL,_binary '\0'),(261,19,17,30,0,'InProgress','2025-12-15 06:54:18','2025-12-15 06:54:17',_binary '\0'),(264,19,17,31,0,'InProgress','2025-12-15 06:54:19','2025-12-15 06:54:19',_binary '\0'),(266,19,17,32,0,'InProgress','2025-12-15 06:54:21','2025-12-15 06:54:21',_binary '\0'),(268,19,17,33,0,'InProgress','2025-12-15 06:54:22','2025-12-15 06:54:22',_binary '\0'),(270,19,16,25,0,'InProgress','2025-12-15 06:55:13','2025-12-15 06:55:13',_binary '\0'),(272,19,16,26,0,'InProgress','2025-12-15 06:55:15','2025-12-15 06:55:15',_binary '\0'),(274,19,16,27,0,'InProgress','2025-12-15 06:55:17','2025-12-15 06:55:17',_binary '\0'),(276,17,17,30,100,'Completed','2025-12-16 08:27:11','2025-12-16 08:27:10',_binary '\0'),(278,17,17,31,100,'Completed','2025-12-16 08:27:12','2025-12-16 08:27:12',_binary '\0'),(280,17,17,32,100,'Completed','2025-12-16 08:27:13','2025-12-16 08:27:13',_binary '\0'),(282,17,17,33,100,'Completed','2025-12-16 08:27:21','2025-12-16 08:27:20',_binary ''),(294,19,1,1,0,'InProgress','2025-12-15 07:30:13','2025-12-15 07:30:07',_binary '\0'),(296,19,1,2,0,'InProgress','2025-12-15 07:28:11','2025-12-15 07:28:11',_binary '\0'),(299,19,1,3,0,'InProgress','2025-12-15 07:28:48','2025-12-15 07:28:42',_binary '\0'),(301,19,1,4,0,'InProgress','2025-12-15 07:30:16','2025-12-15 07:30:16',_binary '\0'),(310,19,1,5,0,'InProgress','2025-12-15 07:30:16',NULL,_binary '\0'),(311,18,17,30,0,'InProgress','2025-12-15 07:32:25',NULL,_binary '\0'),(320,2,7,11,100,'Completed','2025-12-18 06:21:48','2025-12-17 18:19:59',_binary '\0'),(321,2,7,12,100,'Completed','2025-12-17 18:20:01','2025-12-17 18:20:00',_binary '\0'),(322,2,7,13,100,'Completed','2025-12-17 18:20:03','2025-12-17 18:20:02',_binary '\0'),(323,2,7,14,100,'Completed','2025-12-17 18:20:04','2025-12-17 18:20:04',_binary '\0'),(343,17,13,19,0,'InProgress','2025-12-15 08:24:20','2025-12-15 07:53:24',_binary '\0'),(345,17,13,20,0,'InProgress','2025-12-15 07:53:25','2025-12-15 07:53:25',_binary '\0'),(347,17,13,21,0,'InProgress','2025-12-15 07:53:27','2025-12-15 07:53:27',_binary '\0'),(349,17,13,22,0,'InProgress','2025-12-15 07:53:28','2025-12-15 07:53:28',_binary '\0'),(354,20,7,11,0,'InProgress','2025-12-15 14:28:12','2025-12-15 14:28:12',_binary '\0'),(356,20,7,12,0,'InProgress','2025-12-15 14:28:14','2025-12-15 14:28:14',_binary '\0'),(358,20,7,13,0,'InProgress','2025-12-15 14:28:16','2025-12-15 14:28:16',_binary '\0'),(360,20,7,14,0,'InProgress','2025-12-15 14:28:17','2025-12-15 14:28:17',_binary '\0'),(363,20,17,30,0,'InProgress','2025-12-16 05:52:22','2025-12-16 05:52:21',_binary '\0'),(365,20,17,31,0,'InProgress','2025-12-16 05:52:23','2025-12-16 05:52:23',_binary '\0'),(367,20,16,25,100,'Completed','2025-12-16 08:30:50','2025-12-16 08:30:48',_binary ''),(369,20,16,26,100,'Completed','2025-12-16 08:30:52','2025-12-16 08:30:52',_binary '\0'),(372,2,17,30,100,'Completed','2025-12-16 08:26:08','2025-12-16 08:23:17',_binary '\0'),(374,2,17,31,100,'Completed','2025-12-16 08:23:19','2025-12-16 08:23:19',_binary '\0'),(376,2,17,32,100,'Completed','2025-12-16 08:23:21','2025-12-16 08:23:20',_binary '\0'),(378,2,17,33,100,'Completed','2025-12-16 08:23:46','2025-12-16 08:23:45',_binary ''),(389,18,16,25,100,'Completed','2025-12-16 08:28:52','2025-12-16 08:28:51',_binary ''),(392,18,16,26,100,'Completed','2025-12-16 08:28:54','2025-12-16 08:28:54',_binary '\0'),(394,18,16,27,100,'Completed','2025-12-16 08:29:00','2025-12-16 08:29:00',_binary '\0'),(400,20,16,27,100,'Completed','2025-12-16 08:30:55','2025-12-16 08:30:55',_binary '\0'),(402,2,5,34,100,'Completed','2025-12-16 08:32:29','2025-12-16 08:31:42',_binary ''),(404,2,5,35,100,'Completed','2025-12-16 08:31:49','2025-12-16 08:31:48',_binary '\0'),(416,18,9,15,100,'Completed','2025-12-16 08:37:40','2025-12-16 08:34:37',_binary '\0'),(418,18,9,16,100,'Completed','2025-12-16 08:36:44','2025-12-16 08:36:40',_binary ''),(420,18,9,17,100,'Completed','2025-12-16 08:36:46','2025-12-16 08:36:46',_binary '\0'),(422,18,9,18,100,'Completed','2025-12-16 08:36:48','2025-12-16 08:36:48',_binary '\0'),(425,18,4,6,100,'Completed','2025-12-16 08:37:46','2025-12-16 08:37:46',_binary '\0'),(427,18,4,7,100,'Completed','2025-12-16 08:37:48','2025-12-16 08:37:48',_binary '\0'),(429,18,4,8,100,'Completed','2025-12-16 08:37:50','2025-12-16 08:37:50',_binary '\0'),(431,18,4,9,100,'Completed','2025-12-16 08:38:03','2025-12-16 08:38:00',_binary ''),(433,18,4,10,100,'Completed','2025-12-16 08:38:06','2025-12-16 08:38:06',_binary '\0'),(475,18,13,19,100,'Completed','2025-12-18 06:35:07','2025-12-18 06:35:07',_binary '\0'),(477,18,13,20,100,'Completed','2025-12-18 06:35:41','2025-12-18 06:35:40',_binary ''),(479,18,13,21,100,'Completed','2025-12-18 06:35:43','2025-12-18 06:35:43',_binary '\0'),(481,18,13,22,100,'Completed','2025-12-18 06:35:46','2025-12-18 06:35:45',_binary '\0'),(483,27,13,19,100,'Completed','2025-12-18 06:38:22','2025-12-18 06:38:21',_binary '\0'),(485,27,13,20,100,'Completed','2025-12-18 06:38:35','2025-12-18 06:38:34',_binary ''),(487,27,13,21,100,'Completed','2025-12-18 06:38:44','2025-12-18 06:38:44',_binary '\0'),(489,27,13,22,100,'Completed','2025-12-18 06:38:46','2025-12-18 06:38:46',_binary '\0');
/*!40000 ALTER TABLE `course_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_section`
--

DROP TABLE IF EXISTS `course_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_section` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text,
  `content` text NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `position` int NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Inactive',
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `course_section_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_section`
--

LOCK TABLES `course_section` WRITE;
/*!40000 ALTER TABLE `course_section` DISABLE KEYS */;
INSERT INTO `course_section` VALUES (1,1,'Giới thiệu Spring Boot và Setup môi trường','Tổng quan về Spring Framework và Spring Boot, cài đặt JDK, IDE, Maven','# Chào mừng đến với khóa học Spring Boot\n\nTrong phần này, bạn sẽ học:\n- Spring Framework là gì và tại sao nên dùng Spring Boot\n- Cài đặt Java JDK 17+\n- Setup IntelliJ IDEA hoặc Eclipse\n- Tạo project đầu tiên với Spring Initializr\n- Hiểu cấu trúc project Spring Boot\n\nSpring Boot giúp đơn giản hóa việc phát triển ứng dụng Spring, loại bỏ nhiều configuration phức tạp.','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(2,1,'Video hướng dẫn Setup Spring Boot Project','Video chi tiết setup môi trường và tạo project đầu tiên','https://www.youtube.com/embed/9SGDpanrc8U','video',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(3,1,'Spring Boot Architecture và Annotations','Hiểu về kiến trúc và các annotation quan trọng','# Spring Boot Architecture\n\n**Các annotation cơ bản:**\n- @SpringBootApplication\n- @RestController\n- @RequestMapping\n- @Autowired\n- @Component, @Service, @Repository\n\n**Dependency Injection và IoC Container:**\nSpring Boot sử dụng Inversion of Control để quản lý dependencies. IoC Container chịu trách nhiệm tạo và quản lý lifecycle của beans.','text',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(4,1,'Xây dựng RESTful API đầu tiên','Tạo CRUD API với Spring Boot','# Xây dựng REST API\n\nTạo một API đơn giản để quản lý Products:\n- GET /api/products - Lấy danh sách\n- GET /api/products/{id} - Lấy chi tiết\n- POST /api/products - Tạo mới\n- PUT /api/products/{id} - Cập nhật\n- DELETE /api/products/{id} - Xóa\n\nSử dụng @RestController và @RequestMapping để định nghĩa endpoints.','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(5,1,'Kết nối Database với Spring Data JPA','Tích hợp MySQL/PostgreSQL và sử dụng JPA','# Spring Data JPA\n\n**Entity và Repository:**\n- Tạo Entity class với @Entity\n- Định nghĩa Repository interface extends JpaRepository\n- Sử dụng các method có sẵn: save(), findById(), findAll(), delete()\n\n**Configuration:**\n```properties\nspring.datasource.url=jdbc:mysql://localhost:3306/edulab\nspring.datasource.username=root\nspring.datasource.password=your_password\nspring.jpa.hibernate.ddl-auto=update\n```','text',5,'Active','2025-12-09 15:18:11',NULL,1,NULL),(6,4,'React Fundamentals - JSX và Components','Học về JSX syntax và cách tạo components','# React Fundamentals\n\n**JSX - JavaScript XML:**\nJSX cho phép viết HTML trong JavaScript. Nó được Babel compile thành React.createElement() calls.\n\n```jsx\nconst element = <h1>Hello, React!</h1>;\n```\n\n**Components:**\n- Function Components (recommended)\n- Class Components (legacy)\n\n```jsx\nfunction Welcome(props) {\n  return <h1>Hello, {props.name}</h1>;\n}\n```','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(7,4,'React Hooks - useState và useEffect','Quản lý state và side effects','# React Hooks\n\n**useState:**\n```jsx\nconst [count, setCount] = useState(0);\n```\n\n**useEffect:**\n```jsx\nuseEffect(() => {\n  // Effect code\n  return () => {\n    // Cleanup\n  };\n}, [dependencies]);\n```\n\nHooks cho phép sử dụng state và lifecycle trong function components.','text',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(8,4,'Demo: Build Todo App với React','Xây dựng ứng dụng Todo hoàn chỉnh','https://www.youtube.com/embed/hQAHSlTtcmY','video',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(9,4,'React Router - Navigation và Routing','Xây dựng multi-page application','# React Router\n\n```jsx\nimport { BrowserRouter, Routes, Route } from \"react-router-dom\";\n\nfunction App() {\n  return (\n    <BrowserRouter>\n      <Routes>\n        <Route path=\"/\" element={<Home />} />\n        <Route path=\"/about\" element={<About />} />\n        <Route path=\"/products/:id\" element={<Product />} />\n      </Routes>\n    </BrowserRouter>\n  );\n}\n```','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(10,4,'State Management với Redux Toolkit','Quản lý global state hiệu quả','# Redux Toolkit\n\n**Store Setup:**\n```jsx\nimport { configureStore } from \"@reduxjs/toolkit\";\nimport counterReducer from \"./counterSlice\";\n\nexport const store = configureStore({\n  reducer: {\n    counter: counterReducer,\n  },\n});\n```\n\nRedux Toolkit đơn giản hóa việc setup và sử dụng Redux.','text',5,'Active','2025-12-09 15:18:11',NULL,1,NULL),(11,7,'Dart Programming Basics','Ngôn ngữ Dart cho Flutter development','# Dart Programming\n\n**Variables và Types:**\n```dart\nvar name = \"Flutter\";\nint age = 5;\ndouble price = 99.99;\nbool isActive = true;\n```\n\n**Functions:**\n```dart\nint add(int a, int b) {\n  return a + b;\n}\n```\n\n**Classes:**\n```dart\nclass Person {\n  String name;\n  int age;\n  \n  Person(this.name, this.age);\n}\n```','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(12,7,'Flutter Widgets - Building UI','StatelessWidget và StatefulWidget','# Flutter Widgets\n\n**StatelessWidget:**\n```dart\nclass MyApp extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return MaterialApp(\n      home: Scaffold(\n        appBar: AppBar(title: Text(\"My App\")),\n        body: Center(child: Text(\"Hello Flutter\")),\n      ),\n    );\n  }\n}\n```\n\n**Common Widgets:**\n- Container, Row, Column\n- Text, Image, Icon\n- Button, TextField\n- ListView, GridView','text',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(13,7,'Flutter Layouts và Navigation','Xây dựng giao diện và điều hướng màn hình','https://www.youtube.com/embed/1xipg02Wu8s','video',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(14,7,'State Management với Provider','Quản lý state trong Flutter app','# Provider Pattern\n\n```dart\nclass CounterModel extends ChangeNotifier {\n  int _count = 0;\n  int get count => _count;\n  \n  void increment() {\n    _count++;\n    notifyListeners();\n  }\n}\n\n// Usage\nProvider.of<CounterModel>(context).increment();\n```','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(15,9,'UI/UX Design Principles','Các nguyên tắc thiết kế cơ bản','# Design Principles\n\n**1. Visual Hierarchy:**\n- Size, color, contrast\n- Typography scale\n- Spacing và alignment\n\n**2. Consistency:**\n- Design system\n- Component library\n- Style guide\n\n**3. User-Centered Design:**\n- User research\n- Personas\n- User journey mapping\n\n**4. Accessibility:**\n- Color contrast (WCAG)\n- Keyboard navigation\n- Screen reader support','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(16,9,'Figma Basics - Interface và Tools','Làm quen với Figma workspace','https://www.youtube.com/embed/FTFaQWZBqQ8','video',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(17,9,'Wireframing và Prototyping','Từ sketch đến interactive prototype','# Wireframe to Prototype\n\n**Low-fidelity Wireframes:**\n- Sketch layout structure\n- Define information architecture\n- Focus on functionality\n\n**High-fidelity Mockups:**\n- Add visual design\n- Typography và color\n- Images và content\n\n**Interactive Prototype:**\n- Connect frames\n- Add interactions\n- Test user flow','text',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(18,9,'Design System và Component Library','Xây dựng hệ thống thiết kế nhất quán','# Design System\n\n**Components:**\n- Buttons (primary, secondary, text)\n- Input fields\n- Cards\n- Navigation\n- Modals\n\n**Tokens:**\n- Colors (primary, secondary, neutral)\n- Typography (headings, body, caption)\n- Spacing (4px, 8px, 16px, 24px...)\n- Border radius\n- Shadows','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(19,13,'Digital Marketing Overview','Tổng quan về marketing số','# Digital Marketing Channels\n\n**1. SEO (Search Engine Optimization):**\n- On-page SEO\n- Off-page SEO\n- Technical SEO\n\n**2. SEM (Search Engine Marketing):**\n- Google Ads\n- Bing Ads\n- PPC campaigns\n\n**3. Social Media Marketing:**\n- Facebook/Instagram Ads\n- LinkedIn Marketing\n- TikTok Marketing\n\n**4. Email Marketing:**\n- Newsletter campaigns\n- Automation workflows\n- Segmentation\n\n**5. Content Marketing:**\n- Blog posts\n- Videos\n- Infographics','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(20,13,'SEO Fundamentals','Tối ưu hóa công cụ tìm kiếm','# SEO Basics\n\n**Keyword Research:**\n- Google Keyword Planner\n- Search volume và competition\n- Long-tail keywords\n\n**On-Page SEO:**\n- Title tags và meta descriptions\n- Header tags (H1, H2, H3)\n- Internal linking\n- Image alt text\n\n**Content Optimization:**\n- Quality content\n- User intent\n- Readability\n- Freshness','text',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(21,13,'Google Ads Campaign Setup','Chạy quảng cáo Google hiệu quả','https://www.youtube.com/embed/jS-wGmNV0o8','video',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(22,13,'Social Media Strategy','Xây dựng chiến lược mạng xã hội','# Social Media Strategy\n\n**Platform Selection:**\n- Demographics của từng platform\n- Business goals\n- Content type\n\n**Content Calendar:**\n- Planning posts\n- Consistency\n- Engagement timing\n\n**Metrics to Track:**\n- Reach và impressions\n- Engagement rate\n- Click-through rate\n- Conversions','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(23,15,'test','test','test','text',1,'Active',NULL,NULL,1,NULL),(24,15,'test','test','test','video',2,'Active',NULL,NULL,1,1),(25,16,'HDPE cơ bản','Muối bỏ biển thôi','10 tỷ đầu tư HDPE thì ngon luôn','text',1,'Active',NULL,NULL,16,16),(26,16,'HDPE nâng cao','20 tỷ đầu tư gì?','HDPE nâng cao','image',2,'Active',NULL,NULL,16,16),(27,16,'lkasjdlkjasd','đâsd','djkashdjkashjkd','text',3,'Active',NULL,'2025-12-16 05:50:39',16,NULL),(30,17,'section','klajsdkl','ádasd','text',1,'Active',NULL,'2025-12-16 05:56:39',16,16),(31,17,'dákdhjjkasd','ádjkashdjk','ádasd','text',2,'Active',NULL,NULL,16,16),(32,17,'sicalo','ádasd','ádasd','text',3,'Active',NULL,'2025-12-16 05:50:39',16,16),(33,17,'abc','ádasd','ádasd','text',4,'Active',NULL,'2025-12-16 05:50:39',16,NULL),(34,5,'BEGINNER','BEGINNERBEGINNERBEGINNER','bắt đầu khóa học','image',6,'Active',NULL,NULL,1,NULL),(35,5,'bài 2','bài 2bài 2bài 2bài 2','bài 2bài 2bài 2bài 2bài 2','text',6,'Active',NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `course_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment` (
  `course_id` int NOT NULL,
  `user_id` int NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT (_utf8mb4'Enrolled'),
  PRIMARY KEY (`course_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES (1,2,'Learning'),(1,17,'Learning'),(1,18,'Learning'),(1,19,'Learning'),(2,2,'Learning'),(3,2,'Learning'),(4,2,'Learning'),(4,11,'Learning'),(4,18,'Completed'),(5,2,'Completed'),(7,2,'Learning'),(7,11,'Learning'),(7,18,'Learning'),(7,20,'Learning'),(9,2,'Learning'),(9,18,'Completed'),(13,2,'Completed'),(13,17,'Learning'),(13,18,'Completed'),(13,27,'Completed'),(15,2,'Learning'),(15,18,'Learning'),(16,2,'Learning'),(16,18,'Completed'),(16,19,'Learning'),(16,20,'Completed'),(17,2,'Completed'),(17,17,'Completed'),(17,18,'Learning'),(17,19,'Learning'),(17,20,'Learning');
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `objectId` int NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `mime_type` varchar(20) DEFAULT NULL,
  `path` text NOT NULL,
  `created_at` timestamp NULL DEFAULT (now()),
  `created_by` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,'course','image/jpeg','media/image/spring-boot-course.jpg','2025-12-09 15:18:11',1),(2,2,'course','image/jpeg','media/image/nodejs-course.jpg','2025-12-09 15:18:11',1),(3,3,'course','image/jpeg','media/image/django-course.jpg','2025-12-09 15:18:11',1),(4,4,'course','image/jpeg','media/image/react-course.jpg','2025-12-09 15:18:11',1),(5,5,'course','image/jpeg','media/image/vue-course.jpg','2025-12-09 15:18:11',1),(6,6,'course','image/jpeg','media/image/html-css-js.jpg','2025-12-09 15:18:11',1),(7,7,'course','image/jpeg','media/image/flutter-course.jpg','2025-12-09 15:18:11',1),(8,8,'course','image/jpeg','media/image/react-native-course.jpg','2025-12-09 15:18:11',1),(9,9,'course','image/jpeg','media/image/figma-course.jpg','2025-12-09 15:18:11',1),(10,10,'course','image/jpeg','media/image/adobe-xd-course.jpg','2025-12-09 15:18:11',1),(11,11,'course','image/jpeg','media/image/photoshop-course.jpg','2025-12-09 15:18:11',1),(12,12,'course','image/jpeg','media/image/illustrator-course.jpg','2025-12-09 15:18:11',1),(13,13,'course','image/jpeg','media/image/digital-marketing.jpg','2025-12-09 15:18:11',1),(14,14,'course','image/jpeg','media/image/startup-course.jpg','2025-12-09 15:18:11',1),(15,15,'course','image/jpeg','media/image/copywriting-course.jpg','2025-12-09 15:18:11',1),(17,1,'user',NULL,'media/avatar/2cb03c21-b99d-4718-97d0-b51466afcd35.jpeg','2025-12-13 07:41:30',1),(19,3,'user',NULL,'media/avatar/64585b50-cd16-4e93-b3a5-c481776d9a70.jpg','2025-12-15 05:54:18',0),(20,18,'user',NULL,'media/avatar/e8135065-78b3-4f88-bb3c-1cd7e2bd690e.jpg','2025-12-15 08:03:02',0),(21,34,'section',NULL,'media/image/ab02d179-4154-4574-a9f7-238314684929.png','2025-12-16 06:05:32',0),(22,26,'section',NULL,'media/image/91142eca-b4a0-4a69-a6fb-5b962821ce0e.png','2025-12-16 08:30:20',0),(23,0,'user',NULL,'https://lh3.googleusercontent.com/a/ACg8ocK6MEYgQolPZTrl8XDxqx60IOXWnS1-T0jFXFkxf8ddwcJMhQ=s100','2025-12-17 06:28:28',0),(24,0,'user',NULL,'https://lh3.googleusercontent.com/a/ACg8ocJv1IfjHZa4reI9R0FWr9rKpzgwVX1vYInebDua1aS6SvCIxw=s100','2025-12-17 06:33:56',0),(25,0,'user',NULL,'https://lh3.googleusercontent.com/a/ACg8ocJjPUWCWU_lZW-n31q3aH41Vag3P-_7Mzo3M7EDitNo0FLFkg=s100','2025-12-17 06:42:00',0),(26,0,'user',NULL,'https://lh3.googleusercontent.com/a/ACg8ocJjPUWCWU_lZW-n31q3aH41Vag3P-_7Mzo3M7EDitNo0FLFkg=s100','2025-12-17 06:42:33',0),(27,2,'user',NULL,'media/avatar/3bbfab15-e877-49d6-81ac-0227f34b4190.jpg','2025-12-17 07:18:09',0),(28,0,'user',NULL,'https://lh3.googleusercontent.com/a/ACg8ocL3DcSvcZUzZ-M4QNmEkqkkdh7uA7HdTl3k1Qk8mFlcCE0nkmw=s100','2025-12-17 18:35:24',0),(29,0,'user',NULL,'https://lh3.googleusercontent.com/a/ACg8ocL3DcSvcZUzZ-M4QNmEkqkkdh7uA7HdTl3k1Qk8mFlcCE0nkmw=s100','2025-12-18 06:59:27',0),(30,24,'section',NULL,'media/video/9f6ad366-2d26-4f14-8e96-63ffd1a8ec13.mp4','2025-12-18 08:49:42',0);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` text NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `category_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_by` int NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (20,'Trong lập trình hướng đối tượng (OOP), \"encapsulation\" (đóng gói) chủ yếu nhằm mục đích gì?','Single Choice',1,'2025-12-16 07:41:19','2025-12-17 16:26:06',1,1,'Active'),(21,'Chọn tất cả các ví dụ đúng về cấu trúc điều khiển trong lập trình:','Multiple Choice',1,'2025-12-16 07:41:19','2025-12-17 15:50:28',1,1,'Active'),(22,'Trong Git, lệnh nào dùng để tải (download) các commit mới từ remote về local nhưng KHÔNG tự động merge?','Single Choice',1,'2025-12-16 07:41:19',NULL,1,1,'Active'),(23,'Những yếu tố nào thường được xem là \"best practices\" để viết code dễ bảo trì?','Multiple Choice',1,'2025-12-16 07:41:19',NULL,1,1,'Active'),(24,'Độ phức tạp thời gian của tìm kiếm tuyến tính (linear search) trên mảng có n phần tử là:','Single Choice',1,'2025-12-16 07:41:19',NULL,1,1,'Active'),(25,'Chọn các ngôn ngữ thường dùng để phát triển ứng dụng backend/web:','Multiple Choice',1,'2025-12-16 07:41:19',NULL,1,1,'Active'),(26,'Trong thiết kế UI/UX, \"wireframe\" thường dùng để làm gì?','Single Choice',2,'2025-12-16 07:41:19',NULL,1,1,'Active'),(27,'Chọn các nguyên tắc thiết kế giúp tăng tính dễ đọc (readability):','Multiple Choice',2,'2025-12-16 07:41:19',NULL,1,1,'Active'),(28,'Trong thiết kế, hệ màu RGB phù hợp nhất cho:','Single Choice',2,'2025-12-16 07:41:19','2025-12-17 15:49:06',1,1,'Active'),(29,'Những công cụ nào thường được dùng để thiết kế UI/UX và prototype?','Multiple Choice',2,'2025-12-16 07:41:19',NULL,1,1,'Active'),(30,'\"Design system\" giúp ích nhiều nhất cho:','Single Choice',2,'2025-12-16 07:41:19','2025-12-17 15:48:57',1,1,'Active'),(31,'Chọn các yếu tố thường nằm trong một style guide/design guideline:','Multiple Choice',2,'2025-12-16 07:41:19',NULL,1,1,'Active'),(32,'\"Value proposition\" (giá trị đề xuất) mô tả điều gì?','Single Choice',3,'2025-12-16 07:41:19',NULL,1,1,'Active'),(33,'Trong Business Model Canvas, những khối nào thuộc về \"Customer\"?','Multiple Choice',3,'2025-12-16 07:41:19',NULL,1,1,'Active'),(34,'Chỉ số nào sau đây đo lường lợi nhuận trên chi phí quảng cáo?','Single Choice',3,'2025-12-16 07:41:19',NULL,1,1,'Active'),(35,'Chọn các nguồn doanh thu (revenue streams) thường gặp:','Multiple Choice',3,'2025-12-16 07:41:19',NULL,1,1,'Active'),(36,'Trong quản trị dự án, \"stakeholder\" là:','Single Choice',3,'2025-12-16 07:41:19',NULL,1,1,'Active'),(37,'Chọn các ví dụ về chi phí cố định (fixed cost):','Multiple Choice',3,'2025-12-16 07:41:19',NULL,1,1,'Active'),(38,'Trong marketing số, SEO là viết tắt của:','Single Choice',4,'2025-12-16 07:41:19',NULL,1,1,'Active'),(39,'Chọn các kênh thuộc Digital Marketing:','Multiple Choice',4,'2025-12-16 07:41:19',NULL,1,1,'Active'),(40,'Chỉ số nào thường dùng để đo tỉ lệ người nhấp vào quảng cáo?','Single Choice',4,'2025-12-16 07:41:19',NULL,1,1,'Active'),(41,'Chọn các yếu tố thuộc On-page SEO:','Multiple Choice',4,'2025-12-16 07:41:19',NULL,1,1,'Active'),(42,'\"Conversion\" trong marketing nghĩa là:','Single Choice',4,'2025-12-16 07:41:19',NULL,1,1,'Active'),(43,'Chọn các metric thường theo dõi trong Social Media:','Multiple Choice',4,'2025-12-16 07:41:19',NULL,1,1,'Active'),(44,'Trong RESTful API, phương thức HTTP nào thường dùng để tạo mới resource?','Single Choice',5,'2025-12-16 07:41:19',NULL,1,1,'Active'),(45,'Chọn các đặc điểm thường thấy của Spring Data JPA Repository:','Multiple Choice',5,'2025-12-16 07:41:19',NULL,1,1,'Active'),(46,'JWT thường được dùng để:','Single Choice',5,'2025-12-16 07:41:19',NULL,1,1,'Active'),(47,'Chọn các thành phần phổ biến trong kiến trúc backend theo tầng (layered architecture):','Multiple Choice',5,'2025-12-16 07:41:19',NULL,1,1,'Active'),(48,'Trong cơ sở dữ liệu quan hệ, \"foreign key\" dùng để:','Single Choice',5,'2025-12-16 07:41:19',NULL,1,1,'Active'),(49,'Chọn các best practices khi thiết kế API:','Multiple Choice',5,'2025-12-16 07:41:19',NULL,1,1,'Active'),(50,'Trong React, JSX sẽ được biên dịch (compile) thành:','Single Choice',6,'2025-12-16 07:41:19','2025-12-17 15:57:51',1,1,'Active'),(51,'Chọn các hook cơ bản trong React:','Multiple Choice',6,'2025-12-16 07:41:19',NULL,1,1,'Active'),(52,'Trong CSS, Flexbox thường dùng để:','Single Choice',6,'2025-12-16 07:41:19','2025-12-17 15:57:53',1,1,'Active'),(53,'Chọn các lợi ích của component-based UI:','Multiple Choice',6,'2025-12-16 07:41:19','2025-12-17 15:57:55',1,1,'Active'),(54,'Redux Toolkit thường giúp:','Single Choice',6,'2025-12-16 07:41:19',NULL,1,1,'Active'),(55,'Chọn các yếu tố cần chú ý để tối ưu performance frontend:','Multiple Choice',6,'2025-12-16 07:41:19',NULL,1,1,'Active'),(56,'Trong Flutter, widget nào là bất biến (không có state nội bộ)?','Single Choice',7,'2025-12-16 07:41:19',NULL,1,1,'Active'),(57,'Chọn các nền tảng Flutter có thể build ra (theo mặc định/khả dụng phổ biến):','Multiple Choice',7,'2025-12-16 07:41:19',NULL,1,1,'Active'),(58,'Trong React Native, việc điều hướng màn hình thường được xử lý bởi:','Single Choice',7,'2025-12-16 07:41:19',NULL,1,1,'Active'),(59,'Chọn các yếu tố quan trọng khi tối ưu trải nghiệm mobile:','Multiple Choice',7,'2025-12-16 07:41:19',NULL,1,1,'Active'),(60,'Trong Android, Activity lifecycle callback nào thường được gọi khi app trở lại foreground?','Single Choice',7,'2025-12-16 07:41:19',NULL,1,1,'Active'),(61,'Chọn các cách lưu trữ dữ liệu cục bộ phổ biến trên mobile:','Multiple Choice',7,'2025-12-16 07:41:19',NULL,1,1,'Active'),(62,'\"Visual hierarchy\" trong UI design giúp:','Single Choice',8,'2025-12-16 07:41:19',NULL,1,1,'Active'),(63,'Chọn các tiêu chí thường dùng để đánh giá tính nhất quán (consistency) của UI:','Multiple Choice',8,'2025-12-16 07:41:19',NULL,1,1,'Active'),(64,'Trong Figma, \"component\" thường dùng để:','Single Choice',8,'2025-12-16 07:41:19',NULL,1,1,'Active'),(65,'Chọn các guideline liên quan đến accessibility:','Multiple Choice',8,'2025-12-16 07:41:19',NULL,1,1,'Active'),(66,'\"Prototype\" khác \"mockup\" ở điểm chính là prototype:','Single Choice',8,'2025-12-16 07:41:19',NULL,1,1,'Active'),(67,'Chọn các bước phổ biến trong quy trình thiết kế UI/UX:','Multiple Choice',8,'2025-12-16 07:41:19',NULL,1,1,'Active'),(68,'Trong Photoshop, \"layer\" dùng để:','Single Choice',9,'2025-12-16 07:41:19',NULL,1,1,'Active'),(69,'Chọn các định dạng file thường dùng cho đồ họa raster (bitmap):','Multiple Choice',9,'2025-12-16 07:41:19',NULL,1,1,'Active'),(70,'Trong Illustrator, sản phẩm thiết kế chủ yếu là:','Single Choice',9,'2025-12-16 07:41:19',NULL,1,1,'Active'),(71,'Chọn các yếu tố ảnh hưởng trực tiếp đến chất lượng in ấn:','Multiple Choice',9,'2025-12-16 07:41:19',NULL,1,1,'Active'),(72,'\"Kerning\" trong typography là:','Single Choice',9,'2025-12-16 07:41:19',NULL,1,1,'Active'),(73,'Chọn các nguyên tắc để thiết kế logo hiệu quả:','Multiple Choice',9,'2025-12-16 07:41:19',NULL,1,1,'Active'),(74,'\"Target audience\" là gì?','Single Choice',10,'2025-12-16 07:41:19',NULL,1,1,'Active'),(75,'Chọn các bước cơ bản để xây dựng một bài đăng marketing hiệu quả:','Multiple Choice',10,'2025-12-16 07:41:19',NULL,1,1,'Active'),(76,'CTA thường viết tắt của:','Single Choice',10,'2025-12-16 07:41:19',NULL,1,1,'Active'),(77,'Chọn các ví dụ về CTA (Call To Action):','Multiple Choice',10,'2025-12-16 07:41:19',NULL,1,1,'Active'),(78,'Khi viết content, \"USP\" nghĩa là:','Single Choice',10,'2025-12-16 07:41:19',NULL,1,1,'Active'),(79,'Chọn các yếu tố giúp tăng độ tin cậy của nội dung marketing:','Multiple Choice',10,'2025-12-16 07:41:19',NULL,1,1,'Active'),(80,'\"Doanh thu\" (revenue) khác \"lợi nhuận\" (profit) ở chỗ:','Single Choice',11,'2025-12-16 07:41:19',NULL,1,1,'Active'),(81,'Chọn các ví dụ về chi phí biến đổi (variable cost):','Multiple Choice',11,'2025-12-16 07:41:19',NULL,1,1,'Active'),(82,'KPI là viết tắt của:','Single Choice',11,'2025-12-16 07:41:19',NULL,1,1,'Active'),(83,'Chọn các hoạt động thuộc quản lý vận hành (operations) cơ bản:','Multiple Choice',11,'2025-12-16 07:41:19',NULL,1,1,'Active'),(84,'\"Break-even point\" là điểm:','Single Choice',11,'2025-12-16 07:41:19',NULL,1,1,'Active'),(85,'Chọn các yếu tố thường nằm trong kế hoạch kinh doanh (business plan):','Multiple Choice',11,'2025-12-16 07:41:19',NULL,1,1,'Active');
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_answer`
--

DROP TABLE IF EXISTS `quiz_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quiz_id` int NOT NULL,
  `is_true` tinyint(1) NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_id` (`quiz_id`),
  CONSTRAINT `quiz_answer_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=344 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_answer`
--

LOCK TABLES `quiz_answer` WRITE;
/*!40000 ALTER TABLE `quiz_answer` DISABLE KEYS */;
INSERT INTO `quiz_answer` VALUES (74,20,0,'Single Choice','Gộp nhiều class thành một package','2025-12-16 07:41:33',NULL,1,1),(75,20,1,'Single Choice','Ẩn chi tiết triển khai và chỉ lộ ra interface cần thiết','2025-12-16 07:41:33',NULL,1,1),(76,20,0,'Single Choice','Tăng tốc độ chạy bằng cách biên dịch trước','2025-12-16 07:41:33',NULL,1,1),(77,20,0,'Single Choice','Cho phép một class kế thừa từ nhiều class','2025-12-16 07:41:33',NULL,1,1),(78,21,1,'Multiple Choice','if/else','2025-12-16 07:41:33',NULL,1,1),(79,21,1,'Multiple Choice','for/while','2025-12-16 07:41:33',NULL,1,1),(80,21,1,'Multiple Choice','try/catch','2025-12-16 07:41:33',NULL,1,1),(81,21,0,'Multiple Choice','import/package','2025-12-16 07:41:33',NULL,1,1),(82,22,0,'Single Choice','git pull','2025-12-16 07:41:33',NULL,1,1),(83,22,1,'Single Choice','git fetch','2025-12-16 07:41:33',NULL,1,1),(84,22,0,'Single Choice','git commit','2025-12-16 07:41:33',NULL,1,1),(85,22,0,'Single Choice','git push','2025-12-16 07:41:33',NULL,1,1),(86,23,1,'Multiple Choice','Đặt tên biến/hàm rõ nghĩa','2025-12-16 07:41:33',NULL,1,1),(87,23,1,'Multiple Choice','Tách hàm nhỏ, một hàm làm một việc','2025-12-16 07:41:33',NULL,1,1),(88,23,0,'Multiple Choice','Copy-paste code lặp lại để nhanh hơn','2025-12-16 07:41:33',NULL,1,1),(89,23,1,'Multiple Choice','Viết comment giải thích \"tại sao\" khi cần','2025-12-16 07:41:33',NULL,1,1),(90,24,0,'Single Choice','O(log n)','2025-12-16 07:41:33',NULL,1,1),(91,24,1,'Single Choice','O(n)','2025-12-16 07:41:33',NULL,1,1),(92,24,0,'Single Choice','O(1)','2025-12-16 07:41:33',NULL,1,1),(93,24,0,'Single Choice','O(n log n)','2025-12-16 07:41:33',NULL,1,1),(94,25,1,'Multiple Choice','Java','2025-12-16 07:41:33',NULL,1,1),(95,25,1,'Multiple Choice','JavaScript (Node.js)','2025-12-16 07:41:33',NULL,1,1),(96,25,1,'Multiple Choice','Python','2025-12-16 07:41:33',NULL,1,1),(97,25,0,'Multiple Choice','Figma','2025-12-16 07:41:33',NULL,1,1),(98,26,0,'Single Choice','Chọn màu chủ đạo cuối cùng','2025-12-16 07:41:33',NULL,1,1),(99,26,1,'Single Choice','Phác thảo bố cục và luồng thông tin ở mức đơn giản','2025-12-16 07:41:33',NULL,1,1),(100,26,0,'Single Choice','Xuất file ảnh chất lượng cao để in','2025-12-16 07:41:33',NULL,1,1),(101,26,0,'Single Choice','Tối ưu SEO cho website','2025-12-16 07:41:33',NULL,1,1),(102,27,1,'Multiple Choice','Tương phản (contrast) hợp lý giữa chữ và nền','2025-12-16 07:41:33',NULL,1,1),(103,27,1,'Multiple Choice','Khoảng trắng (whitespace) phù hợp','2025-12-16 07:41:33',NULL,1,1),(104,27,0,'Multiple Choice','Dùng quá nhiều font khác nhau trong 1 màn hình','2025-12-16 07:41:33',NULL,1,1),(105,27,1,'Multiple Choice','Cỡ chữ nhất quán theo hệ thống typography','2025-12-16 07:41:33',NULL,1,1),(106,28,0,'Single Choice','In ấn (print)','2025-12-16 07:41:33',NULL,1,1),(107,28,1,'Single Choice','Hiển thị trên màn hình (digital)','2025-12-16 07:41:33',NULL,1,1),(108,28,0,'Single Choice','Khắc laser','2025-12-16 07:41:33',NULL,1,1),(109,28,0,'Single Choice','Vải dệt','2025-12-16 07:41:33',NULL,1,1),(110,29,1,'Multiple Choice','Figma','2025-12-16 07:41:33',NULL,1,1),(111,29,1,'Multiple Choice','Adobe XD','2025-12-16 07:41:33',NULL,1,1),(112,29,1,'Multiple Choice','Photoshop','2025-12-16 07:41:33',NULL,1,1),(113,29,0,'Multiple Choice','MySQL Workbench','2025-12-16 07:41:33',NULL,1,1),(114,30,0,'Single Choice','Giảm thời gian compile code','2025-12-16 07:41:33',NULL,1,1),(115,30,1,'Single Choice','Tăng tính nhất quán và tái sử dụng component','2025-12-16 07:41:33',NULL,1,1),(116,30,0,'Single Choice','Tăng tốc độ mạng','2025-12-16 07:41:33',NULL,1,1),(117,30,0,'Single Choice','Tự động tạo database','2025-12-16 07:41:33',NULL,1,1),(118,31,1,'Multiple Choice','Bảng màu (color palette)','2025-12-16 07:41:33',NULL,1,1),(119,31,1,'Multiple Choice','Typography scale','2025-12-16 07:41:33',NULL,1,1),(120,31,1,'Multiple Choice','Grid/spacing rules','2025-12-16 07:41:33',NULL,1,1),(121,31,0,'Multiple Choice','Danh sách endpoint API','2025-12-16 07:41:33',NULL,1,1),(122,32,0,'Single Choice','Cấu trúc database của hệ thống','2025-12-16 07:41:33',NULL,1,1),(123,32,1,'Single Choice','Lý do khách hàng chọn sản phẩm/dịch vụ của bạn','2025-12-16 07:41:33',NULL,1,1),(124,32,0,'Single Choice','Mã nguồn ứng dụng','2025-12-16 07:41:33',NULL,1,1),(125,32,0,'Single Choice','Chính sách bảo mật','2025-12-16 07:41:33',NULL,1,1),(126,33,1,'Multiple Choice','Customer Segments','2025-12-16 07:41:33',NULL,1,1),(127,33,1,'Multiple Choice','Channels','2025-12-16 07:41:33',NULL,1,1),(128,33,1,'Multiple Choice','Customer Relationships','2025-12-16 07:41:33',NULL,1,1),(129,33,0,'Multiple Choice','Key Activities','2025-12-16 07:41:33',NULL,1,1),(130,34,1,'Single Choice','ROI','2025-12-16 07:41:33',NULL,1,1),(131,34,0,'Single Choice','DAU','2025-12-16 07:41:33',NULL,1,1),(132,34,0,'Single Choice','Latency','2025-12-16 07:41:33',NULL,1,1),(133,34,0,'Single Choice','RAM','2025-12-16 07:41:33',NULL,1,1),(134,35,1,'Multiple Choice','Subscription (thuê bao)','2025-12-16 07:41:33',NULL,1,1),(135,35,1,'Multiple Choice','One-time purchase (mua một lần)','2025-12-16 07:41:33',NULL,1,1),(136,35,1,'Multiple Choice','Licensing (cấp phép)','2025-12-16 07:41:33',NULL,1,1),(137,35,0,'Multiple Choice','Unit test coverage','2025-12-16 07:41:33',NULL,1,1),(138,36,0,'Single Choice','Người viết code','2025-12-16 07:41:33',NULL,1,1),(139,36,1,'Single Choice','Bên liên quan có ảnh hưởng/quan tâm đến dự án','2025-12-16 07:41:33',NULL,1,1),(140,36,0,'Single Choice','Server chạy production','2025-12-16 07:41:33',NULL,1,1),(141,36,0,'Single Choice','Một loại hợp đồng lao động','2025-12-16 07:41:33',NULL,1,1),(142,37,1,'Multiple Choice','Tiền thuê văn phòng cố định hàng tháng','2025-12-16 07:41:33',NULL,1,1),(143,37,1,'Multiple Choice','Lương cơ bản nhân sự','2025-12-16 07:41:33',NULL,1,1),(144,37,0,'Multiple Choice','Chi phí nguyên vật liệu theo số lượng sản phẩm','2025-12-16 07:41:33',NULL,1,1),(145,37,1,'Multiple Choice','Phí hosting theo gói cố định','2025-12-16 07:41:33',NULL,1,1),(146,38,0,'Single Choice','Sales Executive Office','2025-12-16 07:41:33',NULL,1,1),(147,38,1,'Single Choice','Search Engine Optimization','2025-12-16 07:41:33',NULL,1,1),(148,38,0,'Single Choice','Social Engagement Operation','2025-12-16 07:41:33',NULL,1,1),(149,38,0,'Single Choice','System Error Output','2025-12-16 07:41:33',NULL,1,1),(150,39,1,'Multiple Choice','Email Marketing','2025-12-16 07:41:33',NULL,1,1),(151,39,1,'Multiple Choice','Social Media Marketing','2025-12-16 07:41:33',NULL,1,1),(152,39,1,'Multiple Choice','SEO/SEM','2025-12-16 07:41:33',NULL,1,1),(153,39,0,'Multiple Choice','Lập trình C++','2025-12-16 07:41:33',NULL,1,1),(154,40,1,'Single Choice','CTR (Click-through rate)','2025-12-16 07:41:33',NULL,1,1),(155,40,0,'Single Choice','CPU','2025-12-16 07:41:33',NULL,1,1),(156,40,0,'Single Choice','API','2025-12-16 07:41:33',NULL,1,1),(157,40,0,'Single Choice','SQL','2025-12-16 07:41:33',NULL,1,1),(158,41,1,'Multiple Choice','Title tag','2025-12-16 07:41:33',NULL,1,1),(159,41,1,'Multiple Choice','Meta description','2025-12-16 07:41:33',NULL,1,1),(160,41,1,'Multiple Choice','Header tags (H1/H2/H3)','2025-12-16 07:41:33',NULL,1,1),(161,41,0,'Multiple Choice','Backlink từ website khác','2025-12-16 07:41:33',NULL,1,1),(162,42,0,'Single Choice','Người dùng rời trang ngay','2025-12-16 07:41:33',NULL,1,1),(163,42,1,'Single Choice','Người dùng thực hiện hành động mục tiêu (mua, đăng ký, điền form...)','2025-12-16 07:41:33',NULL,1,1),(164,42,0,'Single Choice','Tăng tốc website','2025-12-16 07:41:33',NULL,1,1),(165,42,0,'Single Choice','Giảm chi phí server','2025-12-16 07:41:33',NULL,1,1),(166,43,1,'Multiple Choice','Reach','2025-12-16 07:41:33',NULL,1,1),(167,43,1,'Multiple Choice','Engagement rate','2025-12-16 07:41:33',NULL,1,1),(168,43,1,'Multiple Choice','Impressions','2025-12-16 07:41:33',NULL,1,1),(169,43,0,'Multiple Choice','Heap memory size','2025-12-16 07:41:33',NULL,1,1),(170,44,0,'Single Choice','GET','2025-12-16 07:41:33',NULL,1,1),(171,44,1,'Single Choice','POST','2025-12-16 07:41:33',NULL,1,1),(172,44,0,'Single Choice','PUT','2025-12-16 07:41:33',NULL,1,1),(173,44,0,'Single Choice','DELETE','2025-12-16 07:41:33',NULL,1,1),(174,45,1,'Multiple Choice','Có thể extends JpaRepository','2025-12-16 07:41:33',NULL,1,1),(175,45,1,'Multiple Choice','Cung cấp sẵn save(), findById(), findAll()','2025-12-16 07:41:33',NULL,1,1),(176,45,0,'Multiple Choice','Bắt buộc phải viết SQL thuần cho mọi truy vấn','2025-12-16 07:41:33',NULL,1,1),(177,45,1,'Multiple Choice','Hỗ trợ mapping Entity với bảng','2025-12-16 07:41:33',NULL,1,1),(178,46,0,'Single Choice','Nén hình ảnh','2025-12-16 07:41:33',NULL,1,1),(179,46,1,'Single Choice','Xác thực/ủy quyền (authentication/authorization) trong API','2025-12-16 07:41:33',NULL,1,1),(180,46,0,'Single Choice','Tăng tốc độ render UI','2025-12-16 07:41:33',NULL,1,1),(181,46,0,'Single Choice','Thiết kế prototype','2025-12-16 07:41:33',NULL,1,1),(182,47,1,'Multiple Choice','Controller','2025-12-16 07:41:33',NULL,1,1),(183,47,1,'Multiple Choice','Service','2025-12-16 07:41:33',NULL,1,1),(184,47,1,'Multiple Choice','Repository/DAO','2025-12-16 07:41:33',NULL,1,1),(185,47,0,'Multiple Choice','Storyboard','2025-12-16 07:41:33',NULL,1,1),(186,48,0,'Single Choice','Mã hóa mật khẩu','2025-12-16 07:41:33',NULL,1,1),(187,48,1,'Single Choice','Ràng buộc quan hệ giữa hai bảng','2025-12-16 07:41:33',NULL,1,1),(188,48,0,'Single Choice','Tăng tốc GPU','2025-12-16 07:41:33',NULL,1,1),(189,48,0,'Single Choice','Tạo file ảnh thumbnail','2025-12-16 07:41:33',NULL,1,1),(190,49,1,'Multiple Choice','Sử dụng HTTP status code phù hợp','2025-12-16 07:41:33',NULL,1,1),(191,49,1,'Multiple Choice','Versioning API (ví dụ /api/v1)','2025-12-16 07:41:33',NULL,1,1),(192,49,1,'Multiple Choice','Đặt endpoint theo danh từ (resources) thay vì động từ','2025-12-16 07:41:33',NULL,1,1),(193,49,0,'Multiple Choice','Trả về lỗi 200 cho mọi trường hợp','2025-12-16 07:41:33',NULL,1,1),(194,50,0,'Single Choice','SQL query','2025-12-16 07:41:33',NULL,1,1),(195,50,1,'Single Choice','Các lời gọi React.createElement()','2025-12-16 07:41:33',NULL,1,1),(196,50,0,'Single Choice','File ảnh PNG','2025-12-16 07:41:33',NULL,1,1),(197,50,0,'Single Choice','CSS variables','2025-12-16 07:41:33',NULL,1,1),(198,51,1,'Multiple Choice','useState','2025-12-16 07:41:33',NULL,1,1),(199,51,1,'Multiple Choice','useEffect','2025-12-16 07:41:33',NULL,1,1),(200,51,0,'Multiple Choice','useRoute','2025-12-16 07:41:33',NULL,1,1),(201,51,1,'Multiple Choice','useContext','2025-12-16 07:41:33',NULL,1,1),(202,52,0,'Single Choice','Quản lý database connection pool','2025-12-16 07:41:33',NULL,1,1),(203,52,1,'Single Choice','Sắp xếp bố cục linh hoạt theo trục (row/column)','2025-12-16 07:41:33',NULL,1,1),(204,52,0,'Single Choice','Mã hóa dữ liệu','2025-12-16 07:41:33',NULL,1,1),(205,52,0,'Single Choice','Gửi email marketing','2025-12-16 07:41:33',NULL,1,1),(206,53,1,'Multiple Choice','Tái sử dụng UI','2025-12-16 07:41:33',NULL,1,1),(207,53,1,'Multiple Choice','Dễ bảo trì và mở rộng','2025-12-16 07:41:33',NULL,1,1),(208,53,0,'Multiple Choice','Tăng coupling giữa các phần','2025-12-16 07:41:33',NULL,1,1),(209,53,1,'Multiple Choice','Dễ test từng phần nhỏ','2025-12-16 07:41:33',NULL,1,1),(210,54,0,'Single Choice','Tối ưu hóa hình ảnh','2025-12-16 07:41:33',NULL,1,1),(211,54,1,'Single Choice','Đơn giản hóa setup và quản lý global state','2025-12-16 07:41:33',NULL,1,1),(212,54,0,'Single Choice','Tạo sơ đồ ERD','2025-12-16 07:41:33',NULL,1,1),(213,54,0,'Single Choice','Chạy quảng cáo Google','2025-12-16 07:41:33',NULL,1,1),(214,55,1,'Multiple Choice','Code splitting/lazy loading','2025-12-16 07:41:33',NULL,1,1),(215,55,1,'Multiple Choice','Giảm kích thước bundle','2025-12-16 07:41:33',NULL,1,1),(216,55,0,'Multiple Choice','Render lại toàn bộ UI mọi khi có thay đổi nhỏ','2025-12-16 07:41:33',NULL,1,1),(217,55,1,'Multiple Choice','Caching hợp lý','2025-12-16 07:41:33',NULL,1,1),(218,56,0,'Single Choice','StatefulWidget','2025-12-16 07:41:33',NULL,1,1),(219,56,1,'Single Choice','StatelessWidget','2025-12-16 07:41:33',NULL,1,1),(220,56,0,'Single Choice','Navigator','2025-12-16 07:41:33',NULL,1,1),(221,56,0,'Single Choice','Provider','2025-12-16 07:41:33',NULL,1,1),(222,57,1,'Multiple Choice','Android','2025-12-16 07:41:33',NULL,1,1),(223,57,1,'Multiple Choice','iOS','2025-12-16 07:41:33',NULL,1,1),(224,57,1,'Multiple Choice','Web','2025-12-16 07:41:33',NULL,1,1),(225,57,0,'Multiple Choice','Oracle Database','2025-12-16 07:41:33',NULL,1,1),(226,58,1,'Single Choice','React Navigation','2025-12-16 07:41:33',NULL,1,1),(227,58,0,'Single Choice','MyBatis','2025-12-16 07:41:33',NULL,1,1),(228,58,0,'Single Choice','Hibernate','2025-12-16 07:41:33',NULL,1,1),(229,58,0,'Single Choice','Webpack','2025-12-16 07:41:33',NULL,1,1),(230,59,1,'Multiple Choice','Tối ưu hiệu năng (FPS/giật lag)','2025-12-16 07:41:33',NULL,1,1),(231,59,1,'Multiple Choice','Thiết kế responsive theo kích thước màn hình','2025-12-16 07:41:33',NULL,1,1),(232,59,0,'Multiple Choice','Bắt buộc luôn hiển thị mọi dữ liệu trên 1 màn hình','2025-12-16 07:41:33',NULL,1,1),(233,59,1,'Multiple Choice','Quản lý quyền (permissions) đúng cách','2025-12-16 07:41:33',NULL,1,1),(234,60,1,'Single Choice','onResume()','2025-12-16 07:41:33',NULL,1,1),(235,60,0,'Single Choice','onDestroy()','2025-12-16 07:41:33',NULL,1,1),(236,60,0,'Single Choice','onStop()','2025-12-16 07:41:33',NULL,1,1),(237,60,0,'Single Choice','onCreate()','2025-12-16 07:41:33',NULL,1,1),(238,61,1,'Multiple Choice','SQLite/Room','2025-12-16 07:41:33',NULL,1,1),(239,61,1,'Multiple Choice','SharedPreferences','2025-12-16 07:41:33',NULL,1,1),(240,61,1,'Multiple Choice','Keychain/Keystore','2025-12-16 07:41:33',NULL,1,1),(241,61,0,'Multiple Choice','DNS record','2025-12-16 07:41:33',NULL,1,1),(242,62,0,'Single Choice','Tăng dung lượng RAM','2025-12-16 07:41:33',NULL,1,1),(243,62,1,'Single Choice','Người dùng nhận biết thứ tự quan trọng của thông tin','2025-12-16 07:41:33',NULL,1,1),(244,62,0,'Single Choice','Tăng tốc độ tải database','2025-12-16 07:41:33',NULL,1,1),(245,62,0,'Single Choice','Tạo code tự động','2025-12-16 07:41:33',NULL,1,1),(246,63,1,'Multiple Choice','Button cùng style/size trong các màn hình','2025-12-16 07:41:33',NULL,1,1),(247,63,1,'Multiple Choice','Khoảng cách (spacing) theo quy chuẩn','2025-12-16 07:41:33',NULL,1,1),(248,63,0,'Multiple Choice','Mỗi màn hình dùng font khác nhau để \"đa dạng\"','2025-12-16 07:41:33',NULL,1,1),(249,63,1,'Multiple Choice','Màu sắc theo palette thống nhất','2025-12-16 07:41:33',NULL,1,1),(250,64,0,'Single Choice','Lưu password','2025-12-16 07:41:33',NULL,1,1),(251,64,1,'Single Choice','Tạo phần tử UI tái sử dụng và đồng bộ thay đổi','2025-12-16 07:41:33',NULL,1,1),(252,64,0,'Single Choice','Chạy unit test','2025-12-16 07:41:33',NULL,1,1),(253,64,0,'Single Choice','Export database schema','2025-12-16 07:41:33',NULL,1,1),(254,65,1,'Multiple Choice','Đảm bảo contrast theo WCAG','2025-12-16 07:41:33',NULL,1,1),(255,65,1,'Multiple Choice','Hỗ trợ điều hướng bằng bàn phím','2025-12-16 07:41:33',NULL,1,1),(256,65,0,'Multiple Choice','Dùng placeholder thay cho label trong mọi trường hợp','2025-12-16 07:41:33',NULL,1,1),(257,65,1,'Multiple Choice','Hỗ trợ screen reader','2025-12-16 07:41:33',NULL,1,1),(258,66,0,'Single Choice','Không có hình ảnh','2025-12-16 07:41:33',NULL,1,1),(259,66,1,'Single Choice','Có tương tác mô phỏng luồng sử dụng','2025-12-16 07:41:33',NULL,1,1),(260,66,0,'Single Choice','Chỉ dùng cho in ấn','2025-12-16 07:41:33',NULL,1,1),(261,66,0,'Single Choice','Luôn là code chạy thật','2025-12-16 07:41:33',NULL,1,1),(262,67,1,'Multiple Choice','User research','2025-12-16 07:41:33',NULL,1,1),(263,67,1,'Multiple Choice','Wireframing','2025-12-16 07:41:33',NULL,1,1),(264,67,1,'Multiple Choice','Prototyping & usability testing','2025-12-16 07:41:33',NULL,1,1),(265,67,0,'Multiple Choice','Deploy lên production ngay','2025-12-16 07:41:33',NULL,1,1),(266,68,0,'Single Choice','Tạo bảng dữ liệu','2025-12-16 07:41:33',NULL,1,1),(267,68,1,'Single Choice','Tách các thành phần thiết kế để chỉnh sửa độc lập','2025-12-16 07:41:33',NULL,1,1),(268,68,0,'Single Choice','Chạy animation 3D bắt buộc','2025-12-16 07:41:33',NULL,1,1),(269,68,0,'Single Choice','Tạo API endpoint','2025-12-16 07:41:33',NULL,1,1),(270,69,1,'Multiple Choice','PNG','2025-12-16 07:41:33',NULL,1,1),(271,69,1,'Multiple Choice','JPG/JPEG','2025-12-16 07:41:33',NULL,1,1),(272,69,0,'Multiple Choice','SVG','2025-12-16 07:41:33',NULL,1,1),(273,69,1,'Multiple Choice','GIF','2025-12-16 07:41:33',NULL,1,1),(274,70,0,'Single Choice','Raster/bitmap','2025-12-16 07:41:33',NULL,1,1),(275,70,1,'Single Choice','Vector','2025-12-16 07:41:33',NULL,1,1),(276,70,0,'Single Choice','Text-only','2025-12-16 07:41:33',NULL,1,1),(277,70,0,'Single Choice','Database','2025-12-16 07:41:33',NULL,1,1),(278,71,1,'Multiple Choice','Độ phân giải (DPI)','2025-12-16 07:41:33',NULL,1,1),(279,71,1,'Multiple Choice','Hệ màu CMYK','2025-12-16 07:41:33',NULL,1,1),(280,71,1,'Multiple Choice','Font được embed/outline','2025-12-16 07:41:33',NULL,1,1),(281,71,0,'Multiple Choice','Java version','2025-12-16 07:41:33',NULL,1,1),(282,72,1,'Single Choice','Khoảng cách giữa 2 ký tự','2025-12-16 07:41:33',NULL,1,1),(283,72,0,'Single Choice','Chiều cao dòng','2025-12-16 07:41:33',NULL,1,1),(284,72,0,'Single Choice','Độ dày font','2025-12-16 07:41:33',NULL,1,1),(285,72,0,'Single Choice','Màu nền','2025-12-16 07:41:33',NULL,1,1),(286,73,1,'Multiple Choice','Đơn giản và dễ nhận diện','2025-12-16 07:41:33',NULL,1,1),(287,73,1,'Multiple Choice','Dễ co giãn (scalable) ở nhiều kích thước','2025-12-16 07:41:33',NULL,1,1),(288,73,0,'Multiple Choice','Dùng thật nhiều chi tiết nhỏ để \"ngầu\"','2025-12-16 07:41:33',NULL,1,1),(289,73,1,'Multiple Choice','Phù hợp với thương hiệu (brand)','2025-12-16 07:41:33',NULL,1,1),(290,74,0,'Single Choice','Danh sách nhân viên công ty','2025-12-16 07:41:33',NULL,1,1),(291,74,1,'Single Choice','Nhóm khách hàng mục tiêu mà chiến dịch hướng tới','2025-12-16 07:41:33',NULL,1,1),(292,74,0,'Single Choice','Một loại quảng cáo trả phí','2025-12-16 07:41:33',NULL,1,1),(293,74,0,'Single Choice','Một công cụ thiết kế','2025-12-16 07:41:33',NULL,1,1),(294,75,1,'Multiple Choice','Xác định mục tiêu (goal) của bài đăng','2025-12-16 07:41:33',NULL,1,1),(295,75,1,'Multiple Choice','Viết thông điệp rõ ràng + CTA','2025-12-16 07:41:33',NULL,1,1),(296,75,0,'Multiple Choice','Đăng ngẫu nhiên không cần lịch','2025-12-16 07:41:33',NULL,1,1),(297,75,1,'Multiple Choice','Đo lường kết quả (reach/engagement)','2025-12-16 07:41:33',NULL,1,1),(298,76,0,'Single Choice','Click To Analyze','2025-12-16 07:41:33',NULL,1,1),(299,76,1,'Single Choice','Call To Action','2025-12-16 07:41:33',NULL,1,1),(300,76,0,'Single Choice','Cost To Acquire','2025-12-16 07:41:33',NULL,1,1),(301,76,0,'Single Choice','Code To App','2025-12-16 07:41:33',NULL,1,1),(302,77,1,'Multiple Choice','Đăng ký ngay','2025-12-16 07:41:33',NULL,1,1),(303,77,1,'Multiple Choice','Mua ngay','2025-12-16 07:41:33',NULL,1,1),(304,77,1,'Multiple Choice','Xem thêm','2025-12-16 07:41:33',NULL,1,1),(305,77,0,'Multiple Choice','\"Không cần làm gì\"','2025-12-16 07:41:33',NULL,1,1),(306,78,1,'Single Choice','Unique Selling Proposition','2025-12-16 07:41:33',NULL,1,1),(307,78,0,'Single Choice','User Session Policy','2025-12-16 07:41:33',NULL,1,1),(308,78,0,'Single Choice','Ultra Speed Process','2025-12-16 07:41:33',NULL,1,1),(309,78,0,'Single Choice','UI Style Pattern','2025-12-16 07:41:33',NULL,1,1),(310,79,1,'Multiple Choice','Review/feedback từ người dùng','2025-12-16 07:41:33',NULL,1,1),(311,79,1,'Multiple Choice','Số liệu/đo lường cụ thể (nếu có)','2025-12-16 07:41:33',NULL,1,1),(312,79,0,'Multiple Choice','Cam kết quá đà không có cơ sở','2025-12-16 07:41:33',NULL,1,1),(313,79,1,'Multiple Choice','Hình ảnh minh họa rõ ràng','2025-12-16 07:41:33',NULL,1,1),(314,80,0,'Single Choice','Doanh thu luôn lớn hơn lợi nhuận','2025-12-16 07:41:33',NULL,1,1),(315,80,1,'Single Choice','Lợi nhuận = doanh thu - chi phí','2025-12-16 07:41:33',NULL,1,1),(316,80,0,'Single Choice','Lợi nhuận không liên quan chi phí','2025-12-16 07:41:33',NULL,1,1),(317,80,0,'Single Choice','Doanh thu là tiền còn lại sau khi trừ thuế','2025-12-16 07:41:33',NULL,1,1),(318,81,1,'Multiple Choice','Nguyên vật liệu theo số lượng sản phẩm','2025-12-16 07:41:33',NULL,1,1),(319,81,1,'Multiple Choice','Phí giao hàng theo đơn','2025-12-16 07:41:33',NULL,1,1),(320,81,0,'Multiple Choice','Tiền thuê mặt bằng cố định','2025-12-16 07:41:33',NULL,1,1),(321,81,1,'Multiple Choice','Hoa hồng theo doanh số','2025-12-16 07:41:33',NULL,1,1),(322,82,1,'Single Choice','Key Performance Indicator','2025-12-16 07:41:33',NULL,1,1),(323,82,0,'Single Choice','Kernel Process Interface','2025-12-16 07:41:33',NULL,1,1),(324,82,0,'Single Choice','Key Password Input','2025-12-16 07:41:33',NULL,1,1),(325,82,0,'Single Choice','Known Profit Index','2025-12-16 07:41:33',NULL,1,1),(326,83,1,'Multiple Choice','Quản lý tồn kho','2025-12-16 07:41:33',NULL,1,1),(327,83,1,'Multiple Choice','Quy trình giao hàng','2025-12-16 07:41:33',NULL,1,1),(328,83,1,'Multiple Choice','Đảm bảo chất lượng (QA/QC)','2025-12-16 07:41:33',NULL,1,1),(329,83,0,'Multiple Choice','Viết shader đồ họa','2025-12-16 07:41:33',NULL,1,1),(330,84,0,'Single Choice','Doanh nghiệp bắt đầu lỗ','2025-12-16 07:41:33','2025-12-16 09:05:07',1,1),(331,84,1,'Single Choice','Doanh thu = chi phí (hòa vốn)','2025-12-16 07:41:33','2025-12-16 09:08:05',1,1),(332,84,0,'Single Choice','Tăng trưởng gấp đôi','2025-12-16 07:41:33',NULL,1,1),(333,84,0,'Single Choice','Giảm 50% chi phí','2025-12-16 07:41:33',NULL,1,1),(334,85,1,'Multiple Choice','Phân tích thị trường','2025-12-16 07:41:33','2025-12-16 09:04:30',1,1),(335,85,1,'Multiple Choice','Kế hoạch tài chính','2025-12-16 07:41:33','2025-12-16 09:04:41',1,1),(336,85,1,'Multiple Choice','Chiến lược marketing/bán hàng','2025-12-16 07:41:33','2025-12-16 09:04:44',1,1),(337,85,0,'Multiple Choice','Danh sách package npm','2025-12-16 07:41:33',NULL,1,1);
/*!40000 ALTER TABLE `quiz_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_test`
--

DROP TABLE IF EXISTS `quiz_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_test` (
  `quiz_id` int NOT NULL,
  `test_id` int NOT NULL,
  PRIMARY KEY (`quiz_id`,`test_id`),
  KEY `test_id` (`test_id`),
  CONSTRAINT `quiz_test_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`),
  CONSTRAINT `quiz_test_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_test`
--

LOCK TABLES `quiz_test` WRITE;
/*!40000 ALTER TABLE `quiz_test` DISABLE KEYS */;
INSERT INTO `quiz_test` VALUES (54,17),(55,17),(45,18),(46,18),(47,18),(48,18),(44,19),(46,19),(47,19),(48,19),(49,19),(44,20),(46,20),(47,20),(48,20),(81,21),(82,21),(83,21),(69,22),(70,22),(71,22),(72,22),(73,22),(62,23),(64,23),(66,23),(56,24),(58,24),(76,26),(77,26),(79,26),(54,27),(55,27),(57,28),(59,28),(60,28),(62,29),(63,29),(65,29),(75,30),(76,30),(77,30),(78,30),(79,30),(51,31),(47,32),(51,33),(55,33),(75,34),(76,34),(79,34),(63,35),(65,35),(67,35),(82,36),(83,36),(84,36),(81,37),(83,37),(84,37),(83,38),(84,38),(80,39),(82,39);
/*!40000 ALTER TABLE `quiz_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin',NULL),(2,'Instructor',NULL),(3,'Trainee',NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` char(15) NOT NULL,
  `title` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` text NOT NULL,
  `time_interval` int NOT NULL,
  `min_grade` int NOT NULL,
  `course_id` int NOT NULL,
  `course_section_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_by` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `test_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (17,'RANDOMQUIZTEST','test random','oke oke',60,50,5,0,'2025-12-16 07:46:50',NULL,1,0),(18,'TEST0001','JAVA FINAL','test cuoi ky',50,50,1,0,'2025-12-16 07:48:22',NULL,1,0),(19,'NODEJSTEST','TEST NODE JS FINAL','test final ',50,50,2,0,'2025-12-16 07:48:56',NULL,1,0),(20,'Python01','TEST Python','complete the course with the test',40,50,3,0,'2025-12-16 07:49:37',NULL,1,0),(21,'Startup-01','Khoi nghiep cuoi ky','bai test khoi nghiep startup',10,39,14,0,'2025-12-16 07:50:18',NULL,1,0),(22,'TEST-001','TEST-001','TEST-001',50,40,12,0,'2025-12-16 07:50:44',NULL,1,0),(23,'UIUXTEST','test cuoi ky','bai test photoshopbai test photoshopbai test photoshop',30,50,10,0,'2025-12-16 07:52:13',NULL,1,0),(24,'MOBILE-01','Mobile App','Application test',40,50,8,0,'2025-12-16 07:52:50',NULL,1,0),(25,'HTML-01','bai test HTML','bai test HTML co ban',40,50,6,0,'2025-12-16 07:53:34',NULL,1,0),(26,'CONTENT-01','bai test content','bai test content ',50,40,15,0,'2025-12-16 07:54:11',NULL,1,0),(27,'REACT-01','Modern Web Development test','Modern Web Development ',40,50,4,0,'2025-12-16 07:55:47',NULL,1,0),(28,'FLUTTER-01','Flutter test cuoi ky','Flutter test cuoi ky',40,50,7,0,'2025-12-16 07:56:28',NULL,1,0),(29,'UI-UX-02','Test UI/UX figma','bai test cuoi ky',40,58,9,0,'2025-12-16 07:57:35',NULL,1,0),(30,'MARKETING-01','bai test marketing cuoi ky','Digital Marketing, try your best :D',50,50,13,0,'2025-12-16 07:58:24',NULL,1,0),(31,'baitest1','randomquiz','randomquiz',20,49,5,34,'2025-12-16 07:59:49',NULL,1,1),(32,'SOMEKIND','bai quiz ','quizzzzzz',10,40,1,4,'2025-12-16 08:00:20',NULL,1,1),(33,'quizzzz','bai quiz react','JSJSJSJSJSJSJ',29,50,4,9,'2025-12-16 08:01:01',NULL,1,1),(34,'QUIZ SEO','QUIZ SEO','QUIZ SEO',30,60,13,20,'2025-12-16 08:02:14',NULL,1,1),(35,'QUIZZZZZ','QUIZZZZZ','QUIZZZZZ',30,40,9,16,'2025-12-16 08:02:41',NULL,1,1),(36,'TESTMARKETING','bài test marketing basic','basic thôi',26,40,16,0,'2025-12-16 08:03:31',NULL,16,0),(37,'Test1CHUT','bài test random','oke oke oke',20,57,17,0,'2025-12-16 08:04:42',NULL,16,0),(38,'Quiz HDPE','Check','Cố mà qua',30,60,16,25,'2025-12-16 08:05:13',NULL,16,16),(39,'abcquiz','test quiz','okeokeoekoek',30,50,17,33,'2025-12-16 08:05:39',NULL,16,16);
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_attempt`
--

DROP TABLE IF EXISTS `test_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_attempt` (
  `user_id` int NOT NULL,
  `test_id` int NOT NULL,
  `current_attempted` int NOT NULL DEFAULT '1',
  `grade` float DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`,`test_id`),
  KEY `test_id` (`test_id`),
  CONSTRAINT `test_attempt_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `test_attempt_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_attempt`
--

LOCK TABLES `test_attempt` WRITE;
/*!40000 ALTER TABLE `test_attempt` DISABLE KEYS */;
INSERT INTO `test_attempt` VALUES (2,17,1,80,'Passed'),(2,28,1,0,'Retaking'),(2,30,1,100,'Passed'),(2,31,1,50,'Passed'),(2,34,1,100,'Passed'),(2,35,1,100,'Passed'),(2,37,2,100,'Passed'),(2,39,1,100,'Passed'),(17,37,1,100,'Passed'),(17,39,1,100,'Passed'),(18,27,1,66.7,'Passed'),(18,29,1,100,'Passed'),(18,30,1,100,'Passed'),(18,33,1,50,'Passed'),(18,34,1,100,'Passed'),(18,35,1,66.7,'Passed'),(18,36,1,100,'Passed'),(18,38,1,100,'Passed'),(20,36,1,100,'Passed'),(20,38,1,100,'Passed'),(27,30,1,100,'Passed'),(27,34,1,100,'Passed');
/*!40000 ALTER TABLE `test_attempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uuid` char(36) NOT NULL DEFAULT (uuid()),
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(50) NOT NULL,
  `hash_password` varchar(256) NOT NULL,
  `bod` date DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT (_utf8mb4'Pending'),
  `role_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'ff27132e-d3a1-11f0-8349-088fc35948df','Hoang','Hao','instructor@gmail.com','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961','2025-12-12','Active',2,'2025-12-07 19:21:57','2025-12-14 18:11:26'),(2,'3c1307e0-d3a4-11f0-8349-088fc35948df','Duc','Quan','trainee@gmail.com','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961',NULL,'Active',3,'2025-12-07 19:37:58','2025-12-14 18:11:07'),(3,'0f5bcd4b-d7df-11f0-8bcd-088fc35948df','Tuấn','Võ Minh','admin@gmail.com','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961',NULL,'Active',1,'2025-12-13 04:49:08','2025-12-18 07:08:45'),(11,'15bafd01-d7f1-11f0-8bcd-088fc35948df','Nguyen Duc Quan','(K18  HL)','quanndhe181858@fpt.edu.vn','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961',NULL,'Active',3,'2025-12-13 06:58:10','2025-12-18 06:17:25'),(16,'82f29a46-d80a-11f0-8bcd-088fc35948df','test','test','test@gmail.com','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961',NULL,'Active',2,'2025-12-13 10:00:10','2025-12-14 18:38:10'),(17,'4f8ce0ec-d8f5-11f0-a65e-b48c9d550c76','Nguyễn','Vip','nguyenvip@gmail.com','f087d1fc691ff049e3e9dc7db93f80fddff4698dc78cf0f0eb53c289a92bed5dfcbdfb2a0ba72a8d4389a677c2565e2cb5aacdabd5ac3ddc6c44a8d61fd9f77b',NULL,'Active',3,'2025-12-14 14:00:56',NULL),(18,'d890911c-d917-11f0-a65e-b48c9d550c76','oke oke','la','okela@gmail.com','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961',NULL,'Active',3,'2025-12-14 18:08:08',NULL),(19,'d08b09f8-d982-11f0-a65e-b48c9d550c76','sicalo','oke','sicalo@gmail.com','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961',NULL,'Active',3,'2025-12-15 06:53:51',NULL),(20,'20d74d61-d9c1-11f0-a65e-b48c9d550c76','test','2','test2@gmail.com','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961',NULL,'Active',3,'2025-12-15 14:19:55',NULL),(27,'44f60911-dbd8-11f0-a65e-b48c9d550c76','test','user','testuser@gmail.com','39a5906890b5d0ab4bc771a0f8c2e872be2afbc6f85aab34b970ab14c5669424534243369c712e808abebd19a7c8e88ea736ea7bc775a3943917eb79a7248961','2003-01-01','Active',3,'2025-12-18 06:10:36','2025-12-18 06:38:02'),(29,'108d8dcb-dbdf-11f0-a65e-b48c9d550c76','Phineas','Nguyễn','phineasng528@gmail.com','ecc110cbddefe0f59d24d401430a2bf22126e532e700e5ceefd71d084d38b069269d855320789b43035eb98a12364dd43d056f45c576a3e1196d02b02654f487',NULL,'Active',3,'2025-12-18 06:59:15',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_certificate`
--

DROP TABLE IF EXISTS `user_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_certificate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `certificate_id` int NOT NULL,
  `certificate_code` varchar(50) DEFAULT NULL,
  `issued_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `file_path` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`certificate_id`),
  UNIQUE KEY `certificate_code` (`certificate_code`),
  KEY `certificate_id` (`certificate_id`),
  CONSTRAINT `user_certificate_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_certificate_ibfk_2` FOREIGN KEY (`certificate_id`) REFERENCES `certificate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_certificate`
--

LOCK TABLES `user_certificate` WRITE;
/*!40000 ALTER TABLE `user_certificate` DISABLE KEYS */;
INSERT INTO `user_certificate` VALUES (10,2,8,'COURSE-17-2FFAE23D','2025-12-16 08:25:52',NULL),(11,17,8,'COURSE-17-B1666276','2025-12-16 08:27:30',NULL),(12,18,9,'COURSE-16-627BA290','2025-12-16 08:29:07',NULL),(13,20,9,'COURSE-16-9A023468','2025-12-16 08:31:06',NULL),(14,2,10,'COURSE-5-3C6ECB46','2025-12-16 08:32:22',NULL),(15,2,11,'COURSE-13-B82A43FA','2025-12-16 08:34:16',NULL),(16,18,12,'COURSE-9-F8C94F42','2025-12-16 08:37:02',NULL),(17,18,13,'COURSE-4-8A0A3660','2025-12-16 08:38:27',NULL),(18,18,11,'COURSE-13-F2BF73EA','2025-12-18 06:36:08',NULL),(19,27,11,'COURSE-13-1A0CA21F','2025-12-18 06:39:11',NULL);
/*!40000 ALTER TABLE `user_certificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'edulab'
--

--
-- Dumping routines for database 'edulab'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-18 22:18:26
