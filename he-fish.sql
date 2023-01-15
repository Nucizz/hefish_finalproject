-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2023 at 03:19 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `he-fish`
--

-- --------------------------------------------------------

--
-- Table structure for table `fishes`
--

CREATE TABLE `fishes` (
  `fish_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fish_type_id` int(11) DEFAULT NULL,
  `fish_name` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `image_path` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fishes`
--

INSERT INTO `fishes` (`fish_id`, `user_id`, `fish_type_id`, `fish_name`, `description`, `price`, `image_path`) VALUES
(8, 1, 1, 'gtww', 'gtw dahhh', 123000, 'http://10.0.2.2:3000/assets/bggg.jpg'),
(10, 1, 1, 'gtww anjk', 'gtw anjk', 223000, 'http://10.0.2.2:3000/assets/bgss.jpg'),
(12, 1, 1, 'gtww dah', 'gtw dah', 111000, 'http://10.0.2.2:3000/assets/bgggg.png'),
(13, 1, 2, 'asdf', 'asdf', 123000, 'http://10.0.2.2:3000/assets/bgss.jpg'),
(14, 1, 3, 'wtff', 'wtff', 666000, 'http://10.0.2.2:3000/assets/bgss.jpg'),
(15, 1, 1, 'bodo amat', 'hehe', 333000, 'http://10.0.2.2:3000/assets/bgss.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `fish_types`
--

CREATE TABLE `fish_types` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fish_types`
--

INSERT INTO `fish_types` (`id`, `name`) VALUES
(1, 'fresh'),
(2, 'salt'),
(3, 'brackish');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(50) NOT NULL,
  `token` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `token`) VALUES
(1, 'jonathan@gmail.com', 'jonathan123', 'jonathan123', '12345'),
(2, 'blujek221@gmail.com', 'blujek221', 'blujek221', '12345');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fishes`
--
ALTER TABLE `fishes`
  ADD PRIMARY KEY (`fish_id`),
  ADD KEY `fish_type_idConstraint` (`fish_type_id`),
  ADD KEY `userFK` (`user_id`);

--
-- Indexes for table `fish_types`
--
ALTER TABLE `fish_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fishes`
--
ALTER TABLE `fishes`
  MODIFY `fish_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fishes`
--
ALTER TABLE `fishes`
  ADD CONSTRAINT `fish_type_idConstraint` FOREIGN KEY (`fish_type_id`) REFERENCES `fish_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userFK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
