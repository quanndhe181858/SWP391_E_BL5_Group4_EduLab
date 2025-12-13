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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Lập trình','Các khóa học về lập trình và phát triển phần mềm',NULL),(2,'Thiết kế','Khóa học về thiết kế đồ họa và UI/UX',NULL),(3,'Kinh doanh','Các khóa học về quản trị và phát triển kinh doanh',NULL),(4,'Marketing','Khóa học về marketing và quảng cáo',NULL),(5,'Backend Development','Phát triển phía máy chủ',1),(6,'Frontend Development','Phát triển giao diện người dùng',1),(7,'Mobile Development','Phát triển ứng dụng di động',1),(8,'UI Design','Thiết kế giao diện người dùng',2),(9,'Graphic Design','Thiết kế đồ họa',2),(10,'Maketing Basic','Khóa học về marketing và quảng cáo',4),(11,'Kinh doanh cơ bản','Các khóa học về quản trị và phát triển kinh doanh',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'463e2e7b-d512-11f0-acc1-088fc35948df','Java Spring Boot từ Zero đến Hero','Khóa học toàn diện về Spring Boot, từ cơ bản đến nâng cao. Học cách xây dựng RESTful API, xác thực JWT, tích hợp database, và deploy ứng dụng production-ready.',5,'Active','2025-12-09 15:18:11',NULL,1,NULL,'media/image/spring-boot-course.jpg'),(2,'463e3249-d512-11f0-acc1-088fc35948df','Node.js & Express - Backend Master','Xây dựng backend mạnh mẽ với Node.js và Express. Học MongoDB, authentication, real-time với Socket.io, và các best practices trong phát triển API.',5,'Active','2025-12-09 15:18:11',NULL,1,NULL,'media/image/nodejs-course.jpg'),(3,'463e3359-d512-11f0-acc1-088fc35948df','Python Django cho Web Development','Phát triển web application với Django framework. Từ MVC pattern, ORM, authentication đến deployment trên cloud platform.',5,'Active','2025-12-09 15:18:11',NULL,1,NULL,'media/image/django-course.jpg'),(4,'463e3402-d512-11f0-acc1-088fc35948df','React.js - Modern Web Development','Làm chủ React.js với hooks, context API, Redux, và Next.js. Xây dựng ứng dụng web hiện đại, responsive và performance cao.',6,'Active','2025-12-09 15:18:11','2025-12-10 06:05:12',1,1,'media/image/71670499-960d-4e6f-b2f0-a350c3aafed7.jfif'),(5,'463e34a8-d512-11f0-acc1-088fc35948df','Vue.js Complete Guide','Học Vue.js từ cơ bản đến nâng cao. Composition API, Vuex, Vue Router, và tích hợp với backend API.',6,'Active','2025-12-09 15:18:11','2025-12-10 06:05:01',1,1,'media/image/ed412d02-3074-4150-a64b-935cf9da61e9.jfif'),(6,'463e3537-d512-11f0-acc1-088fc35948df','HTML, CSS & JavaScript Fundamentals','Nền tảng vững chắc cho web development. Học HTML5, CSS3, Flexbox, Grid, và JavaScript ES6+ với các project thực tế.',6,'Active','2025-12-09 15:18:11','2025-12-10 06:04:55',1,1,'media/image/8a67890d-0edf-4144-ab6d-18a82c7bf347.jfif'),(7,'463e35df-d512-11f0-acc1-088fc35948df','Flutter - Xây dựng App Đa nền tảng','Phát triển ứng dụng iOS và Android với Flutter. Dart programming, widget system, state management, và deploy lên store.',7,'Active','2025-12-09 15:18:11','2025-12-10 06:04:50',1,1,'media/image/757e1975-cea8-435b-be87-14e80a270467.png'),(8,'463e3682-d512-11f0-acc1-088fc35948df','React Native - Mobile App Development','Tạo native mobile apps với React Native. Navigation, API integration, push notifications, và app optimization.',7,'Active','2025-12-09 15:18:11','2025-12-10 06:04:44',1,1,'media/image/7869aad5-9b0a-40a4-91ef-1cd0ccdb4454.jfif'),(9,'463e372a-d512-11f0-acc1-088fc35948df','UI/UX Design Bootcamp với Figma','Thiết kế giao diện chuyên nghiệp với Figma. Từ wireframe, prototype đến handoff cho developer. Học design system và accessibility.',8,'Active','2025-12-09 15:18:11','2025-12-10 06:04:37',1,1,'media/image/7d8b590c-9505-46c5-b50e-23be3366e760.png'),(10,'463e37c0-d512-11f0-acc1-088fc35948df','Adobe XD - Thiết kế UI/UX Hiện đại','Sử dụng Adobe XD để tạo mockup, prototype interactive. Học các nguyên tắc thiết kế và user research.',8,'Active','2025-12-09 15:18:11','2025-12-10 06:04:23',1,1,'media/image/2fec032d-46f9-4eb9-8aff-40f06e1c5479.png'),(11,'463e384e-d512-11f0-acc1-088fc35948df','Adobe Photoshop từ Cơ bản đến Nâng cao','Master Photoshop cho graphic design. Layer, mask, filter, color correction, và các kỹ thuật chỉnh sửa ảnh chuyên nghiệp.',9,'Active','2025-12-09 15:18:11','2025-12-10 06:04:15',1,1,'media/image/598ac933-0a2c-465e-ab99-11a9568b1aa6.jpg'),(12,'463e38df-d512-11f0-acc1-088fc35948df','Adobe Illustrator - Vector Graphics Master','Thiết kế vector graphics với Illustrator. Logo design, icon design, typography, và illustration techniques.',9,'Active','2025-12-09 15:18:11','2025-12-10 06:04:04',1,1,'media/image/fed72298-2c73-4953-9c77-4f94ded91cff.jpg'),(13,'463e397b-d512-11f0-acc1-088fc35948df','Digital Marketing Mastery','Chiến lược marketing toàn diện: SEO, SEM, Social Media Marketing, Email Marketing, Analytics và conversion optimization.',10,'Active','2025-12-09 15:18:11','2025-12-10 06:03:56',1,1,'media/image/f3ece4b1-f3ba-4db8-85d5-1e1ccb946922.png'),(14,'463e3a23-d512-11f0-acc1-088fc35948df','Khởi nghiệp và Quản trị Startup','Từ ý tưởng đến sản phẩm. Lean startup, business model canvas, fundraising, và growth hacking strategies.',11,'Active','2025-12-09 15:18:11','2025-12-10 06:03:46',1,1,'media/image/a56b86c5-e0bc-45c7-82ac-e9ae02d8f4b3.jfif'),(15,'463e3ab7-d512-11f0-acc1-088fc35948df','Content Marketing & Copywriting','Viết content thu hút và chuyển đổi. Storytelling, SEO writing, social media content, và email copywriting.',10,'Active','2025-12-09 15:18:11','2025-12-10 06:03:08',1,1,'media/image/12e554e7-2c1d-45cd-9e7f-cba2a65c9104.jfif');
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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_progress`
--

LOCK TABLES `course_progress` WRITE;
/*!40000 ALTER TABLE `course_progress` DISABLE KEYS */;
INSERT INTO `course_progress` VALUES (1,2,9,15,100,'Completed','2025-12-09 15:18:11','2025-11-29 15:18:11',_binary '\0'),(2,2,9,16,100,'Completed','2025-12-09 15:18:11','2025-11-30 15:18:11',_binary '\0'),(3,2,9,17,100,'Completed','2025-12-09 15:18:11','2025-12-01 15:18:11',_binary '\0'),(4,2,9,18,100,'Completed','2025-12-09 15:18:11','2025-12-02 15:18:11',_binary '\0'),(5,2,1,1,100,'Completed','2025-12-10 05:53:44',NULL,_binary '\0'),(6,2,1,2,100,'Completed','2025-12-10 05:53:48',NULL,_binary '\0'),(7,2,1,3,100,'Completed','2025-12-10 05:53:47','2025-12-09 16:04:33',_binary ''),(8,2,4,6,100,'Completed','2025-12-09 15:19:25',NULL,_binary '\0'),(9,2,4,7,40,'InProgress','2025-12-09 15:19:27',NULL,_binary '\0'),(13,2,1,4,100,'Completed','2025-12-10 05:54:28','2025-12-10 05:54:28',_binary '\0'),(14,2,1,5,0,'InProgress','2025-12-10 05:54:27',NULL,_binary '\0'),(19,2,4,8,0,'InProgress','2025-12-09 15:19:31',NULL,_binary '\0'),(21,2,4,9,0,'InProgress','2025-12-09 15:19:30',NULL,_binary '\0');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_section`
--

