-- --------------------------------------------------------
-- Host:                         jommakan.cfogfqygdcer.us-east-1.rds.amazonaws.com
-- Server version:               10.6.14-MariaDB-log - managed by https://aws.amazon.com/rds/
-- Server OS:                    Linux
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for jommakan
DROP DATABASE IF EXISTS `jommakan`;
CREATE DATABASE IF NOT EXISTS `jommakan` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_bin */;
USE `jommakan`;

-- Dumping structure for table jommakan.cart
DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cartID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  `foodID` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `no_vege` varchar(50) DEFAULT NULL,
  `extra_vege` varchar(50) DEFAULT NULL,
  `no_spicy` varchar(50) DEFAULT NULL,
  `extra_spicy` varchar(50) DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cartID`),
  KEY `FK__users` (`userID`),
  CONSTRAINT `FK__users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.cart: ~1 rows (approximately)
INSERT INTO `cart` (`cartID`, `userID`, `foodID`, `quantity`, `no_vege`, `extra_vege`, `no_spicy`, `extra_spicy`, `notes`) VALUES
	(56, 1, 2, 1, '0', '0', '0', '0', '');

-- Dumping structure for table jommakan.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.categories: ~8 rows (approximately)
INSERT INTO `categories` (`categoryID`, `category_name`) VALUES
	(1, 'Rice'),
	(2, 'Noodle'),
	(3, 'Bread'),
	(4, 'Cake'),
	(5, 'Drinks'),
	(6, 'Spaghetti'),
	(7, 'Pizza'),
	(8, 'Burger'),
	(9, 'Sushi'),
	(10, 'Western');

