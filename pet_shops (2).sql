-- phpMyAdmin SQL Dump
-- version 6.0.0-dev+20230725.72d9c61c05
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 15, 2024 at 02:31 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pet_shops`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `customer_procedure` (`p_customer_id` VARCHAR(100), `p_custName` VARCHAR(100), `p_custPhone` INT(100), `p_custEmail` VARCHAR(100), `p_custAddress` VARCHAR(100))   BEGIN

INSERT INTO CUSTOMER (customer_id, custName, custPhone, custEmail, custAddress)
VALUES (p_customer_id,p_custName,p_custPhone,p_custEmail,p_custAddress)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PerformTransaction` (IN `p_transaction_id` VARCHAR(100), IN `p_customer_id` VARCHAR(100), IN `p_product_id` VARCHAR(100), IN `p_employee_id` VARCHAR(100), IN `p_qty` INT)   BEGIN
    DECLARE product_price VARCHAR(100)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `salary_procedure` (IN `p_salary_id` VARCHAR(100), IN `p_employee_id` VARCHAR(100), IN `p_position` VARCHAR(100), IN `p_hours` INT, IN `p_salary_hours` INT, IN `p_total` INT)   BEGIN
    -- Remove the redeclaration of p_employee_id

    -- Ensure that the employee_id exists in the employee table
    IF NOT EXISTS (SELECT 1 FROM employee WHERE employee_id = p_employee_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee does not exist'$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` varchar(100) NOT NULL,
  `custNama` varchar(100) DEFAULT NULL,
  `custPhone` varchar(100) DEFAULT NULL,
  `custEmail` varchar(100) DEFAULT NULL,
  `custAddress` varchar(100) DEFAULT NULL,
  `test` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `custNama`, `custPhone`, `custEmail`, `custAddress`, `test`) VALUES
