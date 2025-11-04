<?php
/**
 * View Business Details - Internal Auditor (Read-Only)
 * Display detailed information for a single business
 */

define('QUICKBILL_305', true);

require_once '../config/config.php';
require_once '../config/database.php';
require_once '../includes/functions.php';

session_start();

require_once '../includes/auth.php';
require_once '../includes/security.php';

initAuth();
initSecurity();

if (!isLoggedIn() || !isInternalAuditor()) {
    header('Location: ../auth/login.php');
    exit();
}

$currentUser = getCurrentUser();
$db = new Database();

// Get business ID
$businessId = isset($_GET['id']) ? (int)$_GET['id'] : 0;

if ($businessId === 0) {
    header('Location: view_businesses.php');
    exit();
}

// Get business details
$query = "
    SELECT 
        b.*,
        z.zone_name,
        sz.sub_zone_name,
        CONCAT(u.first_name, ' ', u.last_name) as created_by_name
    FROM businesses b
    LEFT JOIN zones z ON b.zone_id = z.zone_id
    LEFT JOIN sub_zones sz ON b.sub_zone_id = sz.sub_zone_id
    LEFT JOIN users u ON b.created_by = u.user_id
    WHERE b.business_id = ?
";
$business = $db->fetchRow($query, [$businessId]);

if (!$business) {
    header('Location: view_businesses.php');
    exit();
}

// Get bills for this business
$billsQuery = "
    SELECT * FROM bills 
    WHERE bill_type = 'Business' AND reference_id = ? 
    ORDER BY billing_year DESC, generated_at DESC
";
$bills = $db->fetchAll($billsQuery, [$businessId]);

// Get payments for this business
$paymentsQuery = "
    SELECT 
        p.*,
        b.bill_number,
        b.billing_year,
        CONCAT(u.first_name, ' ', u.last_name) as processed_by_name
    FROM payments p
    LEFT JOIN bills b ON p.bill_id = b.bill_id
    LEFT JOIN users u ON p.processed_by = u.user_id
    WHERE b.bill_type = 'Business' AND b.reference_id = ?
    ORDER BY p.payment_date DESC
";
$payments = $db->fetchAll($paymentsQuery, [$businessId]);

// Get audit logs for this business
$auditQuery = "
    SELECT 
        al.*,
        CONCAT(u.first_name, ' ', u.last_name) as user_name,
        ur.role_name
    FROM audit_logs al
    LEFT JOIN users u ON al.user_id = u.user_id
    LEFT JOIN user_roles ur ON u.role_id = ur.role_id
    WHERE al.table_name = 'businesses' AND al.record_id = ?
    ORDER BY al.created_at DESC
    LIMIT 20