-- Dumping structure for table jommakan.delivery
DROP TABLE IF EXISTS `delivery`;
CREATE TABLE IF NOT EXISTS `delivery` (
  `deliveryID` int(11) NOT NULL AUTO_INCREMENT,
  `orderID` int(11) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `orderedOn` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `rider_in_charge` int(11) DEFAULT NULL,
  PRIMARY KEY (`deliveryID`),
  KEY `FK_delivery_orders` (`orderID`),
  KEY `FK_delivery_riders` (`rider_in_charge`),
  CONSTRAINT `FK_delivery_orders` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_delivery_riders` FOREIGN KEY (`rider_in_charge`) REFERENCES `riders` (`riderID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.delivery: ~12 rows (approximately)
INSERT INTO `delivery` (`deliveryID`, `orderID`, `address`, `orderedOn`, `status`, `rider_in_charge`) VALUES
	(3, 17, '', '29-Nov-2023 16:45:14', 'Completed', 1),
	(4, 22, 'sssss', '01-Dec-2023 13:58:53', 'Pending', NULL),
	(5, 23, '', '01-Dec-2023 14:57:18', 'Pending', NULL),
	(6, 24, '', '01-Dec-2023 14:59:03', 'Pending', NULL),
	(7, 25, '', '01-Dec-2023 15:02:26', 'In progress', 1),
	(8, 28, '', '05-Dec-2023 16:59:31', 'Completed', 1),
	(9, 29, '', '05-Dec-2023 17:00:26', 'Completed', 3),
	(10, 30, '', '05-Dec-2023 17:02:25', 'In progress', 1),
	(11, 40, '', '08-Dec-2023 18:19:28', 'Completed', 6),
	(12, 42, '', '10-Dec-2023 00:44:32', 'Pending', NULL),
	(13, 49, 'ujj', '11-Dec-2023 19:25:36', 'Completed', 4),
	(14, 51, 'Block K', '13-Dec-2023 15:32:49', 'Completed', 6);

-- Dumping structure for table jommakan.favorites
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE IF NOT EXISTS `favorites` (
  `favoritesID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  `foodID` int(11) DEFAULT NULL,
  PRIMARY KEY (`favoritesID`),
  KEY `FK_favorites_users` (`userID`),
  KEY `FK_favorites_foods` (`foodID`),
  CONSTRAINT `FK_favorites_foods` FOREIGN KEY (`foodID`) REFERENCES `foods` (`foodID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_favorites_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.favorites: ~9 rows (approximately)
INSERT INTO `favorites` (`favoritesID`, `userID`, `foodID`) VALUES
	(7, 1, 3),
	(8, 1, 4),
	(13, 1, 5),
	(16, 1, 2),
	(17, 8, 6),
	(18, 8, 5),
	(19, 8, 4),
	(20, 8, 10),
	(21, 8, 2),
	(23, 14, 3);

-- Dumping structure for table jommakan.foods
DROP TABLE IF EXISTS `foods`;
CREATE TABLE IF NOT EXISTS `foods` (
  `foodID` int(11) NOT NULL AUTO_INCREMENT,
  `food_name` varchar(50) DEFAULT NULL,
  `stallID` int(11) DEFAULT NULL,
  `main_category` int(11) DEFAULT NULL,
  `sub_category` int(11) DEFAULT NULL,
  `food_price` double DEFAULT NULL,
  `qty_in_stock` int(11) DEFAULT NULL,
  `food_image` varchar(50) DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  PRIMARY KEY (`foodID`),
  KEY `FK_foods_stalls` (`stallID`),
  KEY `FK_foods_categories` (`main_category`),
  KEY `FK_foods_categories_2` (`sub_category`),
  CONSTRAINT `FK_foods_categories` FOREIGN KEY (`main_category`) REFERENCES `categories` (`categoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_foods_categories_2` FOREIGN KEY (`sub_category`) REFERENCES `categories` (`categoryID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_foods_stalls` FOREIGN KEY (`stallID`) REFERENCES `stalls` (`stallID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.foods: ~9 rows (approximately)
INSERT INTO `foods` (`foodID`, `food_name`, `stallID`, `main_category`, `sub_category`, `food_price`, `qty_in_stock`, `food_image`, `views`) VALUES
	(1, 'Spaghetti Carbonara', 1, 6, 10, 10, 98, 'spaghetti-carbonara.png', 25),
	(2, 'Burger and Chips', 1, 8, 10, 8, 94, 'burger-and-chips.png', 45),
	(3, 'Nasi Kandar', 1, 1, NULL, 8, 92, 'nasi-kandar.png', 56),
	(4, 'Chicken Rice', 2, 1, NULL, 4.5, 94, 'chicken-rice.png', 38),
	(5, 'Spicy Chicken Rice', 3, 1, NULL, 4.5, 79, 'spicy-chicken-rice.png', 17),
	(6, 'aaaa', 1, 1, 1, 1, 1000, 'aq', 3),
	(10, 'ssss', 1, 1, 1, 1, 1, 'a', 0),
	(12, 'asdd', 1, 1, 1, 11, 1111, 'aaaa', 0),
	(13, 'Nasi Ayam Goreng', 1, 2, 2, 10, 111, 'aaaa.png', 0),
	(14, 'q', 1, 2, 3, 10, 111, 'q', 0);

-- Dumping structure for table jommakan.locations
DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `locationID` int(11) NOT NULL AUTO_INCREMENT,
  `location_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`locationID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.locations: ~6 rows (approximately)
INSERT INTO `locations` (`locationID`, `location_name`) VALUES
	(1, 'Red Bricks'),
	(2, 'Yum Yum'),
	(3, 'Swimming Pool Cafe'),
	(4, 'East Campus Cafe'),
	(5, 'i-Chill'),
	(6, 'FM Cafe');

-- Dumping structure for table jommakan.orders
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  `noCutlery` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'In progress',
  `paymentID` int(11) DEFAULT NULL,
  `total_price` double DEFAULT 0,
  `order_method` varchar(50) DEFAULT 'Order Now',
  `seat_numbers` text DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  KEY `FK_orders_users` (`userID`),
  CONSTRAINT `FK_orders_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.orders: ~38 rows (approximately)
INSERT INTO `orders` (`orderID`, `userID`, `noCutlery`, `status`, `paymentID`, `total_price`, `order_method`, `seat_numbers`) VALUES
	(1, 1, '0', 'In progress', 3, 0, 'Order Now', NULL),
	(2, 1, '0', 'In progress', 4, 0, 'Order Now', NULL),
	(3, 1, '0', 'In progress', 5, 16, 'Order Now', NULL),
	(4, 1, '0', 'In progress', 6, 0, 'Order Now', NULL),
	(5, 1, '0', 'In progress', 7, 10, 'Order Now', NULL),
	(6, 1, '0', 'In progress', 8, 8, 'Order Now', NULL),
	(7, 1, '0', 'In progress', 9, 16, 'Order Now', NULL),
	(8, 1, '0', 'In progress', 10, 32, 'Order Now', NULL),
	(9, 1, '0', 'In progress', 11, 32, 'Order Now', NULL),
	(10, 1, '0', 'In progress', 12, 32, 'Order Now', NULL),
	(11, 1, '0', 'In progress', 13, 32, 'Order Now', NULL),
	(12, 1, '0', 'In progress', 14, 29.5, 'Order Now', NULL),
	(13, 1, '0', 'In progress', 16, 12.5, 'Order Now', NULL),
	(14, 1, '0', 'In progress', 17, 12.5, 'Order Now', NULL),
	(15, 1, '0', 'In progress', 18, 0, 'Order Now', NULL),
	(16, 1, '0', 'In progress', 19, 0, 'Order Now', NULL),
	(17, 1, '0', 'Completed', 20, 12.5, 'Delivery', NULL),
	(18, 3, '0', 'In progress', 21, 10, 'Order Now', NULL),
	(19, 3, '0', 'In progress', 22, 8, 'Order Now', NULL),
	(20, 3, '0', 'In progress', 23, 4.5, 'Order Now', NULL),
	(21, 11, '1', 'In progress', 24, 8, 'Order Now', NULL),
	(22, 1, '0', 'In progress', 25, 28.5, 'Delivery', NULL),
	(23, 1, '0', 'In progress', 26, 9, 'Delivery', NULL),
	(24, 1, '0', 'In progress', 27, 8, 'Order Now', NULL),
	(25, 1, '0', 'In progress', 28, 16, 'Delivery', NULL),
	(26, 3, '0', 'In progress', 29, 8, 'Order Now', NULL),
	(27, 3, '0', 'In progress', 30, 10, 'Order Now', NULL),
	(28, 8, '0', 'Completed', 31, 16, 'Delivery', NULL),
	(29, 8, '0', 'Completed', 32, 16, 'Delivery', NULL),
	(30, 8, '0', 'In progress', 33, 16, 'Delivery', NULL),
	(31, 1, '0', 'In progress', 34, 28.5, 'Order Now', NULL),
	(32, 1, '0', 'In progress', 35, 28.5, 'Order Now', NULL),
	(33, 1, '0', 'In progress', 36, 28.5, 'Order Now', NULL),
	(34, 1, '0', 'In progress', 37, 28.5, 'Order Now', NULL),
	(35, 1, '0', 'In progress', 38, 28.5, 'Order Now', NULL),
	(36, 1, '0', 'In progress', 39, 28.5, 'Order Now', NULL),
	(37, 1, '0', 'In progress', 40, 28.5, 'Order Now', NULL),
	(38, 1, '0', 'In progress', 41, 28.5, 'Order Now', NULL),
	(39, 1, '0', 'In progress', 43, 20.5, 'Order Now', NULL),
	(40, 3, '0', 'Completed', 44, 8.4, 'Delivery', NULL),
	(41, 3, '0', 'In progress', 45, 8, 'Pre-Order', NULL),
	(42, 3, '0', 'In progress', 46, 8.4, 'Delivery', NULL),
	(43, 1, '0', 'In progress', 47, 28, 'Order Now', '[5][6], [6][6]'),
	(44, 1, '0', 'In progress', 48, 12.5, 'Order Now', '[3][0], [3][1]'),
	(45, 3, '0', 'In progress', 49, 8, 'Order Now', '[7][4]'),
	(46, 3, '0', 'In progress', 50, 8, 'Order Now', ''),
	(47, 3, '0', 'In progress', 51, 8, 'Order Now', ''),
	(48, 3, '0', 'In progress', 52, 8, 'Order Now', ''),
	(49, 3, '0', 'Completed', 54, 8.4, 'Delivery', ''),
	(50, 14, '0', 'In progress', 55, 8, 'Order Now', '[5][5]'),
	(51, 15, '0', 'Completed', 56, 4.7, 'Delivery', '');

-- Dumping structure for table jommakan.order_details
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE IF NOT EXISTS `order_details` (
  `odetailsID` int(11) NOT NULL AUTO_INCREMENT,
  `orderID` int(11) DEFAULT NULL,
  `foodID` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `no_vege` varchar(50) DEFAULT NULL,
  `extra_vege` varchar(50) DEFAULT NULL,
  `no_spicy` varchar(50) DEFAULT NULL,
  `extra_spicy` varchar(50) DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`odetailsID`),
  KEY `FK_order_details_orders` (`orderID`),
  KEY `FK_order_details_foods` (`foodID`),
  CONSTRAINT `FK_order_details_foods` FOREIGN KEY (`foodID`) REFERENCES `foods` (`foodID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_order_details_orders` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.order_details: ~42 rows (approximately)
INSERT INTO `order_details` (`odetailsID`, `orderID`, `foodID`, `quantity`, `price`, `no_vege`, `extra_vege`, `no_spicy`, `extra_spicy`, `notes`) VALUES
	(3, 11, 3, 2, 16, '0', '0', '0', '0', ''),
	(4, 11, 2, 2, 16, '0', '0', '0', '0', ''),
	(5, 12, 3, 2, 16, '0', '0', '0', '0', ''),
	(6, 12, 5, 3, 13.5, '0', '0', '0', '0', ''),
	(7, 13, 2, 1, 8, '0', '0', '0', '0', ''),
	(8, 13, 5, 1, 4.5, '0', '0', '0', '0', ''),
	(9, 14, 2, 1, 8, '0', '0', '0', '0', ''),
	(10, 14, 5, 1, 4.5, '0', '0', '0', '0', ''),
	(11, 17, 3, 1, 8, '0', '0', '0', '0', ''),
	(12, 17, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(13, 18, 1, 1, 10, '0', '0', '0', '0', ''),
	(14, 19, 3, 1, 8, '0', '0', '0', '0', ''),
	(15, 20, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(16, 21, 3, 1, 8, '0', '0', '0', '0', ''),
	(17, 22, 3, 2, 16, '0', '0', '0', '0', ''),
	(18, 22, 2, 1, 8, '0', '0', '0', '0', ''),
	(19, 22, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(20, 23, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(21, 23, 5, 1, 4.5, '0', '0', '0', '0', ''),
	(22, 24, 2, 1, 8, '0', '0', '0', '0', ''),
	(23, 25, 2, 1, 8, '0', '0', '0', '0', ''),
	(24, 25, 3, 1, 8, '0', '0', '0', '0', ''),
	(25, 26, 3, 1, 8, '0', '0', '0', '0', ''),
	(26, 27, 1, 1, 10, '0', '0', '0', '0', ''),
	(27, 28, 2, 2, 16, '0', '0', '0', '0', ''),
	(28, 29, 2, 2, 16, '0', '0', '0', '0', ''),
	(29, 30, 2, 2, 16, '0', '0', '0', '0', ''),
	(30, 31, 3, 1, 8, '0', '0', '0', '0', ''),
	(31, 32, 3, 1, 8, '0', '0', '0', '0', ''),
	(32, 33, 3, 1, 8, '0', '0', '0', '0', ''),
	(33, 34, 3, 1, 8, '0', '0', '0', '0', ''),
	(34, 35, 3, 1, 8, '0', '0', '0', '0', ''),
	(35, 35, 3, 2, 16, '0', '0', '0', '0', ''),
	(36, 35, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(37, 36, 3, 1, 8, '0', '0', '0', '0', ''),
	(38, 36, 3, 2, 16, '0', '0', '0', '0', ''),
	(39, 36, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(40, 37, 3, 1, 8, '0', '0', '0', '0', ''),
	(41, 37, 3, 2, 16, '0', '0', '0', '0', ''),
	(42, 37, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(43, 38, 3, 1, 8, '0', '0', '0', '0', ''),
	(44, 38, 3, 2, 16, '0', '0', '0', '0', ''),
	(45, 38, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(46, 39, 2, 2, 16, '0', '0', '0', '0', ''),
	(47, 39, 5, 1, 4.5, '0', '0', '0', '0', ''),
	(48, 40, 3, 1, 8, '0', '0', '0', '0', ''),
	(49, 41, 3, 1, 8, '0', '0', '0', '0', ''),
	(50, 42, 2, 1, 8, '0', '0', '0', '0', ''),
	(51, 43, 1, 2, 20, '0', '0', '0', '0', ''),
	(52, 43, 2, 1, 8, '0', '0', '0', '0', ''),
	(53, 44, 2, 1, 8, '0', '0', '0', '0', ''),
	(54, 44, 4, 1, 4.5, '0', '0', '0', '0', ''),
	(55, 45, 3, 1, 8, '0', '0', '0', '0', ''),
	(56, 46, 3, 1, 8, '0', '0', '0', '0', ''),
	(57, 47, 3, 1, 8, '0', '0', '0', '0', ''),
	(58, 48, 3, 1, 8, '0', '0', '0', '0', ''),
	(59, 49, 3, 1, 8, '0', '0', '0', '0', ''),
	(60, 50, 2, 1, 8, '0', '0', '0', '0', ''),
	(61, 51, 4, 1, 4.5, '0', '0', '0', '0', '');

-- Dumping structure for table jommakan.payments
DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `paymentID` int(11) NOT NULL AUTO_INCREMENT,
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_date` varchar(50) DEFAULT NULL,
  `payment_time` varchar(50) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  PRIMARY KEY (`paymentID`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.payments: ~37 rows (approximately)
INSERT INTO `payments` (`paymentID`, `payment_method`, `payment_date`, `payment_time`, `total_price`) VALUES
	(1, 'E-wallet', '26-Nov-2023', '19:58:58', 0),
	(2, 'E-wallet', '26-Nov-2023', '20:10:36', 0),
	(3, 'E-wallet', '26-Nov-2023', '20:16:36', 0),
	(4, 'E-wallet', '26-Nov-2023', '23:17:43', 0),
	(5, 'Cash On Delivery', '27-Nov-2023', '12:24:02', 16),
	(6, 'E-wallet', '27-Nov-2023', '12:27:54', 0),
	(7, 'Cash On Delivery', '27-Nov-2023', '14:38:58', 10),
	(8, 'E-wallet', '27-Nov-2023', '14:43:08', 8),
	(9, 'Cash On Delivery', '27-Nov-2023', '17:31:04', 16),
	(10, 'E-wallet', '27-Nov-2023', '17:33:30', 32),
	(11, 'E-wallet', '27-Nov-2023', '17:34:31', 32),
	(12, 'Cash On Delivery', '27-Nov-2023', '17:37:06', 32),
	(14, 'Cash On Delivery', '27-Nov-2023', '22:48:13', 29.5),
	(15, 'E-wallet', '28-Nov-2023', '11:11:11', 0),
	(16, 'E-wallet', '28-Nov-2023', '00:25:32', 12.5),
	(17, 'E-wallet', '28-Nov-2023', '00:25:32', 12.5),
	(18, 'E-wallet', '29-Nov-2023', '13:30:53', 0),
	(19, 'E-wallet', '29-Nov-2023', '13:32:43', 0),
	(20, 'Cash On Delivery', '29-Nov-2023', '16:45:12', 12.5),
	(21, 'Debit/Credit Card', '30-Nov-2023', '00:07:35', 12.5),
	(22, 'E-wallet', '30-Nov-2023', '13:19:36', 11),
	(23, 'Debit/Credit Card', '30-Nov-2023', '21:30:21', 4.5),
	(24, 'Debit/Credit', '30-Nov-2023', '21:44:45', 8),
	(25, 'Cash On Delivery', '01-Dec-2023', '13:58:50', 28.5),
	(26, 'Cash On Delivery', '01-Dec-2023', '14:57:16', 9),
	(27, 'E-wallet', '01-Dec-2023', '14:59:02', 8),
	(28, 'E-wallet', '01-Dec-2023', '15:02:23', 16),
	(29, 'Cash On Delivery', '03-Dec-2023', '12:58:24', 8),
	(30, 'Cash On Delivery', '03-Dec-2023', '21:58:48', 10),
	(31, 'E-wallet', '05-Dec-2023', '16:59:29', 16),
	(32, 'E-wallet', '05-Dec-2023', '16:59:29', 16),
	(33, 'Debit/Credit Card', '05-Dec-2023', '17:02:22', 16),
	(34, 'E-wallet', '06-Dec-2023', '22:52:18', 28.5),
	(35, 'Cash On Delivery', '06-Dec-2023', '22:53:47', 28.5),
	(36, 'Cash On Delivery', '06-Dec-2023', '22:55:51', 28.5),
	(37, 'Cash On Delivery', '06-Dec-2023', '22:58:39', 28.5),
	(38, 'E-wallet', '06-Dec-2023', '23:00:35', 28.5),
	(39, 'E-wallet', '06-Dec-2023', '23:39:15', 28.5),
	(40, 'Cash On Delivery', '06-Dec-2023', '23:40:30', 28.5),
	(41, 'Cash On Delivery', '06-Dec-2023', '23:41:03', 28.5),
	(42, 'E-wallet', '07-Dec-2023', '15:28:52', 20.5),
	(43, 'Cash On Delivery', '07-Dec-2023', '18:10:27', 20.5),
	(44, 'Cash On Delivery', '08-Dec-2023', '18:19:26', 8.4),
	(45, 'Cash On Delivery', '10-Dec-2023', '00:43:29', 8),
	(46, 'E-wallet', '10-Dec-2023', '00:44:30', 8.4),
	(47, 'E-wallet', '10-Dec-2023', '16:35:29', 28),
	(48, 'E-wallet', '10-Dec-2023', '16:41:55', 12.5),
	(49, 'Cash On Delivery', '10-Dec-2023', '23:14:34', 8),
	(50, 'Cash On Delivery', '11-Dec-2023', '17:31:44', 8),
	(51, 'Cash On Delivery', '11-Dec-2023', '17:32:26', 8),
	(52, 'Cash On Delivery', '11-Dec-2023', '17:32:26', 8),
	(53, 'Cash On Delivery', '11-Dec-2023', '17:50:39', 8),
	(54, 'Cash On Delivery', '11-Dec-2023', '19:25:29', 8.4),
	(55, 'Debit/Credit Card', '12-Dec-2023', '14:59:35', 8),
	(56, 'Cash On Delivery', '13-Dec-2023', '15:32:46', 4.7);

-- Dumping structure for table jommakan.promotion
DROP TABLE IF EXISTS `promotion`;
CREATE TABLE IF NOT EXISTS `promotion` (
  `foodId` varchar(50) DEFAULT NULL,
  `foodName` varchar(50) DEFAULT NULL,
  `foodPrice` double DEFAULT NULL,
  `foodPromotion` double DEFAULT NULL,
  `datePromotion` datetime DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `foodStall` varchar(50) DEFAULT NULL,
  `foodDescription` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.promotion: ~10 rows (approximately)
INSERT INTO `promotion` (`foodId`, `foodName`, `foodPrice`, `foodPromotion`, `datePromotion`, `quantity`, `foodStall`, `foodDescription`) VALUES
	('F0001', 'Nasi Kandar Special', 10, 8, '2023-11-25 15:44:46', 0, 'Kedai Masakan Malaysia (RedBrick)', 'Good Price'),
	('F0002', 'Nasi Minyak', 8, 4, '2023-11-25 15:44:54', 11, 'Kedai Malaysia (East Campus)', 'Not Selling'),
	('F0003', 'MixRice', 12, 10, '2023-11-25 15:44:56', 100, 'Kedai MixRice (YumYum Cafe)', 'Delicious'),
	('F0004', 'Chicken Rice', 10, 6, '2023-11-25 15:44:59', 11, 'Kedai Chicken Rice (Swimming Pool)', 'OKK LOL'),
	('F0005', 'Sprite', 3, 1, '2023-11-25 15:45:01', 11, 'Kedai Minuman (YumYum Cafe)', 'Almost expire'),
	('001', 's', 1, 1, '2023-12-31 00:18:00', 1065017172, 's', 's'),
	('1234', 'a', 11, 11, '2023-12-09 00:23:00', 468498465, 's', 'd'),
	('11111', 'a', 11, 11, '2023-12-09 00:31:00', 557190347, 's', 's'),
	('F001', 'Masakan', 11, 10, '2023-12-09 18:21:00', 532514042, 'Masakan Malaysia', 'Good'),
	('F0016', 'TAN', 12, 11, '2023-12-09 21:41:00', 213331935, 'AAA', 'A'),
	('F0016', 'TAN', 12, 11, '2023-12-09 21:41:00', 213331935, 'AAA', 'A');

-- Dumping structure for table jommakan.ratings
DROP TABLE IF EXISTS `ratings`;
CREATE TABLE IF NOT EXISTS `ratings` (
  `ratingID` int(11) NOT NULL AUTO_INCREMENT,
  `foodID` int(11) DEFAULT NULL,
  `userID` int(11) DEFAULT NULL,
  `stars` int(11) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`ratingID`),
  KEY `FK_ratings_foods` (`foodID`),
  KEY `FK_ratings_users` (`userID`),
  CONSTRAINT `FK_ratings_foods` FOREIGN KEY (`foodID`) REFERENCES `foods` (`foodID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ratings_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.ratings: ~14 rows (approximately)
INSERT INTO `ratings` (`ratingID`, `foodID`, `userID`, `stars`, `date`, `description`) VALUES
	(2, 2, 1, 4, '25-Nov-2023', 'mm'),
	(3, 3, 5, 3, '25-Nov-2023', NULL),
	(4, 1, 4, 4, '25-Nov-2023', NULL),
	(5, 3, 6, 2, '25-Nov-2023', NULL),
	(6, 4, 4, 5, '25-Nov-2023', NULL),
	(7, 1, 6, 4, '25-Nov-2023', NULL),
	(8, 2, 6, 2, '25-Nov-2023', NULL),
	(9, 5, 4, 1, '25-Nov-2023', NULL),
	(10, 2, 4, 4, '25-Nov-2023', NULL),
	(11, 2, 5, 3, '25-Nov-2023', NULL),
	(12, 5, 3, 5, '25-Nov-2023', NULL),
	(13, 2, 8, 5, '26-Nov-2023', 'very nice!!'),
	(14, 4, 8, 5, '2023-11-28 13:39:09', 'This chicken rice is too tasty le. it made me keep dreaming chicken rice. tmr I will EAT IT AGAIN!!! '),
	(15, 3, 1, 5, '28-Nov-2023', 'idk'),
	(16, 3, 3, 5, '30-Nov-2023', 'Good'),
	(17, 3, 11, 4, '30-Nov-2023', 'Good Taste');

-- Dumping structure for table jommakan.riders
DROP TABLE IF EXISTS `riders`;
CREATE TABLE IF NOT EXISTS `riders` (
  `riderID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  PRIMARY KEY (`riderID`),
  KEY `FK_riders_users` (`userID`),
  CONSTRAINT `FK_riders_users` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.riders: ~7 rows (approximately)
INSERT INTO `riders` (`riderID`, `userID`) VALUES
	(1, 1),
	(3, 3),
	(7, 8),
	(8, 8),
	(4, 15),
	(5, 16),
	(6, 16);

-- Dumping structure for table jommakan.seatNumber
DROP TABLE IF EXISTS `seatNumber`;
CREATE TABLE IF NOT EXISTS `seatNumber` (
  `seatID` int(11) NOT NULL AUTO_INCREMENT,
  `confirmationID` varchar(50) DEFAULT NULL,
  `row` int(11) DEFAULT NULL,
  `col` int(11) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `orderID` int(11) DEFAULT NULL,
  PRIMARY KEY (`seatID`),
  KEY `FK_seatNumber_orders` (`orderID`),
  CONSTRAINT `FK_seatNumber_orders` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.seatNumber: ~68 rows (approximately)
INSERT INTO `seatNumber` (`seatID`, `confirmationID`, `row`, `col`, `location`, `time`, `orderID`) VALUES
	(1, 'C0001', 6, 6, 'YumYum Cafe', '2023-12-01 00:57:16', NULL),
	(2, 'C3898', 5, 5, 'RedBrick Cafe', '2023-12-03 01:01:53', NULL),
	(3, 'C8056', 9, 6, 'RedBrick Cafe', '2023-12-03 01:14:38', NULL),
	(4, 'C4207', 4, 1, 'RedBrick Cafe', '2023-12-03 01:25:14', NULL),
	(5, 'C8321', 7, 2, 'RedBrick Cafe', '2023-12-03 01:33:48', NULL),
	(6, 'C6708', 9, 0, 'RedBrick Cafe', '2023-12-03 01:40:36', NULL),
	(7, 'C5107', 4, 0, 'RedBrick Cafe', '2023-12-03 01:41:45', NULL),
	(8, 'C1795', 9, 6, 'RedBrick Cafe', '2023-12-03 01:43:41', NULL),
	(9, 'C3930', 3, 5, 'RedBrick Cafe', '2023-12-03 01:46:23', NULL),
	(10, 'C1070', 8, 5, 'RedBrick Cafe', '2023-12-04 11:27:21', NULL),
	(11, 'C1070', 9, 5, 'RedBrick Cafe', '2023-12-04 11:27:21', NULL),
	(12, 'C1255', 7, 5, 'RedBrick Cafe', '2023-12-04 11:27:41', NULL),
	(13, 'C5197', 5, 5, 'RedBrick Cafe', '2023-12-04 11:33:35', NULL),
	(14, 'C2322', 7, 5, 'RedBrick Cafe', '2023-12-04 14:49:02', NULL),
	(15, 'C8767', 8, 5, 'RedBrick Cafe', '2023-12-04 15:27:48', NULL),
	(16, 'C1871', 4, 4, 'RedBrick Cafe', '2023-12-04 15:30:01', NULL),
	(17, 'C6738', 9, 6, 'RedBrick Cafe', '2023-12-04 15:32:26', NULL),
	(18, 'C2622', 5, 4, 'RedBrick Cafe', '2023-12-04 15:34:32', NULL),
	(19, 'C7564', 3, 5, 'RedBrick Cafe', '2023-12-04 15:46:17', NULL),
	(20, '0C903', 5, 5, 'RedBrick Cafe', '2023-12-04 15:48:10', NULL),
	(21, 'C5388', 4, 2, 'RedBrick Cafe', '2023-12-04 15:50:35', NULL),
	(22, 'C8340', 3, 4, 'RedBrick Cafe', '2023-12-04 15:51:38', NULL),
	(23, 'C1089', 3, 1, 'RedBrick Cafe', '2023-12-04 15:57:41', NULL),
	(24, 'C1525', 5, 5, 'RedBrick Cafe', '2023-12-04 15:58:01', NULL),
	(25, '0C819', 9, 6, 'RedBrick Cafe', '2023-12-04 15:58:50', NULL),
	(26, 'C1061', 8, 5, 'RedBrick Cafe', '2023-12-04 21:23:21', NULL),
	(27, 'C1061', 7, 5, 'RedBrick Cafe', '2023-12-04 21:23:21', NULL),
	(28, 'C6434', 5, 5, 'RedBrick Cafe', '2023-12-04 21:38:56', NULL),
	(29, 'C6434', 6, 6, 'RedBrick Cafe', '2023-12-04 21:38:56', NULL),
	(30, '0C751', 7, 6, 'RedBrick Cafe', '2023-12-04 22:00:40', NULL),
	(31, '0C751', 6, 5, 'RedBrick Cafe', '2023-12-04 22:00:40', NULL),
	(32, 'C4172', 7, 6, 'RedBrick Cafe', '2023-12-04 22:02:34', NULL),
	(33, 'C4172', 6, 5, 'RedBrick Cafe', '2023-12-04 22:02:34', NULL),
	(34, 'C4172', 9, 5, 'RedBrick Cafe', '2023-12-04 22:02:34', NULL),
	(35, 'C4172', 8, 5, 'RedBrick Cafe', '2023-12-04 22:02:34', NULL),
	(36, '0C723', 5, 4, 'RedBrick Cafe', '2023-12-04 22:03:20', NULL),
	(37, '0C723', 5, 5, 'RedBrick Cafe', '2023-12-04 22:03:20', NULL),
	(38, '0C723', 4, 4, 'RedBrick Cafe', '2023-12-04 22:03:20', NULL),
	(39, 'C2753', 9, 5, 'RedBrick Cafe', '2023-12-04 22:04:22', NULL),
	(40, 'C2753', 8, 5, 'RedBrick Cafe', '2023-12-04 22:04:22', NULL),
	(41, 'C2753', 7, 6, 'RedBrick Cafe', '2023-12-04 22:04:22', NULL),
	(42, 'C5264', 8, 5, 'RedBrick Cafe', '2023-12-04 22:05:45', NULL),
	(43, 'C5264', 7, 5, 'RedBrick Cafe', '2023-12-04 22:05:45', NULL),
	(44, 'C5264', 9, 5, 'RedBrick Cafe', '2023-12-04 22:05:45', NULL),
	(45, 'C9482', 7, 5, 'RedBrick Cafe', '2023-12-05 00:20:39', NULL),
	(46, 'C9482', 7, 6, 'RedBrick Cafe', '2023-12-05 00:20:39', NULL),
	(47, 'C9698', 6, 6, 'RedBrick Cafe', '2023-12-05 00:21:49', NULL),
	(48, 'C9698', 7, 6, 'RedBrick Cafe', '2023-12-05 00:21:49', NULL),
	(49, 'C1530', 7, 6, 'RedBrick Cafe', '2023-12-05 00:23:21', NULL),
	(50, 'C1530', 6, 6, 'RedBrick Cafe', '2023-12-05 00:23:21', NULL),
	(51, 'C8390', 6, 5, 'RedBrick Cafe', '2023-12-05 00:26:18', NULL),
	(52, 'C8390', 5, 5, 'RedBrick Cafe', '2023-12-05 00:26:18', NULL),
	(53, 'C6950', 6, 5, 'RedBrick Cafe', '2023-12-05 10:32:36', NULL),
	(54, 'C6950', 6, 4, 'RedBrick Cafe', '2023-12-05 10:32:36', NULL),
	(55, 'C3542', 6, 6, 'RedBrick Cafe', '2023-12-05 10:36:53', NULL),
	(56, 'C3542', 7, 6, 'RedBrick Cafe', '2023-12-05 10:36:53', NULL),
	(57, 'C1050', 6, 6, 'RedBrick Cafe', '2023-12-05 10:39:01', NULL),
	(58, 'C1050', 7, 6, 'RedBrick Cafe', '2023-12-05 10:39:01', NULL),
	(59, 'C6885', 6, 6, 'RedBrick Cafe', '2023-12-05 10:39:56', NULL),
	(60, 'C6885', 7, 6, 'RedBrick Cafe', '2023-12-05 10:39:56', NULL),
	(61, 'C1443', 6, 6, 'RedBrick Cafe', '2023-12-05 10:43:31', NULL),
	(62, 'C1443', 7, 6, 'RedBrick Cafe', '2023-12-05 10:43:31', NULL),
	(63, 'C1574', 4, 4, 'RedBrick Cafe', '2023-12-05 12:10:01', NULL),
	(64, 'C3863', 4, 4, 'RedBrick Cafe', '2023-12-05 12:10:03', NULL),
	(65, 'C8103', 6, 4, 'RedBrick Cafe', '2023-12-05 12:11:18', NULL),
	(66, 'C2578', 6, 4, 'RedBrick Cafe', '2023-12-05 12:11:32', NULL),
	(73, 'C5239', 5, 6, 'RedBrick Cafe', '2023-12-05 20:45:25', NULL),
	(74, 'C5239', 6, 2, 'RedBrick Cafe', '2023-12-05 20:45:25', NULL),
	(75, 'C7033', 8, 5, 'RedBrick Cafe', '2023-12-06 23:40:57', 38),
	(76, 'C7033', 6, 5, 'RedBrick Cafe', '2023-12-06 23:40:57', 38),
	(77, 'C7245', 1, 6, 'RedBrick Cafe', '2023-12-07 18:10:17', 39),
	(78, 'C7245', 1, 5, 'RedBrick Cafe', '2023-12-07 18:10:17', 39),
	(79, 'C2990', 9, 6, 'RedBrick Cafe', '2023-12-08 18:18:52', 40),
	(80, 'C4573', 9, 5, 'RedBrick Cafe', '2023-12-10 00:43:04', 41),
	(81, 'C1698', 6, 6, 'RedBrick Cafe', '2023-12-10 16:35:21', 43),
	(82, 'C1698', 5, 6, 'RedBrick Cafe', '2023-12-10 16:35:21', 43),
	(83, '0C585', 3, 0, 'RedBrick Cafe', '2023-12-10 16:41:50', 44),
	(84, '0C585', 3, 1, 'RedBrick Cafe', '2023-12-10 16:41:50', 44),
	(85, 'C6688', 7, 4, 'RedBrick Cafe', '2023-12-10 23:14:26', 45),
	(86, 'C9803', 6, 4, 'RedBrick Cafe', '2023-12-11 18:55:29', 49),
	(87, '0C404', 5, 5, 'RedBrick Cafe', '2023-12-12 14:59:20', 50);

-- Dumping structure for table jommakan.stallDisplay
DROP TABLE IF EXISTS `stallDisplay`;
CREATE TABLE IF NOT EXISTS `stallDisplay` (
  `stallID` varchar(50) NOT NULL DEFAULT 'AUTO_INCREMENT',
  `stallName` varchar(50) DEFAULT NULL,
  `stallOwner` varchar(50) DEFAULT NULL,
  `totalStaff` int(11) DEFAULT NULL,
  `canteen` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`stallID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.stallDisplay: ~6 rows (approximately)
INSERT INTO `stallDisplay` (`stallID`, `stallName`, `stallOwner`, `totalStaff`, `canteen`) VALUES
	('S0001', 'Restauran Masakan Malaysia', 'Ali', 5, 'RedBrick Cafe'),
	('S0002', 'Restauran Chicken Rice', 'Abu', 3, 'YumYum Cafe'),
	('S0003', 'Restauran Mixed Rice', 'Tan', 2, 'East Campus Cafe'),
	('S0004', 'Restauran Crispy Chicken Rice', 'Tan', 3, 'Swimming Pool Cafe'),
	('S0005', 'Restauran Noodles', 'Har', 3, 'YumYum Cafe'),
	('S0006', 'Restauran Fast Food', 'Har', 4, 'RedBrick Cafe');

-- Dumping structure for table jommakan.stalls
DROP TABLE IF EXISTS `stalls`;
CREATE TABLE IF NOT EXISTS `stalls` (
  `stallID` int(11) NOT NULL AUTO_INCREMENT,
  `stall_name` varchar(50) DEFAULT NULL,
  `locationID` int(11) DEFAULT NULL,
  PRIMARY KEY (`stallID`),
  KEY `FK_stalls_locations` (`locationID`),
  CONSTRAINT `FK_stalls_locations` FOREIGN KEY (`locationID`) REFERENCES `locations` (`locationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.stalls: ~2 rows (approximately)
INSERT INTO `stalls` (`stallID`, `stall_name`, `locationID`) VALUES
	(1, 'Kedai Masakan Malaysia', 1),
	(2, 'Yum Yum Chicken', 2),
	(3, 'East Campus Chicken', 4);

-- Dumping structure for table jommakan.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `user_role` varchar(50) DEFAULT 'User',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COLLATE=latin1_bin;

-- Dumping data for table jommakan.users: ~11 rows (approximately)
INSERT INTO `users` (`userID`, `username`, `email`, `password`, `user_role`) VALUES
	(1, 'Testing', 'testing@tarc.edu.my', '12345678', 'User'),
	(2, 'Jm_admin', 'jmadmin@tarc.edu.my', '87654321', 'Admin'),
	(3, 'Tan Kang Hong', 'tankh-wm20@student.tarc.edu.my', 'kh_12345', 'User'),
	(4, 'Har Chun Wai', 'harcw-wm20@student.tarc.edu.my', '1nothing.', 'User'),
	(5, 'Cheng Cai Jie', 'chengcj-wm20@student.tarc.edu.my', 'chengcaijie', 'User'),
	(6, 'Nee Mei Yi', 'neemy-wm20@student.tarc.edu.my', 'neemywm20', 'User'),
	(7, 'Yong Chi Min', 'yongcm-wm19@student.tarc.edu.my', 'yongcmwm19', 'User'),
	(8, 'ii887522', 'ii887522@gmail.com', 'abcdefgh', 'User'),
	(10, 'tesss', 'tesss@tarc.edu.my', '12345678', 'User'),
	(11, 'Tan', 'kanghong100@gmail.com', 'kh001229', 'User'),
	(12, 'tan', 'tan@gmail.com', 'kanghong', 'User'),
	(14, 'home', 'home@gmail.com', '12345678', 'User'),
	(15, 'Tan', 'home2@gmail.com', 'kanghong', 'User'),
	(16, 'tan2', 'tan2@gmail.com', 'kanghong', 'User');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
