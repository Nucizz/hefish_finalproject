-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 15, 2023 at 07:30 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fishes`
--

INSERT INTO `fishes` (`fish_id`, `user_id`, `fish_type_id`, `fish_name`, `description`, `price`, `image_path`) VALUES
(34, 17, 3, 'Archer Fish', 'Silver body, black stripes, and a turned-up mouth', 4000, 'assets/image_picker2273397921847451907.png'),
(35, 17, 3, 'Colombian Shark Catfish', 'Silver body and white-tipped fins on its underside', 2800, 'assets/image_picker8642663710757173859.png'),
(36, 17, 3, 'Bumblebee Goby Tiger', 'Black body with gold vertical stripes on the head', 7000, 'assets/image_picker1230163026560013328.png'),
(37, 17, 3, 'Scat Fish', 'Green to brown colored bodies with blackish spots', 15000, 'assets/image_picker8543217874293619524.png'),
(38, 17, 3, 'White Pot Belly Molly', 'Silver to white body with fat belly and long fins', 25000, 'assets/image_picker8844001040521264489.jpg'),
(39, 17, 1, 'Gold Fish', 'Dont have barbel sensory organ', 33000, 'assets/image_picker9057777019565147851.png'),
(40, 17, 1, 'Sword Tail Fish', 'elongated fish, growing to about 13 centimetres', 43000, 'assets/image_picker4482263380891785267.png'),
(41, 17, 1, 'Fancy Guppy', 'known for their especially bright colors', 52000, 'assets/image_picker7762045168282690085.png'),
(42, 18, 1, 'Betta Fish', 'Usually small, from 2.4 to 3.1 inches long', 48000, 'assets/image_picker7087853423217314437.png'),
(43, 18, 1, 'Kill Fish', 'Usually elongated of the family Cyprinodontidae', 37000, 'assets/image_picker2166801960375140181.png'),
(44, 18, 2, 'Angel Fish', 'Native to the tropical South America', 45000, 'assets/image_picker881094688602477913.png'),
(45, 18, 2, 'Clown Fish', 'Bright orange with three distinctive white bars', 30000, 'assets/image_picker660982867206209390.png'),
(46, 23, 2, 'Yellow Gobies Fish', 'Usually small, and found throughout the world', 22500, 'assets/image_picker726610843454261807.png'),
(47, 23, 2, 'Lion Fish', 'Marine species that are primarily red', 43000, 'assets/image_picker4779788004290911232.png'),
(48, 23, 2, 'Squirrel Fish', 'Spiny fins and rough, prickly scales', 35000, 'assets/image_picker4256839255647062778.png');

-- --------------------------------------------------------

--
-- Table structure for table `fish_types`
--

CREATE TABLE `fish_types` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fish_types`
--

INSERT INTO `fish_types` (`id`, `name`) VALUES
(1, 'Fresh Water'),
(2, 'Salt Water'),
(3, 'Brackish Water');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `token`) VALUES
(17, 'calvin.suciawan@binus.ac.id', 'nuciz', '5742984990', ''),
(18, 'jonathanraine@gmail.com', 'raineonme', '-2943943280', ''),
(22, 'calvinanacia136@gmail.com', 'calvinanacia136', '', 'Ib3mXknsSH'),
(23, 'alfrid.putra@gmail.com', 'alfridsanjaya03', '-2454403873', '');

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
  MODIFY `fish_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

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