('CUST001', 'JUNA', '897362831', 'junet@gmail.com', 'JAWA', NULL),
('CUST002', 'DODI', '8432749', 'dodi@gmail.com', 'SUNDA', NULL),
('CUST003', 'SUGENG', '85473912', 'sugeng@gmail.com', 'JAWA', NULL),
('CUST004', 'RAYA', '8764729', 'lia@gmail.com', 'PADANG', NULL),
('CUST005', 'RANYA', '814316428', 'ranya@gmail.com', 'BANDUNG', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` varchar(100) NOT NULL,
  `empName` varchar(100) DEFAULT NULL,
  `empPhone` varchar(100) DEFAULT NULL,
  `empEmail` varchar(100) DEFAULT NULL,
  `empAddress` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `empName`, `empPhone`, `empEmail`, `empAddress`) VALUES
('EMP001', 'IRVAN', '812374832', 'irvan1241@gmail.com', 'JAWA'),
('EMP002', 'IRVAN', '812374832', 'irvan1241@gmail.com', 'JAWA'),
('EMP003', 'TAUFIQ', '837129421', 'taufiq1542@gmail.com', 'DEPOK'),
('EMP004', 'RAYAN', '816494321', 'rayan1324@gmail.com', 'KUKUSAN'),
('EMP005', 'JAMAL', '87637439', 'jamal13152@gmail.com', 'JAWIR'),
('EMP006', 'DADANG', '898272346', 'dadang5321@gmail.com', 'SUNDA');

-- --------------------------------------------------------

--
-- Stand-in structure for view `employee_salary_view`
-- (See below for the actual view)
--
CREATE TABLE `employee_salary_view` (
`salary_id` varchar(100)
,`employee_id` varchar(100)
,`empName` varchar(100)
,`position` varchar(100)
,`hours` varchar(100)
,`salary_hours` varchar(100)
,`total` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `empsalary`
-- (See below for the actual view)
--
CREATE TABLE `empsalary` (
`salary_hours` varchar(100)
,`sal_employee_id` varchar(100)
,`employee_id` varchar(100)
,`empName` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `outcome`
-- (See below for the actual view)
--
CREATE TABLE `outcome` (
`salary_id` varchar(100)
,`total` varchar(100)
,`supplier_id` varchar(100)
,`product_id` varchar(100)
,`total_price` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` varchar(100) NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `product_type` varchar(100) DEFAULT NULL,
  `quantity` varchar(100) DEFAULT NULL,
  `min_quantity` varchar(100) DEFAULT NULL,
  `max_quantity` varchar(100) DEFAULT NULL,
  `unit_price` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_type`, `quantity`, `min_quantity`, `max_quantity`, `unit_price`) VALUES
('PR001', 'WHISKAS', 'DRY', '88', '10', '150', 2300),
('PR002', 'ROYAL CANIN', 'WET', '35', '10', '150', 1300),
('PR003', 'BOLT', 'DRY', '73', '12', '180', 13);

--
-- Triggers `product`
--
DELIMITER $$
CREATE TRIGGER `max_qty` BEFORE UPDATE ON `product` FOR EACH ROW BEGIN 
  IF NEW.max_quantity >= NEW.quantity  THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity Overload'DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `product_log`
-- (See below for the actual view)
--
CREATE TABLE `product_log` (
`supplier_id` varchar(100)
,`supplier_product_id` varchar(100)
,`supplier_name` varchar(100)
,`supplier_quantity` varchar(100)
,`transaction_id` varchar(100)
,`customer_id` varchar(100)
,`transaction_product_id` varchar(100)
,`transaction_qty` int(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `salary`
--

CREATE TABLE `salary` (
  `salary_id` varchar(100) NOT NULL,
  `employee_id` varchar(100) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `hours` varchar(100) DEFAULT NULL,
  `salary_hours` varchar(100) DEFAULT NULL,
  `total` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `salary`
--

INSERT INTO `salary` (`salary_id`, `employee_id`, `position`, `hours`, `salary_hours`, `total`) VALUES
('SAL001', 'EMP001', 'MANAGER', '36', '100', '3600'),
('SAL002', 'EMP003', 'CASHIER', '38', '120', '4560');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplier_id` varchar(100) NOT NULL,
  `product_id` varchar(100) DEFAULT NULL,
  `supplier_name` varchar(100) DEFAULT NULL,
  `quantity` varchar(100) DEFAULT NULL,
  `price` varchar(100) DEFAULT NULL,
  `total_price` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplier_id`, `product_id`, `supplier_name`, `quantity`, `price`, `total_price`) VALUES
('SP001', 'PR001', 'GO', '10', '230', '2300'),
('SP0016', 'PR003', 'INDO', '2', '12', '24'),
('SP0017', 'PR003', 'INDO', '2', '12', '24'),
('SP0019', 'PR003', 'INDO', '2', '12', '24'),
('SP002', 'PR001', 'GO', '100', '23000', '2300000'),
('SP0020', 'PR003', 'INDO', '2', '12', '24'),
('SP0021', 'PR003', 'INDO', '2', '12', '24'),
('SP003', 'PR001', 'GOY', '10', '23000', '230000'),
('SP004', 'PR001', 'GOY', '13', '23000', '299000'),
('SP005', 'PR001', 'GOY', '13', '12', '156'),
('SP006', 'PR001', 'GOY', '13', '12000', '156000'),
('SP007', 'PR001', 'GOY', '13', '12000', '156000'),
('SP008', 'PR001', 'GOY', '13', '13', '169'),
('SP009', 'PR001', 'GOY', '13', '13', '169'),
('SP011', 'PR001', 'GO', '10', '230', '2300'),
('SP013', 'PR002', 'JnT', '23', '130', '2990'),
('SP014', 'PR003', 'TnT', '25', '90', '2250'),
('SP015', 'PR003', 'Alfa', '25', '110', '2750');

--
-- Triggers `supplier`
--
DELIMITER $$
CREATE TRIGGER `supplier_AFTER_INSERT` AFTER INSERT ON `supplier` FOR EACH ROW BEGIN
    INSERT INTO product (product_id, quantity, unit_price)
    VALUES (NEW.product_id, NEW.quantity,unit_price)
    ON DUPLICATE KEY UPDATE 
        unit_price = NEW.price * 1.1DELIMITER ;
DELIMITER $$
CREATE TRIGGER `supplier_BEFORE_INSERT` BEFORE INSERT ON `supplier` FOR EACH ROW BEGIN
    SET NEW.total_price = NEW.price * NEW.quantityDELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` varchar(100) NOT NULL,
  `customer_id` varchar(100) DEFAULT NULL,
  `product_id` varchar(100) DEFAULT NULL,
  `employee_id` varchar(100) DEFAULT NULL,
  `qty` int(100) NOT NULL,
  `price` varchar(100) DEFAULT NULL,
  `total_price` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `customer_id`, `product_id`, `employee_id`, `qty`, `price`, `total_price`) VALUES
