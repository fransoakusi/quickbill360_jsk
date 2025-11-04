<?php
/**
 * Get Audit Log Details - AJAX Endpoint
 * Returns detailed information about a specific audit log
 */

define('QUICKBILL_305', true);

require_once '../../config/config.php';
require_once '../../config/database.php';
require_once '../../includes/functions.php';

session_start();

require_once '../../includes/auth.php';

header('Content-Type: application/json');

if (!isLoggedIn() || !isInternalAuditor()) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit();
}

$logId = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($logId <= 0) {
    echo json_encode(['success' => false, 'message' => 'Invalid log ID']);
    exit();
}

try {
    $db = new Database();
    
    $query = "
        SELECT 
            al.*,
            u.username,
            CONCAT(u.first_name, ' ', u.last_name) as user_name,
            ur.role_name
        FROM audit_logs al
        LEFT JOIN users u ON al.user_id = u.user_id
        LEFT JOIN user_roles ur ON u.role_id = ur.role_id
        WHERE al.log_id = ?
    ";
    
    $log = $db->fetchRow($query, [$logId]);
    
    if (!$log) {
        echo json_encode(['success' => false, 'message' => 'Log not found']);
        exit();
    }
    
    // Format timestamp
    $log['created_at'] = formatDateTime($log['created_at']);
    
    echo json_encode([
        'success' => true,
        'log' => $log
    ]);
    
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
}
?>