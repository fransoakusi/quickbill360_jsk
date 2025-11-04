-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2025 at 10:58 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quickbill 360`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_findings`
--

CREATE TABLE `audit_findings` (
  `finding_id` int(11) NOT NULL,
  `finding_title` varchar(200) NOT NULL,
  `severity` enum('Low','Medium','High','Critical') NOT NULL DEFAULT 'Medium',
  `category` enum('Financial','Operational','Compliance','Security','Data Integrity','Other') NOT NULL,
  `description` text NOT NULL,
  `affected_module` varchar(100) DEFAULT NULL,
  `record_reference` varchar(100) DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `status` enum('Open','Under Review','Resolved','Closed') DEFAULT 'Open',
  `identified_by` int(11) NOT NULL,
  `identified_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolved_by` int(11) DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `resolution_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_findings`
--

INSERT INTO `audit_findings` (`finding_id`, `finding_title`, `severity`, `category`, `description`, `affected_module`, `record_reference`, `recommendations`, `status`, `identified_by`, `identified_at`, `resolved_by`, `resolved_at`, `resolution_notes`) VALUES
(1, '', '', 'Data Integrity', 'fdgf', '', '', 'addsfs', 'Open', 7, '2025-09-30 14:37:52', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`log_id`, `user_id`, `action`, `table_name`, `record_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`) VALUES
(594, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 08:46:50'),
(595, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":0,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 08:52:28'),
(596, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":0,\"property_bills\":1,\"skipped_records\":1,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 09:18:45'),
(597, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 09:27:19'),
(598, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 09:27:32'),
(600, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 09:29:28'),
(601, 4, 'USER_LOGIN', 'users', 4, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-08-29 09:33:44'),
(602, 4, 'CREATE_BUSINESS', 'businesses', 27, NULL, '{\"business_name\":\"Media General\",\"owner_name\":\"Kofi\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-08-29 09:35:20'),
(603, 4, 'CREATE_PROPERTY', 'properties', 11, NULL, '{\"owner_name\":\"Yaw Kusi\",\"location\":\"Location: Kpeshie\\r\\nGPS: 5.592970, -0.077170\",\"sub_zone_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-08-29 09:37:28'),
(604, 5, 'USER_LOGOUT', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 14:58:50'),
(605, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 14:59:04'),
(606, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 15:19:42'),
(607, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 15:20:09'),
(608, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":1,\"skipped_records\":2,\"total_generated\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 15:21:10'),
(609, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 17:57:07'),
(610, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 17:59:41'),
(611, 5, 'USER_LOGOUT', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 18:00:12'),
(612, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 18:01:05'),
(613, 4, 'USER_LOGOUT', 'users', 4, NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-08-29 18:01:21'),
(614, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":4,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 18:06:08'),
(615, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 18:18:55'),
(616, 4, 'USER_LOGIN', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 18:19:13'),
(617, 4, 'USER_LOGOUT', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 19:03:55'),
(618, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 19:04:11'),
(619, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 19:20:48'),
(620, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 19:21:02'),
(621, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 11:55:34'),
(622, 1, 'HARD_DELETE_BUSINESS', 'businesses', 27, '{\"business_id\":27,\"account_number\":\"BIZ000027\",\"business_name\":\"Media General\",\"owner_name\":\"Kofi\",\"business_type\":\"Bakeries\",\"category\":\"CAT A - Large Scale (Industrial operations)\",\"telephone\":\"0545041428\",\"exact_location\":\"Battor\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"old_bill\":\"0.00\",\"previous_payments\":\"0.00\",\"arrears\":\"0.00\",\"current_bill\":\"319.00\",\"amount_payable\":\"319.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":4,\"created_at\":\"2025-08-29 09:35:20\",\"updated_at\":\"2025-08-29 09:35:20\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 11:57:13\",\"related_records_deleted\":[\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 11:57:13'),
(623, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:46:09'),
(624, 1, 'HARD_DELETE_PROPERTY', 'properties', 11, '{\"property_id\":11,\"property_number\":\"PROP000011\",\"owner_name\":\"Yaw Kusi\",\"telephone\":\"\",\"gender\":\"Male\",\"location\":\"Location: Kpeshie\\r\\nGPS: 5.592970, -0.077170\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"structure\":\"Concrete Block\",\"ownership_type\":\"Self\",\"property_type\":\"Modern\",\"number_of_rooms\":5,\"property_use\":\"Commercial\",\"old_bill\":\"0.00\",\"previous_payments\":\"0.00\",\"arrears\":\"0.00\",\"current_bill\":\"500.00\",\"amount_payable\":\"500.00\",\"batch\":\"\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":4,\"created_at\":\"2025-08-29 09:37:28\",\"updated_at\":\"2025-08-29 09:37:28\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 12:46:50\",\"related_records_deleted\":[\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:46:50'),
(625, 1, 'HARD_DELETE_PROPERTY', 'properties', 10, '{\"property_id\":10,\"property_number\":\"PROP000001\",\"owner_name\":\"Joojo Megas\",\"telephone\":\"0545041428\",\"gender\":\"Male\",\"location\":\"Location: KpeshieGPS: 5.592970, -0.077170\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"structure\":\"Modern Building\",\"ownership_type\":\"Self\",\"property_type\":\"Modern\",\"number_of_rooms\":3,\"property_use\":\"Commercial\",\"old_bill\":\"0.00\",\"previous_payments\":\"250.00\",\"arrears\":\"0.00\",\"current_bill\":\"450.00\",\"amount_payable\":\"450.00\",\"batch\":\"\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":1,\"created_at\":\"2025-08-29 09:18:25\",\"updated_at\":\"2025-08-29 09:32:00\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 12:47:02\",\"related_records_deleted\":[\"1 payment record(s)\",\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:47:02'),
(626, 1, 'HARD_DELETE_BUSINESS', 'businesses', 28, '{\"business_id\":28,\"account_number\":\"BIZ000028\",\"business_name\":\"KabTech\",\"owner_name\":\"Kusi Francis\",\"business_type\":\"GRAPHIC DESIGN COMPANIES\",\"category\":\"CAT B Medium Scale\",\"telephone\":\"+233545041428\",\"exact_location\":\"Location: KpeshieGPS: 5.592970, -0.077170\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"old_bill\":\"0.00\",\"previous_payments\":\"0.00\",\"arrears\":\"0.00\",\"current_bill\":\"605.00\",\"amount_payable\":\"605.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":3,\"sub_zone_id\":4,\"created_by\":1,\"created_at\":\"2025-08-29 18:03:24\",\"updated_at\":\"2025-08-29 18:03:24\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 12:47:14\",\"related_records_deleted\":[\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:47:14'),
(627, 1, 'HARD_DELETE_BUSINESS', 'businesses', 26, '{\"business_id\":26,\"account_number\":\"BIZ000001\",\"business_name\":\"KabTech Consulting\",\"owner_name\":\"Joojo Megas\",\"business_type\":\"Auto Electricians\",\"category\":\"CAT A - With Battery Charging\",\"telephone\":\"+233545041428\",\"exact_location\":\"Location: KpeshieGPS: 5.592970, -0.077170\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"old_bill\":\"0.00\",\"previous_payments\":\"55.00\",\"arrears\":\"0.00\",\"current_bill\":\"110.00\",\"amount_payable\":\"110.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":4,\"sub_zone_id\":6,\"created_by\":1,\"created_at\":\"2025-08-29 08:47:37\",\"updated_at\":\"2025-08-29 09:29:00\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 12:47:22\",\"related_records_deleted\":[\"1 payment record(s)\",\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:47:22'),
(628, 4, 'USER_LOGIN', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 07:15:02'),
(629, 4, 'USER_LOGOUT', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 07:53:39'),
(630, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 07:53:54'),
(631, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 08:01:09'),
(632, 6, 'USER_LOGIN', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 08:01:28'),
(633, 6, 'USER_LOGOUT', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 09:01:29'),
(634, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 09:01:41'),
(635, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-09 20:26:31'),
(636, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":0,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-09 20:29:01'),
(637, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 15:35:10'),
(638, 1, 'PAYMENT_RECORDED', 'payments', 49, NULL, '{\"payment_reference\":\"PAY202509119LHD06\",\"bill_id\":49,\"bill_number\":\"BILL2025B000029\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":29,\"account_name\":\"KabTech Consulting\",\"account_number\":\"BIZ000001\",\"account_owner\":\"Afful Bismark\",\"amount_paid\":250,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":750,\"new_balance\":500,\"bill_amount_payable_before\":\"500.00\",\"bill_amount_payable_after\":250,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-09-11 15:51:36\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 15:51:36'),
(639, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:40:46'),
(640, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:41:19'),
(641, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:56:06'),
(642, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:57:52'),
(643, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-11 16:59:27'),
(644, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-11 17:05:16'),
(645, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-11 17:05:28'),
(646, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 17:05:41'),
(647, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-17 12:17:03'),
(648, 3, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":1,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-17 12:18:51'),
(649, 3, 'PAYMENT_RECORDED', 'payments', 50, NULL, '{\"payment_reference\":\"PAY20250917B40KEI\",\"bill_id\":50,\"bill_number\":\"BILL2025B000030\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":30,\"account_name\":\"TV 3\",\"account_number\":\"BIZ000030\",\"account_owner\":\"NTDA\",\"amount_paid\":300,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":1000,\"new_balance\":700,\"bill_amount_payable_before\":\"700.00\",\"bill_amount_payable_after\":400,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":3,\"processed_by_name\":\"Joojo Megas\",\"notes\":\"Part payment\",\"timestamp\":\"2025-09-17 12:20:20\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-17 12:20:20'),
(650, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-17 12:39:27'),
(651, 3, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2026,\"business_bills\":2,\"property_bills\":0,\"skipped_records\":0,\"total_generated\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-17 12:49:22'),
(652, 3, 'USER_LOGOUT', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-17 13:30:00'),
(653, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-23 09:33:10'),
(654, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-23 09:50:56'),
(655, 3, 'USER_LOGOUT', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-23 13:10:11'),
(656, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-25 11:08:00'),
(657, 7, 'USER_LOGIN', 'users', 7, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 13:57:09'),
(658, 7, 'PASSWORD_CHANGED', 'users', 7, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 13:58:29'),
(659, 7, 'GENERATE_AUDIT_REPORT', 'audit_reports', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 14:22:33'),
(660, 7, 'GENERATE_AUDIT_REPORT', 'audit_reports', 2, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 14:31:31'),
(661, 7, 'GENERATE_AUDIT_REPORT', 'audit_reports', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 14:32:01'),
(662, 7, 'CREATE_AUDIT_FINDING', 'audit_findings', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 14:37:52'),
(663, 7, 'USER_LOGOUT', 'users', 7, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 14:54:09'),
(664, 7, 'USER_LOGIN', 'users', 7, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 14:55:17'),
(665, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '2025-09-30 14:58:05'),
(666, 7, 'EXPORT_AUDIT_LOGS', 'audit_logs', NULL, NULL, '{\"filter_count\":0,\"records_exported\":71}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 15:04:29'),
(667, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-30 18:03:28'),
(668, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 05:35:41'),
(669, 4, 'USER_LOGIN', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-01 06:00:45'),
(670, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"properties\",\"billing_year\":2025,\"business_bills\":0,\"property_bills\":1,\"skipped_records\":0,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 06:26:05'),
(671, 1, 'HARD_DELETE_BUSINESS', 'businesses', 30, '{\"business_id\":30,\"account_number\":\"BIZ000030\",\"business_name\":\"TV 3\",\"owner_name\":\"NTDA\",\"business_type\":\"Cleaning Companies\",\"category\":\"CAT B - Household\\/Office (Medium)\",\"telephone\":\"0545041428\",\"exact_location\":\"Location: Aveyime-BattorGPS: 6.046445, 0.400574\",\"latitude\":\"6.04644500\",\"longitude\":\"0.40057400\",\"old_bill\":\"700.00\",\"previous_payments\":\"300.00\",\"arrears\":\"400.00\",\"current_bill\":\"700.00\",\"amount_payable\":\"1100.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":4,\"sub_zone_id\":6,\"created_by\":3,\"created_at\":\"2025-09-17 12:18:36\",\"updated_at\":\"2025-09-17 12:49:22\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-10-01 06:27:30\",\"related_records_deleted\":[\"1 payment record(s)\",\"2 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 06:27:30'),
(672, 1, 'HARD_DELETE_BUSINESS', 'businesses', 29, '{\"business_id\":29,\"account_number\":\"BIZ000001\",\"business_name\":\"KabTech Consulting\",\"owner_name\":\"Afful Bismark\",\"business_type\":\"I.T firm\",\"category\":\"Small\",\"telephone\":\"\",\"exact_location\":\"Accra\",\"latitude\":null,\"longitude\":null,\"old_bill\":\"500.00\",\"previous_payments\":\"251.00\",\"arrears\":\"249.00\",\"current_bill\":\"500.00\",\"amount_payable\":\"749.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":4,\"sub_zone_id\":5,\"created_by\":1,\"created_at\":\"2025-09-09 20:28:44\",\"updated_at\":\"2025-09-25 11:09:46\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-10-01 06:27:41\",\"related_records_deleted\":[\"2 payment record(s)\",\"2 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 06:27:41'),
(673, 1, 'UPDATE', 'businesses', 31, '{\"business_id\":31,\"account_number\":\"BIZ-CZ01-GA02-0001\",\"business_name\":\"Amuzu\",\"owner_name\":\"Dr.Amuzu\",\"business_type\":\"Cosmetic\\/Personal Care\\/Hair Product sale\",\"category\":\"CAT C - Retail\",\"telephone\":\"\",\"exact_location\":\"Battor\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07709000\",\"old_bill\":\"0.00\",\"previous_payments\":\"0.00\",\"arrears\":\"0.00\",\"current_bill\":\"121.00\",\"amount_payable\":\"121.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":1,\"created_at\":\"2025-09-30 18:22:49\",\"updated_at\":\"2025-09-30 18:22:49\"}', '{\"business_name\":\"Amuzu\",\"owner_name\":\"Dr.Amuzu\",\"business_type\":\"Cosmetic\\/Personal Care\\/Hair Product sale\",\"category\":\"CAT C - Retail\",\"telephone\":\"\",\"exact_location\":\"Battor\",\"latitude\":\"5.592970\",\"longitude\":\"-0.077090\",\"old_bill\":0,\"previous_payments\":0,\"arrears\":0,\"current_bill\":121,\"batch\":\"\",\"status\":\"Active\",\"zone_id\":1,\"sub_zone_id\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 06:29:10'),
(674, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"businesses\",\"billing_year\":2025,\"business_bills\":2,\"property_bills\":0,\"skipped_records\":0,\"total_generated\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 06:31:07'),
(675, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 09:06:18'),
(676, 7, 'USER_LOGIN', 'users', 7, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 09:07:13'),
(677, 7, 'USER_LOGOUT', 'users', 7, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 10:05:54'),
(678, 4, 'USER_LOGIN', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-01 10:07:56'),
(679, 4, 'CREATE_BUSINESS', 'businesses', 33, NULL, '{\"account_number\":\"BIZ-CZ01-GA02-0002\",\"business_name\":\"Thomas Enterprise\",\"owner_name\":\"Thomas\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-01 10:38:32'),
(680, 4, 'CREATE_PROPERTY', 'properties', 13, NULL, '{\"account_number\":\"PROP-CZ01-GA02-0002\",\"owner_name\":\"Thelma\",\"location\":\"Location: Kpeshie\\r\\nGPS: 5.59297000, -0.07709000\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-01 10:48:19'),
(681, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 10:54:54'),
(682, 1, 'HARD_DELETE_PROPERTY', 'properties', 13, '{\"property_id\":13,\"property_number\":\"PROP000013\",\"owner_name\":\"Thelma\",\"telephone\":\"0545041428\",\"gender\":\"Female\",\"location\":\"Location: Kpeshie\\r\\nGPS: 5.59297000, -0.07709000\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07709000\",\"structure\":\"Concrete Block\",\"ownership_type\":\"Self\",\"property_type\":\"Modern\",\"number_of_rooms\":1,\"property_use\":\"Commercial\",\"old_bill\":\"0.00\",\"previous_payments\":\"0.00\",\"arrears\":\"0.00\",\"current_bill\":\"100.00\",\"amount_payable\":\"100.00\",\"batch\":null,\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":4,\"created_at\":\"2025-10-01 10:48:19\",\"updated_at\":\"2025-10-01 10:48:19\",\"account_number\":\"PROP-CZ01-GA02-0002\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-10-01 10:55:20\",\"related_records_deleted\":[]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 10:55:20'),
(683, 4, 'CREATE_PROPERTY', 'properties', 14, NULL, '{\"property_number\":\"PROP-CZ01-GA02-00002\",\"owner_name\":\"Ben\",\"location\":\"Location: Kpeshie\\r\\nGPS: 5.59297000, -0.07709000\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-01 11:30:03'),
(684, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"properties\",\"billing_year\":2025,\"business_bills\":0,\"property_bills\":1,\"skipped_records\":1,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 11:33:01'),
(685, 6, 'USER_LOGIN', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-01 11:41:10'),
(686, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 12:22:35'),
(687, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 12:23:35'),
(688, 5, 'PAYMENT_RECORDED', 'payments', 52, NULL, '{\"payment_reference\":\"PAY20251001B324DE\",\"bill_id\":54,\"bill_number\":\"BILL2025B000031\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":31,\"account_name\":\"Amuzu\",\"account_number\":\"BIZ-CZ01-GA02-0001\",\"account_owner\":\"Dr.Amuzu\",\"amount_paid\":60.5,\"payment_method\":\"Cash\",\"payment_channel\":\"Cash Payment\",\"transaction_id\":\"\",\"previous_balance\":60.5,\"new_balance\":0,\"bill_amount_payable_before\":\"121.00\",\"bill_amount_payable_after\":60.5,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":5,\"processed_by_name\":\"Aseye Abledu\",\"notes\":\"Part Payment\",\"timestamp\":\"2025-10-01 12:26:35\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-01 12:26:35'),
(689, 6, 'USER_LOGOUT', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-01 12:26:44'),
(690, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-01 12:26:54'),
(691, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-02 02:10:41'),
(692, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-02 02:10:59'),
(693, 5, 'USER_LOGOUT', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 02:12:00'),
(694, 4, 'USER_LOGIN', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 02:12:15'),
(695, 4, 'USER_LOGOUT', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 02:42:29'),
(696, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 02:42:44'),
(697, 5, 'USER_LOGOUT', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 09:44:50'),
(698, 4, 'USER_LOGIN', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 09:44:58'),
(699, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-02 09:47:12'),
(700, 4, 'USER_LOGOUT', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 10:31:26'),
(701, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 10:31:36'),
(702, 1, 'PAYMENT_RECORDED', 'payments', 53, NULL, '{\"payment_reference\":\"PAY202510029L2VIB\",\"bill_id\":55,\"bill_number\":\"BILL2025B000032\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":32,\"account_name\":\"Aseye Enterprise\",\"account_number\":\"BIZ-NZ02-RA01-0001\",\"account_owner\":\"Aseye Abledu\",\"amount_paid\":21,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":142,\"new_balance\":121,\"bill_amount_payable_before\":\"121.00\",\"bill_amount_payable_after\":100,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-10-02 10:33:35\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 10:33:35'),
(703, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":1,\"skipped_records\":4,\"total_generated\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 10:38:32'),
(704, 1, 'PAYMENT_RECORDED', 'payments', 54, NULL, '{\"payment_reference\":\"PAY20251002HN7PRC\",\"bill_id\":57,\"bill_number\":\"BILL2025B000033\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":33,\"account_name\":\"Thomas Enterprise\",\"account_number\":\"BIZ-CZ01-GA02-0002\",\"account_owner\":\"Thomas\",\"amount_paid\":82,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":264,\"new_balance\":182,\"bill_amount_payable_before\":\"182.00\",\"bill_amount_payable_after\":100,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-10-02 10:40:10\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 10:40:10'),
(705, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2026,\"business_bills\":3,\"property_bills\":3,\"skipped_records\":0,\"total_generated\":6}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 10:44:08'),
(706, 1, 'PAYMENT_RECORDED', 'payments', 55, NULL, '{\"payment_reference\":\"PAY202510022FM8L3\",\"bill_id\":57,\"bill_number\":\"BILL2025B000033\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":33,\"account_name\":\"Thomas Enterprise\",\"account_number\":\"BIZ-CZ01-GA02-0002\",\"account_owner\":\"Thomas\",\"amount_paid\":100,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":300,\"new_balance\":200,\"bill_amount_payable_before\":\"100.00\",\"bill_amount_payable_after\":0,\"bill_status_updated\":\"Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-10-02 11:38:55\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 11:38:55'),
(707, 1, 'BILL_FULLY_PAID', 'bills', 57, NULL, '{\"bill_id\":57,\"bill_number\":\"BILL2025B000033\",\"previous_status\":\"Partially Paid\",\"new_status\":\"Paid\",\"final_payment_reference\":\"PAY202510022FM8L3\",\"final_payment_amount\":100,\"total_amount_paid\":\"100.00\",\"account_type\":\"Business\",\"account_id\":33,\"completed_by\":\"System Administrator\",\"completion_timestamp\":\"2025-10-02 11:38:55\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 11:38:55'),
(708, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 12:41:34'),
(709, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 14:28:32'),
(710, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-11-01 15:18:46'),
(711, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-11-01 15:19:00'),
(712, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-02 15:53:37'),
(713, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-02 15:53:42'),
(714, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-02 15:53:58'),
(715, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 19:03:43'),
(716, 1, 'HARD_DELETE_BUSINESS', 'businesses', 31, '{\"business_id\":31,\"account_number\":\"BIZ-CZ01-GA02-0001\",\"business_name\":\"Amuzu\",\"owner_name\":\"Dr.Amuzu\",\"business_type\":\"Cosmetic\\/Personal Care\\/Hair Product sale\",\"category\":\"CAT C - Retail\",\"telephone\":\"\",\"exact_location\":\"Battor\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07709000\",\"old_bill\":\"121.00\",\"previous_payments\":\"60.50\",\"arrears\":\"60.50\",\"current_bill\":\"121.00\",\"amount_payable\":\"181.50\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":1,\"created_at\":\"2025-09-30 18:22:49\",\"updated_at\":\"2025-10-02 10:44:08\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-10-02 19:14:57\",\"related_records_deleted\":[\"1 payment record(s)\",\"2 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 19:14:57'),
(717, 1, 'HARD_DELETE_BUSINESS', 'businesses', 32, '{\"business_id\":32,\"account_number\":\"BIZ-NZ02-RA01-0001\",\"business_name\":\"Aseye Enterprise\",\"owner_name\":\"Aseye Abledu\",\"business_type\":\"Cosmetic\\/Personal Care\\/Hair Product sale\",\"category\":\"CAT C - Retail\",\"telephone\":\"\",\"exact_location\":\"Location: KpeshieGPS: 5.592970, -0.077090\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07709000\",\"old_bill\":\"121.00\",\"previous_payments\":\"21.00\",\"arrears\":\"100.00\",\"current_bill\":\"121.00\",\"amount_payable\":\"221.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":2,\"sub_zone_id\":3,\"created_by\":1,\"created_at\":\"2025-10-01 06:30:38\",\"updated_at\":\"2025-10-02 10:44:08\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-10-02 19:15:05\",\"related_records_deleted\":[\"1 payment record(s)\",\"2 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 19:15:05'),
(718, 1, 'HARD_DELETE_BUSINESS', 'businesses', 33, '{\"business_id\":33,\"account_number\":\"BIZ-CZ01-GA02-0002\",\"business_name\":\"Thomas Enterprise\",\"owner_name\":\"Thomas\",\"business_type\":\"Driving Schools\",\"category\":\"CAT A - Above 6 Vehicles\",\"telephone\":null,\"exact_location\":\"Location: Kpeshie\\r\\nGPS: 5.59297000, -0.07709000\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07709000\",\"old_bill\":\"182.00\",\"previous_payments\":\"182.00\",\"arrears\":\"0.00\",\"current_bill\":\"182.00\",\"amount_payable\":\"182.00\",\"batch\":null,\"status\":\"Active\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":4,\"created_at\":\"2025-10-01 10:38:32\",\"updated_at\":\"2025-10-02 11:38:55\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-10-02 19:15:13\",\"related_records_deleted\":[\"2 payment record(s)\",\"2 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 19:15:13'),
(719, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":1,\"skipped_records\":3,\"total_generated\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 19:19:53'),
(720, 1, 'PAYMENT_RECORDED', 'payments', 56, NULL, '{\"payment_reference\":\"PAY20251002PWA18O\",\"bill_id\":65,\"bill_number\":\"BILL2025B000035\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":35,\"account_name\":\"TV 3\",\"account_number\":\"BIZ-EZ-EZME-0002\",\"account_owner\":\"Joojo Megas\",\"amount_paid\":100,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":300,\"new_balance\":200,\"bill_amount_payable_before\":\"200.00\",\"bill_amount_payable_after\":100,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-10-02 19:20:58\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 19:20:58'),
(721, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"businesses\",\"billing_year\":2026,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":0,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-02 19:22:08'),
(722, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-03 13:25:51'),
(723, 6, 'USER_LOGIN', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-03 13:27:22'),
(724, 6, 'USER_LOGIN', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 06:25:47'),
(725, 6, 'PAYMENT_RECORDED', 'payments', 57, NULL, '{\"payment_reference\":\"PAY2025100421C7BD\",\"bill_id\":65,\"bill_number\":\"BILL2025B000035\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":35,\"account_name\":\"TV 3\",\"account_number\":\"BIZ-EZ-EZME-0002\",\"account_owner\":\"Joojo Megas\",\"amount_paid\":100,\"payment_method\":\"Cash\",\"payment_channel\":\"Cash Payment\",\"transaction_id\":\"\",\"previous_balance\":\"100.00\",\"new_balance\":0,\"bill_amount_payable_before\":\"100.00\",\"bill_amount_payable_after\":0,\"bill_status_updated\":\"Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":6,\"processed_by_name\":\"David Lomko\",\"notes\":\"\",\"timestamp\":\"2025-10-04 06:39:14\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 06:39:14'),
(726, 6, 'BILL_FULLY_PAID', 'bills', 65, NULL, '{\"bill_id\":65,\"bill_number\":\"BILL2025B000035\",\"previous_status\":\"Partially Paid\",\"new_status\":\"Paid\",\"final_payment_reference\":\"PAY2025100421C7BD\",\"final_payment_amount\":100,\"total_amount_paid\":\"100.00\",\"account_type\":\"Business\",\"account_id\":35,\"completed_by\":\"David Lomko\",\"completion_timestamp\":\"2025-10-04 06:39:14\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 06:39:14'),
(727, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 07:27:52'),
(728, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"properties\",\"billing_year\":2025,\"business_bills\":0,\"property_bills\":1,\"skipped_records\":4,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 07:44:39'),
(729, 1, 'PAYMENT_RECORDED', 'payments', 58, NULL, '{\"payment_reference\":\"PAY20251004N1YJ05\",\"bill_id\":68,\"bill_number\":\"BILL2025P000017\",\"billing_year\":\"2025\",\"account_type\":\"Property\",\"account_id\":17,\"account_name\":\"Zayne Ewusi\",\"account_number\":\"PROP-EZ-EZME-00001\",\"account_owner\":\"Zayne Ewusi\",\"amount_paid\":50,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":250,\"new_balance\":200,\"bill_amount_payable_before\":\"250.00\",\"bill_amount_payable_after\":200,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-10-04 07:46:37\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 07:46:37'),
(730, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"properties\",\"billing_year\":2026,\"business_bills\":0,\"property_bills\":2,\"skipped_records\":3,\"total_generated\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 07:51:26'),
(731, 1, 'PAYMENT_RECORDED', 'payments', 59, NULL, '{\"payment_reference\":\"PAY202510041RF09B\",\"bill_id\":68,\"bill_number\":\"BILL2025P000017\",\"billing_year\":\"2025\",\"account_type\":\"Property\",\"account_id\":17,\"account_name\":\"Zayne Ewusi\",\"account_number\":\"PROP-EZ-EZME-00001\",\"account_owner\":\"Zayne Ewusi\",\"amount_paid\":100,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":200,\"new_balance\":100,\"bill_amount_payable_before\":\"200.00\",\"bill_amount_payable_after\":100,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-10-04 07:57:13\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 07:57:13'),
(732, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"properties\",\"billing_year\":2025,\"business_bills\":0,\"property_bills\":1,\"skipped_records\":5,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 08:12:06'),
(733, 1, 'PAYMENT_RECORDED', 'payments', 60, NULL, '{\"payment_reference\":\"PAY20251004FWQOC4\",\"bill_id\":71,\"bill_number\":\"BILL2025P000018\",\"billing_year\":\"2025\",\"account_type\":\"Property\",\"account_id\":18,\"account_name\":\"Beatrice Akueteh\",\"account_number\":\"PROP-NZ02-RA01-00002\",\"account_owner\":\"Beatrice Akueteh\",\"amount_paid\":100,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":300,\"new_balance\":200,\"bill_amount_payable_before\":\"300.00\",\"bill_amount_payable_after\":200,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-10-04 08:13:53\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 08:13:53'),
(734, 1, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"properties\",\"billing_year\":2026,\"business_bills\":0,\"property_bills\":1,\"skipped_records\":5,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 08:15:06');
INSERT INTO `audit_logs` (`log_id`, `user_id`, `action`, `table_name`, `record_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`) VALUES
(735, 6, 'USER_LOGIN', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-04 08:18:48'),
(736, 1, 'USER_LOGOUT', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 09:21:12'),
(737, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 09:21:20'),
(738, 3, 'RESTRICTION_SCHEDULED', 'system_restrictions', NULL, NULL, '{\"restriction_months\":2,\"warning_days\":7,\"start_date\":\"2025-10-05\",\"end_date\":\"2025-12-05\",\"reason\":\"\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 09:22:12'),
(739, 6, 'USER_LOGOUT', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-04 09:39:47'),
(740, 4, 'USER_LOGIN', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-04 09:41:06'),
(741, 4, 'USER_LOGOUT', 'users', 4, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-04 09:42:43'),
(742, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-04 09:43:08'),
(743, 3, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"businesses\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":1,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 10:06:38'),
(744, 3, 'PAYMENT_RECORDED', 'payments', 61, NULL, '{\"payment_reference\":\"PAY20251004HJST6U\",\"bill_id\":73,\"bill_number\":\"BILL2025B000036\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":36,\"account_name\":\"Auntie Bee Shop\",\"account_number\":\"BIZ-CZ01-GA02-0001\",\"account_owner\":\"Bee\",\"amount_paid\":100,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":700,\"new_balance\":600,\"bill_amount_payable_before\":\"700.00\",\"bill_amount_payable_after\":600,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":3,\"processed_by_name\":\"Joojo Megas\",\"notes\":\"\",\"timestamp\":\"2025-10-04 10:07:53\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 10:07:53'),
(745, 3, 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"businesses\",\"billing_year\":2026,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":1,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 10:09:01'),
(746, 3, 'USER_LOGOUT', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2026-02-03 10:10:23'),
(747, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2026-02-03 10:10:33'),
(748, 5, 'USER_LOGOUT', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2026-02-03 10:10:34'),
(749, 3, 'PAYMENT_RECORDED', 'payments', 62, NULL, '{\"payment_reference\":\"PAY202602033RWTF2\",\"bill_id\":74,\"bill_number\":\"BILL2026B000036\",\"billing_year\":\"2026\",\"account_type\":\"Business\",\"account_id\":36,\"account_name\":\"Auntie Bee Shop\",\"account_number\":\"BIZ-CZ01-GA02-0001\",\"account_owner\":\"Bee\",\"amount_paid\":300,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":1300,\"new_balance\":1000,\"bill_amount_payable_before\":\"1300.00\",\"bill_amount_payable_after\":1000,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":3,\"processed_by_name\":\"Joojo Megas\",\"notes\":\"\",\"timestamp\":\"2026-02-03 10:11:27\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2026-02-03 10:11:27'),
(750, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-04 10:32:00'),
(751, 5, 'USER_LOGOUT', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-04 10:33:50'),
(752, 6, 'USER_LOGIN', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2025-10-04 10:34:13'),
(753, 3, 'USER_LOGOUT', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 14:22:42'),
(754, 5, 'USER_LOGIN', 'users', 5, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-10-04 14:23:10'),
(755, 6, 'USER_LOGOUT', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', '2026-01-29 15:23:03'),
(756, 6, 'USER_LOGIN', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 19:23:18'),
(757, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-11 19:25:12'),
(758, 3, 'RESTRICTION_ACTIVATED', 'system_settings', NULL, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-11 19:25:40'),
(759, 6, 'USER_LOGOUT', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 19:26:58'),
(760, 3, 'RESTRICTION_LIFTED', 'system_restrictions', NULL, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-11 19:27:44'),
(761, 6, 'USER_LOGIN', 'users', 6, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 19:28:16'),
(762, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 20:08:12'),
(763, 3, 'USER_LOGOUT', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 20:09:06'),
(764, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 20:09:14'),
(765, 3, 'USER_LOGIN', 'users', 3, NULL, '{\"ip_address\":\"::1\",\"device_fingerprint\":\"d4d2c8572b4108c1a8155a7699427968\",\"user_agent\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/141.0.0.0 Sa\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 20:24:54'),
(766, 3, 'USER_LOGOUT', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 20:26:02'),
(767, 3, 'USER_LOGIN', 'users', 3, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-10-11 20:30:30'),
(768, 1, 'USER_LOGIN', 'users', 1, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-11-03 09:51:46'),
(769, 7, 'USER_LOGIN', 'users', 7, NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', '2025-11-03 09:53:27');

-- --------------------------------------------------------

--
-- Table structure for table `audit_reports`
--

CREATE TABLE `audit_reports` (
  `report_id` int(11) NOT NULL,
  `report_title` varchar(200) NOT NULL,
  `report_type` enum('User Activity','Payment Audit','Bill Generation','System Changes','Financial Summary','Custom') NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `filters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`filters`)),
  `report_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`report_data`)),
  `generated_by` int(11) NOT NULL,
  `generated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `file_path` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_reports`
--

INSERT INTO `audit_reports` (`report_id`, `report_title`, `report_type`, `date_from`, `date_to`, `filters`, `report_data`, `generated_by`, `generated_at`, `file_path`, `notes`) VALUES
(1, 'User activity Report - 2025-09-30 14:22', '', '2025-09-01', '2025-09-30', NULL, '[{\"action\":\"PASSWORD_CHANGED\",\"table_name\":\"users\",\"created_at\":\"2025-09-30 13:58:29\",\"username\":\"auditor\",\"user_name\":\"Internal Auditor\",\"role_name\":\"Internal Auditor\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-30 13:57:09\",\"username\":\"auditor\",\"user_name\":\"Internal Auditor\",\"role_name\":\"Internal Auditor\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-25 11:08:00\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-23 13:10:11\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-23 09:50:56\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-23 09:33:10\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-17 13:30:00\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"BILLS_GENERATED\",\"table_name\":\"bills\",\"created_at\":\"2025-09-17 12:49:22\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-17 12:39:27\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"PAYMENT_RECORDED\",\"table_name\":\"payments\",\"created_at\":\"2025-09-17 12:20:20\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"BILLS_GENERATED\",\"table_name\":\"bills\",\"created_at\":\"2025-09-17 12:18:51\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-17 12:17:03\",\"username\":\"Joojo\",\"user_name\":\"Joojo Megas\",\"role_name\":\"Super Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 17:05:41\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 17:05:28\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 17:05:16\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 16:59:27\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 16:57:52\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 16:56:06\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 16:41:19\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 16:40:46\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"PAYMENT_RECORDED\",\"table_name\":\"payments\",\"created_at\":\"2025-09-11 15:51:36\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-11 15:35:10\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"BILLS_GENERATED\",\"table_name\":\"bills\",\"created_at\":\"2025-09-09 20:29:01\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-09 20:26:31\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-05 09:01:41\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-05 09:01:29\",\"username\":\"David\",\"user_name\":\"David Lomko\",\"role_name\":\"Officer\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-05 08:01:28\",\"username\":\"David\",\"user_name\":\"David Lomko\",\"role_name\":\"Officer\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-05 08:01:09\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-05 07:53:54\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGOUT\",\"table_name\":\"users\",\"created_at\":\"2025-09-05 07:53:39\",\"username\":\"Kusi\",\"user_name\":\"Kusi France\",\"role_name\":\"Data Collector\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-05 07:15:02\",\"username\":\"Kusi\",\"user_name\":\"Kusi France\",\"role_name\":\"Data Collector\",\"ip_address\":\"::1\"},{\"action\":\"HARD_DELETE_BUSINESS\",\"table_name\":\"businesses\",\"created_at\":\"2025-09-02 12:47:22\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"HARD_DELETE_BUSINESS\",\"table_name\":\"businesses\",\"created_at\":\"2025-09-02 12:47:14\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"HARD_DELETE_PROPERTY\",\"table_name\":\"properties\",\"created_at\":\"2025-09-02 12:47:02\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"HARD_DELETE_PROPERTY\",\"table_name\":\"properties\",\"created_at\":\"2025-09-02 12:46:50\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-02 12:46:09\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"HARD_DELETE_BUSINESS\",\"table_name\":\"businesses\",\"created_at\":\"2025-09-02 11:57:13\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"},{\"action\":\"USER_LOGIN\",\"table_name\":\"users\",\"created_at\":\"2025-09-02 11:55:34\",\"username\":\"admin\",\"user_name\":\"System Administrator\",\"role_name\":\"Admin\",\"ip_address\":\"::1\"}]', 7, '2025-09-30 14:22:33', NULL, NULL),
(2, 'Financial summary Report - 2025-09-30 14:31', '', '2025-09-01', '2025-09-30', NULL, '{\"total_payments\":{\"count\":3,\"total\":\"551.00\",\"average\":\"183.666667\"},\"payment_methods\":[{\"payment_method\":\"Cash\",\"count\":2,\"total\":\"550.00\"},{\"payment_method\":\"Online\",\"count\":1,\"total\":\"1.00\"}],\"bills_generated\":{\"count\":4,\"total_billed\":\"2400.00\",\"total_outstanding\":\"2500.00\"},\"payment_status\":[{\"status\":\"Pending\",\"count\":1,\"total\":\"1100.00\"},{\"status\":\"Partially Paid\",\"count\":3,\"total\":\"1400.00\"}]}', 7, '2025-09-30 14:31:31', NULL, NULL),
(3, 'Bill generation Report - 2025-09-30 14:32', '', '2025-09-01', '2025-09-30', NULL, '[{\"bill_number\":\"BILL2026B000029\",\"bill_type\":\"Business\",\"billing_year\":\"2026\",\"current_bill\":\"500.00\",\"amount_payable\":\"750.00\",\"status\":\"Partially Paid\",\"generated_at\":\"2025-09-17 12:49:22\",\"account_name\":\"KabTech Consulting\",\"account_number\":\"BIZ000001\",\"generated_by\":\"Joojo Megas\"},{\"bill_number\":\"BILL2026B000030\",\"bill_type\":\"Business\",\"billing_year\":\"2026\",\"current_bill\":\"700.00\",\"amount_payable\":\"1100.00\",\"status\":\"Pending\",\"generated_at\":\"2025-09-17 12:49:22\",\"account_name\":\"TV 3\",\"account_number\":\"BIZ000030\",\"generated_by\":\"Joojo Megas\"},{\"bill_number\":\"BILL2025B000030\",\"bill_type\":\"Business\",\"billing_year\":\"2025\",\"current_bill\":\"700.00\",\"amount_payable\":\"400.00\",\"status\":\"Partially Paid\",\"generated_at\":\"2025-09-17 12:18:51\",\"account_name\":\"TV 3\",\"account_number\":\"BIZ000030\",\"generated_by\":\"Joojo Megas\"},{\"bill_number\":\"BILL2025B000029\",\"bill_type\":\"Business\",\"billing_year\":\"2025\",\"current_bill\":\"500.00\",\"amount_payable\":\"250.00\",\"status\":\"Partially Paid\",\"generated_at\":\"2025-09-09 20:29:01\",\"account_name\":\"KabTech Consulting\",\"account_number\":\"BIZ000001\",\"generated_by\":\"System Administrator\"}]', 7, '2025-09-30 14:32:01', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `audit_trail_comprehensive`
-- (See below for the actual view)
--
CREATE TABLE `audit_trail_comprehensive` (
`log_id` int(11)
,`action` varchar(100)
,`table_name` varchar(50)
,`record_id` int(11)
,`old_values` longtext
,`new_values` longtext
,`ip_address` varchar(45)
,`created_at` timestamp
,`username` varchar(50)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`role_name` varchar(50)
,`activity_category` varchar(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `backup_logs`
--

CREATE TABLE `backup_logs` (
  `backup_id` int(11) NOT NULL,
  `backup_type` enum('Full','Incremental') NOT NULL,
  `backup_path` varchar(255) NOT NULL,
  `backup_size` bigint(20) DEFAULT NULL,
  `status` enum('In Progress','Completed','Failed') DEFAULT 'In Progress',
  `started_by` int(11) NOT NULL,
  `started_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL,
  `error_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL,
  `bill_number` varchar(20) NOT NULL,
  `bill_type` enum('Business','Property') NOT NULL,
  `reference_id` int(11) NOT NULL,
  `billing_year` year(4) NOT NULL,
  `old_bill` decimal(10,2) DEFAULT 0.00,
  `previous_payments` decimal(10,2) DEFAULT 0.00,
  `arrears` decimal(10,2) DEFAULT 0.00,
  `current_bill` decimal(10,2) NOT NULL,
  `amount_payable` decimal(10,2) NOT NULL,
  `qr_code` text DEFAULT NULL,
  `status` enum('Pending','Paid','Partially Paid','Overdue') DEFAULT 'Pending',
  `served_status` enum('Not Served','Served','Attempted','Returned') DEFAULT 'Not Served',
  `served_by` int(11) DEFAULT NULL,
  `served_at` timestamp NULL DEFAULT NULL,
  `delivery_notes` text DEFAULT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `generated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `due_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`bill_id`, `bill_number`, `bill_type`, `reference_id`, `billing_year`, `old_bill`, `previous_payments`, `arrears`, `current_bill`, `amount_payable`, `qr_code`, `status`, `served_status`, `served_by`, `served_at`, `delivery_notes`, `generated_by`, `generated_at`, `due_date`) VALUES
(53, 'BILL2025P000012', 'Property', 12, '2025', 0.00, 0.00, 0.00, 100.00, 100.00, NULL, 'Pending', 'Served', 4, '2025-10-02 02:41:54', '', 1, '2025-10-01 06:26:05', NULL),
(56, 'BILL2025P000014', 'Property', 14, '2025', 0.00, 0.00, 0.00, 200.00, 200.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-01 11:33:01', NULL),
(58, 'BILL2025P000015', 'Property', 15, '2025', 0.00, 0.00, 0.00, 100.00, 100.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-02 10:38:32', NULL),
(62, 'BILL2026P000012', 'Property', 12, '2026', 100.00, 0.00, 100.00, 100.00, 200.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-02 10:44:08', NULL),
(63, 'BILL2026P000014', 'Property', 14, '2026', 200.00, 0.00, 200.00, 200.00, 400.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-02 10:44:08', NULL),
(64, 'BILL2026P000015', 'Property', 15, '2026', 100.00, 0.00, 100.00, 100.00, 200.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-02 10:44:08', NULL),
(65, 'BILL2025B000035', 'Business', 35, '2025', 0.00, 0.00, 0.00, 200.00, 0.00, NULL, 'Paid', 'Served', 1, '2025-10-02 19:21:16', '', 1, '2025-10-02 19:19:53', NULL),
(66, 'BILL2025P000016', 'Property', 16, '2025', 0.00, 0.00, 0.00, 100.00, 100.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-02 19:19:53', NULL),
(67, 'BILL2026B000035', 'Business', 35, '2026', 200.00, 100.00, 100.00, 200.00, 300.00, NULL, 'Pending', 'Served', 1, '2025-10-02 19:22:32', '', 1, '2025-10-02 19:22:08', NULL),
(68, 'BILL2025P000017', 'Property', 17, '2025', 0.00, 0.00, 0.00, 250.00, 100.00, NULL, 'Partially Paid', 'Not Served', NULL, NULL, NULL, 1, '2025-10-04 07:44:39', NULL),
(69, 'BILL2026P000016', 'Property', 16, '2026', 100.00, 0.00, 100.00, 100.00, 200.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-04 07:51:26', NULL),
(70, 'BILL2026P000017', 'Property', 17, '2026', 250.00, 50.00, 200.00, 250.00, 450.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-04 07:51:26', NULL),
(71, 'BILL2025P000018', 'Property', 18, '2025', 0.00, 0.00, 0.00, 300.00, 200.00, NULL, 'Partially Paid', 'Not Served', NULL, NULL, NULL, 1, '2025-10-04 08:12:06', NULL),
(72, 'BILL2026P000018', 'Property', 18, '2026', 300.00, 100.00, 200.00, 300.00, 500.00, NULL, 'Pending', 'Not Served', NULL, NULL, NULL, 1, '2025-10-04 08:15:06', NULL),
(73, 'BILL2025B000036', 'Business', 36, '2025', 0.00, 0.00, 0.00, 700.00, 600.00, NULL, 'Partially Paid', 'Not Served', NULL, NULL, NULL, 3, '2025-10-04 10:06:38', NULL),
(74, 'BILL2026B000036', 'Business', 36, '2026', 700.00, 100.00, 600.00, 700.00, 1000.00, NULL, 'Partially Paid', 'Not Served', NULL, NULL, NULL, 3, '2025-10-04 10:09:01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `bill_adjustments`
--

CREATE TABLE `bill_adjustments` (
  `adjustment_id` int(11) NOT NULL,
  `adjustment_type` enum('Single','Bulk') NOT NULL,
  `target_type` enum('Business','Property') NOT NULL,
  `target_id` int(11) DEFAULT NULL,
  `criteria` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`criteria`)),
  `adjustment_method` enum('Fixed Amount','Percentage') NOT NULL,
  `adjustment_value` decimal(10,2) NOT NULL,
  `old_amount` decimal(10,2) DEFAULT NULL,
  `new_amount` decimal(10,2) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `applied_by` int(11) NOT NULL,
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `businesses`
--

CREATE TABLE `businesses` (
  `business_id` int(11) NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `business_name` varchar(200) NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `business_type` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `exact_location` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `old_bill` decimal(10,2) DEFAULT 0.00,
  `previous_payments` decimal(10,2) DEFAULT 0.00,
  `arrears` decimal(10,2) DEFAULT 0.00,
  `current_bill` decimal(10,2) DEFAULT 0.00,
  `amount_payable` decimal(10,2) DEFAULT 0.00,
  `batch` varchar(50) DEFAULT NULL,
  `status` enum('Active','Inactive','Suspended') DEFAULT 'Active',
  `zone_id` int(11) DEFAULT NULL,
  `sub_zone_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `businesses`
--

INSERT INTO `businesses` (`business_id`, `account_number`, `business_name`, `owner_name`, `business_type`, `category`, `telephone`, `exact_location`, `latitude`, `longitude`, `old_bill`, `previous_payments`, `arrears`, `current_bill`, `amount_payable`, `batch`, `status`, `zone_id`, `sub_zone_id`, `created_by`, `created_at`, `updated_at`) VALUES
(34, 'BIZ-EZ-EZME-0001', 'MTN', 'Joojo Megas', 'Rural &amp; Community Banks', 'CAT A - Head Office', '', 'Location: KpeshieGPS: 5.592970, -0.077090', 5.59297000, -0.07709000, 0.00, 0.00, 0.00, 2750.00, 2750.00, '', 'Active', 4, 6, 1, '2025-10-02 19:16:42', '2025-10-02 19:16:42'),
(35, 'BIZ-EZ-EZME-0002', 'TV 3', 'Joojo Megas', 'Media Houses Electronic Media (Radio) Operators', 'CAT-H-Information Centre (Urban)', '', 'Location: KpeshieGPS: 5.592970, -0.077090', 5.59297000, -0.07709000, 200.00, 200.00, 0.00, 200.00, 200.00, '', 'Active', 4, 6, 1, '2025-10-02 19:19:42', '2025-10-04 06:39:14'),
(36, 'BIZ-CZ01-GA02-0001', 'Auntie Bee Shop', 'Bee', 'Cleaning Companies', 'CAT B - Household/Office (Medium)', '', 'Location: KpeshieGPS: 5.592970, -0.077090', 5.59297000, -0.07709000, 700.00, 400.00, 300.00, 700.00, 1000.00, '', 'Active', 1, 2, 3, '2025-10-04 10:03:28', '2026-02-03 10:11:27');

--
-- Triggers `businesses`
--
DELIMITER $$
CREATE TRIGGER `calculate_business_payable` BEFORE INSERT ON `businesses` FOR EACH ROW BEGIN
    -- Calculate arrears: old_bill - previous_payments (minimum 0)
    SET NEW.arrears = GREATEST(0, NEW.old_bill - NEW.previous_payments);
    
    -- Calculate amount_payable: arrears + current_bill
    SET NEW.amount_payable = NEW.arrears + NEW.current_bill;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `generate_business_account_number` BEFORE INSERT ON `businesses` FOR EACH ROW BEGIN
    IF NEW.account_number IS NULL OR NEW.account_number = '' THEN
        SET NEW.account_number = CONCAT('BIZ', LPAD(COALESCE((SELECT MAX(business_id) FROM businesses), 0) + 1, 6, '0'));
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_business_payable` BEFORE UPDATE ON `businesses` FOR EACH ROW BEGIN
    -- Calculate arrears: old_bill - previous_payments (minimum 0)
    SET NEW.arrears = GREATEST(0, NEW.old_bill - NEW.previous_payments);
    
    -- Calculate amount_payable: arrears + current_bill
    SET NEW.amount_payable = NEW.arrears + NEW.current_bill;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `business_fee_structure`
--

CREATE TABLE `business_fee_structure` (
  `fee_id` int(11) NOT NULL,
  `business_type` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `fee_amount` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `business_fee_structure`
--

INSERT INTO `business_fee_structure` (`fee_id`, `business_type`, `category`, `fee_amount`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Restaurant', 'Small Scale', 500.00, 1, 1, '2025-07-04 18:57:35', '2025-07-10 14:52:25'),
(2, 'Restaurant', 'Medium Scale', 1000.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(3, 'Restaurant', 'Large Scale', 2100.00, 1, 1, '2025-07-04 18:57:35', '2025-07-12 19:58:34'),
(4, 'Shop', 'Small Scale', 300.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(5, 'Shop', 'Medium Scale', 600.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(6, 'Shop', 'Large Scale', 1200.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(7, 'Saloon', 'Large', 100.00, 1, 3, '2025-07-10 14:51:40', '2025-07-10 14:51:40'),
(8, 'I.T firm', 'Small', 500.00, 1, 3, '2025-07-16 11:27:11', '2025-07-16 11:27:11'),
(9, 'Salon', 'Large Scale', 1200.00, 1, 1, '2025-07-20 09:55:37', '2025-07-20 09:55:37'),
(10, 'Abattoir (Private)', 'CAT F - Slaughter House (Small)', 146.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(11, 'Abattoir (Private)', 'CAT G - Others', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(12, 'Adinkra Designers/Kente/Smock Weavers & Sellers', 'CAT H - Weavers Only (Small)', 40.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(13, 'Adinkra Designers/Kente/Smock Weavers & Sellers', 'CAT I - Sellers Only (Small)', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(14, 'Agro Chemical/Farm Inputs Dealers', 'CAT H - Distributors', 160.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(15, 'Agro Chemical/Farm Inputs Dealers', 'CAT I - Retailers', 93.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(16, 'Agro Machine Dealers', 'CAT I - Retailers', 133.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(17, 'Akpeteshie (liquor) Dealers  Manufacturers (Distillers)', 'CAT B - Medium Scale', 133.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(18, 'Akpeteshie (liquor) Dealers  Manufacturers (Distillers)', 'CAT C - Small Scale', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(19, 'Home Based/Farm Site', 'CAT A - Pito (daily brewing)', 40.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(20, 'Home Based/Farm Site', 'CAT B - Palm Wine Tappers', 40.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(21, 'Akpeteshie Sellers Only', 'Akpeteshie Sellers Only', 80.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(22, 'Aluminium Fabricators (Doors/Windows)', 'CAT B-Medium Scale', 385.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(23, 'Aluminium Fabricators (Doors/Windows)', 'CAT C - Small Scale', 160.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(24, 'Aluminium Fabricators (Doors/Windows)', 'CAT D - Others', 117.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(25, 'Aluminium Pot Dealers (‘Dadesen’)', 'CAT B - Distributors', 116.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(26, 'Aluminium Pot Dealers (‘Dadesen’)', 'CAT C - Retailers', 110.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(27, 'Aluminium Product Distributors', 'CAT B - Medium Scale', 220.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(28, 'Aluminium Product Distributors', 'CAT C - Small Scale', 146.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(29, 'Aluminium Product Retailers', 'Category B - Container/Kiosk (Medium)', 100.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(30, 'Aluminium Product Retailers', 'Category C - Table Top (Small)', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(31, 'Ambulance Service Providers', 'CAT B - Medium Scale (3-5 Vehicles)', 133.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(32, 'Ambulance Service Providers', 'CAT C - Small Scale (1-2 Vehicles)', 61.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(33, 'Arts & Handicraft Dealers', 'CAT F - Retailers Only', 133.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(34, 'Arts & Handicraft Dealers', 'CAT G - Container/Kiosk', 102.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(35, 'Arts & Handicraft Dealers', 'CAT H - Table Top', 61.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(36, 'Artisans e.g., Masons, Carpenters, Plumbers, Electricians, Painters, Steel Benders, Tile Layers etc.', 'CAT \'A\'', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(37, 'Artisans e.g., Masons, Carpenters, Plumbers, Electricians, Painters, Steel Benders, Tile Layers etc.', 'CAT \'B\'', 39.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(38, 'Air Condition Mechanics', 'CAT C - Informal Garage without Shop', 160.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(39, 'Air Condition Mechanics', 'CAT D - Others', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(40, 'Arc Welders', 'CAT A - Fuel and Water Tankers; Truck Builders', 160.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(41, 'Arc Welders', 'CAT B - Light vehicle repairs, Container Shops, and Iron Gates', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(42, 'Argon (Aluminium) Welders', 'Argon (Aluminium) Welders', 44.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(43, 'Auto Body Repairers', 'CAT C - Informal Garage without Shop', 160.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(44, 'Auto Body Repairers', 'CAT D - Others', 117.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(45, 'Auto Electricians', 'CAT A - With Battery Charging', 110.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(46, 'Auto Electricians', 'CAT B - Without Battery Charging', 41.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(47, 'Auto Mechanics', 'CAT B - Heavy Duty Trucks', 97.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(48, 'Auto Mechanics', 'CAT C - Light Duty Trucks (3 to 5 tonnes)', 89.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(49, 'Auto Mechanics', 'CAT D - Light Duty Vehicles (Below 3 tonnes)', 81.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(50, 'Auto Sprayers', 'CAT A - Spraying with Oven', 315.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(51, 'Auto Sprayers', 'CAT B - Spraying without Oven', 293.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(52, 'Auto Upholstery', 'CAT A - Moulding and Seat Cover Sewing', 110.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(53, 'Auto Upholstery', 'CAT B - Seat Cover Sewing', 59.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(54, 'Vulcanisers', 'CAT C - Wheel Balancing and Alignment', 106.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(55, 'Vulcanisers', 'CAT D - Tyre Repairs only', 66.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(56, 'Brake Specialist', 'Brake Specialist', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(57, 'Carburettor Specialist', 'Carburettor Specialist', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(58, 'Plastic Welders and Fabricators', 'Plastic Welders and Fabricators', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(59, 'Radiator Specialist', 'Radiator Specialist', 67.00, 1, 1, '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
(60, 'Multiple Service Providers for Auto Works', 'CAT B-Medium Scale', 110.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(61, 'Multiple Service Providers for Auto Works', 'CAT C - Small Scale', 99.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(62, 'Windscreen Repairers', 'CAT C- Small scale', 99.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(63, 'Bolt and Nut Dealers', 'CAT A - Shop', 93.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(64, 'Bolt and Nut Dealers', 'CAT B - Table Top', 67.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(65, 'Spare Parts Sales Outlets (Secondhand)', 'CAT A - Second-Hand Engine Shops', 532.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(66, 'Spare Parts Sales Outlets (Secondhand)', 'CAT B - Retailers (Large)', 308.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(67, 'Spare Parts Sales Outlets (Secondhand)', 'CAT C - Retailers (Medium)', 187.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(68, 'Spare Parts Sales Outlets (Secondhand)', 'CAT D - Retailers (Small)', 106.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(69, 'Spare Parts Sales Outlets (Secondhand)', 'CAT E - Kiosk/Tabletop', 77.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(70, 'Tyre/Battery Dealers – Used', 'CAT B - Retail (Large)', 160.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(71, 'Tyre/Battery Dealers – Used', 'CAT C - Retail (Medium)', 133.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(72, 'Tyre/Battery Dealers – Used', 'CAT D - Retail (Small)', 100.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(73, 'Barbering Shop (floor space and number of points)', 'CAT B - Medium Shop (3-5 points)', 133.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(74, 'Barbering Shop (floor space and number of points)', 'CAT C - Small Shop (1-2 points)', 70.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(75, 'Barbering Shop (floor space and number of points)', 'CAT D - Mobile Operators', 17.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(76, 'Barbering Shop (floor space and number of points)', 'CAT E - Barbering accessory shop', 44.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(77, 'Bakeries', 'CAT A - Large Scale (Industrial operations)', 319.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(78, 'Bakeries', 'CAT B - Medium Scale', 160.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(79, 'Bakeries', 'CAT C - Small Scale', 80.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(80, 'Beads Dealers', 'CAT B', 83.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(81, 'Beads Dealers', 'CAT C', 55.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(82, 'Beads Dealers', 'CAT D - Retailers (Tabletop)', 33.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(83, 'Alcoholic and Non-Alcoholic beverages', 'CAT D - Retail (Large)', 400.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(84, 'Alcoholic and Non-Alcoholic beverages', 'CAT E - Retail (Medium)', 133.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(85, 'Alcoholic and Non-Alcoholic beverages', 'CAT F - Retail (Small)', 70.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(86, 'Bet & Game Centres Sports Betting Operations', 'CAT A - Online Betting', 2200.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(87, 'Route Operations (Console/consul Games)', 'CAT ‘C’', 1198.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(88, 'Route Operations (Console/consul Games)', 'CAT D (Per Machine)', 266.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(89, 'Bicycles/Tricycles/Motorcycle Dealers (Second-hand)', 'CAT C - Small Scale', 133.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(90, 'Bicycles/Tricycles/Motorcycles Parts Sales', 'CAT C - Motorcycle/Tricycles', 152.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(91, 'Bicycles/Tricycles/Motorcycles Parts Sales', 'CAT D - Bicycle with Parts', 120.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(92, 'Bicycles/Tricycles/Motorcycles Parts Sales', 'CAT E - Bicycles', 67.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(93, 'Bicycle Tricycle/ Motorcycle Repairers', 'CAT A - Tricycle', 66.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(94, 'Bicycle Tricycle/ Motorcycle Repairers', 'CAT B - Motorcycle', 39.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(95, 'Bicycle Tricycle/ Motorcycle Repairers', 'CAT C - Bicycle', 13.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(96, 'Billboards/Outdoor Adverts (e.g., Road Arches, Unipole spectacular, LEDs, Building wrap or Wall Drap', 'CAT A - Class A1 (Along First Class Access)', 37.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(97, 'Billboards/Outdoor Adverts (e.g., Road Arches, Unipole spectacular, LEDs, Building wrap or Wall Drap', 'CAT B - Class A2 (Along Second Class Access)', 29.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(98, 'Billboards/Outdoor Adverts (e.g., Road Arches, Unipole spectacular, LEDs, Building wrap or Wall Drap', 'CAT C - Class A3 (Along Third Class Access)', 25.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(99, 'Other Adverts', 'Other Adverts', 100.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(100, 'Blacksmith', 'Blacksmith', 73.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(101, 'Blocks & Concrete Producers', 'Blocks & Concrete Producers', 74.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(102, 'CAT E - Small Scale (Manual design blocks/columns only)', 'CAT E - Small Scale (Manual design blocks/columns only)', 75.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(103, 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT H - Office Equipment Only', 300.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(104, 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT I - Stationery Only', 200.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(105, 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT J - Books Only', 73.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(106, 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT K - Table Top/Truck Pusher', 27.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(107, 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT L - Mobile Vans', 44.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(108, 'Boutiques (Including African Wear)', 'CAT B - Small Scale', 400.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(109, 'Boutiques (Including African Wear)', 'CAT C - Small Scale', 242.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(110, 'Boutiques (Including African Wear)', 'CAT D - Branches of CAT A & B', 182.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(111, 'Boutiques (Including African Wear)', 'CAT E - Others', 85.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(112, 'Bridal Homes', 'CAT ‘B’', 399.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(113, 'Bridal Homes', 'CAT \'C\'', 200.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(114, 'Butcher\'s Licence', 'CAT B - Butcher', 88.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(115, 'Building Material Dealers Hardware (Distributor/ Wholesaler)', 'CAT A - Distributor/Wholesaler (Large)', 2782.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(116, 'Building Material Dealers Hardware (Distributor/ Wholesaler)', 'CAT B - Distributor/Wholesaler (Medium)', 1171.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(117, 'Building Material Dealers Hardware (Distributor/ Wholesaler)', 'CAT C - Wholesaler (Medium)', 732.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(118, 'Building Material Dealers Hardware (Distributor/ Wholesaler)', 'CAT D - Wholesaler (Small)', 395.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(119, 'Finishing/Retail', 'CAT A - Large Scale', 666.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(120, 'Finishing/Retail', 'CAT B - Medium Scale', 395.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(121, 'Finishing/Retail', 'CAT C - Small Scale', 293.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(122, 'Finishing/Retail', 'CAT D - Very Small Scale', 146.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(123, 'Roofing Material Dealers', 'CAT A - Manufacture/Sales', 666.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(124, 'Roofing Material Dealers', 'CAT B - Sales & Installation', 399.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(125, 'Business Centres', 'CAT D - Internet, Word Processing, Printing and Copying Services plus below 11 Workstations', 146.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(126, 'Business Centres', 'CAT E - Secretarial Services (Word Processing, Printing and Copying Services)', 102.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(127, 'Cane Product Weavers', 'CAT ‘B’', 41.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(128, 'Cane Product Weavers', 'CAT \'C\'', 32.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(129, 'Car Washing Bay', 'CAT C - Jet Washing Only', 117.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(130, 'Car Washing Bay', 'CAT E - Manual Washing with other Facilities', 73.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(131, 'Car Washing Bay', 'CAT F - Manual Washing', 44.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(132, 'Canopy Producers', 'CAT B - Metal Fabricators', 133.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(133, 'Canopy Producers', 'CAT C - Fabric Sewing', 53.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(134, 'Carpentry Workshops', 'CAT C - Furniture (plus upholstery - Medium)', 102.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(135, 'Carpentry Workshops', 'CAT D - Furniture (plus upholstery - Small)', 81.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(136, 'Carpentry Workshops', 'CAT E - Minor Works', 64.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(137, 'Casket & Coffin Dealers', 'CAT C - Industrial (Manufacture & Sale)', 363.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(138, 'Casket & Coffin Dealers', 'CAT C - Manual (Manufacture & Sale)', 303.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(139, 'Casket & Coffin Dealers', 'CAT D - Sales Outlets', 110.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(140, 'Casket & Coffin Dealers', 'CAT E - Manufacturers Only', 99.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(141, 'Contracted Caterers (e.g., School Feeding)', 'CAT B - Above 500 to 1,000 pupils', 161.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(142, 'Contracted Caterers (e.g., School Feeding)', 'CAT C - Up to 500 pupils', 122.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(143, 'Ceremonial Hiring Services', 'CAT C - Canopies, Chairs, Tables', 399.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(144, 'Ceremonial Hiring Services', 'CAT D - Single Item of above', 99.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(145, 'Ceremonial Hiring Services', 'CAT H - Spinners (Large)', 200.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(146, 'Ceremonial Hiring Services', 'CAT I - Spinners (Small)', 99.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(147, 'Ceremonial Hiring Services', 'CAT J - Live Band', 333.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(148, 'Ceremonial Hiring Services', 'CAT K - Musical/Dance Groups', 133.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(149, 'Cleaning Companies', 'CAT B - Household/Office (Medium)', 700.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(150, 'Cleaning Companies', 'CAT C - Household/Office (Small)', 600.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(151, 'Cleaning Companies', 'CAT D - Household/Office (Very Small)', 200.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(152, 'Cold Storage Faccilities Non-Importers with Containerised Cold Storage Facilities (Local)', 'CAT D - Fabricated facility (Retail Large)', 200.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(153, 'Cold Storage Faccilities Non-Importers with Containerised Cold Storage Facilities (Local)', 'CAT E - Fabricated facility (Retail Medium)', 110.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(154, 'Cold Storage Faccilities Non-Importers with Containerised Cold Storage Facilities (Local)', 'CAT F - Fabricated facility (Retail Small)', 53.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(155, 'Stores Commercial Houses/Departmental', 'CAT G - Neighbourhood Shops (Large Size)', 399.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(156, 'Stores Commercial Houses/Departmental', 'CAT H - Neighbourhood Shops (Medium Size)', 266.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(157, 'Stores Commercial Houses/Departmental', 'CAT I - Neighbourhood Shops (Small Size)', 99.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(158, 'Stores Commercial Houses/Departmental', 'CAT J - Neighbourhood Shops (Very Small Size)', 66.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(159, 'Commercial Houses/Departmental', 'CAT C - Branch Offices', 7700.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(160, 'Commercial Houses/Departmental', 'CAT D - District Offices', 4950.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(161, 'Commercial Houses/Departmental', 'CAT E - Local Offices', 2200.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(162, 'Commissioner of Oath/Letter Writers', 'CAT ‘A’', 99.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(163, 'Commissioner of Oath/Letter Writers', 'CAT ‘B’', 66.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(164, 'Communication Mast Operating License', 'CAT A - 1-10 Masts', 2420.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(165, 'Communication Mast Operating License', 'CAT B - 11-20 Masts', 1980.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(166, 'Communication Mast Operating License', 'CAT C - 21-30 Masts', 1650.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(167, 'Communication Mast Operating License', 'CAT D - 31-40 Masts', 1100.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(168, 'Communication Mast Operating License', 'CAT E - Above 40 Masts', 792.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(169, 'Cooking/Household Utensil Sales', 'CAT ‘A’', 75.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(170, 'Cooking/Household Utensil Sales', 'CAT ‘B’', 54.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(171, 'Cooking/Household Utensil Sales', 'CAT ‘C’', 35.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(172, 'Cosmetic/Personal Care/Hair Product sale', 'CAT C - Retail', 121.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(173, 'Cosmetic/Personal Care/Hair Product sale', 'CAT D - Table top', 40.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(174, 'Curtains/Carpets etc. Sales', 'CAT ‘A’', 133.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(175, 'Curtains/Carpets etc. Sales', 'CAT ‘B’', 93.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(176, 'Curtains/Carpets etc. Sales', 'CAT ‘C’', 67.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(177, 'Disposable Products Dealers', 'CAT A - Wholesalers/Retailers', 200.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(178, 'Disposable Products Dealers', 'CAT B - Retailers (Medium)', 133.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(179, 'Disposable Products Dealers', 'CAT C - Retailers (Small)', 80.00, 1, 1, '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
(180, 'Dressmakers/Tailors (Non-Industrial)', 'CAT A - Large Scale', 96.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(181, 'Dressmakers/Tailors (Non-Industrial)', 'CAT B - Medium Scale', 80.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(182, 'Dressmakers/Tailors (Non-Industrial)', 'CAT C - Small scale', 64.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(183, 'Dressmakers/Tailors Services', 'CAT A - Knitting, Haberdashery and Embroidery', 93.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(184, 'Dressmakers/Tailors Services', 'CAT B - Knitting and Embroidery', 67.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(185, 'Dressmakers/Tailors Services', 'CAT C - Embroidery only', 40.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(186, 'Dressmakers/Tailors Services', 'CAT D - Knitting only', 27.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(187, 'Dressmakers/Tailors Services', 'CAT E - Haberdashery Only (sewingitems -    large)', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(188, 'Dressmakers/Tailors Services', 'CAT F - Haberdashery Only (Small)', 67.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(189, 'Driving Schools', 'CAT A - Above 6 Vehicles', 182.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(190, 'Driving Schools', 'CAT B - 4 - 6 Vehicles', 146.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(191, 'Driving Schools', 'CAT C - 1 - 3 Vehicles', 106.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(192, 'Educational Institutions – Private Day Care Centres (Early Childhood Development Centres)', 'CAT A - Grade A', 666.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(193, 'Educational Institutions – Private Day Care Centres (Early Childhood Development Centres)', 'CAT B - Grade B', 395.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(194, 'Educational Institutions – Private Day Care Centres (Early Childhood Development Centres)', 'CAT C - Grade C', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(195, 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT B - KG/Primary/Junior High Schools (Medium)', 1210.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(196, 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT C - KG/Primary/Junior High Schools (Small)', 545.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(197, 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT D - KG/Primary (Large)', 424.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(198, 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT E - KG/Primary (Medium)', 242.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(199, 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT F - KG/Primary (Small)', 121.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(200, 'Secondary Level (Senior) High/Technical/ Vocational Schools)', 'CAT A - Large', 878.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(201, 'Secondary Level (Senior) High/Technical/ Vocational Schools)', 'CAT B - Medium', 586.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(202, 'Secondary Level (Senior) High/Technical/ Vocational Schools)', 'CAT C - Small', 439.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(203, 'Basic to Secondary School', 'CAT A - Large', 1210.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(204, 'Basic to Secondary School', 'CAT B - Medium', 847.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(205, 'Specialised Schools (Remedial School)', 'CAT \'A\'', 1065.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(206, 'Specialised Schools (Remedial School)', 'CAT \'B\'', 399.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(207, 'Training & Vocational Institutions (Media, Construction, Fashion, Floral, Catering, Cosmetology & We', 'CAT \'A\'', 293.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(208, 'Training & Vocational Institutions (Media, Construction, Fashion, Floral, Catering, Cosmetology & We', 'CAT \'B\'', 293.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(209, 'Training & Vocational Institutions (Media, Construction, Fashion, Floral, Catering, Cosmetology & We', 'CAT \'C\'', 200.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(210, 'Training & Vocational Institutions (Media, Construction, Fashion, Floral, Catering, Cosmetology & We', 'CAT \'D\'', 200.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(211, 'Egg Dealers', 'CAT A - Wholesale', 110.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(212, 'Egg Dealers', 'CAT B - Retail Shops', 73.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(213, 'Egg Dealers', 'CAT C - Mobile Retail', 44.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(214, 'Electrical Appliances (New & Secondhand)', 'CAT B - Wholesalers', 303.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(215, 'Electrical Appliances (New & Secondhand)', 'CAT C - Retailers (Large)', 182.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(216, 'Electrical Appliances (New & Secondhand)', 'CAT D - Retailers - (Small)', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(217, 'Electrical Appliances (New & Secondhand)', 'CAT E - Table Top', 80.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(218, 'Electronic/Home Appliances/Shops (New\n& Second Hand)', 'CAT H - Retailers (Tabletop - Medium)', 266.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(219, 'Electronic/Home Appliances/Shops (New\n& Second Hand)', 'CAT I - Retailers (Tabletop - Small)', 153.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(220, 'Fabric Dealers – Sales', 'CAT C - Wholesale', 184.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(221, 'Fabric Dealers – Sales', 'CAT D - Retail', 108.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(222, 'Fabric Dealers – Sales', 'CAT E - Table Top', 67.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(223, 'Feed Sellers (Poultry, Pets, Fish etc.)', 'CAT A - Wholesalers', 220.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(224, 'Feed Sellers (Poultry, Pets, Fish etc.)', 'CAT B - Distributors', 143.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(225, 'Feed Sellers (Poultry, Pets, Fish etc.)', 'CAT C - Retailers', 99.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(226, 'Financial Institutions (Banking) Other Financial Institutions Microfinance Companies (Deposit Taking', 'CAT A - Head Office', 1452.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(227, 'Financial Institutions (Banking) Other Financial Institutions Microfinance Companies (Deposit Taking', 'CAT B - Branch', 605.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(228, 'Microcredit/Money Lenders/Credit Union', 'CAT A - Head Office', 1452.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(229, 'Microcredit/Money Lenders/Credit Union', 'CAT B - Branch', 605.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(230, 'Microcredit/Money Lenders/Credit Union', 'CAT C - Tier 4 Operators', 242.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(231, 'Rural & Community Banks', 'CAT A - Head Office', 2750.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(232, 'Rural & Community Banks', 'CAT B - Branch', 448.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(233, 'Rural & Community Banks', 'CAT C - Agency', 303.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(234, 'Rural & Community Banks', 'CAT D - Mobilisation Centre', 145.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(235, 'Financial Technology Companies (FINTECH)', 'CAT B Mobile Money Vendor Large', 1210.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(236, 'Financial Technology Companies (FINTECH)', 'CAT C Mobile Money Vendor Medium', 303.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(237, 'Financial Technology Companies (FINTECH)', 'CAT D Mobile Money Vendor Small', 182.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(238, 'Stand Alone ATMs', 'Stand Alone ATMs', 500.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(239, 'Insurance Companies Non-Life Insurance', 'Cat-C-Agency', 700.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(240, 'Life Insurance Life Insurance', 'Cat- C-Agency', 605.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(241, 'Fish Farming Companies', 'CAT C- International Small Scale', 6050.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(242, 'Fish Farming Companies', 'CAT D - Local Large Scale', 266.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(243, 'Fish Farming Companies', 'CAT E - Local Medium Scale', 146.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(244, 'Fish Farming Companies', 'CAT F - Local Small Scale', 67.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(245, 'Fishing Nets and Accessories Dealers', 'CAT B - Wholesalers', 363.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(246, 'Fishing Nets and Accessories Dealers', 'CAT C - Retailers', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(247, 'Fishing Nets and Accessories Dealers', 'CAT D - Table Top', 44.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(248, 'Footwear Sales - New', 'CAT ‘A’', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(249, 'Footwear Sales - New', 'CAT ‘B’', 93.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(250, 'Footwear Sales - New', 'CAT ‘C’', 67.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(251, 'Footwear Sales - Used', 'CAT ‘A’', 100.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(252, 'Footwear Sales - Used', 'CAT ‘B’', 67.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(253, 'Footwear Sales - Used', 'CAT ‘C’', 36.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(254, 'Footwear Repairers (Cobblers)', 'CAT ‘A’', 47.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(255, 'Footwear Repairers (Cobblers)', 'CAT ‘B’', 29.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(256, 'Funeral – Undertaker’s Licence Hearse Service Providers', 'CAT A - Large Scale (Above 5 Vehicles)', 440.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(257, 'Funeral – Undertaker’s Licence Hearse Service Providers', 'CAT B - Medium Scale (3-5 Vehicles)', 220.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(258, 'Funeral – Undertaker’s Licence Hearse Service Providers', 'CAT C - Small Scale (1-2 Vehicles)', 110.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(259, 'Furniture Showroom', 'CAT -C', 605.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(260, 'Furniture Showroom', 'CAT-D', 363.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(261, 'Game Viewing/Commercial TV Viewing Centres', 'CAT B - Medium Scale', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(262, 'Game Viewing/Commercial TV Viewing Centres', 'CAT C - Small Scale', 87.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(263, 'Gas Cylinder/ Stoves & Accessory Dealers', 'CAT A - Large Scale', 160.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(264, 'Gas Cylinder/ Stoves & Accessory Dealers', 'CAT B - Medium Scale', 100.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(265, 'Gas Cylinder/ Stoves & Accessory Dealers', 'CAT C - Small Scale', 67.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(266, 'General Goods - Sales (e.g., Generator, Water pump, Chain saw, etc.)', 'CAT C - Small Scale', 322.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(267, 'General Goods - Sales (e.g., Generator, Water pump, Chain saw, etc.)', 'CAT D - Individuals', 293.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(268, 'Gift Shops', 'CAT B-Medium Scale', 120.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(269, 'Gift Shops', 'CAT C - Small Scale', 59.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(270, 'Glass Sellers (Tinted /Plain)', 'CAT A - Large Scale', 666.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(271, 'Glass Sellers (Tinted /Plain)', 'CAT B - Medium Scale', 586.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(272, 'Glass Sellers (Tinted /Plain)', 'CAT C - Small Scale', 293.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(273, 'GRAPHIC DESIGN COMPANIES', 'CAT B Medium Scale', 605.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(274, 'GRAPHIC DESIGN COMPANIES', 'CAT C Small Scale', 440.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(275, 'GRAPHIC DESIGN COMPANIES', 'CAT D Individuals', 275.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(276, 'Hair & Beauty Service Providers', 'CAT D - Big Salon', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(277, 'Hair & Beauty Service Providers', 'CAT E - Small Salon', 73.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(278, 'Hair & Beauty Service Providers', 'CAT F - Braiding and Weaving Only', 146.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(279, 'Hair & Beauty Service Providers', 'CAT G - Braiding Only', 73.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(280, 'Hair & Beauty Service Providers', 'CAT H - Pedicure & Manicure Only', 40.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(281, 'Health Facilities – Private Dental Clinics', 'Dental Clinics', 293.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(282, 'Health Facilities – Private Eye Clinics', 'CAT A - Ophthalmologist Clinics', 293.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(283, 'Health Facilities – Private Eye Clinics', 'CAT B - Opticians/Optometrist', 293.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(284, 'Health Facilities – Private General Clinics', 'CAT A - Specialty Clinics', 666.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(285, 'Health Facilities – Private General Clinics', 'CAT B - Primary Health Care', 532.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(286, 'General Hospitals', 'Primary', 666.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(287, 'Maternity Homes', 'CAT A - Expanded Services', 306.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(288, 'Maternity Homes', 'CAT B - General Services', 121.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(289, 'Medical Diagnostic Services', 'CAT A - Secondary/Tertiary', 230.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(290, 'Medical Diagnostic Services', 'CAT B - Basic/ Primary', 108.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(291, 'Licenced Herbal Medicine Units', 'CAT E - Medicine Producers Only (Local)', 200.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(292, 'Licenced Herbal Medicine Units', 'CAT F - Herbal Shops (Local)', 146.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(293, 'Hire Purchase Trading Enterprises', 'CAT A - Large Scale', 306.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(294, 'Hire Purchase Trading Enterprises', 'CAT B - Medium Scale', 266.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(295, 'Hire Purchase Trading Enterprises', 'CAT C - Small Scale', 200.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(296, 'Ice Cream/Yoghurt Dealers', 'CAT E - Retail', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(297, 'Interior/Event Decorators', 'CAT C - Individuals', 146.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(298, 'Jewelry Repairers (watches/bracelets, etc.)', 'CAT ‘A’', 53.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(299, 'Jewelry Repairers (watches/bracelets, etc.)', 'CAT ‘B’', 40.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(300, 'Key Technicians/Cutters', 'CAT \'A\'', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(301, 'Key Technicians/Cutters', 'CAT \'B\'', 66.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(302, 'Laundry Services', 'CAT B - Medium Scale', 230.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(303, 'Laundry Services', 'CAT C - Small Scale', 77.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(304, 'Leather Works Dealers (Other Nonfootwear products)', 'CAT C - Producers (Handmade Medium)', 133.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(305, 'Leather Works Dealers (Other Nonfootwear products)', 'CAT D - Sales/Others', 80.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(306, 'Livestock Farms', 'CAT C - Medium-sized', 399.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(307, 'Livestock Farms', 'CAT D - Small-sized', 200.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(308, 'Livestock Farms', 'CAT E - Very Small-sized', 106.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(309, 'Lottery Business Operators', 'CAT B - National Marketing Companies/Agents', 1997.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(310, 'Lottery Business Operators', 'CAT C - Private Operators', 605.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(311, 'Lottery Business Operators', 'CAT D - Lotto Receiver', 399.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(312, 'Lumber Business (Including Sawmill)', 'CAT ‘B’', 1997.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(313, 'Lumber Business (Including Sawmill)', 'CAT \'C\'', 932.00, 1, 1, '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
(314, 'Lumber Business (Including Sawmill)', 'CAT \'D\'', 532.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(315, 'Machine Sharpening Operators', 'CAT A - Stationed with shops', 47.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(316, 'Machine Sharpening Operators', 'CAT B - Mobile', 7.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(317, 'Markets & Other Facilities’ Management Companies', 'CAT C - Small Scale', 1597.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(318, 'Mattress/Foam Products Dealers', 'CAT B - Wholesalers', 532.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(319, 'Mattress/Foam Products Dealers', 'CAT C - Retailers (Medium Scale)', 306.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(320, 'Mattress/Foam Products Dealers', 'CAT D - Retailers (Small Scale)', 153.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(321, 'Mattress Makers/Repairers', 'Mattress Makers/Repairers', 55.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(322, 'Media Houses Electronic Media (Radio) Operators', 'CAT-C District', 1870.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(323, 'Media Houses Electronic Media (Radio) Operators', 'CAT D - Community', 799.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(324, 'Media Houses Electronic Media (Radio) Operators', 'CAT-E -Recording Studio-Large', 700.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(325, 'Media Houses Electronic Media (Radio) Operators', 'CAT-F-Recording Studio-medium', 300.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(326, 'Media Houses Electronic Media (Radio) Operators', 'CAT-H-Information Centre (Urban)', 200.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(327, 'Media Houses Electronic Media (Radio) Operators', 'CAT-I-Information Centre (Rural)', 150.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(328, 'Printing Houses', 'CAT E - Others', 133.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(329, 'Printing Houses', 'CAT F - Newspaper/Periodicals Vendors', 67.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(330, 'Metal Dealers Metal Fabricators', 'CAT C - Domestic Milling Machines', 932.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(331, 'Metal Dealers Metal Fabricators', 'CAT D - Canopies and Scaffolding', 673.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(332, 'Metal Dealers Metal Fabricators', 'CAT E - Pot, Coal pots and Sheet moulders', 306.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(333, 'Metal Dealers Metal Fabricators', 'CAT F - Chairs and beds, etc.', 184.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(334, 'Milling Businesses (For Food)', 'CAT A - Above 3 Machines', 133.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(335, 'Milling Businesses (For Food)', 'CAT B - 2-3 Machines', 99.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(336, 'Milling Businesses (For Food)', 'CAT C - 1 Machine Only', 44.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(337, 'Mineral Water Producers', 'CAT C - Sachet Water', 586.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(338, 'Mineral Water Distribution/Sales', 'CAT C - Retail (Large)', 200.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(339, 'Mineral Water Distribution/Sales', 'CAT D - Retail (Medium)', 93.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(340, 'Mineral Water Distribution/Sales', 'CAT E - Retail (Small)', 40.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(341, 'Mobile Phone & Accessories Sales/Assembling/Repairs', 'CAT C - Retail/Repairs', 220.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(342, 'Mobile Phone & Accessories Sales/Assembling/Repairs', 'CAT D - Retail Only', 165.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(343, 'Mobile Phone & Accessories Sales/Assembling/Repairs', 'CAT E - Repairs Only', 165.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(344, 'Mobile Phone & Accessories Sales/Assembling/Repairs', 'CAT F - Repairs Only (Small)', 110.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(345, 'Mother Care Shops Retail', 'CAT A - Large Scale', 399.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(346, 'Mother Care Shops Retail', 'CAT B - Medium Scale', 200.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(347, 'Musical Equipment Musical Instrument Sales', 'CAT B - Retail (Medium)', 126.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(348, 'Musical Equipment Musical Instrument Sales', 'CAT C - Retail (Small)', 93.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(349, 'Musical Speaker Manufacturers &Sales', 'Musical Speaker Manufacturers &Sales', 93.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(350, 'Non-Governmental Institutions (Renewal)', 'CAT A - International NGOs/CSOs /FBOs', 187.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(351, 'Non-Governmental Institutions (Renewal)', 'CAT B - Local NGOs/CSOs/ FBOs', 110.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(352, 'Non-Governmental Institutions (Renewal)', 'CAT C - Community NGOs/CSOs /FBOs', 77.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(353, 'Pharmaceutical Companies Pharmacies', 'CAT D - Retail', 439.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(354, 'Over the Counter Medicine Sellers (OTCMs) (Licenced Chemical Shops)', 'Over the Counter Medicine Sellers (OTCMs) (Licenced Chemical Shops)', 231.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(355, 'Photographers / Video Operators', 'CAT D - Photo Shops/Studio', 200.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(356, 'Photographers / Video Operators', 'CAT E - Individual video and photography operators', 77.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(357, 'Plastic Product Sales (Including Water tanks)', 'CAT A - Wholesale (Large)', 385.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(358, 'Plastic Product Sales (Including Water tanks)', 'CAT B - Wholesale (Small)', 200.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(359, 'Plastic Product Sales (Including Water tanks)', 'CAT C - Retail (Large)', 93.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(360, 'Plastic Product Sales (Including Water tanks)', 'CAT D - Retail (Medium)', 80.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(361, 'Plastic Product Sales (Including Water tanks)', 'CAT E - Retail (Small)', 53.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(362, 'Plastic Product Sales (Including Water tanks)', 'CAT F - Polyethylene Sellers', 40.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(363, 'Poultry Farms', 'CAT A - Above 2000 Birds', 466.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(364, 'Poultry Farms', 'CAT B - Up to 2000 Birds', 333.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(365, 'Poultry Farms', 'CAT C - Up to 1000 Birds', 186.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(366, 'Poultry Farms', 'CAT D - Up to 500 Birds', 160.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(367, 'Professional Firms/Individuals (Architectural, Auditing, Accounting, Engineering, Legal Firms etc.)', 'CAT G - Others', 399.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(368, 'Draughtsmanship Business', 'CAT ‘A’', 385.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(369, 'Draughtsmanship Business', 'CAT ‘B’', 187.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(370, 'Publishing Houses', 'CAT D - Publishing Only (Small)', 466.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(371, 'Refrigerator/Air Condition Mechanics', 'CAT ‘A’', 306.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(372, 'Refrigerator/Air Condition Mechanics', 'CAT ‘B’', 230.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(373, 'Straw Basket Weavers and Sales', 'CAT \'C\'', 93.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(374, 'Scrap Metal Dealers', 'CAT B - Medium Scale (Depot)', 399.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(375, 'Scrap Metal Dealers', 'CAT C - Small Scale (Collection Points)', 266.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(376, 'Service/Filling Stations', 'CAT E - Fuel Only', 1100.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(377, 'Service/Filling Stations', 'CAT F - Surface Tank Points', 400.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(378, 'Service/Filling Stations', 'CAT G - Sale of Lubricants', 133.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(379, 'Service/Filling Stations', 'CAT H - Kerosene', 133.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(380, 'Service/Filling Stations', 'CAT I - LPG Retail Points (Large)', 600.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(381, 'Service/Filling Stations', 'CAT J - LPG Retail Points (Medium)', 466.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(382, 'Service/Filling Stations', 'CAT K - LPG Retail Points Only (Small)', 399.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(383, 'Straw Basket Weavers and Sales', 'Straw Basket Weavers and Sales', 40.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(384, 'Timber Products Retail Outlets', 'CAT A - Large scale', 202.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34');
INSERT INTO `business_fee_structure` (`fee_id`, `business_type`, `category`, `fee_amount`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(385, 'Timber Products Retail Outlets', 'CAT B - Medium scale', 92.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(386, 'Timber Products Retail Outlets', 'CAT C - Small scale', 61.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(387, 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT A- Five Star', 5000.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(388, 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT B- Four Star', 4000.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(389, 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT C - Three Star', 3328.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(390, 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT D - Two Star', 900.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(391, 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT E - One Star', 750.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(392, 'Guest Houses (4-9 Rooms)', 'Guest Houses (4-9 Rooms)', 500.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(393, 'Budget Hotels', 'Budget Hotels', 400.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(394, 'Hostels (Private):', 'CAT A - Above 50 Beds', 759.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(395, 'Hostels (Private):', 'CAT B - 21-50 Beds', 626.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(396, 'Hostels (Private):', 'CAT C - 11-20 Beds', 506.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(397, 'Hostels (Private):', 'CAT D - Up to 10 Beds', 383.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(398, 'Body Building Gyms', 'CAT-A- Large scale settings', 440.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(399, 'Body Building Gyms', 'CAT-B- Medium Scale', 308.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(400, 'Body Building Gyms', 'CAT-C- Small', 154.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(401, 'Food & Beverage (Eatery / Catering Houses) Formal Catering Services Restaurants.', 'CAT-A- Large', 1430.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(402, 'Food & Beverage (Eatery / Catering Houses) Formal Catering Services Restaurants.', 'CAT-B- Medium Scale', 935.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(403, 'Food & Beverage (Eatery / Catering Houses) Formal Catering Services Restaurants.', 'CAT-C- Small', 660.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(404, 'Fast Food', 'CAT A - Grade 1', 799.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(405, 'Fast Food', 'CAT B - Grade 2', 532.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(406, 'Fast Food', 'CAT C - Grade 3', 399.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(407, 'Local Restaurant (Chop Bar)', 'CAT-A', 220.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(408, 'Local Restaurant (Chop Bar)', 'CAT-B', 165.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(409, 'Local Restaurant (Chop Bar)', 'CAT-C', 110.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(410, 'Transport Charges - Commercial Transport Unions (Lorry Park Operations)', 'CAT ‘C’ (GPRTU/ CO-ORPERATIVE)', 303.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(411, 'Transport Charges - Commercial Transport Unions (Lorry Park Operations)', 'CAT \'D\' (PROTOA)', 266.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(412, 'TV & Radio Repairers', 'TV & Radio Repairers', 94.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(413, 'Upholstery Dealers', 'CAT A - Production & Sales', 399.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(414, 'Upholstery Dealers', 'CAT B - Sales', 266.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(415, 'Upholstery Dealers', 'CAT C - Production', 133.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(416, 'Used Clothing Sales (\'Second Hand\')', 'CAT D - Retailers (Containers/Kiosks/Tabletops)', 87.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(417, 'Used Clothing Sales (\'Second Hand\')', 'CAT E - Retailers (Tabletops)', 67.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(418, 'Wood Fuel', 'CAT A - Charcoal Producers', 46.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(419, 'Wood Fuel', 'CAT B - Firewood Sellers (Large)', 106.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(420, 'Wood Fuel', 'CAT C - Firewood Sellers (Medium)', 77.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(421, 'Wood Fuel', 'CAT D - Firewood Sellers (Small)', 46.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
(422, 'Wood Fuel', 'CAT E - Charcoal Sellers', 46.00, 1, 1, '2025-07-20 10:07:34', '2025-07-20 10:07:34');

-- --------------------------------------------------------

--
-- Stand-in structure for view `business_summary`
-- (See below for the actual view)
--
CREATE TABLE `business_summary` (
`business_id` int(11)
,`account_number` varchar(20)
,`business_name` varchar(200)
,`owner_name` varchar(100)
,`business_type` varchar(100)
,`category` varchar(100)
,`telephone` varchar(20)
,`exact_location` text
,`amount_payable` decimal(10,2)
,`status` enum('Active','Inactive','Suspended')
,`zone_name` varchar(100)
,`sub_zone_name` varchar(100)
,`payment_status` varchar(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `device_tokens`
--

CREATE TABLE `device_tokens` (
  `token_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `device_token` varchar(255) NOT NULL,
  `platform` enum('Android','iOS') NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `last_used` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message_templates`
--

CREATE TABLE `message_templates` (
  `template_id` int(11) NOT NULL,
  `template_name` varchar(100) NOT NULL,
  `template_type` enum('SMS','Email','System') NOT NULL DEFAULT 'SMS',
  `template_content` text NOT NULL,
  `variables` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `recipient_type` enum('User','Business','Property') NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `notification_type` enum('SMS','System','Email') NOT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('Pending','Sent','Failed','Read') DEFAULT 'Pending',
  `sent_by` int(11) DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `payment_reference` varchar(50) NOT NULL,
  `bill_id` int(11) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `payment_method` enum('Mobile Money','Cash','Bank Transfer','Online') NOT NULL,
  `payment_channel` varchar(50) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `paystack_reference` varchar(100) DEFAULT NULL,
  `payment_status` enum('Pending','Successful','Failed','Cancelled') DEFAULT 'Pending',
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `processed_by` int(11) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `receipt_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `payment_reference`, `bill_id`, `amount_paid`, `payment_method`, `payment_channel`, `transaction_id`, `paystack_reference`, `payment_status`, `payment_date`, `processed_by`, `notes`, `receipt_url`) VALUES
(56, 'PAY20251002PWA18O', 65, 100.00, 'Cash', '', '', NULL, 'Successful', '2025-10-02 19:20:58', 1, '', NULL),
(57, 'PAY2025100421C7BD', 65, 100.00, 'Cash', 'Cash Payment', '', NULL, 'Successful', '2025-10-04 06:39:14', 6, '', NULL),
(58, 'PAY20251004N1YJ05', 68, 50.00, 'Cash', '', '', NULL, 'Successful', '2025-10-04 07:46:37', 1, '', NULL),
(59, 'PAY202510041RF09B', 68, 100.00, 'Cash', '', '', NULL, 'Successful', '2025-10-04 07:57:13', 1, '', NULL),
(60, 'PAY20251004FWQOC4', 71, 100.00, 'Cash', '', '', NULL, 'Successful', '2025-10-04 08:13:53', 1, '', NULL),
(61, 'PAY20251004HJST6U', 73, 100.00, 'Cash', '', '', NULL, 'Successful', '2025-10-04 10:07:53', 3, '', NULL),
(62, 'PAY202602033RWTF2', 74, 300.00, 'Cash', '', '', NULL, 'Successful', '2026-02-03 10:11:27', 3, '', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `payment_audit_summary`
-- (See below for the actual view)
--
CREATE TABLE `payment_audit_summary` (
`payment_id` int(11)
,`payment_reference` varchar(50)
,`payment_date` timestamp
,`amount_paid` decimal(10,2)
,`payment_method` enum('Mobile Money','Cash','Bank Transfer','Online')
,`payment_status` enum('Pending','Successful','Failed','Cancelled')
,`bill_number` varchar(20)
,`bill_type` enum('Business','Property')
,`payer_name` varchar(200)
,`account_number` varchar(20)
,`processed_by_username` varchar(50)
,`processed_by_name` varchar(101)
,`processed_by_role` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `payment_summary`
-- (See below for the actual view)
--
CREATE TABLE `payment_summary` (
`payment_id` int(11)
,`payment_reference` varchar(50)
,`amount_paid` decimal(10,2)
,`payment_method` enum('Mobile Money','Cash','Bank Transfer','Online')
,`payment_status` enum('Pending','Successful','Failed','Cancelled')
,`payment_date` timestamp
,`bill_number` varchar(20)
,`bill_type` enum('Business','Property')
,`payer_name` varchar(200)
);

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `property_id` int(11) NOT NULL,
  `property_number` varchar(20) NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `location` text DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `structure` varchar(100) NOT NULL,
  `ownership_type` enum('Self','Family','Corporate','Others') DEFAULT 'Self',
  `property_type` enum('Modern','Traditional') DEFAULT 'Modern',
  `number_of_rooms` int(11) NOT NULL,
  `property_use` enum('Commercial','Residential') NOT NULL,
  `old_bill` decimal(10,2) DEFAULT 0.00,
  `previous_payments` decimal(10,2) DEFAULT 0.00,
  `arrears` decimal(10,2) DEFAULT 0.00,
  `current_bill` decimal(10,2) DEFAULT 0.00,
  `amount_payable` decimal(10,2) DEFAULT 0.00,
  `batch` varchar(50) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `sub_zone_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `account_number` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`property_id`, `property_number`, `owner_name`, `telephone`, `gender`, `location`, `latitude`, `longitude`, `structure`, `ownership_type`, `property_type`, `number_of_rooms`, `property_use`, `old_bill`, `previous_payments`, `arrears`, `current_bill`, `amount_payable`, `batch`, `zone_id`, `sub_zone_id`, `created_by`, `created_at`, `updated_at`, `account_number`) VALUES
(12, 'PROP-CZ01-GA02-00001', 'MEGAS', '0545041428', 'Male', 'Location: KpeshieGPS: 5.592970, -0.077090', 5.59297000, -0.07709000, 'Concrete Block', 'Self', 'Modern', 2, 'Residential', 100.00, 0.00, 100.00, 100.00, 200.00, '', 1, 2, 1, '2025-10-01 05:45:08', '2025-10-02 10:44:08', NULL),
(14, 'PROP-CZ01-GA02-00002', 'Ben', '0545041428', 'Male', 'Location: Kpeshie\r\nGPS: 5.59297000, -0.07709000', 5.59297000, -0.07709000, 'Concrete Block', 'Self', 'Modern', 2, 'Commercial', 200.00, 0.00, 200.00, 200.00, 400.00, NULL, 1, 2, 4, '2025-10-01 11:30:03', '2025-10-02 10:44:08', 'PROP-CZ01-GA02-0002'),
(15, 'PROP-CZ01-GA02-00003', 'Kusi Francis', '', 'Male', 'Location: Sasaabi\r\nGPS: 5.831213, -0.113624', 5.83121300, -0.11362400, 'Concrete Block', 'Self', 'Modern', 1, 'Commercial', 100.00, 0.00, 100.00, 100.00, 200.00, '', 1, 2, NULL, '2025-10-01 11:42:41', '2025-10-02 10:44:08', 'PROP-CZ01-GA02-0003'),
(16, 'PROP-NZ02-RA01-00001', 'Emma', '+233545041428', 'Male', 'Location: KpeshieGPS: 5.592970, -0.077090', 5.59297000, -0.07709000, 'Concrete Block', 'Family', 'Modern', 2, 'Residential', 100.00, 0.00, 100.00, 100.00, 200.00, '', 2, 3, 1, '2025-10-02 19:18:33', '2025-10-04 07:51:26', 'PROP-NZ02-RA01-0001'),
(17, 'PROP-EZ-EZME-00001', 'Zayne Ewusi', '0545041428', 'Male', 'Location: KpeshieGPS: 5.592970, -0.077090', 5.59297000, -0.07709000, 'Concrete Block', 'Self', 'Modern', 5, 'Residential', 250.00, 150.00, 100.00, 250.00, 350.00, '', 4, 6, 1, '2025-10-04 07:44:29', '2025-10-04 07:57:13', 'PROP-EZ-EZME-0001'),
(18, 'PROP-NZ02-RA01-00002', 'Beatrice Akueteh', '', 'Female', 'Location: KpeshieGPS: 5.592970, -0.077090', 5.59297000, -0.07709000, 'Concrete Block', 'Self', 'Modern', 3, 'Commercial', 300.00, 100.00, 200.00, 300.00, 500.00, '', 2, 3, 1, '2025-10-04 08:11:48', '2025-10-04 08:15:06', 'PROP-NZ02-RA01-0002');

--
-- Triggers `properties`
--
DELIMITER $$
CREATE TRIGGER `calculate_property_payable` BEFORE INSERT ON `properties` FOR EACH ROW BEGIN
    -- Calculate arrears: old_bill - previous_payments (minimum 0)
    SET NEW.arrears = GREATEST(0, NEW.old_bill - NEW.previous_payments);
    
    -- Calculate amount_payable: arrears + current_bill
    SET NEW.amount_payable = NEW.arrears + NEW.current_bill;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `generate_property_account_number` BEFORE INSERT ON `properties` FOR EACH ROW BEGIN
    DECLARE zone_code_val VARCHAR(20);
    DECLARE subzone_code_val VARCHAR(20);
    DECLARE next_number INT;
    
    IF NEW.account_number IS NULL OR NEW.account_number = '' THEN
        SELECT zone_code INTO zone_code_val 
        FROM zones WHERE zone_id = NEW.zone_id;
        
        SELECT sub_zone_code INTO subzone_code_val 
        FROM sub_zones WHERE sub_zone_id = NEW.sub_zone_id;
        
        SELECT COUNT(*) + 1 INTO next_number 
        FROM properties 
        WHERE zone_id = NEW.zone_id AND sub_zone_id = NEW.sub_zone_id;
        
        SET NEW.account_number = CONCAT(
            'PROP-',
            COALESCE(zone_code_val, 'XX'),
            '-',
            COALESCE(subzone_code_val, 'XX'),
            '-',
            LPAD(next_number, 4, '0')
        );
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `generate_property_number` BEFORE INSERT ON `properties` FOR EACH ROW BEGIN
    IF NEW.property_number IS NULL OR NEW.property_number = '' THEN
        SET NEW.property_number = CONCAT('PROP', LPAD(COALESCE((SELECT MAX(property_id) FROM properties), 0) + 1, 6, '0'));
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_property_payable` BEFORE UPDATE ON `properties` FOR EACH ROW BEGIN
    -- Calculate arrears: old_bill - previous_payments (minimum 0)
    SET NEW.arrears = GREATEST(0, NEW.old_bill - NEW.previous_payments);
    
    -- Calculate amount_payable: arrears + current_bill
    SET NEW.amount_payable = NEW.arrears + NEW.current_bill;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `property_fee_structure`
--

CREATE TABLE `property_fee_structure` (
  `fee_id` int(11) NOT NULL,
  `structure` varchar(100) NOT NULL,
  `property_use` enum('Commercial','Residential') NOT NULL,
  `fee_per_room` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_fee_structure`
--

INSERT INTO `property_fee_structure` (`fee_id`, `structure`, `property_use`, `fee_per_room`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Concrete Block', 'Residential', 50.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(2, 'Concrete Block', 'Commercial', 100.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(3, 'Mud Block', 'Residential', 25.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(4, 'Mud Block', 'Commercial', 50.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(5, 'Modern Building', 'Residential', 75.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(6, 'Modern Building', 'Commercial', 150.00, 1, 1, '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
(7, 'The storey', 'Residential', 35.00, 1, 3, '2025-08-04 18:55:58', '2025-08-04 18:55:58');

-- --------------------------------------------------------

--
-- Stand-in structure for view `property_summary`
-- (See below for the actual view)
--
CREATE TABLE `property_summary` (
`property_id` int(11)
,`property_number` varchar(20)
,`owner_name` varchar(100)
,`telephone` varchar(20)
,`location` text
,`structure` varchar(100)
,`property_use` enum('Commercial','Residential')
,`number_of_rooms` int(11)
,`amount_payable` decimal(10,2)
,`zone_name` varchar(100)
,`sub_zone_name` varchar(100)
,`payment_status` varchar(10)
);

-- --------------------------------------------------------

--
-- Table structure for table `public_sessions`
--

CREATE TABLE `public_sessions` (
  `session_id` varchar(64) NOT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`session_data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NOT NULL DEFAULT (current_timestamp() + interval 1 hour)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_zones`
--

CREATE TABLE `sub_zones` (
  `sub_zone_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL,
  `sub_zone_name` varchar(100) NOT NULL,
  `sub_zone_code` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_zones`
--

INSERT INTO `sub_zones` (`sub_zone_id`, `zone_id`, `sub_zone_name`, `sub_zone_code`, `description`, `created_by`, `created_at`) VALUES
(1, 1, 'Market Area', 'MA01', 'Main market area', 1, '2025-07-04 18:57:35'),
(2, 1, 'Government Area', 'GA02', 'Government offices area', 1, '2025-07-04 18:57:35'),
(3, 2, 'Residential A', 'RA01', 'High-end residential', 1, '2025-07-04 18:57:35'),
(4, 3, 'Industrial Area', 'IA01', 'Industrial zone', 1, '2025-07-04 18:57:35'),
(5, 4, 'Nungua', 'EZNU', NULL, 3, '2025-08-04 18:03:57'),
(6, 4, 'Mepe', 'EZME', NULL, 3, '2025-08-08 08:11:00');

-- --------------------------------------------------------

--
-- Table structure for table `system_restrictions`
--

CREATE TABLE `system_restrictions` (
  `restriction_id` int(11) NOT NULL,
  `restriction_start_date` date NOT NULL,
  `restriction_end_date` date NOT NULL,
  `warning_days` int(11) DEFAULT 7,
  `is_active` tinyint(1) DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_restrictions`
--

INSERT INTO `system_restrictions` (`restriction_id`, `restriction_start_date`, `restriction_end_date`, `warning_days`, `is_active`, `created_by`, `created_at`) VALUES
(16, '2025-08-26', '2025-10-26', 7, 0, 3, '2025-08-24 19:27:10'),
(17, '2025-08-26', '2025-10-26', 7, 0, 3, '2025-08-24 19:29:04'),
(18, '2025-08-25', '2025-10-25', 7, 0, 3, '2025-08-24 19:30:00'),
(19, '2025-10-05', '2025-12-05', 7, 0, 3, '2025-10-04 09:22:12');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `setting_id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` enum('text','number','boolean','date','json') DEFAULT 'text',
  `description` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`setting_id`, `setting_key`, `setting_value`, `setting_type`, `description`, `updated_by`, `updated_at`) VALUES
(1, 'assembly_name', 'Jasikan Municipal Assembly', 'text', 'Name to appear on bills and reports', 1, '2025-09-09 20:27:09'),
(2, 'billing_start_date', '2024-11-01', 'date', 'Annual billing start date', 1, '2025-10-02 15:32:40'),
(3, 'restriction_period_months', '3', 'number', 'System restriction period in months', NULL, '2025-07-04 18:57:35'),
(4, 'restriction_start_date', '2025-10-05', 'date', 'Restriction countdown start date', 3, '2025-10-04 09:22:12'),
(5, 'system_restricted', 'false', 'boolean', 'System restriction status', 3, '2025-10-11 19:27:44'),
(6, 'sms_enabled', 'true', 'boolean', 'SMS notifications enabled', 1, '2025-07-12 18:55:11'),
(7, 'auto_bill_generation', 'false', 'boolean', 'Automatic bill generation on Nov 1st', 1, '2025-10-02 15:32:40'),
(8, 'twilio_sid', '831JD7BHZAHE9M7EWNW1FCUB', 'text', 'Twilio Sid', 3, '2025-07-12 20:23:05'),
(9, 'twilio_token', 'ZQHijuboaimCs7Ali3X9aRzizbjztN8a', 'text', 'Twilio Token', 3, '2025-07-12 20:23:05'),
(10, 'twilio_phone', '0545041428', 'text', 'Twilio Phone', 3, '2025-07-12 20:23:05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `first_login` tinyint(1) DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `role_id`, `first_name`, `last_name`, `phone`, `is_active`, `first_login`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@quickbill305.com', '$2y$10$e4YGmKebT13JFeJVTNJTr.oWNFXUzfTYqhmQEco1/VF/hVOSPCdYS', 2, 'System', 'Administrator', '+233000000000', 1, 0, '2025-11-03 09:51:46', '2025-07-04 18:57:35', '2025-11-03 09:51:46'),
(3, 'Joojo', 'kwadwomegas@gmail.com', '$2y$10$JSLvWE7gM/FUgiTqv9v1qOU9L4U3udx6crIBivD6KIP9.q2NMuTDq', 1, 'Joojo', 'Megas', '0545041428', 1, 0, '2025-10-11 20:30:30', '2025-07-09 19:03:22', '2025-10-11 20:30:30'),
(4, 'Kusi', 'kusi@gmail.com', '$2y$10$xXAtNw3GQSVKPNRPnaIacOX9XWegyGQT47fAkuZ22b1J9swsJllge', 5, 'Kusi', 'France', '+233543258791', 1, 0, '2025-10-04 09:41:06', '2025-07-11 15:21:00', '2025-10-04 09:41:06'),
(5, 'Aseye', 'aseyeabledoo@gmail.com', '$2y$10$I8aBJT72RTKJ8bMgiWOwP.831BvSerUvhqQCLft82TbkDyTDJgIZO', 4, 'Aseye', 'Abledu', '', 1, 0, '2025-10-04 14:23:10', '2025-07-12 05:12:52', '2025-10-04 14:23:10'),
(6, 'David', 'kabtechconsulting@gmail.com', '$2y$10$Sn1Ex9uZx3GlCdAwsKkOcuow7anUlJI9FJBSaRgjyDDUeQg4S0XjW', 3, 'David', 'Lomko', '', 1, 0, '2025-10-11 19:28:15', '2025-07-12 07:18:33', '2025-10-11 19:28:15'),
(7, 'auditor', 'auditor@quickbill305.com', '$2y$10$FoD1Xj3EptKucFlXjB.j0.EcVrI6e/J68idDYZ74Qi/udwJYRo82O', 6, 'Internal', 'Auditor', '+233200000000', 1, 0, '2025-11-03 09:53:27', '2025-09-30 13:31:09', '2025-11-03 09:53:27');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`role_id`, `role_name`, `description`, `created_at`) VALUES
(1, 'Super Admin', 'Full system access with restriction controls', '2025-07-04 18:57:34'),
(2, 'Admin', 'Full system access excluding restrictions', '2025-07-04 18:57:34'),
(3, 'Officer', 'Register businesses/properties, record payments, generate bills', '2025-07-04 18:57:34'),
(4, 'Revenue Officer', 'Record payments and view maps', '2025-07-04 18:57:34'),
(5, 'Data Collector', 'Register businesses/properties and view profiles', '2025-07-04 18:57:34'),
(6, 'Internal Auditor', 'Read-only access with full audit capabilities', '2025-09-30 13:31:09');

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `session_token` varchar(128) NOT NULL,
  `device_fingerprint` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `login_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`session_id`, `user_id`, `session_token`, `device_fingerprint`, `ip_address`, `user_agent`, `login_time`, `last_activity`, `is_active`) VALUES
(7, 3, '8206640cba7a8839ac9927e47342d53340e9e5447b808564e799a5849559536a', 'd4d2c8572b4108c1a8155a7699427968', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 20:08:12', '2025-10-11 20:24:54', 0),
(8, 3, '2011ce8d2efa80a3a7b99448443fa0babd438e18977b54af66cbc3d3a20e9059', 'd4d2c8572b4108c1a8155a7699427968', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36 Edg/141.0.0.0', '2025-10-11 20:24:54', '2025-10-11 20:26:02', 0);

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `zone_id` int(11) NOT NULL,
  `zone_name` varchar(100) NOT NULL,
  `zone_code` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`zone_id`, `zone_name`, `zone_code`, `description`, `created_by`, `created_at`) VALUES
(1, 'Central Zone', 'CZ01', 'Central business district', 1, '2025-07-04 18:57:35'),
(2, 'North Zone', 'NZ02', 'Northern residential area', 1, '2025-07-04 18:57:35'),
(3, 'South Zone', 'SZ03', 'Southern commercial area', 1, '2025-07-04 18:57:35'),
(4, 'Eastern Zone', 'EZ', NULL, 1, '2025-07-10 09:20:38'),
(5, 'Juapong', 'JU', NULL, 3, '2025-08-08 08:22:19');

-- --------------------------------------------------------

--
-- Structure for view `audit_trail_comprehensive`
--
DROP TABLE IF EXISTS `audit_trail_comprehensive`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `audit_trail_comprehensive`  AS SELECT `al`.`log_id` AS `log_id`, `al`.`action` AS `action`, `al`.`table_name` AS `table_name`, `al`.`record_id` AS `record_id`, `al`.`old_values` AS `old_values`, `al`.`new_values` AS `new_values`, `al`.`ip_address` AS `ip_address`, `al`.`created_at` AS `created_at`, `u`.`username` AS `username`, `u`.`first_name` AS `first_name`, `u`.`last_name` AS `last_name`, `ur`.`role_name` AS `role_name`, CASE WHEN `al`.`table_name` = 'payments' THEN 'Financial Transaction' WHEN `al`.`table_name` = 'bills' THEN 'Billing Activity' WHEN `al`.`table_name` = 'businesses' THEN 'Business Management' WHEN `al`.`table_name` = 'properties' THEN 'Property Management' WHEN `al`.`table_name` = 'users' THEN 'User Management' WHEN `al`.`table_name` = 'system_settings' THEN 'System Configuration' ELSE 'Other Activity' END AS `activity_category` FROM ((`audit_logs` `al` left join `users` `u` on(`al`.`user_id` = `u`.`user_id`)) left join `user_roles` `ur` on(`u`.`role_id` = `ur`.`role_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `business_summary`
--
DROP TABLE IF EXISTS `business_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `business_summary`  AS SELECT `b`.`business_id` AS `business_id`, `b`.`account_number` AS `account_number`, `b`.`business_name` AS `business_name`, `b`.`owner_name` AS `owner_name`, `b`.`business_type` AS `business_type`, `b`.`category` AS `category`, `b`.`telephone` AS `telephone`, `b`.`exact_location` AS `exact_location`, `b`.`amount_payable` AS `amount_payable`, `b`.`status` AS `status`, `z`.`zone_name` AS `zone_name`, `sz`.`sub_zone_name` AS `sub_zone_name`, CASE WHEN `b`.`amount_payable` > 0 THEN 'Defaulter' ELSE 'Up to Date' END AS `payment_status` FROM ((`businesses` `b` left join `zones` `z` on(`b`.`zone_id` = `z`.`zone_id`)) left join `sub_zones` `sz` on(`b`.`sub_zone_id` = `sz`.`sub_zone_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `payment_audit_summary`
--
DROP TABLE IF EXISTS `payment_audit_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `payment_audit_summary`  AS SELECT `p`.`payment_id` AS `payment_id`, `p`.`payment_reference` AS `payment_reference`, `p`.`payment_date` AS `payment_date`, `p`.`amount_paid` AS `amount_paid`, `p`.`payment_method` AS `payment_method`, `p`.`payment_status` AS `payment_status`, `b`.`bill_number` AS `bill_number`, `b`.`bill_type` AS `bill_type`, CASE WHEN `b`.`bill_type` = 'Business' THEN `bs`.`business_name` WHEN `b`.`bill_type` = 'Property' THEN `pr`.`owner_name` END AS `payer_name`, CASE WHEN `b`.`bill_type` = 'Business' THEN `bs`.`account_number` WHEN `b`.`bill_type` = 'Property' THEN `pr`.`property_number` END AS `account_number`, `u`.`username` AS `processed_by_username`, concat(`u`.`first_name`,' ',`u`.`last_name`) AS `processed_by_name`, `ur`.`role_name` AS `processed_by_role` FROM (((((`payments` `p` left join `bills` `b` on(`p`.`bill_id` = `b`.`bill_id`)) left join `businesses` `bs` on(`b`.`bill_type` = 'Business' and `b`.`reference_id` = `bs`.`business_id`)) left join `properties` `pr` on(`b`.`bill_type` = 'Property' and `b`.`reference_id` = `pr`.`property_id`)) left join `users` `u` on(`p`.`processed_by` = `u`.`user_id`)) left join `user_roles` `ur` on(`u`.`role_id` = `ur`.`role_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `payment_summary`
--
DROP TABLE IF EXISTS `payment_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `payment_summary`  AS SELECT `p`.`payment_id` AS `payment_id`, `p`.`payment_reference` AS `payment_reference`, `p`.`amount_paid` AS `amount_paid`, `p`.`payment_method` AS `payment_method`, `p`.`payment_status` AS `payment_status`, `p`.`payment_date` AS `payment_date`, `b`.`bill_number` AS `bill_number`, `b`.`bill_type` AS `bill_type`, CASE WHEN `b`.`bill_type` = 'Business' THEN `bs`.`business_name` WHEN `b`.`bill_type` = 'Property' THEN `pr`.`owner_name` END AS `payer_name` FROM (((`payments` `p` join `bills` `b` on(`p`.`bill_id` = `b`.`bill_id`)) left join `businesses` `bs` on(`b`.`bill_type` = 'Business' and `b`.`reference_id` = `bs`.`business_id`)) left join `properties` `pr` on(`b`.`bill_type` = 'Property' and `b`.`reference_id` = `pr`.`property_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `property_summary`
--
DROP TABLE IF EXISTS `property_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `property_summary`  AS SELECT `p`.`property_id` AS `property_id`, `p`.`property_number` AS `property_number`, `p`.`owner_name` AS `owner_name`, `p`.`telephone` AS `telephone`, `p`.`location` AS `location`, `p`.`structure` AS `structure`, `p`.`property_use` AS `property_use`, `p`.`number_of_rooms` AS `number_of_rooms`, `p`.`amount_payable` AS `amount_payable`, `z`.`zone_name` AS `zone_name`, `sz`.`sub_zone_name` AS `sub_zone_name`, CASE WHEN `p`.`amount_payable` > 0 THEN 'Defaulter' ELSE 'Up to Date' END AS `payment_status` FROM ((`properties` `p` left join `zones` `z` on(`p`.`zone_id` = `z`.`zone_id`)) left join `sub_zones` `sz` on(`p`.`sub_zone_id` = `sz`.`sub_zone_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_findings`
--
ALTER TABLE `audit_findings`
  ADD PRIMARY KEY (`finding_id`),
  ADD KEY `identified_by` (`identified_by`),
  ADD KEY `resolved_by` (`resolved_by`),
  ADD KEY `idx_severity` (`severity`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_table_name` (`table_name`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_audit_logs_user_date` (`user_id`,`created_at`),
  ADD KEY `idx_user_action_date` (`user_id`,`action`,`created_at`),
  ADD KEY `idx_table_record` (`table_name`,`record_id`);

--
-- Indexes for table `audit_reports`
--
ALTER TABLE `audit_reports`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `generated_by` (`generated_by`),
  ADD KEY `idx_report_type` (`report_type`),
  ADD KEY `idx_date_range` (`date_from`,`date_to`);

--
-- Indexes for table `backup_logs`
--
ALTER TABLE `backup_logs`
  ADD PRIMARY KEY (`backup_id`),
  ADD KEY `started_by` (`started_by`),
  ADD KEY `idx_backup_type` (`backup_type`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_started_at` (`started_at`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`bill_id`),
  ADD UNIQUE KEY `bill_number` (`bill_number`),
  ADD KEY `generated_by` (`generated_by`),
  ADD KEY `idx_bill_number` (`bill_number`),
  ADD KEY `idx_bill_type_ref` (`bill_type`,`reference_id`),
  ADD KEY `idx_billing_year` (`billing_year`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_bills_due_date` (`due_date`),
  ADD KEY `idx_served_status` (`served_status`),
  ADD KEY `idx_served_at` (`served_at`),
  ADD KEY `fk_bills_served_by` (`served_by`),
  ADD KEY `idx_bill_audit` (`status`,`generated_at`,`generated_by`);

--
-- Indexes for table `bill_adjustments`
--
ALTER TABLE `bill_adjustments`
  ADD PRIMARY KEY (`adjustment_id`),
  ADD KEY `applied_by` (`applied_by`),
  ADD KEY `idx_adjustment_type` (`adjustment_type`),
  ADD KEY `idx_target` (`target_type`,`target_id`),
  ADD KEY `idx_applied_at` (`applied_at`);

--
-- Indexes for table `businesses`
--
ALTER TABLE `businesses`
  ADD PRIMARY KEY (`business_id`),
  ADD UNIQUE KEY `account_number` (`account_number`),
  ADD KEY `sub_zone_id` (`sub_zone_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_account_number` (`account_number`),
  ADD KEY `idx_business_type` (`business_type`),
  ADD KEY `idx_zone` (`zone_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_businesses_payable` (`amount_payable`);

--
-- Indexes for table `business_fee_structure`
--
ALTER TABLE `business_fee_structure`
  ADD PRIMARY KEY (`fee_id`),
  ADD UNIQUE KEY `unique_business_type_category` (`business_type`,`category`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `device_tokens`
--
ALTER TABLE `device_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD UNIQUE KEY `user_device_unique` (`user_id`,`device_token`);

--
-- Indexes for table `message_templates`
--
ALTER TABLE `message_templates`
  ADD PRIMARY KEY (`template_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `sent_by` (`sent_by`),
  ADD KEY `idx_recipient` (`recipient_type`,`recipient_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_sent_at` (`sent_at`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `payment_reference` (`payment_reference`),
  ADD KEY `processed_by` (`processed_by`),
  ADD KEY `idx_payment_ref` (`payment_reference`),
  ADD KEY `idx_bill_id` (`bill_id`),
  ADD KEY `idx_transaction_id` (`transaction_id`),
  ADD KEY `idx_payment_date` (`payment_date`),
  ADD KEY `idx_payments_date_status` (`payment_date`,`payment_status`),
  ADD KEY `idx_payment_audit` (`payment_status`,`payment_date`,`processed_by`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`property_id`),
  ADD UNIQUE KEY `property_number` (`property_number`),
  ADD UNIQUE KEY `account_number` (`account_number`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_property_number` (`property_number`),
  ADD KEY `idx_structure` (`structure`),
  ADD KEY `idx_zone` (`zone_id`),
  ADD KEY `idx_properties_payable` (`amount_payable`),
  ADD KEY `idx_sub_zone` (`sub_zone_id`),
  ADD KEY `idx_properties_account_number` (`account_number`);

--
-- Indexes for table `property_fee_structure`
--
ALTER TABLE `property_fee_structure`
  ADD PRIMARY KEY (`fee_id`),
  ADD UNIQUE KEY `unique_structure_use` (`structure`,`property_use`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `public_sessions`
--
ALTER TABLE `public_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD KEY `idx_account_number` (`account_number`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `sub_zones`
--
ALTER TABLE `sub_zones`
  ADD PRIMARY KEY (`sub_zone_id`),
  ADD UNIQUE KEY `sub_zone_code` (`sub_zone_code`),
  ADD KEY `zone_id` (`zone_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `system_restrictions`
--
ALTER TABLE `system_restrictions`
  ADD PRIMARY KEY (`restriction_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD UNIQUE KEY `session_token` (`session_token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`zone_id`),
  ADD UNIQUE KEY `zone_code` (`zone_code`),
  ADD KEY `created_by` (`created_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_findings`
--
ALTER TABLE `audit_findings`
  MODIFY `finding_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=770;

--
-- AUTO_INCREMENT for table `audit_reports`
--
ALTER TABLE `audit_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `backup_logs`
--
ALTER TABLE `backup_logs`
  MODIFY `backup_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `bill_adjustments`
--
ALTER TABLE `bill_adjustments`
  MODIFY `adjustment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `businesses`
--
ALTER TABLE `businesses`
  MODIFY `business_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `business_fee_structure`
--
ALTER TABLE `business_fee_structure`
  MODIFY `fee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=423;

--
-- AUTO_INCREMENT for table `device_tokens`
--
ALTER TABLE `device_tokens`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `message_templates`
--
ALTER TABLE `message_templates`
  MODIFY `template_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `property_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `property_fee_structure`
--
ALTER TABLE `property_fee_structure`
  MODIFY `fee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sub_zones`
--
ALTER TABLE `sub_zones`
  MODIFY `sub_zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `system_restrictions`
--
ALTER TABLE `system_restrictions`
  MODIFY `restriction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `session_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_findings`
--
ALTER TABLE `audit_findings`
  ADD CONSTRAINT `audit_findings_ibfk_1` FOREIGN KEY (`identified_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `audit_findings_ibfk_2` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `audit_reports`
--
ALTER TABLE `audit_reports`
  ADD CONSTRAINT `audit_reports_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `backup_logs`
--
ALTER TABLE `backup_logs`
  ADD CONSTRAINT `backup_logs_ibfk_1` FOREIGN KEY (`started_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `fk_bills_served_by` FOREIGN KEY (`served_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `bill_adjustments`
--
ALTER TABLE `bill_adjustments`
  ADD CONSTRAINT `bill_adjustments_ibfk_1` FOREIGN KEY (`applied_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `businesses`
--
ALTER TABLE `businesses`
  ADD CONSTRAINT `businesses_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`),
  ADD CONSTRAINT `businesses_ibfk_2` FOREIGN KEY (`sub_zone_id`) REFERENCES `sub_zones` (`sub_zone_id`),
  ADD CONSTRAINT `businesses_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `business_fee_structure`
--
ALTER TABLE `business_fee_structure`
  ADD CONSTRAINT `business_fee_structure_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `device_tokens`
--
ALTER TABLE `device_tokens`
  ADD CONSTRAINT `device_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `message_templates`
--
ALTER TABLE `message_templates`
  ADD CONSTRAINT `message_templates_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`sent_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `properties`
--
ALTER TABLE `properties`
  ADD CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`),
  ADD CONSTRAINT `properties_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `properties_ibfk_3` FOREIGN KEY (`sub_zone_id`) REFERENCES `sub_zones` (`sub_zone_id`);

--
-- Constraints for table `property_fee_structure`
--
ALTER TABLE `property_fee_structure`
  ADD CONSTRAINT `property_fee_structure_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `sub_zones`
--
ALTER TABLE `sub_zones`
  ADD CONSTRAINT `sub_zones_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sub_zones_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `system_restrictions`
--
ALTER TABLE `system_restrictions`
  ADD CONSTRAINT `system_restrictions_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD CONSTRAINT `system_settings_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`role_id`);

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `zones`
--
ALTER TABLE `zones`
  ADD CONSTRAINT `zones_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
