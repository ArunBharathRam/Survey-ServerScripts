-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 05, 2017 at 06:29 PM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `survey`
--
CREATE DATABASE IF NOT EXISTS `survey` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `survey`;

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `user_id` int(11) DEFAULT NULL,
  `questions_id` int(11) DEFAULT NULL,
  `options_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `survey_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `custom_answers`
--

CREATE TABLE `custom_answers` (
  `users_id` int(11) DEFAULT NULL,
  `questions_id` int(11) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(11) NOT NULL,
  `questions_id` int(11) DEFAULT NULL,
  `option` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `questions_id`, `option`) VALUES
(1, 1, 'Chappathi'),
(2, 1, 'Paratha'),
(3, 1, 'Kebab'),
(4, 1, 'Pulao'),
(5, 1, 'Aloo Recipe'),
(6, 2, 'Idli'),
(7, 2, 'Dosa'),
(8, 2, 'Sambar Rice'),
(9, 2, 'Fish Curry'),
(10, 2, 'Sambar Idli'),
(11, 3, 'Alutua'),
(12, 3, 'Amer Chatni'),
(13, 3, 'Chanar Bara'),
(14, 3, 'Lavang Latika'),
(15, 4, 'Daal Parantha'),
(16, 4, 'Khaman'),
(17, 4, 'Khichu'),
(18, 4, 'Masala Puri'),
(19, 9, 'Amitabh Bachan'),
(20, 9, 'Amir Khan'),
(21, 10, 'Rajni'),
(22, 10, 'Kamal'),
(23, 11, 'Renu Saikia'),
(24, 11, 'Moghai Ojah'),
(25, 12, 'Naresh Kanodia'),
(26, 12, 'Sanjeev Kumar'),
(27, 13, 'Trisha'),
(28, 13, 'Nayanthara'),
(29, 13, 'Samantha'),
(30, 13, 'Amy Jackson'),
(31, 13, 'Tamannah');

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `organization`
--

INSERT INTO `organization` (`id`, `name`) VALUES
(3, 'Facile'),
(2, 'Hunt'),
(1, 'Thinnovators');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `survey_id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `compulsory` tinyint(1) DEFAULT '0',
  `is_custom` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `survey_id`, `question`, `compulsory`, `is_custom`) VALUES
(1, 1, 'Favourite North Indian Food', 0, 0),
(2, 1, 'Favourite South Indian Food', 0, 0),
(3, 1, 'Favourite Food from Eastern Parts of India', 0, 0),
(4, 1, 'Favourite Food from Western parts of India', 0, 0),
(9, 2, 'Favourite Bollywood Actor', 0, 0),
(10, 2, 'Favourite Kollywood', 0, 0),
(11, 2, 'Favourite Assam Actor ', 0, 0),
(12, 2, 'Favourite Gujarati Actor', 0, 0),
(13, 3, 'Favourite Kollywood Actress', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `survey`
--

CREATE TABLE `survey` (
  `id` int(11) NOT NULL,
  `organization_id` int(11) NOT NULL,
  `title` varchar(80) NOT NULL,
  `instructions` varchar(255) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `survey`
--

INSERT INTO `survey` (`id`, `organization_id`, `title`, `instructions`, `created_on`) VALUES
(1, 1, 'Favourite Indian Food', 'This is a survey to find out the favourite Indian food from all parts of India', '2015-12-23 18:39:16'),
(2, 2, 'Favourite Actor of India', 'A survey to find the favourite actor from all over India', '2015-12-23 18:59:45'),
(3, 3, 'Favourite Actress of Kollywood', 'This is a survey to find the favourite actress of South India', '2015-12-23 19:09:53');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `email` varchar(80) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `password` char(255) DEFAULT NULL,
  `is_google` tinyint(1) NOT NULL DEFAULT '0',
  `last_login` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `is_google`, `last_login`) VALUES
(13, 'Prathab', 'jm.prathab@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 0, '2017-01-05 22:59:00'),
(14, 'test', 'test', '098f6bcd4621d373cade4e832627b4f6', 0, '2017-01-05 22:59:05');

-- --------------------------------------------------------

--
-- Table structure for table `user_surveys`
--

CREATE TABLE `user_surveys` (
  `survey_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `completed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD KEY `fk_answers_users_idx` (`user_id`),
  ADD KEY `fk_answers_questions_idx` (`questions_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD KEY `fk_comments_survey_idx` (`survey_id`),
  ADD KEY `fk_comments_users_idx` (`user_id`);

--
-- Indexes for table `custom_answers`
--
ALTER TABLE `custom_answers`
  ADD KEY `fk_custom_answers_users_idx` (`users_id`),
  ADD KEY `fk_custom_answers_questions_idx` (`questions_id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_options_questions_idx` (`questions_id`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_questions_survey_idx` (`survey_id`);

--
-- Indexes for table `survey`
--
ALTER TABLE `survey`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_survey_organization_idx` (`organization_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `user_surveys`
--
ALTER TABLE `user_surveys`
  ADD KEY `fk_user_surveys_users_idx` (`user_id`),
  ADD KEY `fk_user_surveys_survey_idx` (`survey_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `organization`
--
ALTER TABLE `organization`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `survey`
--
ALTER TABLE `survey`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `fk_answers_questions` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_answers_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_survey` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_comments_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `custom_answers`
--
ALTER TABLE `custom_answers`
  ADD CONSTRAINT `fk_custom_answers_questions` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_custom_answers_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `options`
--
ALTER TABLE `options`
  ADD CONSTRAINT `fk_options_questions` FOREIGN KEY (`questions_id`) REFERENCES `questions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `fk_questions_survey` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `survey`
--
ALTER TABLE `survey`
  ADD CONSTRAINT `fk_survey_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_surveys`
--
ALTER TABLE `user_surveys`
  ADD CONSTRAINT `fk_user_surveys_survey` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_surveys_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
