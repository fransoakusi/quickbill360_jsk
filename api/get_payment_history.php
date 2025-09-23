<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once '../config/database.php';
require_once '../config/paystack.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["error" => "Method not allowed"]);
    exit();
}

try {
    $database = new Database();
    $db = $database->getConnection();
    
    $input = json_decode(file_get_contents("php://input"), true);
    
    // Validate required fields
    $required_fields = ['paystack_reference', 'account_number', 'record_type', 'amount', 'user_phone', 'customer_email'];
    foreach ($required_fields as $field) {
        if (!isset($input[$field]) || empty($input[$field])) {
            http_response_code(400);
            echo json_encode(["error" => "Missing required field: $field"]);
            exit();
        }
    }
    
    $paystack_reference = $input['paystack_reference'];
    $account_number = $input['account_number'];
    $record_type = $input['record_type'];
    $amount = floatval($input['amount']);
    $user_phone = $input['user_phone'];
    $customer_email = $input['customer_email'];
    $payment_method = $input['payment_method'] ?? 'unknown';
    
    // Find the bill_id for this account
    if ($record_type === 'business') {
        $bill_query = $db->prepare("
            SELECT b.id as bill_id, bs.business_name, bs.owner_name 
            FROM bills b 
            JOIN businesses bs ON b.account_number = bs.account_number 
            WHERE b.account_number = ? AND b.status = 'active'
            ORDER BY b.created_at DESC LIMIT 1
        ");
    } else {
        $bill_query = $db->prepare("
            SELECT b.id as bill_id, p.property_name as business_name, p.property_owner as owner_name 
            FROM bills b 
            JOIN properties p ON b.account_number = p.property_number 
            WHERE b.account_number = ? AND b.status = 'active'
            ORDER BY b.created_at DESC LIMIT 1
        ");
    }
    
    $bill_query->execute([$account_number]);
    $bill_info = $bill_query->fetch(PDO::FETCH_ASSOC);
    
    if (!$bill_info) {
        http_response_code(404);
        echo json_encode([
            "error" => "No active bill found for account",
            "account_number" => $account_number,
            "record_type" => $record_type
        ]);
        exit();
    }
    
    $bill_id = $bill_info['bill_id'];
    $business_name = $bill_info['business_name'];
    $owner_name = $bill_info['owner_name'];
    
    // Verify payment with Paystack
    $paystack_response = PaystackConfig::verifyPayment($paystack_reference);
    
    if (!$paystack_response || !$paystack_response['status']) {
        http_response_code(400);
        echo json_encode([
            "error" => "Payment verification failed",
            "message" => $paystack_response['message'] ?? "Invalid transaction reference"
        ]);
        exit();
    }
    
    $payment_data = $paystack_response['data'];
    
    if ($payment_data['status'] !== 'success') {
        http_response_code(400);
        echo json_encode([
            "error" => "Payment not successful",
            "status" => $payment_data['status'],
            "message" => $payment_data['gateway_response'] ?? "Payment failed"
        ]);
        exit();
    }
    
    // Check if payment already processed
    $check_payment = $db->prepare("SELECT payment_id FROM payments WHERE paystack_reference = ?");
    $check_payment->execute([$paystack_reference]);
    
    if ($check_payment->rowCount() > 0) {
        http_response_code(409);
        echo json_encode([
            "error" => "Payment already processed",
            "reference" => $paystack_reference
        ]);
        exit();
    }
    
    // Verify amount matches
    $paystack_amount = $payment_data['amount'] / 100;
    if (abs($paystack_amount - $amount) > 0.01) {
        http_response_code(400);
        echo json_encode([
            "error" => "Amount mismatch",
            "expected" => $amount,
            "received" => $paystack_amount
        ]);
        exit();
    }
    
    // Generate payment reference
    $payment_reference = 'PAY_' . time() . '_' . rand(1000, 9999);
    
    // Start transaction
    $db->beginTransaction();
    
    try {
        // Insert payment using existing table structure
        $insert_payment = $db->prepare("
            INSERT INTO payments (
                payment_reference,
                bill_id,
                amount_paid,
                payment_method,
                payment_channel,
                paystack_reference,
                payment_status,
                payment_date,
                processed_by,
                notes
            ) VALUES (?, ?, ?, ?, ?, ?, 'successful', NOW(), 'mobile_app', ?)
        ");
        
        $notes = "Mobile app payment - User: $user_phone, Business: $business_name, Owner: $owner_name";
        
        $insert_payment->execute([
            $payment_reference,
            $bill_id,
            $amount,
            $payment_method,
            $payment_data['channel'] ?? 'mobile_money',
            $paystack_reference,
            $notes
        ]);
        
        $payment_id = $db->lastInsertId();
        
        // Update business/property balances
        if ($record_type === 'business') {
            $update_balance = $db->prepare("
                UPDATE businesses 
                SET 
                    previous_payments = previous_payments + ?,
                    amount_payable = GREATEST(0, amount_payable - ?)
                WHERE account_number = ?
            ");
        } else {
            $update_balance = $db->prepare("
                UPDATE properties 
                SET 
                    previous_payments = previous_payments + ?,
                    amount_payable = GREATEST(0, amount_payable - ?)
                WHERE property_number = ?
            ");
        }
        
        $update_balance->execute([$amount, $amount, $account_number]);
        
        $db->commit();
        
        echo json_encode([
            "success" => true,
            "message" => "Payment processed successfully",
            "payment_id" => $payment_id,
            "payment_reference" => $payment_reference,
            "paystack_reference" => $paystack_reference,
            "business_name" => $business_name,
            "account_number" => $account_number,
            "record_type" => $record_type,
            "amount_paid" => $amount,
            "payment_date" => date('Y-m-d H:i:s')
        ]);
        
    } catch (Exception $e) {
        $db->rollBack();
        error_log("Payment processing error: " . $e->getMessage());
        http_response_code(500);
        echo json_encode([
            "error" => "Payment processing failed",
            "message" => "Internal server error"
        ]);
    }
    
} catch (Exception $e) {
    error_log("Payment API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        "error" => "Server error",
        "message" => "Internal server error"
    ]);
}
?>