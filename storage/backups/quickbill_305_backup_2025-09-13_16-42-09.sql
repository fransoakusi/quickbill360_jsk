-- QuickBill 305 Database Backup
-- Generated on: 2025-09-13 16:42:09
-- Backup Type: Full

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


-- Table structure for table `audit_logs`
DROP TABLE IF EXISTS `audit_logs`;
CREATE TABLE `audit_logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`log_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_action` (`action`),
  KEY `idx_table_name` (`table_name`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_audit_logs_user_date` (`user_id`,`created_at`),
  CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=684 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `audit_logs`
INSERT INTO `audit_logs` (`log_id`, `user_id`, `action`, `table_name`, `record_id`, `old_values`, `new_values`, `ip_address`, `user_agent`, `created_at`) VALUES
('594', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 08:46:50'),
('595', '1', 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":0,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 08:52:28'),
('596', '1', 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":0,\"property_bills\":1,\"skipped_records\":1,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 09:18:45'),
('597', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 09:27:19'),
('598', '5', 'USER_LOGIN', 'users', '5', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 09:27:32'),
('600', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 09:29:28'),
('601', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-08-29 09:33:44'),
('602', '4', 'CREATE_BUSINESS', 'businesses', '27', NULL, '{\"business_name\":\"Media General\",\"owner_name\":\"Kofi\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-08-29 09:35:20'),
('603', '4', 'CREATE_PROPERTY', 'properties', '11', NULL, '{\"owner_name\":\"Yaw Kusi\",\"location\":\"Location: Kpeshie\\r\\nGPS: 5.592970, -0.077170\",\"sub_zone_id\":2}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-08-29 09:37:28'),
('604', '5', 'USER_LOGOUT', 'users', '5', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 14:58:50'),
('605', '5', 'USER_LOGIN', 'users', '5', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 14:59:04'),
('606', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 15:19:42'),
('607', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 15:20:09'),
('608', '1', 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":1,\"skipped_records\":2,\"total_generated\":2}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 15:21:10'),
('609', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 17:57:07'),
('610', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 17:59:41'),
('611', '5', 'USER_LOGOUT', 'users', '5', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 18:00:12'),
('612', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 18:01:05'),
('613', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-08-29 18:01:21'),
('614', '1', 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":4,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 18:06:08'),
('615', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 18:18:55'),
('616', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 18:19:13'),
('617', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 19:03:55'),
('618', '5', 'USER_LOGIN', 'users', '5', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-08-29 19:04:11'),
('619', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 19:20:48'),
('620', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-08-29 19:21:02'),
('621', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 11:55:34'),
('622', '1', 'HARD_DELETE_BUSINESS', 'businesses', '27', '{\"business_id\":27,\"account_number\":\"BIZ000027\",\"business_name\":\"Media General\",\"owner_name\":\"Kofi\",\"business_type\":\"Bakeries\",\"category\":\"CAT A - Large Scale (Industrial operations)\",\"telephone\":\"0545041428\",\"exact_location\":\"Battor\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"old_bill\":\"0.00\",\"previous_payments\":\"0.00\",\"arrears\":\"0.00\",\"current_bill\":\"319.00\",\"amount_payable\":\"319.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":4,\"created_at\":\"2025-08-29 09:35:20\",\"updated_at\":\"2025-08-29 09:35:20\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 11:57:13\",\"related_records_deleted\":[\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 11:57:13'),
('623', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:46:09'),
('624', '1', 'HARD_DELETE_PROPERTY', 'properties', '11', '{\"property_id\":11,\"property_number\":\"PROP000011\",\"owner_name\":\"Yaw Kusi\",\"telephone\":\"\",\"gender\":\"Male\",\"location\":\"Location: Kpeshie\\r\\nGPS: 5.592970, -0.077170\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"structure\":\"Concrete Block\",\"ownership_type\":\"Self\",\"property_type\":\"Modern\",\"number_of_rooms\":5,\"property_use\":\"Commercial\",\"old_bill\":\"0.00\",\"previous_payments\":\"0.00\",\"arrears\":\"0.00\",\"current_bill\":\"500.00\",\"amount_payable\":\"500.00\",\"batch\":\"\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":4,\"created_at\":\"2025-08-29 09:37:28\",\"updated_at\":\"2025-08-29 09:37:28\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 12:46:50\",\"related_records_deleted\":[\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:46:50'),
('625', '1', 'HARD_DELETE_PROPERTY', 'properties', '10', '{\"property_id\":10,\"property_number\":\"PROP000001\",\"owner_name\":\"Joojo Megas\",\"telephone\":\"0545041428\",\"gender\":\"Male\",\"location\":\"Location: KpeshieGPS: 5.592970, -0.077170\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"structure\":\"Modern Building\",\"ownership_type\":\"Self\",\"property_type\":\"Modern\",\"number_of_rooms\":3,\"property_use\":\"Commercial\",\"old_bill\":\"0.00\",\"previous_payments\":\"250.00\",\"arrears\":\"0.00\",\"current_bill\":\"450.00\",\"amount_payable\":\"450.00\",\"batch\":\"\",\"zone_id\":1,\"sub_zone_id\":2,\"created_by\":1,\"created_at\":\"2025-08-29 09:18:25\",\"updated_at\":\"2025-08-29 09:32:00\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 12:47:02\",\"related_records_deleted\":[\"1 payment record(s)\",\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:47:02'),
('626', '1', 'HARD_DELETE_BUSINESS', 'businesses', '28', '{\"business_id\":28,\"account_number\":\"BIZ000028\",\"business_name\":\"KabTech\",\"owner_name\":\"Kusi Francis\",\"business_type\":\"GRAPHIC DESIGN COMPANIES\",\"category\":\"CAT B Medium Scale\",\"telephone\":\"+233545041428\",\"exact_location\":\"Location: KpeshieGPS: 5.592970, -0.077170\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"old_bill\":\"0.00\",\"previous_payments\":\"0.00\",\"arrears\":\"0.00\",\"current_bill\":\"605.00\",\"amount_payable\":\"605.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":3,\"sub_zone_id\":4,\"created_by\":1,\"created_at\":\"2025-08-29 18:03:24\",\"updated_at\":\"2025-08-29 18:03:24\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 12:47:14\",\"related_records_deleted\":[\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:47:14'),
('627', '1', 'HARD_DELETE_BUSINESS', 'businesses', '26', '{\"business_id\":26,\"account_number\":\"BIZ000001\",\"business_name\":\"KabTech Consulting\",\"owner_name\":\"Joojo Megas\",\"business_type\":\"Auto Electricians\",\"category\":\"CAT A - With Battery Charging\",\"telephone\":\"+233545041428\",\"exact_location\":\"Location: KpeshieGPS: 5.592970, -0.077170\",\"latitude\":\"5.59297000\",\"longitude\":\"-0.07717000\",\"old_bill\":\"0.00\",\"previous_payments\":\"55.00\",\"arrears\":\"0.00\",\"current_bill\":\"110.00\",\"amount_payable\":\"110.00\",\"batch\":\"\",\"status\":\"Active\",\"zone_id\":4,\"sub_zone_id\":6,\"created_by\":1,\"created_at\":\"2025-08-29 08:47:37\",\"updated_at\":\"2025-08-29 09:29:00\"}', '{\"deleted\":true,\"deleted_by\":1,\"deleted_at\":\"2025-09-02 12:47:22\",\"related_records_deleted\":[\"1 payment record(s)\",\"1 bill record(s)\"]}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-02 12:47:22'),
('628', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 07:15:02'),
('629', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 07:53:39'),
('630', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 07:53:54'),
('631', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 08:01:09'),
('632', '6', 'USER_LOGIN', 'users', '6', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 08:01:28'),
('633', '6', 'USER_LOGOUT', 'users', '6', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 09:01:29'),
('634', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36 Edg/139.0.0.0', '2025-09-05 09:01:41'),
('635', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-09 20:26:31'),
('636', '1', 'BILLS_GENERATED', 'bills', NULL, NULL, '{\"generation_type\":\"all\",\"billing_year\":2025,\"business_bills\":1,\"property_bills\":0,\"skipped_records\":0,\"total_generated\":1}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-09 20:29:01'),
('637', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 15:35:10'),
('638', '1', 'PAYMENT_RECORDED', 'payments', '49', NULL, '{\"payment_reference\":\"PAY202509119LHD06\",\"bill_id\":49,\"bill_number\":\"BILL2025B000029\",\"billing_year\":\"2025\",\"account_type\":\"Business\",\"account_id\":29,\"account_name\":\"KabTech Consulting\",\"account_number\":\"BIZ000001\",\"account_owner\":\"Afful Bismark\",\"amount_paid\":250,\"payment_method\":\"Cash\",\"payment_channel\":\"\",\"transaction_id\":\"\",\"previous_balance\":750,\"new_balance\":500,\"bill_amount_payable_before\":\"500.00\",\"bill_amount_payable_after\":250,\"bill_status_updated\":\"Partially Paid\",\"payment_status\":\"Successful\",\"processed_by_id\":1,\"processed_by_name\":\"System Administrator\",\"notes\":\"\",\"timestamp\":\"2025-09-11 15:51:36\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 15:51:36'),
('639', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:40:46'),
('640', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:41:19'),
('641', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:56:06'),
('642', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:57:52'),
('643', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-11 16:59:27'),
('644', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-11 17:05:16'),
('645', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-11 17:05:28'),
('646', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 17:05:41'),
('647', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-12 11:55:01'),
('648', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 11:55:38'),
('649', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 11:56:00'),
('650', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 11:56:15'),
('651', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 12:05:01'),
('652', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 12:05:39'),
('653', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 12:05:56'),
('654', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-12 12:31:21'),
('655', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-12 12:36:10'),
('656', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 07:59:53'),
('657', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:20:01'),
('658', '4', 'TERMINATE_ALL_SESSIONS', 'user_sessions', NULL, '{\"terminated_sessions\":1,\"reason\":\"user_requested_new_login\",\"device_fingerprint\":\"740e3206e3c0b5169777c5457521521e43080b04930532c6f1a20d0a08a03eb8\"}', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:20:01'),
('659', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:20:04'),
('660', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:28:00'),
('661', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:32:05'),
('662', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:38:08'),
('663', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:38:50'),
('664', '4', 'TERMINATE_ALL_SESSIONS', 'user_sessions', NULL, '{\"terminated_sessions\":1,\"reason\":\"user_requested_new_login\",\"device_fingerprint\":\"0df3fe7ef95c5be7938efb4081546f769b0b4c5b47264fdc1731e47d5976714a\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:38:50'),
('665', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:39:22'),
('666', '1', 'TERMINATE_ALL_SESSIONS', 'user_sessions', NULL, '{\"terminated_sessions\":1,\"reason\":\"user_requested_new_login\",\"device_fingerprint\":\"0df3fe7ef95c5be7938efb4081546f769b0b4c5b47264fdc1731e47d5976714a\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:39:22'),
('667', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:39:26'),
('668', '1', 'USER_LOGOUT', 'users', '1', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:39:41'),
('669', '3', 'USER_LOGIN', 'users', '3', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:39:50'),
('670', '3', 'RESTRICTION_SCHEDULED', 'system_restrictions', NULL, NULL, '{\"restriction_months\":2,\"warning_days\":7,\"start_date\":\"2025-09-14\",\"end_date\":\"2025-11-14\",\"reason\":\"\"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:40:48'),
('671', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:41:02'),
('672', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:41:08'),
('673', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 13:19:16'),
('674', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 16:15:16'),
('675', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 16:17:42'),
('676', '4', 'TERMINATE_ALL_SESSIONS', 'user_sessions', NULL, '{\"terminated_sessions\":1,\"reason\":\"user_requested_new_login\",\"device_fingerprint\":\"0df3fe7ef95c5be7938efb4081546f769b0b4c5b47264fdc1731e47d5976714a\"}', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 16:17:42'),
('677', '4', 'USER_LOGIN', 'users', '4', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 16:17:57'),
('678', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 16:19:56'),
('679', '4', 'USER_LOGOUT', 'users', '4', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 16:21:00'),
('680', '1', 'USER_LOGIN', 'users', '1', NULL, NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 16:22:07');


-- Table structure for table `backup_logs`
DROP TABLE IF EXISTS `backup_logs`;
CREATE TABLE `backup_logs` (
  `backup_id` int(11) NOT NULL AUTO_INCREMENT,
  `backup_type` enum('Full','Incremental') NOT NULL,
  `backup_path` varchar(255) NOT NULL,
  `backup_size` bigint(20) DEFAULT NULL,
  `status` enum('In Progress','Completed','Failed') DEFAULT 'In Progress',
  `started_by` int(11) NOT NULL,
  `started_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  PRIMARY KEY (`backup_id`),
  KEY `started_by` (`started_by`),
  KEY `idx_backup_type` (`backup_type`),
  KEY `idx_status` (`status`),
  KEY `idx_started_at` (`started_at`),
  CONSTRAINT `backup_logs_ibfk_1` FOREIGN KEY (`started_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `backup_logs`
INSERT INTO `backup_logs` (`backup_id`, `backup_type`, `backup_path`, `backup_size`, `status`, `started_by`, `started_at`, `completed_at`, `error_message`) VALUES
('4', 'Full', '../../storage/backups/quickbill_305_backup_2025-09-13_16-29-02.sql', NULL, 'In Progress', '1', '2025-09-13 16:29:02', NULL, NULL),
('5', 'Full', '../../storage/backups/quickbill_305_backup_2025-09-13_16-29-15.sql', '119402', 'Completed', '1', '2025-09-13 16:29:15', '2025-09-13 16:29:15', NULL),
('6', 'Full', '../../storage/backups/quickbill_305_backup_2025-09-13_16-38-56.sql', NULL, 'In Progress', '1', '2025-09-13 16:38:56', NULL, NULL),
('7', 'Full', '../../storage/backups/quickbill_305_backup_2025-09-13_16-42-09.sql', NULL, 'In Progress', '1', '2025-09-13 16:42:09', NULL, NULL);


-- Table structure for table `bill_adjustments`
DROP TABLE IF EXISTS `bill_adjustments`;
CREATE TABLE `bill_adjustments` (
  `adjustment_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`adjustment_id`),
  KEY `applied_by` (`applied_by`),
  KEY `idx_adjustment_type` (`adjustment_type`),
  KEY `idx_target` (`target_type`,`target_id`),
  KEY `idx_applied_at` (`applied_at`),
  CONSTRAINT `bill_adjustments_ibfk_1` FOREIGN KEY (`applied_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `bill_adjustments`

-- Table structure for table `bills`
DROP TABLE IF EXISTS `bills`;
CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `due_date` date DEFAULT NULL,
  PRIMARY KEY (`bill_id`),
  UNIQUE KEY `bill_number` (`bill_number`),
  KEY `generated_by` (`generated_by`),
  KEY `idx_bill_number` (`bill_number`),
  KEY `idx_bill_type_ref` (`bill_type`,`reference_id`),
  KEY `idx_billing_year` (`billing_year`),
  KEY `idx_status` (`status`),
  KEY `idx_bills_due_date` (`due_date`),
  KEY `idx_served_status` (`served_status`),
  KEY `idx_served_at` (`served_at`),
  KEY `fk_bills_served_by` (`served_by`),
  CONSTRAINT `bills_ibfk_1` FOREIGN KEY (`generated_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `fk_bills_served_by` FOREIGN KEY (`served_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `bills`
INSERT INTO `bills` (`bill_id`, `bill_number`, `bill_type`, `reference_id`, `billing_year`, `old_bill`, `previous_payments`, `arrears`, `current_bill`, `amount_payable`, `qr_code`, `status`, `served_status`, `served_by`, `served_at`, `delivery_notes`, `generated_by`, `generated_at`, `due_date`) VALUES
('49', 'BILL2025B000029', 'Business', '29', '2025', '0.00', '0.00', '0.00', '500.00', '250.00', NULL, 'Partially Paid', 'Served', '1', '2025-09-09 20:29:46', '', '1', '2025-09-09 20:29:01', NULL);


-- Table structure for table `business_fee_structure`
DROP TABLE IF EXISTS `business_fee_structure`;
CREATE TABLE `business_fee_structure` (
  `fee_id` int(11) NOT NULL AUTO_INCREMENT,
  `business_type` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `fee_amount` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`fee_id`),
  UNIQUE KEY `unique_business_type_category` (`business_type`,`category`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `business_fee_structure_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=423 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `business_fee_structure`
INSERT INTO `business_fee_structure` (`fee_id`, `business_type`, `category`, `fee_amount`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
('1', 'Restaurant', 'Small Scale', '500.00', '1', '1', '2025-07-04 18:57:35', '2025-07-10 14:52:25'),
('2', 'Restaurant', 'Medium Scale', '1000.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('3', 'Restaurant', 'Large Scale', '2100.00', '1', '1', '2025-07-04 18:57:35', '2025-07-12 19:58:34'),
('4', 'Shop', 'Small Scale', '300.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('5', 'Shop', 'Medium Scale', '600.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('6', 'Shop', 'Large Scale', '1200.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('7', 'Saloon', 'Large', '100.00', '1', '3', '2025-07-10 14:51:40', '2025-07-10 14:51:40'),
('8', 'I.T firm', 'Small', '500.00', '1', '3', '2025-07-16 11:27:11', '2025-07-16 11:27:11'),
('9', 'Salon', 'Large Scale', '1200.00', '1', '1', '2025-07-20 09:55:37', '2025-07-20 09:55:37'),
('10', 'Abattoir (Private)', 'CAT F - Slaughter House (Small)', '146.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('11', 'Abattoir (Private)', 'CAT G - Others', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('12', 'Adinkra Designers/Kente/Smock Weavers & Sellers', 'CAT H - Weavers Only (Small)', '40.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('13', 'Adinkra Designers/Kente/Smock Weavers & Sellers', 'CAT I - Sellers Only (Small)', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('14', 'Agro Chemical/Farm Inputs Dealers', 'CAT H - Distributors', '160.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('15', 'Agro Chemical/Farm Inputs Dealers', 'CAT I - Retailers', '93.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('16', 'Agro Machine Dealers', 'CAT I - Retailers', '133.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('17', 'Akpeteshie (liquor) Dealers  Manufacturers (Distillers)', 'CAT B - Medium Scale', '133.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('18', 'Akpeteshie (liquor) Dealers  Manufacturers (Distillers)', 'CAT C - Small Scale', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('19', 'Home Based/Farm Site', 'CAT A - Pito (daily brewing)', '40.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('20', 'Home Based/Farm Site', 'CAT B - Palm Wine Tappers', '40.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('21', 'Akpeteshie Sellers Only', 'Akpeteshie Sellers Only', '80.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('22', 'Aluminium Fabricators (Doors/Windows)', 'CAT B-Medium Scale', '385.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('23', 'Aluminium Fabricators (Doors/Windows)', 'CAT C - Small Scale', '160.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('24', 'Aluminium Fabricators (Doors/Windows)', 'CAT D - Others', '117.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('25', 'Aluminium Pot Dealers (‘Dadesen’)', 'CAT B - Distributors', '116.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('26', 'Aluminium Pot Dealers (‘Dadesen’)', 'CAT C - Retailers', '110.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('27', 'Aluminium Product Distributors', 'CAT B - Medium Scale', '220.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('28', 'Aluminium Product Distributors', 'CAT C - Small Scale', '146.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('29', 'Aluminium Product Retailers', 'Category B - Container/Kiosk (Medium)', '100.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('30', 'Aluminium Product Retailers', 'Category C - Table Top (Small)', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('31', 'Ambulance Service Providers', 'CAT B - Medium Scale (3-5 Vehicles)', '133.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('32', 'Ambulance Service Providers', 'CAT C - Small Scale (1-2 Vehicles)', '61.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('33', 'Arts & Handicraft Dealers', 'CAT F - Retailers Only', '133.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('34', 'Arts & Handicraft Dealers', 'CAT G - Container/Kiosk', '102.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('35', 'Arts & Handicraft Dealers', 'CAT H - Table Top', '61.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('36', 'Artisans e.g., Masons, Carpenters, Plumbers, Electricians, Painters, Steel Benders, Tile Layers etc.', 'CAT \'A\'', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('37', 'Artisans e.g., Masons, Carpenters, Plumbers, Electricians, Painters, Steel Benders, Tile Layers etc.', 'CAT \'B\'', '39.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('38', 'Air Condition Mechanics', 'CAT C - Informal Garage without Shop', '160.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('39', 'Air Condition Mechanics', 'CAT D - Others', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('40', 'Arc Welders', 'CAT A - Fuel and Water Tankers; Truck Builders', '160.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('41', 'Arc Welders', 'CAT B - Light vehicle repairs, Container Shops, and Iron Gates', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('42', 'Argon (Aluminium) Welders', 'Argon (Aluminium) Welders', '44.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('43', 'Auto Body Repairers', 'CAT C - Informal Garage without Shop', '160.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('44', 'Auto Body Repairers', 'CAT D - Others', '117.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('45', 'Auto Electricians', 'CAT A - With Battery Charging', '110.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('46', 'Auto Electricians', 'CAT B - Without Battery Charging', '41.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('47', 'Auto Mechanics', 'CAT B - Heavy Duty Trucks', '97.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('48', 'Auto Mechanics', 'CAT C - Light Duty Trucks (3 to 5 tonnes)', '89.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('49', 'Auto Mechanics', 'CAT D - Light Duty Vehicles (Below 3 tonnes)', '81.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('50', 'Auto Sprayers', 'CAT A - Spraying with Oven', '315.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('51', 'Auto Sprayers', 'CAT B - Spraying without Oven', '293.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('52', 'Auto Upholstery', 'CAT A - Moulding and Seat Cover Sewing', '110.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('53', 'Auto Upholstery', 'CAT B - Seat Cover Sewing', '59.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('54', 'Vulcanisers', 'CAT C - Wheel Balancing and Alignment', '106.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('55', 'Vulcanisers', 'CAT D - Tyre Repairs only', '66.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('56', 'Brake Specialist', 'Brake Specialist', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('57', 'Carburettor Specialist', 'Carburettor Specialist', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('58', 'Plastic Welders and Fabricators', 'Plastic Welders and Fabricators', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('59', 'Radiator Specialist', 'Radiator Specialist', '67.00', '1', '1', '2025-07-20 10:07:31', '2025-07-20 10:07:31'),
('60', 'Multiple Service Providers for Auto Works', 'CAT B-Medium Scale', '110.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('61', 'Multiple Service Providers for Auto Works', 'CAT C - Small Scale', '99.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('62', 'Windscreen Repairers', 'CAT C- Small scale', '99.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('63', 'Bolt and Nut Dealers', 'CAT A - Shop', '93.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('64', 'Bolt and Nut Dealers', 'CAT B - Table Top', '67.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('65', 'Spare Parts Sales Outlets (Secondhand)', 'CAT A - Second-Hand Engine Shops', '532.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('66', 'Spare Parts Sales Outlets (Secondhand)', 'CAT B - Retailers (Large)', '308.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('67', 'Spare Parts Sales Outlets (Secondhand)', 'CAT C - Retailers (Medium)', '187.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('68', 'Spare Parts Sales Outlets (Secondhand)', 'CAT D - Retailers (Small)', '106.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('69', 'Spare Parts Sales Outlets (Secondhand)', 'CAT E - Kiosk/Tabletop', '77.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('70', 'Tyre/Battery Dealers – Used', 'CAT B - Retail (Large)', '160.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('71', 'Tyre/Battery Dealers – Used', 'CAT C - Retail (Medium)', '133.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('72', 'Tyre/Battery Dealers – Used', 'CAT D - Retail (Small)', '100.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('73', 'Barbering Shop (floor space and number of points)', 'CAT B - Medium Shop (3-5 points)', '133.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('74', 'Barbering Shop (floor space and number of points)', 'CAT C - Small Shop (1-2 points)', '70.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('75', 'Barbering Shop (floor space and number of points)', 'CAT D - Mobile Operators', '17.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('76', 'Barbering Shop (floor space and number of points)', 'CAT E - Barbering accessory shop', '44.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('77', 'Bakeries', 'CAT A - Large Scale (Industrial operations)', '319.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('78', 'Bakeries', 'CAT B - Medium Scale', '160.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('79', 'Bakeries', 'CAT C - Small Scale', '80.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('80', 'Beads Dealers', 'CAT B', '83.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('81', 'Beads Dealers', 'CAT C', '55.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('82', 'Beads Dealers', 'CAT D - Retailers (Tabletop)', '33.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('83', 'Alcoholic and Non-Alcoholic beverages', 'CAT D - Retail (Large)', '400.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('84', 'Alcoholic and Non-Alcoholic beverages', 'CAT E - Retail (Medium)', '133.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('85', 'Alcoholic and Non-Alcoholic beverages', 'CAT F - Retail (Small)', '70.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('86', 'Bet & Game Centres Sports Betting Operations', 'CAT A - Online Betting', '2200.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('87', 'Route Operations (Console/consul Games)', 'CAT ‘C’', '1198.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('88', 'Route Operations (Console/consul Games)', 'CAT D (Per Machine)', '266.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('89', 'Bicycles/Tricycles/Motorcycle Dealers (Second-hand)', 'CAT C - Small Scale', '133.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('90', 'Bicycles/Tricycles/Motorcycles Parts Sales', 'CAT C - Motorcycle/Tricycles', '152.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('91', 'Bicycles/Tricycles/Motorcycles Parts Sales', 'CAT D - Bicycle with Parts', '120.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('92', 'Bicycles/Tricycles/Motorcycles Parts Sales', 'CAT E - Bicycles', '67.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('93', 'Bicycle Tricycle/ Motorcycle Repairers', 'CAT A - Tricycle', '66.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('94', 'Bicycle Tricycle/ Motorcycle Repairers', 'CAT B - Motorcycle', '39.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('95', 'Bicycle Tricycle/ Motorcycle Repairers', 'CAT C - Bicycle', '13.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('96', 'Billboards/Outdoor Adverts (e.g., Road Arches, Unipole spectacular, LEDs, Building wrap or Wall Drap', 'CAT A - Class A1 (Along First Class Access)', '37.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('97', 'Billboards/Outdoor Adverts (e.g., Road Arches, Unipole spectacular, LEDs, Building wrap or Wall Drap', 'CAT B - Class A2 (Along Second Class Access)', '29.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('98', 'Billboards/Outdoor Adverts (e.g., Road Arches, Unipole spectacular, LEDs, Building wrap or Wall Drap', 'CAT C - Class A3 (Along Third Class Access)', '25.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('99', 'Other Adverts', 'Other Adverts', '100.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('100', 'Blacksmith', 'Blacksmith', '73.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('101', 'Blocks & Concrete Producers', 'Blocks & Concrete Producers', '74.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('102', 'CAT E - Small Scale (Manual design blocks/columns only)', 'CAT E - Small Scale (Manual design blocks/columns only)', '75.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('103', 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT H - Office Equipment Only', '300.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('104', 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT I - Stationery Only', '200.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('105', 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT J - Books Only', '73.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('106', 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT K - Table Top/Truck Pusher', '27.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('107', 'Book, Stationery, Office Equipment, Computer & Accessory, etc. Shops', 'CAT L - Mobile Vans', '44.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('108', 'Boutiques (Including African Wear)', 'CAT B - Small Scale', '400.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('109', 'Boutiques (Including African Wear)', 'CAT C - Small Scale', '242.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('110', 'Boutiques (Including African Wear)', 'CAT D - Branches of CAT A & B', '182.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('111', 'Boutiques (Including African Wear)', 'CAT E - Others', '85.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('112', 'Bridal Homes', 'CAT ‘B’', '399.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('113', 'Bridal Homes', 'CAT \'C\'', '200.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('114', 'Butcher\'s Licence', 'CAT B - Butcher', '88.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('115', 'Building Material Dealers Hardware (Distributor/ Wholesaler)', 'CAT A - Distributor/Wholesaler (Large)', '2782.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('116', 'Building Material Dealers Hardware (Distributor/ Wholesaler)', 'CAT B - Distributor/Wholesaler (Medium)', '1171.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('117', 'Building Material Dealers Hardware (Distributor/ Wholesaler)', 'CAT C - Wholesaler (Medium)', '732.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('118', 'Building Material Dealers Hardware (Distributor/ Wholesaler)', 'CAT D - Wholesaler (Small)', '395.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('119', 'Finishing/Retail', 'CAT A - Large Scale', '666.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('120', 'Finishing/Retail', 'CAT B - Medium Scale', '395.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('121', 'Finishing/Retail', 'CAT C - Small Scale', '293.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('122', 'Finishing/Retail', 'CAT D - Very Small Scale', '146.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('123', 'Roofing Material Dealers', 'CAT A - Manufacture/Sales', '666.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('124', 'Roofing Material Dealers', 'CAT B - Sales & Installation', '399.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('125', 'Business Centres', 'CAT D - Internet, Word Processing, Printing and Copying Services plus below 11 Workstations', '146.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('126', 'Business Centres', 'CAT E - Secretarial Services (Word Processing, Printing and Copying Services)', '102.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('127', 'Cane Product Weavers', 'CAT ‘B’', '41.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('128', 'Cane Product Weavers', 'CAT \'C\'', '32.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('129', 'Car Washing Bay', 'CAT C - Jet Washing Only', '117.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('130', 'Car Washing Bay', 'CAT E - Manual Washing with other Facilities', '73.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('131', 'Car Washing Bay', 'CAT F - Manual Washing', '44.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('132', 'Canopy Producers', 'CAT B - Metal Fabricators', '133.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('133', 'Canopy Producers', 'CAT C - Fabric Sewing', '53.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('134', 'Carpentry Workshops', 'CAT C - Furniture (plus upholstery - Medium)', '102.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('135', 'Carpentry Workshops', 'CAT D - Furniture (plus upholstery - Small)', '81.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('136', 'Carpentry Workshops', 'CAT E - Minor Works', '64.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('137', 'Casket & Coffin Dealers', 'CAT C - Industrial (Manufacture & Sale)', '363.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('138', 'Casket & Coffin Dealers', 'CAT C - Manual (Manufacture & Sale)', '303.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('139', 'Casket & Coffin Dealers', 'CAT D - Sales Outlets', '110.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('140', 'Casket & Coffin Dealers', 'CAT E - Manufacturers Only', '99.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('141', 'Contracted Caterers (e.g., School Feeding)', 'CAT B - Above 500 to 1,000 pupils', '161.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('142', 'Contracted Caterers (e.g., School Feeding)', 'CAT C - Up to 500 pupils', '122.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('143', 'Ceremonial Hiring Services', 'CAT C - Canopies, Chairs, Tables', '399.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('144', 'Ceremonial Hiring Services', 'CAT D - Single Item of above', '99.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('145', 'Ceremonial Hiring Services', 'CAT H - Spinners (Large)', '200.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('146', 'Ceremonial Hiring Services', 'CAT I - Spinners (Small)', '99.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('147', 'Ceremonial Hiring Services', 'CAT J - Live Band', '333.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('148', 'Ceremonial Hiring Services', 'CAT K - Musical/Dance Groups', '133.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('149', 'Cleaning Companies', 'CAT B - Household/Office (Medium)', '700.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('150', 'Cleaning Companies', 'CAT C - Household/Office (Small)', '600.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('151', 'Cleaning Companies', 'CAT D - Household/Office (Very Small)', '200.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('152', 'Cold Storage Faccilities Non-Importers with Containerised Cold Storage Facilities (Local)', 'CAT D - Fabricated facility (Retail Large)', '200.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('153', 'Cold Storage Faccilities Non-Importers with Containerised Cold Storage Facilities (Local)', 'CAT E - Fabricated facility (Retail Medium)', '110.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('154', 'Cold Storage Faccilities Non-Importers with Containerised Cold Storage Facilities (Local)', 'CAT F - Fabricated facility (Retail Small)', '53.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('155', 'Stores Commercial Houses/Departmental', 'CAT G - Neighbourhood Shops (Large Size)', '399.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('156', 'Stores Commercial Houses/Departmental', 'CAT H - Neighbourhood Shops (Medium Size)', '266.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('157', 'Stores Commercial Houses/Departmental', 'CAT I - Neighbourhood Shops (Small Size)', '99.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('158', 'Stores Commercial Houses/Departmental', 'CAT J - Neighbourhood Shops (Very Small Size)', '66.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('159', 'Commercial Houses/Departmental', 'CAT C - Branch Offices', '7700.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('160', 'Commercial Houses/Departmental', 'CAT D - District Offices', '4950.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('161', 'Commercial Houses/Departmental', 'CAT E - Local Offices', '2200.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('162', 'Commissioner of Oath/Letter Writers', 'CAT ‘A’', '99.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('163', 'Commissioner of Oath/Letter Writers', 'CAT ‘B’', '66.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('164', 'Communication Mast Operating License', 'CAT A - 1-10 Masts', '2420.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('165', 'Communication Mast Operating License', 'CAT B - 11-20 Masts', '1980.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('166', 'Communication Mast Operating License', 'CAT C - 21-30 Masts', '1650.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('167', 'Communication Mast Operating License', 'CAT D - 31-40 Masts', '1100.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('168', 'Communication Mast Operating License', 'CAT E - Above 40 Masts', '792.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('169', 'Cooking/Household Utensil Sales', 'CAT ‘A’', '75.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('170', 'Cooking/Household Utensil Sales', 'CAT ‘B’', '54.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('171', 'Cooking/Household Utensil Sales', 'CAT ‘C’', '35.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('172', 'Cosmetic/Personal Care/Hair Product sale', 'CAT C - Retail', '121.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('173', 'Cosmetic/Personal Care/Hair Product sale', 'CAT D - Table top', '40.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('174', 'Curtains/Carpets etc. Sales', 'CAT ‘A’', '133.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('175', 'Curtains/Carpets etc. Sales', 'CAT ‘B’', '93.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('176', 'Curtains/Carpets etc. Sales', 'CAT ‘C’', '67.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('177', 'Disposable Products Dealers', 'CAT A - Wholesalers/Retailers', '200.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('178', 'Disposable Products Dealers', 'CAT B - Retailers (Medium)', '133.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('179', 'Disposable Products Dealers', 'CAT C - Retailers (Small)', '80.00', '1', '1', '2025-07-20 10:07:32', '2025-07-20 10:07:32'),
('180', 'Dressmakers/Tailors (Non-Industrial)', 'CAT A - Large Scale', '96.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('181', 'Dressmakers/Tailors (Non-Industrial)', 'CAT B - Medium Scale', '80.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('182', 'Dressmakers/Tailors (Non-Industrial)', 'CAT C - Small scale', '64.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('183', 'Dressmakers/Tailors Services', 'CAT A - Knitting, Haberdashery and Embroidery', '93.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('184', 'Dressmakers/Tailors Services', 'CAT B - Knitting and Embroidery', '67.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('185', 'Dressmakers/Tailors Services', 'CAT C - Embroidery only', '40.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('186', 'Dressmakers/Tailors Services', 'CAT D - Knitting only', '27.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('187', 'Dressmakers/Tailors Services', 'CAT E - Haberdashery Only (sewingitems -    large)', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('188', 'Dressmakers/Tailors Services', 'CAT F - Haberdashery Only (Small)', '67.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('189', 'Driving Schools', 'CAT A - Above 6 Vehicles', '182.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('190', 'Driving Schools', 'CAT B - 4 - 6 Vehicles', '146.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('191', 'Driving Schools', 'CAT C - 1 - 3 Vehicles', '106.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('192', 'Educational Institutions – Private Day Care Centres (Early Childhood Development Centres)', 'CAT A - Grade A', '666.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('193', 'Educational Institutions – Private Day Care Centres (Early Childhood Development Centres)', 'CAT B - Grade B', '395.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('194', 'Educational Institutions – Private Day Care Centres (Early Childhood Development Centres)', 'CAT C - Grade C', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('195', 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT B - KG/Primary/Junior High Schools (Medium)', '1210.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('196', 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT C - KG/Primary/Junior High Schools (Small)', '545.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('197', 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT D - KG/Primary (Large)', '424.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('198', 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT E - KG/Primary (Medium)', '242.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('199', 'Pre-Tertiary Schools Basic School (KG/Primary/Junior High Schools) National Curriculum Operators', 'CAT F - KG/Primary (Small)', '121.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('200', 'Secondary Level (Senior) High/Technical/ Vocational Schools)', 'CAT A - Large', '878.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('201', 'Secondary Level (Senior) High/Technical/ Vocational Schools)', 'CAT B - Medium', '586.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('202', 'Secondary Level (Senior) High/Technical/ Vocational Schools)', 'CAT C - Small', '439.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('203', 'Basic to Secondary School', 'CAT A - Large', '1210.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('204', 'Basic to Secondary School', 'CAT B - Medium', '847.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('205', 'Specialised Schools (Remedial School)', 'CAT \'A\'', '1065.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('206', 'Specialised Schools (Remedial School)', 'CAT \'B\'', '399.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('207', 'Training & Vocational Institutions (Media, Construction, Fashion, Floral, Catering, Cosmetology & We', 'CAT \'A\'', '293.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('208', 'Training & Vocational Institutions (Media, Construction, Fashion, Floral, Catering, Cosmetology & We', 'CAT \'B\'', '293.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('209', 'Training & Vocational Institutions (Media, Construction, Fashion, Floral, Catering, Cosmetology & We', 'CAT \'C\'', '200.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('210', 'Training & Vocational Institutions (Media, Construction, Fashion, Floral, Catering, Cosmetology & We', 'CAT \'D\'', '200.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('211', 'Egg Dealers', 'CAT A - Wholesale', '110.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('212', 'Egg Dealers', 'CAT B - Retail Shops', '73.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('213', 'Egg Dealers', 'CAT C - Mobile Retail', '44.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('214', 'Electrical Appliances (New & Secondhand)', 'CAT B - Wholesalers', '303.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('215', 'Electrical Appliances (New & Secondhand)', 'CAT C - Retailers (Large)', '182.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('216', 'Electrical Appliances (New & Secondhand)', 'CAT D - Retailers - (Small)', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('217', 'Electrical Appliances (New & Secondhand)', 'CAT E - Table Top', '80.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('218', 'Electronic/Home Appliances/Shops (New
& Second Hand)', 'CAT H - Retailers (Tabletop - Medium)', '266.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('219', 'Electronic/Home Appliances/Shops (New
& Second Hand)', 'CAT I - Retailers (Tabletop - Small)', '153.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('220', 'Fabric Dealers – Sales', 'CAT C - Wholesale', '184.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('221', 'Fabric Dealers – Sales', 'CAT D - Retail', '108.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('222', 'Fabric Dealers – Sales', 'CAT E - Table Top', '67.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('223', 'Feed Sellers (Poultry, Pets, Fish etc.)', 'CAT A - Wholesalers', '220.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('224', 'Feed Sellers (Poultry, Pets, Fish etc.)', 'CAT B - Distributors', '143.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('225', 'Feed Sellers (Poultry, Pets, Fish etc.)', 'CAT C - Retailers', '99.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('226', 'Financial Institutions (Banking) Other Financial Institutions Microfinance Companies (Deposit Taking', 'CAT A - Head Office', '1452.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('227', 'Financial Institutions (Banking) Other Financial Institutions Microfinance Companies (Deposit Taking', 'CAT B - Branch', '605.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('228', 'Microcredit/Money Lenders/Credit Union', 'CAT A - Head Office', '1452.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('229', 'Microcredit/Money Lenders/Credit Union', 'CAT B - Branch', '605.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('230', 'Microcredit/Money Lenders/Credit Union', 'CAT C - Tier 4 Operators', '242.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('231', 'Rural & Community Banks', 'CAT A - Head Office', '2750.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('232', 'Rural & Community Banks', 'CAT B - Branch', '448.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('233', 'Rural & Community Banks', 'CAT C - Agency', '303.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('234', 'Rural & Community Banks', 'CAT D - Mobilisation Centre', '145.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('235', 'Financial Technology Companies (FINTECH)', 'CAT B Mobile Money Vendor Large', '1210.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('236', 'Financial Technology Companies (FINTECH)', 'CAT C Mobile Money Vendor Medium', '303.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('237', 'Financial Technology Companies (FINTECH)', 'CAT D Mobile Money Vendor Small', '182.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('238', 'Stand Alone ATMs', 'Stand Alone ATMs', '500.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('239', 'Insurance Companies Non-Life Insurance', 'Cat-C-Agency', '700.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('240', 'Life Insurance Life Insurance', 'Cat- C-Agency', '605.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('241', 'Fish Farming Companies', 'CAT C- International Small Scale', '6050.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('242', 'Fish Farming Companies', 'CAT D - Local Large Scale', '266.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('243', 'Fish Farming Companies', 'CAT E - Local Medium Scale', '146.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('244', 'Fish Farming Companies', 'CAT F - Local Small Scale', '67.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('245', 'Fishing Nets and Accessories Dealers', 'CAT B - Wholesalers', '363.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('246', 'Fishing Nets and Accessories Dealers', 'CAT C - Retailers', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('247', 'Fishing Nets and Accessories Dealers', 'CAT D - Table Top', '44.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('248', 'Footwear Sales - New', 'CAT ‘A’', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('249', 'Footwear Sales - New', 'CAT ‘B’', '93.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('250', 'Footwear Sales - New', 'CAT ‘C’', '67.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('251', 'Footwear Sales - Used', 'CAT ‘A’', '100.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('252', 'Footwear Sales - Used', 'CAT ‘B’', '67.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('253', 'Footwear Sales - Used', 'CAT ‘C’', '36.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('254', 'Footwear Repairers (Cobblers)', 'CAT ‘A’', '47.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('255', 'Footwear Repairers (Cobblers)', 'CAT ‘B’', '29.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('256', 'Funeral – Undertaker’s Licence Hearse Service Providers', 'CAT A - Large Scale (Above 5 Vehicles)', '440.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('257', 'Funeral – Undertaker’s Licence Hearse Service Providers', 'CAT B - Medium Scale (3-5 Vehicles)', '220.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('258', 'Funeral – Undertaker’s Licence Hearse Service Providers', 'CAT C - Small Scale (1-2 Vehicles)', '110.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('259', 'Furniture Showroom', 'CAT -C', '605.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('260', 'Furniture Showroom', 'CAT-D', '363.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('261', 'Game Viewing/Commercial TV Viewing Centres', 'CAT B - Medium Scale', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('262', 'Game Viewing/Commercial TV Viewing Centres', 'CAT C - Small Scale', '87.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('263', 'Gas Cylinder/ Stoves & Accessory Dealers', 'CAT A - Large Scale', '160.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('264', 'Gas Cylinder/ Stoves & Accessory Dealers', 'CAT B - Medium Scale', '100.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('265', 'Gas Cylinder/ Stoves & Accessory Dealers', 'CAT C - Small Scale', '67.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('266', 'General Goods - Sales (e.g., Generator, Water pump, Chain saw, etc.)', 'CAT C - Small Scale', '322.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('267', 'General Goods - Sales (e.g., Generator, Water pump, Chain saw, etc.)', 'CAT D - Individuals', '293.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('268', 'Gift Shops', 'CAT B-Medium Scale', '120.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('269', 'Gift Shops', 'CAT C - Small Scale', '59.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('270', 'Glass Sellers (Tinted /Plain)', 'CAT A - Large Scale', '666.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('271', 'Glass Sellers (Tinted /Plain)', 'CAT B - Medium Scale', '586.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('272', 'Glass Sellers (Tinted /Plain)', 'CAT C - Small Scale', '293.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('273', 'GRAPHIC DESIGN COMPANIES', 'CAT B Medium Scale', '605.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('274', 'GRAPHIC DESIGN COMPANIES', 'CAT C Small Scale', '440.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('275', 'GRAPHIC DESIGN COMPANIES', 'CAT D Individuals', '275.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('276', 'Hair & Beauty Service Providers', 'CAT D - Big Salon', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('277', 'Hair & Beauty Service Providers', 'CAT E - Small Salon', '73.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('278', 'Hair & Beauty Service Providers', 'CAT F - Braiding and Weaving Only', '146.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('279', 'Hair & Beauty Service Providers', 'CAT G - Braiding Only', '73.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('280', 'Hair & Beauty Service Providers', 'CAT H - Pedicure & Manicure Only', '40.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('281', 'Health Facilities – Private Dental Clinics', 'Dental Clinics', '293.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('282', 'Health Facilities – Private Eye Clinics', 'CAT A - Ophthalmologist Clinics', '293.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('283', 'Health Facilities – Private Eye Clinics', 'CAT B - Opticians/Optometrist', '293.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('284', 'Health Facilities – Private General Clinics', 'CAT A - Specialty Clinics', '666.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('285', 'Health Facilities – Private General Clinics', 'CAT B - Primary Health Care', '532.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('286', 'General Hospitals', 'Primary', '666.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('287', 'Maternity Homes', 'CAT A - Expanded Services', '306.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('288', 'Maternity Homes', 'CAT B - General Services', '121.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('289', 'Medical Diagnostic Services', 'CAT A - Secondary/Tertiary', '230.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('290', 'Medical Diagnostic Services', 'CAT B - Basic/ Primary', '108.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('291', 'Licenced Herbal Medicine Units', 'CAT E - Medicine Producers Only (Local)', '200.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('292', 'Licenced Herbal Medicine Units', 'CAT F - Herbal Shops (Local)', '146.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('293', 'Hire Purchase Trading Enterprises', 'CAT A - Large Scale', '306.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('294', 'Hire Purchase Trading Enterprises', 'CAT B - Medium Scale', '266.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('295', 'Hire Purchase Trading Enterprises', 'CAT C - Small Scale', '200.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('296', 'Ice Cream/Yoghurt Dealers', 'CAT E - Retail', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('297', 'Interior/Event Decorators', 'CAT C - Individuals', '146.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('298', 'Jewelry Repairers (watches/bracelets, etc.)', 'CAT ‘A’', '53.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('299', 'Jewelry Repairers (watches/bracelets, etc.)', 'CAT ‘B’', '40.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('300', 'Key Technicians/Cutters', 'CAT \'A\'', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('301', 'Key Technicians/Cutters', 'CAT \'B\'', '66.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('302', 'Laundry Services', 'CAT B - Medium Scale', '230.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('303', 'Laundry Services', 'CAT C - Small Scale', '77.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('304', 'Leather Works Dealers (Other Nonfootwear products)', 'CAT C - Producers (Handmade Medium)', '133.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('305', 'Leather Works Dealers (Other Nonfootwear products)', 'CAT D - Sales/Others', '80.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('306', 'Livestock Farms', 'CAT C - Medium-sized', '399.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('307', 'Livestock Farms', 'CAT D - Small-sized', '200.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('308', 'Livestock Farms', 'CAT E - Very Small-sized', '106.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('309', 'Lottery Business Operators', 'CAT B - National Marketing Companies/Agents', '1997.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('310', 'Lottery Business Operators', 'CAT C - Private Operators', '605.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('311', 'Lottery Business Operators', 'CAT D - Lotto Receiver', '399.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('312', 'Lumber Business (Including Sawmill)', 'CAT ‘B’', '1997.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('313', 'Lumber Business (Including Sawmill)', 'CAT \'C\'', '932.00', '1', '1', '2025-07-20 10:07:33', '2025-07-20 10:07:33'),
('314', 'Lumber Business (Including Sawmill)', 'CAT \'D\'', '532.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('315', 'Machine Sharpening Operators', 'CAT A - Stationed with shops', '47.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('316', 'Machine Sharpening Operators', 'CAT B - Mobile', '7.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('317', 'Markets & Other Facilities’ Management Companies', 'CAT C - Small Scale', '1597.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('318', 'Mattress/Foam Products Dealers', 'CAT B - Wholesalers', '532.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('319', 'Mattress/Foam Products Dealers', 'CAT C - Retailers (Medium Scale)', '306.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('320', 'Mattress/Foam Products Dealers', 'CAT D - Retailers (Small Scale)', '153.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('321', 'Mattress Makers/Repairers', 'Mattress Makers/Repairers', '55.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('322', 'Media Houses Electronic Media (Radio) Operators', 'CAT-C District', '1870.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('323', 'Media Houses Electronic Media (Radio) Operators', 'CAT D - Community', '799.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('324', 'Media Houses Electronic Media (Radio) Operators', 'CAT-E -Recording Studio-Large', '700.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('325', 'Media Houses Electronic Media (Radio) Operators', 'CAT-F-Recording Studio-medium', '300.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('326', 'Media Houses Electronic Media (Radio) Operators', 'CAT-H-Information Centre (Urban)', '200.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('327', 'Media Houses Electronic Media (Radio) Operators', 'CAT-I-Information Centre (Rural)', '150.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('328', 'Printing Houses', 'CAT E - Others', '133.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('329', 'Printing Houses', 'CAT F - Newspaper/Periodicals Vendors', '67.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('330', 'Metal Dealers Metal Fabricators', 'CAT C - Domestic Milling Machines', '932.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('331', 'Metal Dealers Metal Fabricators', 'CAT D - Canopies and Scaffolding', '673.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('332', 'Metal Dealers Metal Fabricators', 'CAT E - Pot, Coal pots and Sheet moulders', '306.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('333', 'Metal Dealers Metal Fabricators', 'CAT F - Chairs and beds, etc.', '184.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('334', 'Milling Businesses (For Food)', 'CAT A - Above 3 Machines', '133.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('335', 'Milling Businesses (For Food)', 'CAT B - 2-3 Machines', '99.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('336', 'Milling Businesses (For Food)', 'CAT C - 1 Machine Only', '44.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('337', 'Mineral Water Producers', 'CAT C - Sachet Water', '586.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('338', 'Mineral Water Distribution/Sales', 'CAT C - Retail (Large)', '200.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('339', 'Mineral Water Distribution/Sales', 'CAT D - Retail (Medium)', '93.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('340', 'Mineral Water Distribution/Sales', 'CAT E - Retail (Small)', '40.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('341', 'Mobile Phone & Accessories Sales/Assembling/Repairs', 'CAT C - Retail/Repairs', '220.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('342', 'Mobile Phone & Accessories Sales/Assembling/Repairs', 'CAT D - Retail Only', '165.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('343', 'Mobile Phone & Accessories Sales/Assembling/Repairs', 'CAT E - Repairs Only', '165.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('344', 'Mobile Phone & Accessories Sales/Assembling/Repairs', 'CAT F - Repairs Only (Small)', '110.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('345', 'Mother Care Shops Retail', 'CAT A - Large Scale', '399.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('346', 'Mother Care Shops Retail', 'CAT B - Medium Scale', '200.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('347', 'Musical Equipment Musical Instrument Sales', 'CAT B - Retail (Medium)', '126.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('348', 'Musical Equipment Musical Instrument Sales', 'CAT C - Retail (Small)', '93.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('349', 'Musical Speaker Manufacturers &Sales', 'Musical Speaker Manufacturers &Sales', '93.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('350', 'Non-Governmental Institutions (Renewal)', 'CAT A - International NGOs/CSOs /FBOs', '187.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('351', 'Non-Governmental Institutions (Renewal)', 'CAT B - Local NGOs/CSOs/ FBOs', '110.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('352', 'Non-Governmental Institutions (Renewal)', 'CAT C - Community NGOs/CSOs /FBOs', '77.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('353', 'Pharmaceutical Companies Pharmacies', 'CAT D - Retail', '439.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('354', 'Over the Counter Medicine Sellers (OTCMs) (Licenced Chemical Shops)', 'Over the Counter Medicine Sellers (OTCMs) (Licenced Chemical Shops)', '231.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('355', 'Photographers / Video Operators', 'CAT D - Photo Shops/Studio', '200.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('356', 'Photographers / Video Operators', 'CAT E - Individual video and photography operators', '77.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('357', 'Plastic Product Sales (Including Water tanks)', 'CAT A - Wholesale (Large)', '385.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('358', 'Plastic Product Sales (Including Water tanks)', 'CAT B - Wholesale (Small)', '200.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('359', 'Plastic Product Sales (Including Water tanks)', 'CAT C - Retail (Large)', '93.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('360', 'Plastic Product Sales (Including Water tanks)', 'CAT D - Retail (Medium)', '80.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('361', 'Plastic Product Sales (Including Water tanks)', 'CAT E - Retail (Small)', '53.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('362', 'Plastic Product Sales (Including Water tanks)', 'CAT F - Polyethylene Sellers', '40.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('363', 'Poultry Farms', 'CAT A - Above 2000 Birds', '466.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('364', 'Poultry Farms', 'CAT B - Up to 2000 Birds', '333.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('365', 'Poultry Farms', 'CAT C - Up to 1000 Birds', '186.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('366', 'Poultry Farms', 'CAT D - Up to 500 Birds', '160.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('367', 'Professional Firms/Individuals (Architectural, Auditing, Accounting, Engineering, Legal Firms etc.)', 'CAT G - Others', '399.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('368', 'Draughtsmanship Business', 'CAT ‘A’', '385.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('369', 'Draughtsmanship Business', 'CAT ‘B’', '187.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('370', 'Publishing Houses', 'CAT D - Publishing Only (Small)', '466.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('371', 'Refrigerator/Air Condition Mechanics', 'CAT ‘A’', '306.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('372', 'Refrigerator/Air Condition Mechanics', 'CAT ‘B’', '230.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('373', 'Straw Basket Weavers and Sales', 'CAT \'C\'', '93.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('374', 'Scrap Metal Dealers', 'CAT B - Medium Scale (Depot)', '399.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('375', 'Scrap Metal Dealers', 'CAT C - Small Scale (Collection Points)', '266.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('376', 'Service/Filling Stations', 'CAT E - Fuel Only', '1100.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('377', 'Service/Filling Stations', 'CAT F - Surface Tank Points', '400.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('378', 'Service/Filling Stations', 'CAT G - Sale of Lubricants', '133.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('379', 'Service/Filling Stations', 'CAT H - Kerosene', '133.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('380', 'Service/Filling Stations', 'CAT I - LPG Retail Points (Large)', '600.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('381', 'Service/Filling Stations', 'CAT J - LPG Retail Points (Medium)', '466.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('382', 'Service/Filling Stations', 'CAT K - LPG Retail Points Only (Small)', '399.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('383', 'Straw Basket Weavers and Sales', 'Straw Basket Weavers and Sales', '40.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('384', 'Timber Products Retail Outlets', 'CAT A - Large scale', '202.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('385', 'Timber Products Retail Outlets', 'CAT B - Medium scale', '92.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('386', 'Timber Products Retail Outlets', 'CAT C - Small scale', '61.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('387', 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT A- Five Star', '5000.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('388', 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT B- Four Star', '4000.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('389', 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT C - Three Star', '3328.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('390', 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT D - Two Star', '900.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('391', 'Tourism Licenced Facilities Accommodation Facilities Hotels/ Beach Resorts/ Motels/ Apartments', 'CAT E - One Star', '750.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('392', 'Guest Houses (4-9 Rooms)', 'Guest Houses (4-9 Rooms)', '500.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('393', 'Budget Hotels', 'Budget Hotels', '400.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('394', 'Hostels (Private):', 'CAT A - Above 50 Beds', '759.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('395', 'Hostels (Private):', 'CAT B - 21-50 Beds', '626.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('396', 'Hostels (Private):', 'CAT C - 11-20 Beds', '506.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('397', 'Hostels (Private):', 'CAT D - Up to 10 Beds', '383.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('398', 'Body Building Gyms', 'CAT-A- Large scale settings', '440.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('399', 'Body Building Gyms', 'CAT-B- Medium Scale', '308.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('400', 'Body Building Gyms', 'CAT-C- Small', '154.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('401', 'Food & Beverage (Eatery / Catering Houses) Formal Catering Services Restaurants.', 'CAT-A- Large', '1430.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('402', 'Food & Beverage (Eatery / Catering Houses) Formal Catering Services Restaurants.', 'CAT-B- Medium Scale', '935.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('403', 'Food & Beverage (Eatery / Catering Houses) Formal Catering Services Restaurants.', 'CAT-C- Small', '660.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('404', 'Fast Food', 'CAT A - Grade 1', '799.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('405', 'Fast Food', 'CAT B - Grade 2', '532.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('406', 'Fast Food', 'CAT C - Grade 3', '399.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('407', 'Local Restaurant (Chop Bar)', 'CAT-A', '220.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('408', 'Local Restaurant (Chop Bar)', 'CAT-B', '165.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('409', 'Local Restaurant (Chop Bar)', 'CAT-C', '110.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('410', 'Transport Charges - Commercial Transport Unions (Lorry Park Operations)', 'CAT ‘C’ (GPRTU/ CO-ORPERATIVE)', '303.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('411', 'Transport Charges - Commercial Transport Unions (Lorry Park Operations)', 'CAT \'D\' (PROTOA)', '266.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('412', 'TV & Radio Repairers', 'TV & Radio Repairers', '94.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('413', 'Upholstery Dealers', 'CAT A - Production & Sales', '399.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('414', 'Upholstery Dealers', 'CAT B - Sales', '266.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('415', 'Upholstery Dealers', 'CAT C - Production', '133.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('416', 'Used Clothing Sales (\'Second Hand\')', 'CAT D - Retailers (Containers/Kiosks/Tabletops)', '87.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('417', 'Used Clothing Sales (\'Second Hand\')', 'CAT E - Retailers (Tabletops)', '67.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('418', 'Wood Fuel', 'CAT A - Charcoal Producers', '46.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('419', 'Wood Fuel', 'CAT B - Firewood Sellers (Large)', '106.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('420', 'Wood Fuel', 'CAT C - Firewood Sellers (Medium)', '77.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('421', 'Wood Fuel', 'CAT D - Firewood Sellers (Small)', '46.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34'),
('422', 'Wood Fuel', 'CAT E - Charcoal Sellers', '46.00', '1', '1', '2025-07-20 10:07:34', '2025-07-20 10:07:34');


-- Table structure for table `business_summary`
DROP TABLE IF EXISTS `business_summary`;
;

-- Dumping data for table `business_summary`
INSERT INTO `business_summary` (`business_id`, `account_number`, `business_name`, `owner_name`, `business_type`, `category`, `telephone`, `exact_location`, `amount_payable`, `status`, `zone_name`, `sub_zone_name`, `payment_status`) VALUES
('29', 'BIZ000001', 'KabTech Consulting', 'Afful Bismark', 'I.T firm', 'Small', '', 'Accra', '500.00', 'Active', 'Eastern Zone', 'Nungua', 'Defaulter');


-- Table structure for table `businesses`
DROP TABLE IF EXISTS `businesses`;
CREATE TABLE `businesses` (
  `business_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`business_id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `sub_zone_id` (`sub_zone_id`),
  KEY `created_by` (`created_by`),
  KEY `idx_account_number` (`account_number`),
  KEY `idx_business_type` (`business_type`),
  KEY `idx_zone` (`zone_id`),
  KEY `idx_status` (`status`),
  KEY `idx_businesses_payable` (`amount_payable`),
  CONSTRAINT `businesses_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`),
  CONSTRAINT `businesses_ibfk_2` FOREIGN KEY (`sub_zone_id`) REFERENCES `sub_zones` (`sub_zone_id`),
  CONSTRAINT `businesses_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `businesses`
INSERT INTO `businesses` (`business_id`, `account_number`, `business_name`, `owner_name`, `business_type`, `category`, `telephone`, `exact_location`, `latitude`, `longitude`, `old_bill`, `previous_payments`, `arrears`, `current_bill`, `amount_payable`, `batch`, `status`, `zone_id`, `sub_zone_id`, `created_by`, `created_at`, `updated_at`) VALUES
('29', 'BIZ000001', 'KabTech Consulting', 'Afful Bismark', 'I.T firm', 'Small', '', 'Accra', NULL, NULL, '0.00', '250.00', '0.00', '500.00', '500.00', '', 'Active', '4', '5', '1', '2025-09-09 20:28:44', '2025-09-11 15:51:36');


-- Table structure for table `device_tokens`
DROP TABLE IF EXISTS `device_tokens`;
CREATE TABLE `device_tokens` (
  `token_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `device_token` varchar(255) NOT NULL,
  `platform` enum('Android','iOS') NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `last_used` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`token_id`),
  UNIQUE KEY `user_device_unique` (`user_id`,`device_token`),
  CONSTRAINT `device_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `device_tokens`

-- Table structure for table `message_templates`
DROP TABLE IF EXISTS `message_templates`;
CREATE TABLE `message_templates` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(100) NOT NULL,
  `template_type` enum('SMS','Email','System') NOT NULL DEFAULT 'SMS',
  `template_content` text NOT NULL,
  `variables` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`template_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `message_templates_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `message_templates`

-- Table structure for table `notifications`
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `recipient_type` enum('User','Business','Property') NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `notification_type` enum('SMS','System','Email') NOT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `message` text NOT NULL,
  `status` enum('Pending','Sent','Failed','Read') DEFAULT 'Pending',
  `sent_by` int(11) DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`notification_id`),
  KEY `sent_by` (`sent_by`),
  KEY `idx_recipient` (`recipient_type`,`recipient_id`),
  KEY `idx_status` (`status`),
  KEY `idx_sent_at` (`sent_at`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`sent_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `notifications`

-- Table structure for table `payment_summary`
DROP TABLE IF EXISTS `payment_summary`;
;

-- Dumping data for table `payment_summary`
INSERT INTO `payment_summary` (`payment_id`, `payment_reference`, `amount_paid`, `payment_method`, `payment_status`, `payment_date`, `bill_number`, `bill_type`, `payer_name`) VALUES
('49', 'PAY202509119LHD06', '250.00', 'Cash', 'Successful', '2025-09-11 15:51:36', 'BILL2025B000029', 'Business', 'KabTech Consulting');


-- Table structure for table `payments`
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `receipt_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `payment_reference` (`payment_reference`),
  KEY `processed_by` (`processed_by`),
  KEY `idx_payment_ref` (`payment_reference`),
  KEY `idx_bill_id` (`bill_id`),
  KEY `idx_transaction_id` (`transaction_id`),
  KEY `idx_payment_date` (`payment_date`),
  KEY `idx_payments_date_status` (`payment_date`,`payment_status`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`processed_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `payments`
INSERT INTO `payments` (`payment_id`, `payment_reference`, `bill_id`, `amount_paid`, `payment_method`, `payment_channel`, `transaction_id`, `paystack_reference`, `payment_status`, `payment_date`, `processed_by`, `notes`, `receipt_url`) VALUES
('49', 'PAY202509119LHD06', '49', '250.00', 'Cash', '', '', NULL, 'Successful', '2025-09-11 15:51:36', '1', '', NULL);


-- Table structure for table `properties`
DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties` (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`property_id`),
  UNIQUE KEY `property_number` (`property_number`),
  KEY `created_by` (`created_by`),
  KEY `idx_property_number` (`property_number`),
  KEY `idx_structure` (`structure`),
  KEY `idx_zone` (`zone_id`),
  KEY `idx_properties_payable` (`amount_payable`),
  KEY `idx_sub_zone` (`sub_zone_id`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`),
  CONSTRAINT `properties_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`),
  CONSTRAINT `properties_ibfk_3` FOREIGN KEY (`sub_zone_id`) REFERENCES `sub_zones` (`sub_zone_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `properties`

-- Table structure for table `property_fee_structure`
DROP TABLE IF EXISTS `property_fee_structure`;
CREATE TABLE `property_fee_structure` (
  `fee_id` int(11) NOT NULL AUTO_INCREMENT,
  `structure` varchar(100) NOT NULL,
  `property_use` enum('Commercial','Residential') NOT NULL,
  `fee_per_room` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`fee_id`),
  UNIQUE KEY `unique_structure_use` (`structure`,`property_use`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `property_fee_structure_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `property_fee_structure`
INSERT INTO `property_fee_structure` (`fee_id`, `structure`, `property_use`, `fee_per_room`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
('1', 'Concrete Block', 'Residential', '50.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('2', 'Concrete Block', 'Commercial', '100.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('3', 'Mud Block', 'Residential', '25.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('4', 'Mud Block', 'Commercial', '50.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('5', 'Modern Building', 'Residential', '75.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('6', 'Modern Building', 'Commercial', '150.00', '1', '1', '2025-07-04 18:57:35', '2025-07-04 18:57:35'),
('7', 'The storey', 'Residential', '35.00', '1', '3', '2025-08-04 18:55:58', '2025-08-04 18:55:58');


-- Table structure for table `property_summary`
DROP TABLE IF EXISTS `property_summary`;
;

-- Dumping data for table `property_summary`

-- Table structure for table `public_sessions`
DROP TABLE IF EXISTS `public_sessions`;
CREATE TABLE `public_sessions` (
  `session_id` varchar(64) NOT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`session_data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NOT NULL DEFAULT (current_timestamp() + interval 1 hour),
  PRIMARY KEY (`session_id`),
  KEY `idx_account_number` (`account_number`),
  KEY `idx_expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `public_sessions`

-- Table structure for table `sub_zones`
DROP TABLE IF EXISTS `sub_zones`;
CREATE TABLE `sub_zones` (
  `sub_zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_id` int(11) NOT NULL,
  `sub_zone_name` varchar(100) NOT NULL,
  `sub_zone_code` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`sub_zone_id`),
  UNIQUE KEY `sub_zone_code` (`sub_zone_code`),
  KEY `zone_id` (`zone_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `sub_zones_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`zone_id`) ON DELETE CASCADE,
  CONSTRAINT `sub_zones_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `sub_zones`
INSERT INTO `sub_zones` (`sub_zone_id`, `zone_id`, `sub_zone_name`, `sub_zone_code`, `description`, `created_by`, `created_at`) VALUES
('1', '1', 'Market Area', 'MA01', 'Main market area', '1', '2025-07-04 18:57:35'),
('2', '1', 'Government Area', 'GA02', 'Government offices area', '1', '2025-07-04 18:57:35'),
('3', '2', 'Residential A', 'RA01', 'High-end residential', '1', '2025-07-04 18:57:35'),
('4', '3', 'Industrial Area', 'IA01', 'Industrial zone', '1', '2025-07-04 18:57:35'),
('5', '4', 'Nungua', 'EZNU', NULL, '3', '2025-08-04 18:03:57'),
('6', '4', 'Mepe', 'EZME', NULL, '3', '2025-08-08 08:11:00');


-- Table structure for table `system_restrictions`
DROP TABLE IF EXISTS `system_restrictions`;
CREATE TABLE `system_restrictions` (
  `restriction_id` int(11) NOT NULL AUTO_INCREMENT,
  `restriction_start_date` date NOT NULL,
  `restriction_end_date` date NOT NULL,
  `warning_days` int(11) DEFAULT 7,
  `is_active` tinyint(1) DEFAULT 0,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`restriction_id`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `system_restrictions_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `system_restrictions`
INSERT INTO `system_restrictions` (`restriction_id`, `restriction_start_date`, `restriction_end_date`, `warning_days`, `is_active`, `created_by`, `created_at`) VALUES
('16', '2025-08-26', '2025-10-26', '7', '0', '3', '2025-08-24 19:27:10'),
('17', '2025-08-26', '2025-10-26', '7', '0', '3', '2025-08-24 19:29:04'),
('18', '2025-08-25', '2025-10-25', '7', '0', '3', '2025-08-24 19:30:00'),
('19', '2025-09-14', '2025-11-14', '7', '1', '3', '2025-09-13 08:40:48');


-- Table structure for table `system_settings`
DROP TABLE IF EXISTS `system_settings`;
CREATE TABLE `system_settings` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` enum('text','number','boolean','date','json') DEFAULT 'text',
  `description` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`setting_id`),
  UNIQUE KEY `setting_key` (`setting_key`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `system_settings_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `system_settings`
INSERT INTO `system_settings` (`setting_id`, `setting_key`, `setting_value`, `setting_type`, `description`, `updated_by`, `updated_at`) VALUES
('1', 'assembly_name', 'Jasikan Municipal Assembly', 'text', 'Name to appear on bills and reports', '1', '2025-09-09 20:27:09'),
('2', 'billing_start_date', '2024-11-01', 'date', 'Annual billing start date', NULL, '2025-07-04 18:57:35'),
('3', 'restriction_period_months', '3', 'number', 'System restriction period in months', NULL, '2025-07-04 18:57:35'),
('4', 'restriction_start_date', '2025-09-14', 'date', 'Restriction countdown start date', '3', '2025-09-13 08:40:48'),
('5', 'system_restricted', 'false', 'boolean', 'System restriction status', '3', '2025-09-13 08:40:48'),
('6', 'sms_enabled', 'true', 'boolean', 'SMS notifications enabled', '1', '2025-07-12 18:55:11'),
('7', 'auto_bill_generation', 'true', 'boolean', 'Automatic bill generation on Nov 1st', NULL, '2025-07-04 18:57:35'),
('8', 'twilio_sid', '831JD7BHZAHE9M7EWNW1FCUB', 'text', 'Twilio Sid', '3', '2025-07-12 20:23:05'),
('9', 'twilio_token', 'ZQHijuboaimCs7Ali3X9aRzizbjztN8a', 'text', 'Twilio Token', '3', '2025-07-12 20:23:05'),
('10', 'twilio_phone', '0545041428', 'text', 'Twilio Phone', '3', '2025-07-12 20:23:05');


-- Table structure for table `user_roles`
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `user_roles`
INSERT INTO `user_roles` (`role_id`, `role_name`, `description`, `created_at`) VALUES
('1', 'Super Admin', 'Full system access with restriction controls', '2025-07-04 18:57:34'),
('2', 'Admin', 'Full system access excluding restrictions', '2025-07-04 18:57:34'),
('3', 'Officer', 'Register businesses/properties, record payments, generate bills', '2025-07-04 18:57:34'),
('4', 'Revenue Officer', 'Record payments and view maps', '2025-07-04 18:57:34'),
('5', 'Data Collector', 'Register businesses/properties and view profiles', '2025-07-04 18:57:34');


-- Table structure for table `user_sessions`
DROP TABLE IF EXISTS `user_sessions`;
CREATE TABLE `user_sessions` (
  `session_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `session_token` varchar(128) NOT NULL,
  `device_fingerprint` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `login_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`session_id`),
  UNIQUE KEY `session_token` (`session_token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `user_sessions`
INSERT INTO `user_sessions` (`session_id`, `user_id`, `session_token`, `device_fingerprint`, `ip_address`, `user_agent`, `login_time`, `last_activity`, `is_active`) VALUES
('1', '1', '42eb2905dda2698263bebc8593b974d7eca1697964a4cd95d9d34c12b65ddbdd38b019f9b3d113489279efc72172c942025df1b324c321b442866ef67e9b67de', '740e3206e3c0b5169777c5457521521e43080b04930532c6f1a20d0a08a03eb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-11 16:57:52', '2025-09-11 16:58:56', '0'),
('2', '1', '7cd4b5c9a519359da7644528dac273c51e0442574565024bfe3560f408a63142f8db249d5281e922ba11a90beb301c214790f5c2d54b81b9780f05eb2f5703c1', '4cc995827516d10766fbf74eedfbeb42f2f4afac4af1b7e2b0715a71197bd327', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-11 16:59:27', '2025-09-11 17:05:28', '0'),
('3', '1', 'b868308d6f95457e0890b81bba53b5b9742db6a61e24b49c83a319c801cdfc12126067a900163f2cc71d811065476473a173a6bb1acd9428cea5a3796781ebf2', '4cc995827516d10766fbf74eedfbeb42f2f4afac4af1b7e2b0715a71197bd327', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-11 17:05:28', '2025-09-11 17:06:08', '0'),
('4', '1', '049cffd5e47e77f9079f2f8676f00cabe21b977210c1e12913de20f23ef5c7e1346b06036bdebe342d37f67da0367937a2224e305191bb1119129e8b86452377', '740e3206e3c0b5169777c5457521521e43080b04930532c6f1a20d0a08a03eb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-12 11:55:01', '2025-09-12 11:55:38', '0'),
('5', '1', '5039f37c9e9dee8f2d45a0e3b2c496f2c24d6128e7e62d2de5b1266c23a3c152e42371782c2e838f18d355c1b3bdb228108802823fe558674bef8565c07a650a', '4cc995827516d10766fbf74eedfbeb42f2f4afac4af1b7e2b0715a71197bd327', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 11:55:38', '2025-09-12 11:56:15', '0'),
('6', '1', '86c009fec318756d711316be712fe945382d7aabb42d7b62bfb6d955ac2011ccaf81fa1681ff0ea7ed32628a7fbf2329169a66cf4a67ee40e9dd9d37da48fc8c', '4cc995827516d10766fbf74eedfbeb42f2f4afac4af1b7e2b0715a71197bd327', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 11:56:15', '2025-09-12 12:05:39', '0'),
('7', '1', '17217bdb4c42fe646ce9676b9160aac6efe2622bf519b5f9a76c551a798c5aaabbac613eca8522375f5b54cc294a3344e34e3854756a8497ea4012c9a3680c09', '4cc995827516d10766fbf74eedfbeb42f2f4afac4af1b7e2b0715a71197bd327', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', '2025-09-12 12:05:39', '2025-09-13 08:39:22', '0'),
('8', '4', 'e4e0ce72dc8a786f8bfc1fd7c3753999a56903a348d8be7ca241db21d05956bdd64f357c422433eaf470c55411572c9f10ab4b1b750de8b68fd7b20042dc8598', '0df3fe7ef95c5be7938efb4081546f769b0b4c5b47264fdc1731e47d5976714a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-12 12:36:10', '2025-09-13 08:20:01', '0'),
('9', '4', '2fada554f06a95147866c5602c814321b978469a384db48aa2597050b75a534101cebc67835d1a40507b0640a93044ccd6cad9ddfc22921e827539e949830550', '740e3206e3c0b5169777c5457521521e43080b04930532c6f1a20d0a08a03eb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:20:04', '2025-09-13 08:27:59', '0'),
('10', '4', '9b25df80b4aa31f5b8e7ea19c17fb530a5ed76da0c1b448d89b4442a0a84b3b4f9a3c0cdfa4c3baa219e8909d1bc3602990fd5dc17a5ff6e43669ac7c2ea58fa', '740e3206e3c0b5169777c5457521521e43080b04930532c6f1a20d0a08a03eb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:28:00', '2025-09-13 08:38:08', '0'),
('11', '4', 'd227cae09115a90e19e926c06b181a82119a082f83097270aa53f9792c5f2a71bce887df345a1886e9d84f6d2c4d3c049b0e9bf8007d1789f6d03611219a6644', '740e3206e3c0b5169777c5457521521e43080b04930532c6f1a20d0a08a03eb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:38:08', '2025-09-13 08:38:50', '0'),
('12', '1', '1b1cb1ab8cca2afcd6c02d7c8d78d021ac673af90747900277f3524a04d7b825f22e5f2b90422a43b104dd6232f696a9e65d5b2d0397acc6093882f2b3136fbc', '0df3fe7ef95c5be7938efb4081546f769b0b4c5b47264fdc1731e47d5976714a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:39:26', '2025-09-13 16:22:07', '0'),
('13', '3', 'f71066bcbe7872547e6d2dc8bb6a0c91d1c5aa85500170d2a00d08b7524992558d75f8b37e226ac76db221f99e68ba38446f264c7c675fbe96c8570837a8ccf3', '0df3fe7ef95c5be7938efb4081546f769b0b4c5b47264fdc1731e47d5976714a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 08:39:50', '2025-09-13 08:39:50', '1'),
('14', '4', 'fee9458f0fceae0cc2727e6933186ad6118d41b1ea03a5dba528a9b54fa04404ac9e6bd1fd394476dcd0c37dbd2278226b1ca3b0bc95797620f319512d190f98', '740e3206e3c0b5169777c5457521521e43080b04930532c6f1a20d0a08a03eb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 08:41:08', '2025-09-13 16:15:15', '0'),
('15', '4', '436b3021354a7baadfb4235c48dec8b9c9cd9f222081c746b5ab338130eb53bb15e592efa968a3904513d8e81414fe2f72f59aa7b651d2796117522a6d8204d6', '740e3206e3c0b5169777c5457521521e43080b04930532c6f1a20d0a08a03eb8', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36 Edg/140.0.0.0', '2025-09-13 16:15:16', '2025-09-13 16:17:42', '0'),
('16', '4', '5f6b85d6d6ee3ca66b8fc75becacd01627119efd0b1e6e0f08a7222bd0c660a45e7fd8b3806b79f206137a55e13d97e1ae71fb1a24c5134aeffcf2e2245fc0ff', '0df3fe7ef95c5be7938efb4081546f769b0b4c5b47264fdc1731e47d5976714a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 16:17:57', '2025-09-13 16:17:57', '1'),
('17', '1', '4a23389f27599306779255a3e7964cc6c98a7bb7178449315a99cd4c13b7c1b04f724d1652df7fdf356bb3d0be6a64ab663d8f5d79c8666effc4bdc1acc8d24a', '0df3fe7ef95c5be7938efb4081546f769b0b4c5b47264fdc1731e47d5976714a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:142.0) Gecko/20100101 Firefox/142.0', '2025-09-13 16:22:07', '2025-09-13 16:22:07', '1');


-- Table structure for table `users`
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `users`
INSERT INTO `users` (`user_id`, `username`, `email`, `password_hash`, `role_id`, `first_name`, `last_name`, `phone`, `is_active`, `first_login`, `last_login`, `created_at`, `updated_at`) VALUES
('1', 'admin', 'admin@quickbill305.com', '$2y$10$e4YGmKebT13JFeJVTNJTr.oWNFXUzfTYqhmQEco1/VF/hVOSPCdYS', '2', 'System', 'Administrator', '+233000000000', '1', '0', '2025-09-13 16:22:07', '2025-07-04 18:57:35', '2025-09-13 16:22:07'),
('3', 'Joojo', 'kwadwomegas@gmail.com', '$2y$10$JSLvWE7gM/FUgiTqv9v1qOU9L4U3udx6crIBivD6KIP9.q2NMuTDq', '1', 'Joojo', 'Megas', '0545041428', '1', '0', '2025-09-13 08:39:50', '2025-07-09 19:03:22', '2025-09-13 08:39:50'),
('4', 'Kusi', 'kusi@gmail.com', '$2y$10$xXAtNw3GQSVKPNRPnaIacOX9XWegyGQT47fAkuZ22b1J9swsJllge', '5', 'Kusi', 'France', '+233543258791', '1', '0', '2025-09-13 16:17:57', '2025-07-11 15:21:00', '2025-09-13 16:17:57'),
('5', 'Aseye', 'aseyeabledoo@gmail.com', '$2y$10$I8aBJT72RTKJ8bMgiWOwP.831BvSerUvhqQCLft82TbkDyTDJgIZO', '4', 'Aseye', 'Abledu', '', '1', '0', '2025-08-29 19:04:11', '2025-07-12 05:12:52', '2025-08-29 19:04:11'),
('6', 'David', 'kabtechconsulting@gmail.com', '$2y$10$Sn1Ex9uZx3GlCdAwsKkOcuow7anUlJI9FJBSaRgjyDDUeQg4S0XjW', '3', 'David', 'Lomko', '', '1', '0', '2025-09-05 08:01:28', '2025-07-12 07:18:33', '2025-09-05 08:01:28');


-- Table structure for table `zones`
DROP TABLE IF EXISTS `zones`;
CREATE TABLE `zones` (
  `zone_id` int(11) NOT NULL AUTO_INCREMENT,
  `zone_name` varchar(100) NOT NULL,
  `zone_code` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`zone_id`),
  UNIQUE KEY `zone_code` (`zone_code`),
  KEY `created_by` (`created_by`),
  CONSTRAINT `zones_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table `zones`
INSERT INTO `zones` (`zone_id`, `zone_name`, `zone_code`, `description`, `created_by`, `created_at`) VALUES
('1', 'Central Zone', 'CZ01', 'Central business district', '1', '2025-07-04 18:57:35'),
('2', 'North Zone', 'NZ02', 'Northern residential area', '1', '2025-07-04 18:57:35'),
('3', 'South Zone', 'SZ03', 'Southern commercial area', '1', '2025-07-04 18:57:35'),
('4', 'Eastern Zone', 'EZ', NULL, '1', '2025-07-10 09:20:38'),
('5', 'Juapong', 'JU', NULL, '3', '2025-08-08 08:22:19');

COMMIT;
