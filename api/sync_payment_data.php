<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");

require_once '../config/database.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    
    $account_number = $_GET['account_number'] ?? null;
    $record_type = $_GET['record_type'] ?? null;
    
    if (!$account_number || !$record_type) {
        http_response_code(400);
        echo json_encode(["error" => "Account number and record type required"]);
        exit();
    }
    
    // Get current balance and bill information
    $balance_query = "CALL GetAccountBalance(?, ?)";
    $stmt = $db->prepare($balance_query);
    $stmt->execute([$account_number, $record_type]);
    $balance_info = $stmt->fetch(PDO::FETCH_ASSOC);
    
    // Get recent payments (last 10)
    $payments_query = "
        SELECT 
            payment_id,
            amount,
            payment_method,
            payment_source,
            paystack_reference,
            paid_at
        FROM payments 
        WHERE account_number = ? 
        AND record_type = ?
        AND payment_status = 'successful'
        ORDER BY paid_at DESC 
        LIMIT 10
    ";
    
    $payments_stmt = $db->prepare($payments_query);
    $payments_stmt->execute([$account_number, $record_type]);
    $recent_payments = $payments_stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Get payment summary
    $summary_query = "
        SELECT 
            COUNT(*) as total_payments,
            SUM(amount) as total_paid,
            MAX(paid_at) as last_payment_date,
            SUM(CASE WHEN payment_source = 'mobile_app' THEN amount ELSE 0 END) as app_payments,
            SUM(CASE WHEN payment_source = 'web_portal' THEN amount ELSE 0 END) as web_payments
        FROM payments 
        WHERE account_number = ? 
        AND record_type = ?
        AND payment_status = 'successful'
    ";
    
    $summary_stmt = $db->prepare($summary_query);
    $summary_stmt->execute([$account_number, $record_type]);
    $payment_summary = $summary_stmt->fetch(PDO::FETCH_ASSOC);
    
    echo json_encode([
        "success" => true,
        "account_number" => $account_number,
        "record_type" => $record_type,
        "balance_info" => $balance_info,
        "recent_payments" => $recent_payments,
        "payment_summary" => $payment_summary,
        "sync_timestamp" => date('Y-m-d H:i:s')
    ]);
    
} catch (Exception $e) {
    error_log("Sync payment data error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        "error" => "Server error",
        "message" => "Internal server error"
    ]);
}
?>