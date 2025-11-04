<?php
/**
 * View Payments - Internal Auditor (Read-Only)
 * Display all payment transactions with filtering - NO edit/delete capabilities
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

// Pagination
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 50;
$offset = ($page - 1) * $perPage;

// Filters
$search = $_GET['search'] ?? '';
$paymentMethod = $_GET['payment_method'] ?? '';
$paymentStatus = $_GET['payment_status'] ?? '';
$dateFrom = $_GET['date_from'] ?? '';
$dateTo = $_GET['date_to'] ?? '';

// Build query
$where = [];
$params = [];

if (!empty($search)) {
    $where[] = "(p.payment_reference LIKE ? OR b.bill_number LIKE ?)";
    $searchTerm = '%' . $search . '%';
    $params[] = $searchTerm;
    $params[] = $searchTerm;
}

if (!empty($paymentMethod)) {
    $where[] = "p.payment_method = ?";
    $params[] = $paymentMethod;
}

if (!empty($paymentStatus)) {
    $where[] = "p.payment_status = ?";
    $params[] = $paymentStatus;
}

if (!empty($dateFrom)) {
    $where[] = "DATE(p.payment_date) >= ?";
    $params[] = $dateFrom;
}

if (!empty($dateTo)) {
    $where[] = "DATE(p.payment_date) <= ?";
    $params[] = $dateTo;
}

$whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Get total count
$countQuery = "
    SELECT COUNT(*) as total 
    FROM payments p
    LEFT JOIN bills b ON p.bill_id = b.bill_id
    $whereClause
";
$totalResult = $db->fetchRow($countQuery, $params);
$totalRecords = $totalResult['total'];
$totalPages = ceil($totalRecords / $perPage);

// Get payments
$query = "
    SELECT 
        p.*,
        b.bill_number,
        b.bill_type,
        CASE 
            WHEN b.bill_type = 'Business' THEN bs.business_name
            WHEN b.bill_type = 'Property' THEN pr.owner_name
        END as payer_name,
        CASE 
            WHEN b.bill_type = 'Business' THEN bs.account_number
            WHEN b.bill_type = 'Property' THEN pr.property_number
        END as account_number,
        CONCAT(u.first_name, ' ', u.last_name) as processed_by_name
    FROM payments p
    LEFT JOIN bills b ON p.bill_id = b.bill_id
    LEFT JOIN businesses bs ON b.bill_type = 'Business' AND b.reference_id = bs.business_id
    LEFT JOIN properties pr ON b.bill_type = 'Property' AND b.reference_id = pr.property_id
    LEFT JOIN users u ON p.processed_by = u.user_id
    $whereClause
    ORDER BY p.payment_date DESC
    LIMIT ? OFFSET ?
";
$params[] = $perPage;
$params[] = $offset;
$payments = $db->fetchAll($query, $params);

// Calculate statistics
$statsQuery = "
    SELECT 
        COUNT(*) as total_count,
        SUM(CASE WHEN payment_status = 'Successful' THEN amount_paid ELSE 0 END) as total_successful,
        SUM(CASE WHEN payment_status = 'Successful' AND DATE(payment_date) = CURDATE() THEN amount_paid ELSE 0 END) as today_total,
        COUNT(CASE WHEN payment_status = 'Successful' AND DATE(payment_date) = CURDATE() THEN 1 END) as today_count
    FROM payments
";
$stats = $db->fetchRow($statsQuery);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Payments - Internal Auditor</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f8f9fa; padding: 20px; }
        .page-header { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .page-title { font-size: 24px; font-weight: bold; color: #2d3748; margin-bottom: 5px; }
        .read-only-badge { display: inline-block; background: #fff3cd; color: #856404; padding: 4px 12px; border-radius: 12px; font-size: 12px; font-weight: 600; margin-left: 10px; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-bottom: 20px; }
        .stat-card { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .stat-value { font-size: 32px; font-weight: bold; color: #2d3748; }
        .stat-label { font-size: 12px; color: #718096; text-transform: uppercase; margin-top: 5px; }
        .filters-section { background: white; padding: 20px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .filter-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 15px; }
        .form-group { display: flex; flex-direction: column; }
        .form-label { font-size: 12px; font-weight: 600; color: #718096; margin-bottom: 5px; text-transform: uppercase; }
        .form-control { padding: 10px; border: 1px solid #e2e8f0; border-radius: 6px; font-size: 14px; }
        .btn { padding: 10px 20px; border: none; border-radius: 6px; cursor: pointer; font-weight: 600; transition: all 0.3s; text-decoration: none; display: inline-block; }
        .btn-primary { background: #3498db; color: white; }
        .btn-secondary { background: #718096; color: white; }
        .table-container { background: white; border-radius: 10px; overflow-x: auto; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .table { width: 100%; border-collapse: collapse; }
        .table th { background: #f7fafc; padding: 12px; text-align: left; font-size: 12px; font-weight: 600; color: #718096; text-transform: uppercase; border-bottom: 2px solid #e2e8f0; white-space: nowrap; }
        .table td { padding: 12px; border-bottom: 1px solid #e2e8f0; font-size: 14px; color: #2d3748; }
        .table tr:hover { background: #f7fafc; }
        .badge { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
        .badge-success { background: #d4edda; color: #155724; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger { background: #f8d7da; color: #721c24; }
        .badge-info { background: #d1ecf1; color: #0c5460; }
        .action-link { color: #3498db; text-decoration: none; font-weight: 500; }
        .action-link:hover { text-decoration: underline; }
        .pagination { display: flex; justify-content: center; align-items: center; gap: 10px; padding: 20px; background: white; border-radius: 10px; margin-top: 20px; }
        .pagination a, .pagination span { padding: 8px 12px; border: 1px solid #e2e8f0; border-radius: 6px; text-decoration: none; color: #2d3748; }
        .pagination .active { background: #3498db; color: white; border-color: #3498db; }
        .info-banner { background: #fff3cd; border-left: 4px solid #f39c12; padding: 15px; border-radius: 6px; margin-bottom: 20px; }
        .info-banner-text { color: #856404; font-weight: 500; }
    </style>
</head>
<body>
    <div class="page-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h1 class="page-title">
                    Payment Transactions 
                    <span class="read-only-badge">READ-ONLY VIEW</span>
                </h1>
                <p style="color: #718096; margin-top: 5px;">View all payment records - No edit/delete rights</p>
            </div>
            <a href="index.php" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
    
    <div class="info-banner">
        <div class="info-banner-text">
            As an Internal Auditor, you can view all payment transactions but cannot create, edit, or delete records.
        </div>
    </div>
    
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['total_count']); ?></div>
            <div class="stat-label">Total Payments</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">₵ <?php echo number_format($stats['total_successful'], 2); ?></div>
            <div class="stat-label">Total Successful</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['today_count']); ?></div>
            <div class="stat-label">Today's Count</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">₵ <?php echo number_format($stats['today_total'], 2); ?></div>
            <div class="stat-label">Today's Total</div>
        </div>
    </div>
    
    <div class="filters-section">
        <form method="GET" action="">
            <div class="filter-grid">
                <div class="form-group">
                    <label class="form-label">Search</label>
                    <input type="text" name="search" class="form-control" placeholder="Reference, bill number..." value="<?php echo htmlspecialchars($search); ?>">
                </div>
                <div class="form-group">
                    <label class="form-label">Payment Method</label>
                    <select name="payment_method" class="form-control">
                        <option value="">All Methods</option>
                        <option value="Cash" <?php echo $paymentMethod === 'Cash' ? 'selected' : ''; ?>>Cash</option>
                        <option value="Mobile Money" <?php echo $paymentMethod === 'Mobile Money' ? 'selected' : ''; ?>>Mobile Money</option>
                        <option value="Bank Transfer" <?php echo $paymentMethod === 'Bank Transfer' ? 'selected' : ''; ?>>Bank Transfer</option>
                        <option value="Online" <?php echo $paymentMethod === 'Online' ? 'selected' : ''; ?>>Online</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Status</label>
                    <select name="payment_status" class="form-control">
                        <option value="">All Status</option>
                        <option value="Successful" <?php echo $paymentStatus === 'Successful' ? 'selected' : ''; ?>>Successful</option>
                        <option value="Pending" <?php echo $paymentStatus === 'Pending' ? 'selected' : ''; ?>>Pending</option>
                        <option value="Failed" <?php echo $paymentStatus === 'Failed' ? 'selected' : ''; ?>>Failed</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Date From</label>
                    <input type="date" name="date_from" class="form-control" value="<?php echo htmlspecialchars($dateFrom); ?>">
                </div>
                <div class="form-group">
                    <label class="form-label">Date To</label>
                    <input type="date" name="date_to" class="form-control" value="<?php echo htmlspecialchars($dateTo); ?>">
                </div>
                <div class="form-group" style="justify-content: flex-end;">
                    <label class="form-label">&nbsp;</label>
                    <div style="display: flex; gap: 10px;">
                        <button type="submit" class="btn btn-primary">Apply</button>
                        <a href="view_payments.php" class="btn btn-secondary">Clear</a>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <div style="background: white; padding: 15px; border-radius: 10px; margin-bottom: 20px;">
        <p style="margin: 0; color: #2d3748;">
            Showing <strong><?php echo number_format($offset + 1); ?></strong> to 
            <strong><?php echo number_format(min($offset + $perPage, $totalRecords)); ?></strong> of 
            <strong><?php echo number_format($totalRecords); ?></strong> payments
        </p>
    </div>
    
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th>Payment Ref</th>
                    <th>Date</th>
                    <th>Bill Number</th>
                    <th>Payer</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Status</th>
                    <th>Processed By</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($payments)): ?>
                    <?php foreach ($payments as $payment): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($payment['payment_reference']); ?></td>
                        <td><?php echo date('Y-m-d H:i', strtotime($payment['payment_date'])); ?></td>
                        <td><?php echo htmlspecialchars($payment['bill_number']); ?></td>
                        <td><?php echo htmlspecialchars($payment['payer_name'] ?? 'N/A'); ?></td>
                        <td>₵ <?php echo number_format($payment['amount_paid'], 2); ?></td>
                        <td><span class="badge badge-info"><?php echo htmlspecialchars($payment['payment_method']); ?></span></td>
                        <td>
                            <span class="badge badge-<?php 
                                echo $payment['payment_status'] === 'Successful' ? 'success' : 
                                    ($payment['payment_status'] === 'Pending' ? 'warning' : 'danger'); 
                            ?>">
                                <?php echo htmlspecialchars($payment['payment_status']); ?>
                            </span>
                        </td>
                        <td><?php echo htmlspecialchars($payment['processed_by_name'] ?? 'System'); ?></td>
                    </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 40px; color: #718096;">
                            No payment records found matching your criteria.
                        </td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
    
    <?php if ($totalPages > 1): ?>
    <div class="pagination">
        <?php if ($page > 1): ?>
            <a href="?page=<?php echo ($page - 1); ?>&search=<?php echo urlencode($search); ?>&payment_method=<?php echo urlencode($paymentMethod); ?>&payment_status=<?php echo urlencode($paymentStatus); ?>&date_from=<?php echo urlencode($dateFrom); ?>&date_to=<?php echo urlencode($dateTo); ?>">Previous</a>
        <?php endif; ?>
        
        <?php
        $startPage = max(1, $page - 2);
        $endPage = min($totalPages, $page + 2);
        for ($i = $startPage; $i <= $endPage; $i++):
        ?>
            <?php if ($i == $page): ?>
                <span class="active"><?php echo $i; ?></span>
            <?php else: ?>
                <a href="?page=<?php echo $i; ?>&search=<?php echo urlencode($search); ?>&payment_method=<?php echo urlencode($paymentMethod); ?>&payment_status=<?php echo urlencode($paymentStatus); ?>&date_from=<?php echo urlencode($dateFrom); ?>&date_to=<?php echo urlencode($dateTo); ?>"><?php echo $i; ?></a>
            <?php endif; ?>
        <?php endfor; ?>
        
        <?php if ($page < $totalPages): ?>
            <a href="?page=<?php echo ($page + 1); ?>&search=<?php echo urlencode($search); ?>&payment_method=<?php echo urlencode($paymentMethod); ?>&payment_status=<?php echo urlencode($paymentStatus); ?>&date_from=<?php echo urlencode($dateFrom); ?>&date_to=<?php echo urlencode($dateTo); ?>">Next</a>
        <?php endif; ?>
    </div>
    <?php endif; ?>
</body>
</html>