";
$auditLogs = $db->fetchAll($auditQuery, [$businessId]);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Business Details - <?php echo htmlspecialchars($business['business_name']); ?></title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f8f9fa; padding: 20px; }
        .page-header { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .page-title { font-size: 24px; font-weight: bold; color: #2d3748; margin-bottom: 5px; }
        .read-only-badge { display: inline-block; background: #fff3cd; color: #856404; padding: 4px 12px; border-radius: 12px; font-size: 12px; font-weight: 600; margin-left: 10px; }
        .btn { padding: 10px 20px; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; transition: all 0.3s; text-decoration: none; display: inline-block; }
        .btn-secondary { background: #718096; color: white; }
        .card { background: white; border-radius: 10px; padding: 25px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .card-title { font-size: 18px; font-weight: bold; color: #2d3748; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #e2e8f0; }
        .info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; }
        .info-item { display: flex; flex-direction: column; }
        .info-label { font-size: 12px; font-weight: 600; color: #718096; text-transform: uppercase; margin-bottom: 5px; }
        .info-value { font-size: 14px; color: #2d3748; font-weight: 500; }
        .badge { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger { background: #f8d7da; color: #721c24; }
        .badge-info { background: #d1ecf1; color: #0c5460; }
        .table-container { overflow-x: auto; }
        .table { width: 100%; border-collapse: collapse; }
        .table th { background: #f7fafc; padding: 12px; text-align: left; font-size: 12px; font-weight: 600; color: #718096; text-transform: uppercase; border-bottom: 2px solid #e2e8f0; }
        .table td { padding: 12px; border-bottom: 1px solid #e2e8f0; font-size: 14px; color: #2d3748; }
        .table tr:hover { background: #f7fafc; }
        .map-container { width: 100%; height: 300px; background: #e2e8f0; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: #718096; }
    </style>
</head>
<body>
    <div class="page-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h1 class="page-title">
                    <?php echo htmlspecialchars($business['business_name']); ?>
                    <span class="read-only-badge">READ-ONLY VIEW</span>
                </h1>
                <p style="color: #718096; margin-top: 5px;">Account: <?php echo htmlspecialchars($business['account_number']); ?></p>
            </div>
            <a href="view_businesses.php" class="btn btn-secondary">Back to List</a>
        </div>
    </div>

    <!-- Business Information -->
    <div class="card">
        <h3 class="card-title">Business Information</h3>
        <div class="info-grid">
            <div class="info-item">
                <span class="info-label">Account Number</span>
                <span class="info-value"><?php echo htmlspecialchars($business['account_number']); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Business Name</span>
                <span class="info-value"><?php echo htmlspecialchars($business['business_name']); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Owner Name</span>
                <span class="info-value"><?php echo htmlspecialchars($business['owner_name']); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Telephone</span>
                <span class="info-value"><?php echo htmlspecialchars($business['telephone'] ?: 'N/A'); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Business Type</span>
                <span class="info-value"><?php echo htmlspecialchars($business['business_type']); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Category</span>
                <span class="info-value"><?php echo htmlspecialchars($business['category']); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Zone</span>
                <span class="info-value"><?php echo htmlspecialchars($business['zone_name'] ?? 'N/A'); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Sub-Zone</span>
                <span class="info-value"><?php echo htmlspecialchars($business['sub_zone_name'] ?? 'N/A'); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Status</span>
                <span class="info-value">
                    <span class="badge badge-<?php echo $business['status'] === 'Active' ? 'success' : 'warning'; ?>">
                        <?php echo htmlspecialchars($business['status']); ?>
                    </span>
                </span>
            </div>
            <div class="info-item">
                <span class="info-label">Created By</span>
                <span class="info-value"><?php echo htmlspecialchars($business['created_by_name'] ?? 'N/A'); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Created At</span>
                <span class="info-value"><?php echo date('Y-m-d H:i', strtotime($business['created_at'])); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Last Updated</span>
                <span class="info-value"><?php echo date('Y-m-d H:i', strtotime($business['updated_at'])); ?></span>
            </div>
        </div>
    </div>

    <!-- Financial Summary -->
    <div class="card">
        <h3 class="card-title">Financial Summary</h3>
        <div class="info-grid">
            <div class="info-item">
                <span class="info-label">Old Bill</span>
                <span class="info-value">₵ <?php echo number_format($business['old_bill'], 2); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Previous Payments</span>
                <span class="info-value">₵ <?php echo number_format($business['previous_payments'], 2); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Arrears</span>
                <span class="info-value">₵ <?php echo number_format($business['arrears'], 2); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Current Bill</span>
                <span class="info-value">₵ <?php echo number_format($business['current_bill'], 2); ?></span>
            </div>
            <div class="info-item">
                <span class="info-label">Amount Payable</span>
                <span class="info-value" style="font-size: 18px; color: #e74c3c; font-weight: bold;">
                    ₵ <?php echo number_format($business['amount_payable'], 2); ?>
                </span>
            </div>
        </div>
    </div>

    <!-- Location -->
    <?php if ($business['latitude'] && $business['longitude']): ?>
    <div class="card">
        <h3 class="card-title">Location</h3>
        <div class="info-item" style="margin-bottom: 15px;">
            <span class="info-label">Exact Location</span>
            <span class="info-value"><?php echo htmlspecialchars($business['exact_location'] ?: 'N/A'); ?></span>
        </div>
        <div class="info-item" style="margin-bottom: 15px;">
            <span class="info-label">Coordinates</span>
            <span class="info-value">
                Lat: <?php echo htmlspecialchars($business['latitude']); ?>, 
                Long: <?php echo htmlspecialchars($business['longitude']); ?>
            </span>
        </div>
        <div class="map-container">
            Map View (Coordinates: <?php echo $business['latitude']; ?>, <?php echo $business['longitude']; ?>)
        </div>
    </div>
    <?php endif; ?>

    <!-- Bills History -->
    <div class="card">
        <h3 class="card-title">Bills History (<?php echo count($bills); ?>)</h3>
        <?php if (!empty($bills)): ?>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Bill Number</th>
                        <th>Year</th>
                        <th>Current Bill</th>
                        <th>Amount Payable</th>
                        <th>Status</th>
                        <th>Generated</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($bills as $bill): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($bill['bill_number']); ?></td>
                        <td><?php echo htmlspecialchars($bill['billing_year']); ?></td>
                        <td>₵ <?php echo number_format($bill['current_bill'], 2); ?></td>
                        <td>₵ <?php echo number_format($bill['amount_payable'], 2); ?></td>
                        <td>
                            <span class="badge badge-<?php 
                                echo $bill['status'] === 'Paid' ? 'success' : 
                                    ($bill['status'] === 'Partially Paid' ? 'info' : 'warning'); 
                            ?>">
                                <?php echo htmlspecialchars($bill['status']); ?>
                            </span>
                        </td>
                        <td><?php echo date('Y-m-d', strtotime($bill['generated_at'])); ?></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php else: ?>
        <p style="text-align: center; color: #718096; padding: 40px;">No bills generated yet.</p>
        <?php endif; ?>
    </div>

    <!-- Payment History -->
    <div class="card">
        <h3 class="card-title">Payment History (<?php echo count($payments); ?>)</h3>
        <?php if (!empty($payments)): ?>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Payment Reference</th>
                        <th>Date</th>
                        <th>Bill Number</th>
                        <th>Amount</th>
                        <th>Method</th>
                        <th>Status</th>
                        <th>Processed By</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($payments as $payment): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($payment['payment_reference']); ?></td>
                        <td><?php echo date('Y-m-d H:i', strtotime($payment['payment_date'])); ?></td>
                        <td><?php echo htmlspecialchars($payment['bill_number']); ?></td>
                        <td>₵ <?php echo number_format($payment['amount_paid'], 2); ?></td>
                        <td><?php echo htmlspecialchars($payment['payment_method']); ?></td>
                        <td>
                            <span class="badge badge-<?php echo $payment['payment_status'] === 'Successful' ? 'success' : 'warning'; ?>">
                                <?php echo htmlspecialchars($payment['payment_status']); ?>
                            </span>
                        </td>
                        <td><?php echo htmlspecialchars($payment['processed_by_name'] ?? 'System'); ?></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php else: ?>
        <p style="text-align: center; color: #718096; padding: 40px;">No payment records found.</p>
        <?php endif; ?>
    </div>

    <!-- Audit Trail -->
    <div class="card">
        <h3 class="card-title">Recent Audit Trail (Last 20 Activities)</h3>
        <?php if (!empty($auditLogs)): ?>
        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>Date/Time</th>
                        <th>Action</th>
                        <th>User</th>
                        <th>Role</th>
                        <th>IP Address</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($auditLogs as $log): ?>
                    <tr>
                        <td><?php echo date('Y-m-d H:i:s', strtotime($log['created_at'])); ?></td>
                        <td><span class="badge badge-info"><?php echo htmlspecialchars($log['action']); ?></span></td>
                        <td><?php echo htmlspecialchars($log['user_name'] ?? 'System'); ?></td>
                        <td><?php echo htmlspecialchars($log['role_name'] ?? 'N/A'); ?></td>
                        <td><?php echo htmlspecialchars($log['ip_address'] ?? 'N/A'); ?></td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php else: ?>
        <p style="text-align: center; color: #718096; padding: 40px;">No audit trail found.</p>
        <?php endif; ?>
    </div>
</body>
</html>