LOCK TABLES `course_section` WRITE;
/*!40000 ALTER TABLE `course_section` DISABLE KEYS */;
INSERT INTO `course_section` VALUES (1,1,'Giới thiệu Spring Boot và Setup môi trường','Tổng quan về Spring Framework và Spring Boot, cài đặt JDK, IDE, Maven','# Chào mừng đến với khóa học Spring Boot\n\nTrong phần này, bạn sẽ học:\n- Spring Framework là gì và tại sao nên dùng Spring Boot\n- Cài đặt Java JDK 17+\n- Setup IntelliJ IDEA hoặc Eclipse\n- Tạo project đầu tiên với Spring Initializr\n- Hiểu cấu trúc project Spring Boot\n\nSpring Boot giúp đơn giản hóa việc phát triển ứng dụng Spring, loại bỏ nhiều configuration phức tạp.','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(2,1,'Video hướng dẫn Setup Spring Boot Project','Video chi tiết setup môi trường và tạo project đầu tiên','https://www.youtube.com/embed/9SGDpanrc8U','video',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(3,1,'Spring Boot Architecture và Annotations','Hiểu về kiến trúc và các annotation quan trọng','# Spring Boot Architecture\n\n**Các annotation cơ bản:**\n- @SpringBootApplication\n- @RestController\n- @RequestMapping\n- @Autowired\n- @Component, @Service, @Repository\n\n**Dependency Injection và IoC Container:**\nSpring Boot sử dụng Inversion of Control để quản lý dependencies. IoC Container chịu trách nhiệm tạo và quản lý lifecycle của beans.','text',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(4,1,'Xây dựng RESTful API đầu tiên','Tạo CRUD API với Spring Boot','# Xây dựng REST API\n\nTạo một API đơn giản để quản lý Products:\n- GET /api/products - Lấy danh sách\n- GET /api/products/{id} - Lấy chi tiết\n- POST /api/products - Tạo mới\n- PUT /api/products/{id} - Cập nhật\n- DELETE /api/products/{id} - Xóa\n\nSử dụng @RestController và @RequestMapping để định nghĩa endpoints.','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(5,1,'Kết nối Database với Spring Data JPA','Tích hợp MySQL/PostgreSQL và sử dụng JPA','# Spring Data JPA\n\n**Entity và Repository:**\n- Tạo Entity class với @Entity\n- Định nghĩa Repository interface extends JpaRepository\n- Sử dụng các method có sẵn: save(), findById(), findAll(), delete()\n\n**Configuration:**\n```properties\nspring.datasource.url=jdbc:mysql://localhost:3306/edulab\nspring.datasource.username=root\nspring.datasource.password=your_password\nspring.jpa.hibernate.ddl-auto=update\n```','text',5,'Active','2025-12-09 15:18:11',NULL,1,NULL),(6,4,'React Fundamentals - JSX và Components','Học về JSX syntax và cách tạo components','# React Fundamentals\n\n**JSX - JavaScript XML:**\nJSX cho phép viết HTML trong JavaScript. Nó được Babel compile thành React.createElement() calls.\n\n```jsx\nconst element = <h1>Hello, React!</h1>;\n```\n\n**Components:**\n- Function Components (recommended)\n- Class Components (legacy)\n\n```jsx\nfunction Welcome(props) {\n  return <h1>Hello, {props.name}</h1>;\n}\n```','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(7,4,'React Hooks - useState và useEffect','Quản lý state và side effects','# React Hooks\n\n**useState:**\n```jsx\nconst [count, setCount] = useState(0);\n```\n\n**useEffect:**\n```jsx\nuseEffect(() => {\n  // Effect code\n  return () => {\n    // Cleanup\n  };\n}, [dependencies]);\n```\n\nHooks cho phép sử dụng state và lifecycle trong function components.','text',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(8,4,'Demo: Build Todo App với React','Xây dựng ứng dụng Todo hoàn chỉnh','https://www.youtube.com/embed/hQAHSlTtcmY','video',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(9,4,'React Router - Navigation và Routing','Xây dựng multi-page application','# React Router\n\n```jsx\nimport { BrowserRouter, Routes, Route } from \"react-router-dom\";\n\nfunction App() {\n  return (\n    <BrowserRouter>\n      <Routes>\n        <Route path=\"/\" element={<Home />} />\n        <Route path=\"/about\" element={<About />} />\n        <Route path=\"/products/:id\" element={<Product />} />\n      </Routes>\n    </BrowserRouter>\n  );\n}\n```','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(10,4,'State Management với Redux Toolkit','Quản lý global state hiệu quả','# Redux Toolkit\n\n**Store Setup:**\n```jsx\nimport { configureStore } from \"@reduxjs/toolkit\";\nimport counterReducer from \"./counterSlice\";\n\nexport const store = configureStore({\n  reducer: {\n    counter: counterReducer,\n  },\n});\n```\n\nRedux Toolkit đơn giản hóa việc setup và sử dụng Redux.','text',5,'Active','2025-12-09 15:18:11',NULL,1,NULL),(11,7,'Dart Programming Basics','Ngôn ngữ Dart cho Flutter development','# Dart Programming\n\n**Variables và Types:**\n```dart\nvar name = \"Flutter\";\nint age = 5;\ndouble price = 99.99;\nbool isActive = true;\n```\n\n**Functions:**\n```dart\nint add(int a, int b) {\n  return a + b;\n}\n```\n\n**Classes:**\n```dart\nclass Person {\n  String name;\n  int age;\n  \n  Person(this.name, this.age);\n}\n```','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(12,7,'Flutter Widgets - Building UI','StatelessWidget và StatefulWidget','# Flutter Widgets\n\n**StatelessWidget:**\n```dart\nclass MyApp extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return MaterialApp(\n      home: Scaffold(\n        appBar: AppBar(title: Text(\"My App\")),\n        body: Center(child: Text(\"Hello Flutter\")),\n      ),\n    );\n  }\n}\n```\n\n**Common Widgets:**\n- Container, Row, Column\n- Text, Image, Icon\n- Button, TextField\n- ListView, GridView','text',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(13,7,'Flutter Layouts và Navigation','Xây dựng giao diện và điều hướng màn hình','https://www.youtube.com/embed/1xipg02Wu8s','video',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(14,7,'State Management với Provider','Quản lý state trong Flutter app','# Provider Pattern\n\n```dart\nclass CounterModel extends ChangeNotifier {\n  int _count = 0;\n  int get count => _count;\n  \n  void increment() {\n    _count++;\n    notifyListeners();\n  }\n}\n\n// Usage\nProvider.of<CounterModel>(context).increment();\n```','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(15,9,'UI/UX Design Principles','Các nguyên tắc thiết kế cơ bản','# Design Principles\n\n**1. Visual Hierarchy:**\n- Size, color, contrast\n- Typography scale\n- Spacing và alignment\n\n**2. Consistency:**\n- Design system\n- Component library\n- Style guide\n\n**3. User-Centered Design:**\n- User research\n- Personas\n- User journey mapping\n\n**4. Accessibility:**\n- Color contrast (WCAG)\n- Keyboard navigation\n- Screen reader support','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(16,9,'Figma Basics - Interface và Tools','Làm quen với Figma workspace','https://www.youtube.com/embed/FTFaQWZBqQ8','video',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(17,9,'Wireframing và Prototyping','Từ sketch đến interactive prototype','# Wireframe to Prototype\n\n**Low-fidelity Wireframes:**\n- Sketch layout structure\n- Define information architecture\n- Focus on functionality\n\n**High-fidelity Mockups:**\n- Add visual design\n- Typography và color\n- Images và content\n\n**Interactive Prototype:**\n- Connect frames\n- Add interactions\n- Test user flow','text',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(18,9,'Design System và Component Library','Xây dựng hệ thống thiết kế nhất quán','# Design System\n\n**Components:**\n- Buttons (primary, secondary, text)\n- Input fields\n- Cards\n- Navigation\n- Modals\n\n**Tokens:**\n- Colors (primary, secondary, neutral)\n- Typography (headings, body, caption)\n- Spacing (4px, 8px, 16px, 24px...)\n- Border radius\n- Shadows','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL),(19,13,'Digital Marketing Overview','Tổng quan về marketing số','# Digital Marketing Channels\n\n**1. SEO (Search Engine Optimization):**\n- On-page SEO\n- Off-page SEO\n- Technical SEO\n\n**2. SEM (Search Engine Marketing):**\n- Google Ads\n- Bing Ads\n- PPC campaigns\n\n**3. Social Media Marketing:**\n- Facebook/Instagram Ads\n- LinkedIn Marketing\n- TikTok Marketing\n\n**4. Email Marketing:**\n- Newsletter campaigns\n- Automation workflows\n- Segmentation\n\n**5. Content Marketing:**\n- Blog posts\n- Videos\n- Infographics','text',1,'Active','2025-12-09 15:18:11',NULL,1,NULL),(20,13,'SEO Fundamentals','Tối ưu hóa công cụ tìm kiếm','# SEO Basics\n\n**Keyword Research:**\n- Google Keyword Planner\n- Search volume và competition\n- Long-tail keywords\n\n**On-Page SEO:**\n- Title tags và meta descriptions\n- Header tags (H1, H2, H3)\n- Internal linking\n- Image alt text\n\n**Content Optimization:**\n- Quality content\n- User intent\n- Readability\n- Freshness','text',2,'Active','2025-12-09 15:18:11',NULL,1,NULL),(21,13,'Google Ads Campaign Setup','Chạy quảng cáo Google hiệu quả','https://www.youtube.com/embed/jS-wGmNV0o8','video',3,'Active','2025-12-09 15:18:11',NULL,1,NULL),(22,13,'Social Media Strategy','Xây dựng chiến lược mạng xã hội','# Social Media Strategy\n\n**Platform Selection:**\n- Demographics của từng platform\n- Business goals\n- Content type\n\n**Content Calendar:**\n- Planning posts\n- Consistency\n- Engagement timing\n\n**Metrics to Track:**\n- Reach và impressions\n- Engagement rate\n- Click-through rate\n- Conversions','text',4,'Active','2025-12-09 15:18:11',NULL,1,NULL);
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
INSERT INTO `enrollment` VALUES (1,2,'Learning'),(2,2,'Learning'),(3,2,'Learning'),(4,2,'Learning'),(7,2,'Learning'),(9,2,'Completed'),(13,2,'Learning');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,1,'course','image/jpeg','media/image/spring-boot-course.jpg','2025-12-09 15:18:11',1),(2,2,'course','image/jpeg','media/image/nodejs-course.jpg','2025-12-09 15:18:11',1),(3,3,'course','image/jpeg','media/image/django-course.jpg','2025-12-09 15:18:11',1),(4,4,'course','image/jpeg','media/image/react-course.jpg','2025-12-09 15:18:11',1),(5,5,'course','image/jpeg','media/image/vue-course.jpg','2025-12-09 15:18:11',1),(6,6,'course','image/jpeg','media/image/html-css-js.jpg','2025-12-09 15:18:11',1),(7,7,'course','image/jpeg','media/image/flutter-course.jpg','2025-12-09 15:18:11',1),(8,8,'course','image/jpeg','media/image/react-native-course.jpg','2025-12-09 15:18:11',1),(9,9,'course','image/jpeg','media/image/figma-course.jpg','2025-12-09 15:18:11',1),(10,10,'course','image/jpeg','media/image/adobe-xd-course.jpg','2025-12-09 15:18:11',1),(11,11,'course','image/jpeg','media/image/photoshop-course.jpg','2025-12-09 15:18:11',1),(12,12,'course','image/jpeg','media/image/illustrator-course.jpg','2025-12-09 15:18:11',1),(13,13,'course','image/jpeg','media/image/digital-marketing.jpg','2025-12-09 15:18:11',1),(14,14,'course','image/jpeg','media/image/startup-course.jpg','2025-12-09 15:18:11',1),(15,15,'course','image/jpeg','media/image/copywriting-course.jpg','2025-12-09 15:18:11',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (1,'Spring Boot là gì?','single',1,'2025-12-09 15:18:11',NULL,1,1),(2,'Annotation nào được sử dụng để đánh dấu một class là REST Controller?','single',1,'2025-12-09 15:18:11',NULL,1,1),(3,'Dependency Injection trong Spring Boot giúp gì?','multiple',1,'2025-12-09 15:18:11',NULL,1,1),(4,'IoC Container trong Spring Boot có vai trò gì?','single',1,'2025-12-09 15:18:11',NULL,1,1),(5,'JSX là gì trong React?','single',1,'2025-12-09 15:18:11',NULL,1,1),(6,'Hook nào được sử dụng để quản lý state trong Function Component?','single',1,'2025-12-09 15:18:11',NULL,1,1),(7,'Khi nào useEffect được gọi?','multiple',1,'2025-12-09 15:18:11',NULL,1,1),(8,'Props trong React có đặc điểm gì?','single',1,'2025-12-09 15:18:11',NULL,1,1),(9,'Visual Hierarchy trong thiết kế UI có mục đích gì?','single',2,'2025-12-09 15:18:11',NULL,1,1),(10,'WCAG là gì trong accessibility?','single',2,'2025-12-09 15:18:11',NULL,1,1),(11,'Wireframe và Mockup khác nhau như thế nào?','multiple',2,'2025-12-09 15:18:11',NULL,1,1),(12,'Design System bao gồm những gì?','multiple',2,'2025-12-09 15:18:11',NULL,1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_answer`
--

LOCK TABLES `quiz_answer` WRITE;
/*!40000 ALTER TABLE `quiz_answer` DISABLE KEYS */;
INSERT INTO `quiz_answer` VALUES (1,1,1,'text','Framework giúp đơn giản hóa việc phát triển ứng dụng Spring','2025-12-09 15:18:11',NULL,1,1),(2,1,0,'text','Một database management system','2025-12-09 15:18:11',NULL,1,1),(3,1,0,'text','Một ngôn ngữ lập trình mới','2025-12-09 15:18:11',NULL,1,1),(4,1,0,'text','Một IDE cho Java','2025-12-09 15:18:11',NULL,1,1),(5,2,1,'text','@RestController','2025-12-09 15:18:11',NULL,1,1),(6,2,0,'text','@Controller','2025-12-09 15:18:11',NULL,1,1),(7,2,0,'text','@Component','2025-12-09 15:18:11',NULL,1,1),(8,2,0,'text','@Service','2025-12-09 15:18:11',NULL,1,1),(9,3,1,'text','Giảm coupling giữa các class','2025-12-09 15:18:11',NULL,1,1),(10,3,1,'text','Dễ dàng test code','2025-12-09 15:18:11',NULL,1,1),(11,3,1,'text','Quản lý dependencies tự động','2025-12-09 15:18:11',NULL,1,1),(12,3,0,'text','Tăng tốc độ chạy ứng dụng','2025-12-09 15:18:11',NULL,1,1),(13,5,1,'text','Cú pháp cho phép viết HTML trong JavaScript','2025-12-09 15:18:11',NULL,1,1),(14,5,0,'text','Một thư viện CSS','2025-12-09 15:18:11',NULL,1,1),(15,5,0,'text','Một testing framework','2025-12-09 15:18:11',NULL,1,1),(16,5,0,'text','Một build tool','2025-12-09 15:18:11',NULL,1,1),(17,6,1,'text','useState','2025-12-09 15:18:11',NULL,1,1),(18,6,0,'text','useContext','2025-12-09 15:18:11',NULL,1,1),(19,6,0,'text','useReducer','2025-12-09 15:18:11',NULL,1,1),(20,6,0,'text','useRef','2025-12-09 15:18:11',NULL,1,1),(21,9,1,'text','Hướng dẫn mắt người dùng đến các thông tin quan trọng nhất','2025-12-09 15:18:11',NULL,1,1),(22,9,0,'text','Làm cho thiết kế đẹp hơn','2025-12-09 15:18:11',NULL,1,1),(23,9,0,'text','Tăng tốc độ load trang','2025-12-09 15:18:11',NULL,1,1),(24,9,0,'text','Giảm dung lượng file','2025-12-09 15:18:11',NULL,1,1),(25,10,1,'text','Web Content Accessibility Guidelines - hướng dẫn về khả năng tiếp cận web','2025-12-09 15:18:11',NULL,1,1),(26,10,0,'text','World Wide Web Consortium - tổ chức tiêu chuẩn web','2025-12-09 15:18:11',NULL,1,1),(27,10,0,'text','Website Configuration And Guidelines','2025-12-09 15:18:11',NULL,1,1),(28,10,0,'text','Web Color Accessibility Guide','2025-12-09 15:18:11',NULL,1,1);
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
INSERT INTO `quiz_test` VALUES (1,1),(2,1),(3,1),(4,1),(1,2),(2,2),(5,3),(6,3),(8,3),(6,4),(7,4),(9,5),(10,5),(11,5),(12,5);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'SPRING_Q1','Quiz: Spring Boot Basics','Kiểm tra kiến thức cơ bản về Spring Boot và Dependency Injection',15,70,1,3,'2025-12-09 15:18:11',NULL,1,1),(2,'SPRING_Q2','Quiz: Spring Data JPA','Đánh giá hiểu biết về JPA và database integration',20,70,1,5,'2025-12-09 15:18:11',NULL,1,1),(3,'REACT_Q1','Quiz: React Fundamentals','Kiểm tra JSX, Components và Props',15,70,4,6,'2025-12-09 15:18:11',NULL,1,1),(4,'REACT_Q2','Quiz: React Hooks','Đánh giá useState và useEffect',20,70,4,7,'2025-12-09 15:18:11',NULL,1,1),(5,'UXDES_Q1','Quiz: Design Principles','Kiểm tra các nguyên tắc thiết kế UI/UX',15,70,9,15,'2025-12-09 15:18:11',NULL,1,1);
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
INSERT INTO `test_attempt` VALUES (2,1,2,65,'Retaking'),(2,3,1,90,'Passed'),(2,5,1,85.5,'Passed');
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

-- Dump completed on 2025-12-10 13:05:45
