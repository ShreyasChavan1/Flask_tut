-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 31, 2023 at 06:20 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codewithme`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `srno` int(11) NOT NULL,
  `name` text NOT NULL,
  `mobile` int(15) NOT NULL,
  `msg` text NOT NULL,
  `email` varchar(200) NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`srno`, `name`, `mobile`, `msg`, `email`, `date`) VALUES
(1, 'first commenter', 838383838, 'hello where much apprecieted', 'st@gmail.com', '2023-12-26 20:20:33'),
(2, 'shreyas chavan', 2147483647, 'ddfdf', 'chavanshreyas120@gmail.com', '2023-12-26 20:49:14'),
(3, 'hello world dkd', 33993293, ' patt se headshot', 'dddkdk@gmail.com', '2023-12-27 11:09:46'),
(4, 'ema', 38338333, 'pls bhai email send hoza', 'idiotshark201@gmail.com', '2023-12-27 12:30:23'),
(5, 'ema', 38338333, 'pls bhai email send hoza', 'idiotshark201@gmail.com', '2023-12-27 12:38:58'),
(6, 'ema', 38338333, 'pls bhai email send hoza', 'idiotshark201@gmail.com', '2023-12-27 12:39:03'),
(7, 'ema', 38338333, 'pls bhai email send hoza', 'idiotshark201@gmail.com', '2023-12-27 12:39:29'),
(8, 'ema', 38338333, 'pls bhai email send hoza', 'idiotshark201@gmail.com', '2023-12-27 12:40:08'),
(9, 'ema', 38338333, 'pls bhai email send hoza', 'idiotshark201@gmail.com', '2023-12-27 12:45:17');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `srno` int(10) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `img_src` varchar(20) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`srno`, `title`, `tagline`, `slug`, `content`, `img_src`, `date`) VALUES
(2, 'Basics of stock market', 'stock basics', 'stock-post', 'Global marketing is defined as “marketing on a worldwide scale reconciling or taking global operational differences, similarities and opportunities in order to reach global objectives\".[1][2]\r\n\r\nGlobal marketing is also a field of study in general business management that markets products, solutions and services to customers locally, nationally, and internationally.[3]\r\n\r\nInternational marketing is the application of marketing principles in more than one country, by companies overseas or across national borders.[4] It is done through the export of a company\'s product into another location or entry through a joint venture with another firm within the country, or foreign direct investment into the country. International marketing is required for the development of the marketing mix for the country.[5] International marketing includes the use of existing marketing strategies, mix and tools for export, relationship strategies such as localization, local product offerings, pricing, production and distribution with customized promotions, offers, website, social media and leadership.', 'data:image/jpeg;base', '2023-12-29 13:05:25'),
(3, 'this is 3rd blog', 'hello there', 'third-blog', 'how are you i am fine thank you for always reading my blogs and please do share if you find this blog informative fine', 'home-bg.jpg', '2023-12-30 12:08:53'),
(4, 'python blog', 'basic of python', 'python-post', 'dfdsgagdbad', 'home-bg.jpg', '2023-12-30 14:46:26'),
(5, 'python blog', 'hello there', 'python-post', 'hidjjdbjajbvjjk;ndldk;fnd', 'home-bg.jpg', '2023-12-30 19:25:44'),
(6, 'dgbagdfd', 'ddd', 'dfdd', 'dfdgasbaddfddd', 'dfdfd', '2023-12-30 19:25:56'),
(7, 'dfdsvdad', 'cvdad', 'vddvdxcv', 'dfdgdgd', 'dfdgad', '2023-12-30 19:26:05'),
(8, 'latest blog', 'hello there', 'latest-blog', 'how are you i am fine thank you', 'contact-bg.jpg', '2023-12-30 23:03:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`srno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`srno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `srno` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
