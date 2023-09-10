SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `goodlearn` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `goodlearn`;

DROP TABLE IF EXISTS `catagorized_in`;
CREATE TABLE IF NOT EXISTS `catagorized_in` (
  `CS-id` int(8) NOT NULL,
  `CAT_name` varchar(255) NOT NULL,
  PRIMARY KEY (`CS-id`,`CAT_name`),
  KEY `catagory_name` (`CAT_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `catagory`;
CREATE TABLE IF NOT EXISTS `catagory` (
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `content`;
CREATE TABLE IF NOT EXISTS `content` (
  `CNT_ID` int(8) NOT NULL,
  `CNT_Title` varchar(255) NOT NULL,
  `CNT_TYPE` varchar(255) NOT NULL,
  `CNT_URL` varchar(255) NOT NULL,
  `sec-id` int(8) NOT NULL,
  PRIMARY KEY (`CNT_ID`),
  KEY `sec-id` (`sec-id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `course`;
CREATE TABLE IF NOT EXISTS `course` (
  `CS_ID` int(8) NOT NULL,
  `CS_NAME` varchar(255) NOT NULL,
  `CS_description` text NOT NULL,
  `CS_rating` decimal(2,2) NOT NULL,
  `instructor` int(10) NOT NULL,
  PRIMARY KEY (`CS_ID`),
  KEY `instructor_id` (`instructor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `enroll`;
CREATE TABLE IF NOT EXISTS `enroll` (
  `Ln-id` int(10) NOT NULL,
  `CS-id` int(8) NOT NULL,
  PRIMARY KEY (`Ln-id`,`CS-id`),
  KEY `crs-id` (`CS-id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `instructor_acc`;
CREATE TABLE IF NOT EXISTS `instructor_acc` (
  `IN_ID` int(10) NOT NULL,
  `U_Email` varchar(320) NOT NULL,
  PRIMARY KEY (`IN_ID`),
  KEY `U-email` (`U_Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `learner_acc`;
CREATE TABLE IF NOT EXISTS `learner_acc` (
  `LN_ID` int(10) NOT NULL,
  `U_Email` varchar(320) NOT NULL,
  PRIMARY KEY (`LN_ID`),
  KEY `U_email` (`U_Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
  `SEC_ID` int(8) NOT NULL,
  `SEC_NAME` varchar(255) NOT NULL,
  `cs-id` int(8) NOT NULL,
  PRIMARY KEY (`SEC_ID`),
  KEY `cs-id` (`cs-id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `Email` varchar(320) NOT NULL,
  `Password` varchar(64) NOT NULL,
  `RealName` varchar(255) NOT NULL,
  `PFP` mediumblob DEFAULT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `catagorized_in`
  ADD CONSTRAINT `catagory_name` FOREIGN KEY (`CAT_name`) REFERENCES `catagory` (`name`),
  ADD CONSTRAINT `course-id` FOREIGN KEY (`CS-id`) REFERENCES `course` (`CS_ID`);

ALTER TABLE `content`
  ADD CONSTRAINT `sec-id` FOREIGN KEY (`sec-id`) REFERENCES `section` (`SEC_ID`);

ALTER TABLE `course`
  ADD CONSTRAINT `instructor_id` FOREIGN KEY (`instructor`) REFERENCES `instructor_acc` (`IN_ID`);

ALTER TABLE `enroll`
  ADD CONSTRAINT `crs-id` FOREIGN KEY (`CS-id`) REFERENCES `course` (`CS_ID`),
  ADD CONSTRAINT `lrn-id` FOREIGN KEY (`Ln-id`) REFERENCES `learner_acc` (`LN_ID`);

ALTER TABLE `instructor_acc`
  ADD CONSTRAINT `U-email` FOREIGN KEY (`U_Email`) REFERENCES `user` (`Email`);

ALTER TABLE `learner_acc`
  ADD CONSTRAINT `U_email` FOREIGN KEY (`U_Email`) REFERENCES `user` (`Email`);

ALTER TABLE `section`
  ADD CONSTRAINT `cs-id` FOREIGN KEY (`cs-id`) REFERENCES `course` (`CS_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
