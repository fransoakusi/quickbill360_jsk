<?php
/**
 * View Bills - Internal Auditor (Read-Only)
 * Display all bills with filtering - NO edit/delete capabilities
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
$billType = $_GET['bill_type'] ?? '';
$billStatus = $_GET['status'] ?? '';
$billingYear = $_GET['billing_year'] ?? '';

// Build query
$where = [];
$params = [];

if (!empty($search)) {
    $where[] = "(b.bill_number LIKE ?)";
    $searchTerm = '%' . $search . '%';
    $params[] = $searchTerm;
}

if (!empty($billType)) {
    $where[] = "b.bill_type = ?";
    $params[] = $billType;
}

if (!empty($billStatus)) {
    $where[] = "b.status = ?";
    $params[] = $billStatus;
}

if (!empty($billingYear)) {
    $where[] = "b.billing_year = ?";
    $params[] = $billingYear;
}

$whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Get total count
$countQuery = "SELECT COUNT(*) as total FROM bills b $whereClause";
$totalResult = $db->fetchRow($countQuery, $params);
$totalRecords = $totalResult['total'];
$totalPages = ceil($totalRecords / $perPage);

// Get bills
$query = "
    SELECT 
        b.*,
        CASE 
            WHEN b.bill_type = 'Business' THEN bs.business_name
            WHEN b.bill_type = 'Property' THEN pr.owner_name
        END as account_name,
        CASE 
            WHEN b.bill_type = 'Business' THEN bs.account_number
            WHEN b.bill_type = 'Property' THEN pr.property_number
        END as account_number,
        CONCAT(u.first_name, ' ', u.last_name) as generated_by_name
    FROM bills b
    LEFT JOIN businesses bs ON b.bill_type = 'Business' AND b.reference_id = bs.business_id
    LEFT JOIN properties pr ON b.bill_type = 'Property' AND b.reference_id = pr.property_id
    LEFT JOIN users u ON b.generated_by = u.user_id
    $whereClause
    ORDER BY b.generated_at DESC
    LIMIT ? OFFSET ?
";
$params[] = $perPage;
$params[] = $offset;
$bills = $db->fetchAll($query, $params);

// Get unique billing years for filter
$years = $db->fetchAll("SELECT DISTINCT billing_year FROM bills ORDER BY billing_year DESC");

// Calculate statistics
$statsQuery = "
    SELECT 
        COUNT(*) as total_count,
        SUM(current_bill) as total_billed,
        SUM(amount_payable) as total_outstanding,
        COUNT(CASE WHEN status = 'Pending' THEN 1 END) as pending_count,
        COUNT(CASE WHEN status = 'Paid' THEN 1 END) as paid_count
    FROM bills
";
$stats = $db->fetchRow($statsQuery);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Bills - Internal Auditor</title>
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
                    Bills 
                    <span class="read-only-badge">READ-ONLY VIEW</span>
                </h1>
                <p style="color: #718096; margin-top: 5px;">View all generated bills - No edit/delete rights</p>
            </div>
            <a href="index.php" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
    
    <div class="info-banner">
        <div class="info-banner-text">
            As an Internal Auditor, you can view all bills but cannot create, edit, or delete records.
        </div>
    </div>
    
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['total_count']); ?></div>
            <div class="stat-label">Total Bills</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">₵ <?php echo number_format($stats['total_billed'], 2); ?></div>
            <div class="stat-label">Total Billed</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">₵ <?php echo number_format($stats['total_outstanding'], 2); ?></div>
            <div class="stat-label">Outstanding</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['paid_count']); ?></div>
            <div class="stat-label">Paid Bills</div>
        </div>
    </div>
    
    <div class="filters-section">
        <form method="GET" action="">
            <div class="filter-grid">
                <div class="form-group">
                    <label class="form-label">Search Bill</label>
                    <input type="text" name="search" class="form-control" placeholder="Bill number..." value="<?php echo htmlspecialchars($search); ?>">
                </div>
                <div class="form-group">
                    <label class="form-label">Bill Type</label>
                    <select name="bill_type" class="form-control">
                        <option value="">All Types</option>
                        <option value="Business" <?php echo $billType === 'Business' ? 'selected' : ''; ?>>Business</option>
                        <option value="Property" <?php echo $billType === 'Property' ? 'selected' : ''; ?>>Property</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-control">
                        <option value="">All Status</option>
                        <option value="Pending" <?php echo $billStatus === 'Pending' ? 'selected' : ''; ?>>Pending</option>
                        <option value="Paid" <?php echo $billStatus === 'Paid' ? 'selected' : ''; ?>>Paid</option>
                        <option value="Partially Paid" <?php echo $billStatus === 'Partially Paid' ? 'selected' : ''; ?>>Partially Paid</option>
                        <option value="Overdue" <?php echo $billStatus === 'Overdue' ? 'selected' : ''; ?>>Overdue</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Billing Year</label>
                    <select name="billing_year" class="form-control">
                        <option value="">All Years</option>
                        <?php foreach ($years as $year): ?>
                        <option value="<?php echo $year['billing_year']; ?>" <?php echo $billingYear == $year['billing_year'] ? 'selected' : ''; ?>>
                            <?php echo $year['billing_year']; ?>
                        </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group" style="justify-content: flex-end;">
                    <label class="form-label">&nbsp;</label>
                    <div style="display: flex; gap: 10px;">
                        <button type="submit" class="btn btn-primary">Apply</button>
                        <a href="view_bills.php" class="btn btn-secondary">Clear</a>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <div style="background: white; padding: 15px; border-radius: 10px; margin-bottom: 20px;">
        <p style="margin: 0; color: #2d3748;">
            Showing <strong><?php echo number_format($offset + 1); ?></strong> to 
            <strong><?php echo number_format(min($offset + $perPage, $totalRecords)); ?></strong> of 
            <strong><?php echo number_format($totalRecords); ?></strong> bills
        </p>
    </div>
    
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th>Bill Number</th>
                    <th>Type</th>
                    <th>Account</th>
                    <th>Year</th>
                    <th>Current Bill</th>
                    <th>Amount Payable</th>
                    <th>Status</th>
                    <th>Generated</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($bills)): ?>
                    <?php foreach ($bills as $bill): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($bill['bill_number']); ?></td>
                        <td><span class="badge badge-info"><?php echo htmlspecialchars($bill['bill_type']); ?></span></td>
                        <td><?php echo htmlspecialchars($bill['account_name'] ?? 'N/A'); ?></td>
                        <td><?php echo htmlspecialchars($bill['billing_year']); ?></td>
                        <td>₵ <?php echo number_format($bill['current_bill'], 2); ?></td>
                        <td>₵ <?php echo number_format($bill['amount_payable'], 2); ?></td>
                        <td>
                            <span class="badge badge-<?php 
                                echo $bill['status'] === 'Paid' ? 'success' : 
                                    ($bill['status'] === 'Partially Paid' ? 'info' : 
                                    ($bill['status'] === 'Overdue' ? 'danger' : 'warning')); 
                            ?>">
                                <?php echo htmlspecialchars($bill['status']); ?>
                            </span>
                        </td>
                        <td><?php echo date('Y-m-d', strtotime($bill['generated_at'])); ?></td>
                    </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 40px; color: #718096;">
                            No bills found matching your criteria.
                        </td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
    
    <?php if ($totalPages > 1): ?>
    <div class="pagination">
        <?php if ($page > 1): ?>
            <a href="?page=<?php echo ($page - 1); ?>&search=<?php echo urlencode($search); ?>&bill_type=<?php echo urlencode($billType); ?>&status=<?php echo urlencode($billStatus); ?>&billing_year=<?php echo urlencode($billingYear); ?>">Previous</a>
        <?php endif; ?>
        
        <?php
        $startPage = max(1, $page - 2);
        $endPage = min($totalPages, $page + 2);
        for ($i = $startPage; $i <= $endPage; $i++):
        ?>
            <?php if ($i == $page): ?>
                <span class="active"><?php echo $i; ?></span>
            <?php else: ?>
                <a href="?page=<?php echo $i; ?>&search=<?php echo urlencode($search); ?>&bill_type=<?php echo urlencode($billType); ?>&status=<?php echo urlencode($billStatus); ?>&billing_year=<?php echo urlencode($billingYear); ?>"><?php echo $i; ?></a>
            <?php endif; ?>
        <?php endfor; ?>
        
        <?php if ($page < $totalPages): ?>
            <a href="?page=<?php echo ($page + 1); ?>&search=<?php echo urlencode($search); ?>&bill_type=<?php echo urlencode($billType); ?>&status=<?php echo urlencode($billStatus); ?>&billing_year=<?php echo urlencode($billingYear); ?>">Next</a>
        <?php endif; ?>
    </div>
    <?php endif; ?>
</body>
</html>