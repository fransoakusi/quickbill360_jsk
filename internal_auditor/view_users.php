<?php
/**
 * View Users - Internal Auditor (Read-Only)
 * Display all system users with filtering - NO edit/delete capabilities
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
$roleFilter = $_GET['role'] ?? '';
$statusFilter = $_GET['is_active'] ?? '';

// Build query
$where = [];
$params = [];

if (!empty($search)) {
    $where[] = "(u.username LIKE ? OR u.first_name LIKE ? OR u.last_name LIKE ? OR u.email LIKE ?)";
    $searchTerm = '%' . $search . '%';
    $params[] = $searchTerm;
    $params[] = $searchTerm;
    $params[] = $searchTerm;
    $params[] = $searchTerm;
}

if (!empty($roleFilter)) {
    $where[] = "u.role_id = ?";
    $params[] = $roleFilter;
}

if ($statusFilter !== '') {
    $where[] = "u.is_active = ?";
    $params[] = $statusFilter;
}

$whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Get total count
$countQuery = "SELECT COUNT(*) as total FROM users u $whereClause";
$totalResult = $db->fetchRow($countQuery, $params);
$totalRecords = $totalResult['total'];
$totalPages = ceil($totalRecords / $perPage);

// Get users
$query = "
    SELECT 
        u.*,
        ur.role_name
    FROM users u
    LEFT JOIN user_roles ur ON u.role_id = ur.role_id
    $whereClause
    ORDER BY u.created_at DESC
    LIMIT ? OFFSET ?
";
$params[] = $perPage;
$params[] = $offset;
$users = $db->fetchAll($query, $params);

// Get roles for filter
$roles = $db->fetchAll("SELECT role_id, role_name FROM user_roles ORDER BY role_name");

// Calculate statistics
$stats = [
    'total' => $totalRecords,
    'active' => $db->fetchRow("SELECT COUNT(*) as count FROM users WHERE is_active = 1")['count'],
    'inactive' => $db->fetchRow("SELECT COUNT(*) as count FROM users WHERE is_active = 0")['count'],
    'logged_in_today' => $db->fetchRow("SELECT COUNT(*) as count FROM users WHERE DATE(last_login) = CURDATE()")['count']
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Users - Internal Auditor</title>
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
        .filter-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; }
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
                    System Users 
                    <span class="read-only-badge">READ-ONLY VIEW</span>
                </h1>
                <p style="color: #718096; margin-top: 5px;">View all system users - No edit/delete rights</p>
            </div>
            <a href="index.php" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
    
    <div class="info-banner">
        <div class="info-banner-text">
            As an Internal Auditor, you can view user information but cannot create, edit, or delete user accounts.
        </div>
    </div>
    
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['total']); ?></div>
            <div class="stat-label">Total Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['active']); ?></div>
            <div class="stat-label">Active Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['inactive']); ?></div>
            <div class="stat-label">Inactive Users</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['logged_in_today']); ?></div>
            <div class="stat-label">Logged In Today</div>
        </div>
    </div>
    
    <div class="filters-section">
        <form method="GET" action="">
            <div class="filter-grid">
                <div class="form-group">
                    <label class="form-label">Search</label>
                    <input type="text" name="search" class="form-control" placeholder="Username, name, email..." value="<?php echo htmlspecialchars($search); ?>">
                </div>
                <div class="form-group">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-control">
                        <option value="">All Roles</option>
                        <?php foreach ($roles as $role): ?>
                        <option value="<?php echo $role['role_id']; ?>" <?php echo $roleFilter == $role['role_id'] ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($role['role_name']); ?>
                        </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Status</label>
                    <select name="is_active" class="form-control">
                        <option value="">All Status</option>
                        <option value="1" <?php echo $statusFilter === '1' ? 'selected' : ''; ?>>Active</option>
                        <option value="0" <?php echo $statusFilter === '0' ? 'selected' : ''; ?>>Inactive</option>
                    </select>
                </div>
                <div class="form-group" style="justify-content: flex-end;">
                    <label class="form-label">&nbsp;</label>
                    <div style="display: flex; gap: 10px;">
                        <button type="submit" class="btn btn-primary">Apply Filters</button>
                        <a href="view_users.php" class="btn btn-secondary">Clear</a>
                    </div>
                </div>
            </div>
        </form>
    </div>
    
    <div style="background: white; padding: 15px; border-radius: 10px; margin-bottom: 20px;">
        <p style="margin: 0; color: #2d3748;">
            Showing <strong><?php echo number_format($offset + 1); ?></strong> to 
            <strong><?php echo number_format(min($offset + $perPage, $totalRecords)); ?></strong> of 
            <strong><?php echo number_format($totalRecords); ?></strong> users
        </p>
    </div>
    
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Last Login</th>
                    <th>Created</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($users)): ?>
                    <?php foreach ($users as $user): ?>
                    <tr>
                        <td><?php echo htmlspecialchars($user['username']); ?></td>
                        <td><?php echo htmlspecialchars($user['first_name'] . ' ' . $user['last_name']); ?></td>
                        <td><?php echo htmlspecialchars($user['email'] ?? 'N/A'); ?></td>
                        <td><span class="badge badge-info"><?php echo htmlspecialchars($user['role_name']); ?></span></td>
                        <td>
                            <span class="badge badge-<?php echo $user['is_active'] ? 'success' : 'danger'; ?>">
                                <?php echo $user['is_active'] ? 'Active' : 'Inactive'; ?>
                            </span>
                        </td>
                        <td><?php echo $user['last_login'] ? date('Y-m-d H:i', strtotime($user['last_login'])) : 'Never'; ?></td>
                        <td><?php echo date('Y-m-d', strtotime($user['created_at'])); ?></td>
                    </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 40px; color: #718096;">
                            No users found matching your criteria.
                        </td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
    
    <?php if ($totalPages > 1): ?>
    <div class="pagination">
        <?php if ($page > 1): ?>
            <a href="?page=<?php echo ($page - 1); ?>&search=<?php echo urlencode($search); ?>&role=<?php echo urlencode($roleFilter); ?>&is_active=<?php echo urlencode($statusFilter); ?>">Previous</a>
        <?php endif; ?>
        
        <?php
        $startPage = max(1, $page - 2);
        $endPage = min($totalPages, $page + 2);
        for ($i = $startPage; $i <= $endPage; $i++):
        ?>
            <?php if ($i == $page): ?>
                <span class="active"><?php echo $i; ?></span>
            <?php else: ?>
                <a href="?page=<?php echo $i; ?>&search=<?php echo urlencode($search); ?>&role=<?php echo urlencode($roleFilter); ?>&is_active=<?php echo urlencode($statusFilter); ?>"><?php echo $i; ?></a>
            <?php endif; ?>
        <?php endfor; ?>
        
        <?php if ($page < $totalPages): ?>
            <a href="?page=<?php echo ($page + 1); ?>&search=<?php echo urlencode($search); ?>&role=<?php echo urlencode($roleFilter); ?>&is_active=<?php echo urlencode($statusFilter); ?>">Next</a>
        <?php endif; ?>
    </div>
    <?php endif; ?>
</body>
</html>