('TRC001', 'CUST001', 'PR001', 'EMP001', 0, '130.00', '1300'),
('TRC002', 'CUST001', 'PR001', 'EMP001', 10, '130', '1300'),
('TRC003', 'CUST002', 'PR001', 'EMP001', 10, '130', '1300'),
('TRC004', 'CUST002', 'PR001', 'EMP001', 10, '130', '1300');

-- --------------------------------------------------------

--
-- Structure for view `employee_salary_view`
--
DROP TABLE IF EXISTS `employee_salary_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `employee_salary_view`  AS SELECT `s`.`salary_id` AS `salary_id`, `e`.`employee_id` AS `employee_id`, `e`.`empName` AS `empName`, `s`.`position` AS `position`, `s`.`hours` AS `hours`, `s`.`salary_hours` AS `salary_hours`, `s`.`total` AS `total` FROM (`salary` `s` join `employee` `e` on(`s`.`employee_id` = `e`.`employee_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `empsalary`
--
DROP TABLE IF EXISTS `empsalary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `empsalary`  AS SELECT `s`.`salary_hours` AS `salary_hours`, `s`.`employee_id` AS `sal_employee_id`, `e`.`employee_id` AS `employee_id`, `e`.`empName` AS `empName` FROM (`salary` `s` join `employee` `e` on(`s`.`employee_id` = `e`.`employee_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `outcome`
--
DROP TABLE IF EXISTS `outcome`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `outcome`  AS SELECT `s`.`salary_id` AS `salary_id`, `s`.`total` AS `total`, `sp`.`supplier_id` AS `supplier_id`, `sp`.`product_id` AS `product_id`, `sp`.`total_price` AS `total_price` FROM (`supplier` `sp` left join `salary` `s` on(`s`.`salary_id` = `sp`.`supplier_id`))union select `s`.`salary_id` AS `salary_id`,`s`.`total` AS `total`,`sp`.`supplier_id` AS `supplier_id`,`sp`.`product_id` AS `product_id`,`sp`.`total_price` AS `total_price` from (`salary` `s` left join `supplier` `sp` on(`s`.`salary_id` = `sp`.`supplier_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `product_log`
--
DROP TABLE IF EXISTS `product_log`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `product_log`  AS SELECT `sp`.`supplier_id` AS `supplier_id`, `sp`.`product_id` AS `supplier_product_id`, `sp`.`supplier_name` AS `supplier_name`, `sp`.`quantity` AS `supplier_quantity`, `tr`.`transaction_id` AS `transaction_id`, `tr`.`customer_id` AS `customer_id`, `tr`.`product_id` AS `transaction_product_id`, `tr`.`qty` AS `transaction_qty` FROM (`supplier` `sp` left join `transaction` `tr` on(`sp`.`supplier_id` = `tr`.`transaction_id`))union select `sp`.`supplier_id` AS `supplier_id`,`sp`.`product_id` AS `supplier_product_id`,`sp`.`supplier_name` AS `supplier_name`,`sp`.`quantity` AS `supplier_quantity`,`tr`.`transaction_id` AS `transaction_id`,`tr`.`customer_id` AS `customer_id`,`tr`.`product_id` AS `transaction_product_id`,`tr`.`qty` AS `transaction_qty` from (`transaction` `tr` left join `supplier` `sp` on(`sp`.`supplier_id` = `tr`.`transaction_id`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `empName` (`empName`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `productIndex` (`product_id`);

--
-- Indexes for table `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`salary_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `supplierIndex` (`supplier_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `salary`
--
ALTER TABLE `salary`
  ADD CONSTRAINT `salary_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`);

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
  ADD CONSTRAINT `supplier_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
