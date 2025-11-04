<?php
/**
 * Export Audit Logs - Internal Auditor
 * Export filtered audit logs to CSV or Excel format
 */

define('QUICKBILL_305', true);

require_once '../config/config.php';
require_once '../config/database.php';
require_once '../includes/functions.php';

session_start();

require_once '../includes/auth.php';

if (!isLoggedIn() || !isInternalAuditor()) {
    header('Location: ../auth/login.php');
    exit();
}

$db = new Database();

// Get filters from URL (same as audit_logs.php)
$filters = [
    'action' => $_GET['action'] ?? '',
    'table_name' => $_GET['table_name'] ?? '',
    'user_id' => $_GET['user_id'] ?? '',
    'date_from' => $_GET['date_from'] ?? '',
    'date_to' => $_GET['date_to'] ?? '',
    'search' => $_GET['search'] ?? ''
];

// Build query
$where = [];
$params = [];

if (!empty($filters['action'])) {
    $where[] = "al.action = ?";
    $params[] = $filters['action'];
}

if (!empty($filters['table_name'])) {
    $where[] = "al.table_name = ?";
    $params[] = $filters['table_name'];
}

if (!empty($filters['user_id'])) {
    $where[] = "al.user_id = ?";
    $params[] = $filters['user_id'];
}

if (!empty($filters['date_from'])) {
    $where[] = "DATE(al.created_at) >= ?";
    $params[] = $filters['date_from'];
}

if (!empty($filters['date_to'])) {
    $where[] = "DATE(al.created_at) <= ?";
    $params[] = $filters['date_to'];
}

if (!empty($filters['search'])) {
    $where[] = "(u.username LIKE ? OR u.first_name LIKE ? OR u.last_name LIKE ? OR al.action LIKE ?)";
    $searchTerm = '%' . $filters['search'] . '%';
    $params[] = $searchTerm;
    $params[] = $searchTerm;
    $params[] = $searchTerm;
    $params[] = $searchTerm;
}

$whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Get logs (limit to 10,000 records for performance)
$query = "
    SELECT 
        al.log_id,
        al.action,
        al.table_name,
        al.record_id,
        al.ip_address,
        al.created_at,
        u.username,
        CONCAT(u.first_name, ' ', u.last_name) as user_name,
        ur.role_name
    FROM audit_logs al
    LEFT JOIN users u ON al.user_id = u.user_id
    LEFT JOIN user_roles ur ON u.role_id = ur.role_id
    $whereClause
    ORDER BY al.created_at DESC
    LIMIT 10000
";

$logs = $db->fetchAll($query, $params);

// Log the export action
logUserAction('EXPORT_AUDIT_LOGS', 'audit_logs', null, null, [
    'filter_count' => count(array_filter($filters)),
    'records_exported' => count($logs)
]);

// Set headers for CSV download
$filename = 'audit_logs_' . date('Y-m-d_H-i-s') . '.csv';
header('Content-Type: text/csv; charset=utf-8');
header('Content-Disposition: attachment; filename="' . $filename . '"');
header('Pragma: no-cache');
header('Expires: 0');

// Create output stream
$output = fopen('php://output', 'w');

// Add BOM for Excel UTF-8 support
fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));

// CSV Headers
fputcsv($output, [
    'Log ID',
    'Date/Time',
    'Action',
    'Module/Table',
    'Record ID',
    'User',
    'Username',
    'Role',
    'IP Address'
]);

// CSV Data
foreach ($logs as $log) {
    fputcsv($output, [
        $log['log_id'],
        $log['created_at'],
        $log['action'],
        $log['table_name'] ?: 'N/A',
        $log['record_id'] ?: 'N/A',
        $log['user_name'],
        $log['username'],
        $log['role_name'],
        $log['ip_address']
    ]);
}

fclose($output);
exit();
?>