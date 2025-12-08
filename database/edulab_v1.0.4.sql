CREATE DATABASE  IF NOT EXISTS `edulab` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `edulab`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: edulab
-- ------------------------------------------------------
-- Server version	8.0.44

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Software Engineer',NULL,NULL),(2,'Devops',NULL,1),(3,'Devops 2',NULL,1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (4,'bf3089ed-d2a2-11f0-8412-088fc35948df','ASP .NET','Learn something big',3,'Inactive','2025-12-06 12:54:48','2025-12-07 15:23:55',1,1,'media/image/0debf440-86d5-469f-97dc-70e6f0a35ec4.jpeg'),(6,'60344d1b-d2e3-11f0-96ec-088fc35948df','Java Programming Essentials','A complete introduction to Java, covering variables, OOP, methods, and real-world coding challenges.',3,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(7,'6034713b-d2e3-11f0-96ec-088fc35948df','UI/UX Design for Beginners 123','Understand design principles, user flows, wireframes, and prototyping using Figma and real project samples.',2,'Active','2025-12-06 20:37:26','2025-12-07 20:10:57',1,1,'media/image/1c9569b6-a35c-4ea2-9189-2006b275d86d.jpeg'),(8,'603472ec-d2e3-11f0-96ec-088fc35948df','Python for Data Analysis','Learn how to analyze datasets using Python, Pandas, NumPy, and real business case studies.',3,'Active','2025-12-06 20:37:26','2025-12-07 20:07:41',1,NULL,'media/image/21ae6870-91e2-4284-8f40-e3942b441614.jpg'),(9,'60347475-d2e3-11f0-96ec-088fc35948df','Digital Marketing 101','Master SEO, social media ads, email marketing, and essential strategies to grow any online business.',2,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(10,'60347584-d2e3-11f0-96ec-088fc35948df','React Frontend Development','Build fast and modern web applications using React, components, hooks, and API integrations.',3,'Active','2025-12-06 20:37:26','2025-12-07 20:10:57',1,NULL,'media/image/1c9569b6-a35c-4ea2-9189-2006b275d86d.jpeg'),(11,'6034768b-d2e3-11f0-96ec-088fc35948df','Project Management Basics','Understand agile, scrum, waterfall, planning, and how to manage projects with confidence.',2,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(12,'6034779f-d2e3-11f0-96ec-088fc35948df','SQL for Data Professionals','Learn how to query databases, join tables, and build powerful analytical SQL statements.',3,'Active','2025-12-06 20:37:26','2025-12-07 20:10:57',1,NULL,'media/image/1c9569b6-a35c-4ea2-9189-2006b275d86d.jpeg'),(13,'603478c1-d2e3-11f0-96ec-088fc35948df','Mobile App Design','Create stunning mobile interfaces with user-centered design principles and prototyping tools.',2,'Active','2025-12-06 20:37:26','2025-12-07 20:10:45',1,NULL,'media/image/292de8cb-2d24-4425-b93f-b765c4502300.jpg'),(14,'603479d2-d2e3-11f0-96ec-088fc35948df','Spring Boot REST API Development','Build secure and scalable REST APIs using Spring Boot, JPA, and layered architecture.',3,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(15,'60347ae1-d2e3-11f0-96ec-088fc35948df','Creative Writing Workshop','Improve your storytelling, narrative structure, and writing flow through guided exercises.',2,'Active','2025-12-06 20:37:26','2025-12-07 20:10:57',1,NULL,'media/image/1c9569b6-a35c-4ea2-9189-2006b275d86d.jpeg'),(16,'60347c12-d2e3-11f0-96ec-088fc35948df','Advanced Java OOP','Deep dive into abstraction, inheritance, polymorphism, interfaces, and design patterns.',3,'Active','2025-12-06 20:37:26','2025-12-07 20:10:57',1,NULL,'media/image/1c9569b6-a35c-4ea2-9189-2006b275d86d.jpeg'),(17,'60347d2d-d2e3-11f0-96ec-088fc35948df','Graphic Design with Canva','Learn to create modern posters, banners, and social media designs using Canva tools.',2,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(18,'60347e1d-d2e3-11f0-96ec-088fc35948df','Machine Learning Basics','Understand supervised and unsupervised learning with real examples in Python.',3,'Active','2025-12-06 20:37:26','2025-12-07 20:11:05',1,NULL,'media/image/1c9569b6-a35c-4ea2-9189-2006b275d86d.jpeg'),(19,'60347ed4-d2e3-11f0-96ec-088fc35948df','Photography for Beginners','Learn camera basics, lighting, composition, and photo editing essentials.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(20,'60347f7c-d2e3-11f0-96ec-088fc35948df','Backend Development with Node.js','Build backend services, APIs, and authentication systems using Node.js and Express.',3,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(21,'60348074-d2e3-11f0-96ec-088fc35948df','Content Strategy Masterclass','A practical guide to planning, creating, and optimizing digital content for business growth.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(22,'60348123-d2e3-11f0-96ec-088fc35948df','Docker & DevOps Fundamentals','Learn containerization, deployment pipelines, and DevOps practices for modern systems.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(23,'603481bf-d2e3-11f0-96ec-088fc35948df','Branding & Visual Identity','Build strong brand visuals, typography, and color systems with practical examples.',2,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(24,'60348257-d2e3-11f0-96ec-088fc35948df','Android App Development','Create Android apps with Java/Kotlin, layouts, components, and Firebase integration.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(25,'603482f1-d2e3-11f0-96ec-088fc35948df','Basic Financial Literacy','Understand budgeting, saving, investing, and personal finance foundations for beginners.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(26,'60348386-d2e3-11f0-96ec-088fc35948df','Full-Stack Java Developer Path','Master Java, Spring Boot, SQL, and frontend skills to become a job-ready developer.',3,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(27,'60348430-d2e3-11f0-96ec-088fc35948df','Illustration Fundamentals','Learn drawing basics, shapes, shading, and digital illustration tools.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(28,'603484dd-d2e3-11f0-96ec-088fc35948df','Data Visualization with Python','Create powerful visuals using Matplotlib, Seaborn, and real datasets.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(29,'60348607-d2e3-11f0-96ec-088fc35948df','Creative Logo Design','Learn branding principles, sketching, and digital logo creation skills.',2,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(30,'603486da-d2e3-11f0-96ec-088fc35948df','REST API Security Best Practices','Protect your APIs with JWT, OAuth2, CORS rules, and secure coding standards.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(31,'60348808-d2e3-11f0-96ec-088fc35948df','Social Media Content Creation','Learn lighting, editing, and content planning for Instagram, TikTok, and Facebook.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(32,'6034890c-d2e3-11f0-96ec-088fc35948df','Kotlin for Android Beginners','Build your first Android apps using Kotlin with step-by-step guidance.',3,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(33,'603489b9-d2e3-11f0-96ec-088fc35948df','Copywriting Essentials','Write persuasive marketing content using proven frameworks and real examples.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(34,'60348a56-d2e3-11f0-96ec-088fc35948df','Advanced Data Structures in Java','Master trees, heaps, graphs, and algorithm optimization techniques.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(35,'60348b00-d2e3-11f0-96ec-088fc35948df','Public Speaking Confidence','Learn how to speak clearly and confidently with real-world communication techniques.',2,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(36,'60348ba6-d2e3-11f0-96ec-088fc35948df','Spring Security Deep Dive','A complete guide to user authentication, authorization, and secure architecture.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(37,'60348d03-d2e3-11f0-96ec-088fc35948df','Video Editing for Beginners','Learn editing basics, transitions, audio balancing, and export settings.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(38,'60348dc0-d2e3-11f0-96ec-088fc35948df','Cloud Computing with AWS','Understand EC2, S3, IAM, cloud architecture, and deployment best practices.',3,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(39,'60348e71-d2e3-11f0-96ec-088fc35948df','Music Production Basics','Create beats, mix tracks, and understand audio fundamentals using modern tools.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(40,'60348f18-d2e3-11f0-96ec-088fc35948df','Microservices with Spring Boot','Design microservices using Spring Cloud, Eureka, API Gateway, and distributed systems.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(41,'60348fce-d2e3-11f0-96ec-088fc35948df','Entrepreneurship Fundamentals','Learn how to start, plan, and grow a successful startup with practical frameworks.',2,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(42,'60349075-d2e3-11f0-96ec-088fc35948df','Database Design Principles','Master normalization, relationships, indexing, and schema design best practices.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(43,'60349115-d2e3-11f0-96ec-088fc35948df','Time Management Mastery','Boost productivity with proven time management systems and tools.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(44,'603491b2-d2e3-11f0-96ec-088fc35948df','iOS App Development with Swift','Build iOS apps using Swift, Storyboards, UI components, and API integration.',3,'Inactive','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(45,'603492be-d2e3-11f0-96ec-088fc35948df','Creative Thinking Skills','Enhance your creativity with brainstorming, mind mapping, and problem-solving techniques.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(46,'603493c0-d2e3-11f0-96ec-088fc35948df','Advanced SQL & Query Optimization','Optimize queries, indexes, execution plans, and improve database performance.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(48,'603495d1-d2e3-11f0-96ec-088fc35948df','Java Multithreading Masterclass','Master concurrent programming, synchronization, and scalable architectures.',3,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(49,'603496ff-d2e3-11f0-96ec-088fc35948df','UI Motion Design Basics','Create beautiful micro-interactions and animations for websites and apps.',2,'Active','2025-12-06 20:37:26',NULL,1,NULL,'https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png'),(50,'60349818-d2e3-11f0-96ec-088fc35948df','System Design for Developers','Learn scalable system architecture, load balancing, caching, and real interviews.',3,'Inactive','2025-12-06 20:37:26','2025-12-07 10:27:20',1,1,'media/image/292de8cb-2d24-4425-b93f-b765c4502300.jpg'),(51,'6034992c-d2e3-11f0-96ec-088fc35948df','Freelancing & Client Management','Learn pricing, contracts, communication, and how to build a strong freelance career.',2,'Active','2025-12-06 20:37:26','2025-12-07 08:34:24',1,1,'media/image/7312411b-abcd-47c4-8d0d-58c92481d441.jpeg'),(54,'60349b86-d2e3-11f0-96ec-088fc35948df','API Design Best Practices update test','Design clean, scalable, and maintainable APIs used in large-scale applications.',3,'Inactive','2025-12-06 20:37:26','2025-12-07 17:26:48',1,1,'media/image/1c9569b6-a35c-4ea2-9189-2006b275d86d.jpeg');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_section`
--

LOCK TABLES `course_section` WRITE;
/*!40000 ALTER TABLE `course_section` DISABLE KEYS */;
INSERT INTO `course_section` VALUES (138,4,'Course Introduction','Overview of what you will learn','Welcome to this course. Let’s get started!','text',1,'Inactive','2025-12-06 21:39:12',NULL,1,NULL),(139,4,'Overview Image','Main visual image for understanding the concept','https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png','image',2,'Inactive','2025-12-06 21:39:12',NULL,1,NULL),(140,4,'Main Video Lecture','Primary video lesson covering the core topics','https://www.youtube.com/watch?v=dQw4w9WgXcQ','video',3,'Inactive','2025-12-06 21:39:12',NULL,1,NULL),(141,4,'Deep Dive','Detailed explanation in text form','This section explains all key ideas in depth.','text',4,'Inactive','2025-12-06 21:39:12',NULL,1,NULL),(142,4,'Summary','Short summary of the section','This summarises the core lessons learned.','text',5,'Inactive','2025-12-06 21:39:12',NULL,1,NULL),(148,6,'Course Introduction','Overview of what you will learn','Welcome to this course. Let’s get started!','text',1,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(149,6,'Overview Image','Main visual image for understanding the concept','https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png','image',2,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(150,6,'Main Video Lecture','Primary video lesson covering the core topics','https://www.youtube.com/watch?v=dQw4w9WgXcQ','video',3,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(151,6,'Deep Dive','Detailed explanation in text form','This section explains all key ideas in depth.','text',4,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(152,6,'Summary','Short summary of the section','This summarises the core lessons learned.','text',5,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(153,7,'Course Introduction','Overview of what you will learn','Welcome to this course. Let’s get started!','text',1,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(154,7,'Overview Image','Main visual image for understanding the concept','https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png','image',2,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(155,7,'Main Video Lecture','Primary video lesson covering the core topics','https://www.youtube.com/watch?v=dQw4w9WgXcQ','video',3,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(156,7,'Deep Dive','Detailed explanation in text form','This section explains all key ideas in depth.','text',4,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(158,8,'Course Introduction','Overview of what you will learn','Welcome to this course. Let’s get started!','text',1,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(159,8,'Overview Image','Main visual image for understanding the concept','https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png','image',2,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(160,8,'Main Video Lecture','Primary video lesson covering the core topics','https://www.youtube.com/watch?v=dQw4w9WgXcQ','video',3,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(163,9,'Course Introduction','Overview of what you will learn','Welcome to this course. Let’s get started!','text',1,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(164,9,'Overview Image','Main visual image for understanding the concept','https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png','image',2,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(165,9,'Main Video Lecture','Primary video lesson covering the core topics','https://www.youtube.com/watch?v=dQw4w9WgXcQ','video',3,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(166,9,'Deep Dive','Detailed explanation in text form','This section explains all key ideas in depth.','text',4,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(167,9,'Summary','Short summary of the section','This summarises the core lessons learned.','text',5,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(168,10,'Course Introduction','Overview of what you will learn','Welcome to this course. Let’s get started!','text',1,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(169,10,'Overview Image','Main visual image for understanding the concept','https://foundr.com/wp-content/uploads/2021/09/Best-online-course-platforms.png','image',2,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(170,10,'Main Video Lecture','Primary video lesson covering the core topics','https://www.youtube.com/watch?v=dQw4w9WgXcQ','video',3,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(171,10,'Deep Dive','Detailed explanation in text form','This section explains all key ideas in depth.','text',4,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(172,10,'Summary','Short summary of the section','This summarises the core lessons learned.','text',5,'Inactive','2025-12-06 21:39:32',NULL,1,NULL),(173,54,'test','test','test','image',1,'Inactive',NULL,NULL,1,1),(176,54,'test image','test image','test image','image',5,'Active',NULL,NULL,1,1),(177,54,'test video 2','test video 2','test video 2','video',4,'Active',NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `course_section` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `course_section_BEFORE_DELETE` BEFORE DELETE ON `course_section` FOR EACH ROW BEGIN
    UPDATE course
    SET updated_at = NOW()
    WHERE id = OLD.course_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (3,176,'section',NULL,'media/image/9ead4c98-2aaf-465d-8dd9-60917fc36c54.jpeg','2025-12-07 09:14:58',0),(4,177,'section',NULL,'media/video/b3486807-d927-4a41-a13a-5ba270b0568e.mp4','2025-12-07 09:57:31',0),(5,173,'section',NULL,'media/image/f4277e34-65d4-44b1-9904-5dc1ef66d4f4.jpg','2025-12-07 10:25:46',0);
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_answer`
--

LOCK TABLES `quiz_answer` WRITE;
/*!40000 ALTER TABLE `quiz_answer` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
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
  `first_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(50) NOT NULL,
  `hash_password` varchar(256) NOT NULL,
  `bod` date DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT (_utf8mb4'Pending'),
  `role_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `first_name` (`first_name`),
  UNIQUE KEY `last_name` (`last_name`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'ff27132e-d3a1-11f0-8349-088fc35948df','Hoang','Hao','instructor@gmail.com','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',NULL,'Active',2,'2025-12-07 19:21:57','2025-12-07 19:22:07'),(2,'3c1307e0-d3a4-11f0-8349-088fc35948df','Duc','Quan','trainee@gmail.com','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',NULL,'Active',3,'2025-12-07 19:37:58',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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

-- Dump completed on 2025-12-08  3:32:32
