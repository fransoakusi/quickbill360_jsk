<?php
/**
 * Audit Logs Page - Internal Auditor
 * Comprehensive view of all system audit logs with advanced filtering
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

// Get total count
$countQuery = "
    SELECT COUNT(*) as total
    FROM audit_logs al
    LEFT JOIN users u ON al.user_id = u.user_id
    $whereClause
";
$totalResult = $db->fetchRow($countQuery, $params);
$totalRecords = $totalResult['total'];
$totalPages = ceil($totalRecords / $perPage);

// Get logs
$query = "
    SELECT 
        al.*,
        u.username,
        CONCAT(u.first_name, ' ', u.last_name) as user_name,
        ur.role_name
    FROM audit_logs al
    LEFT JOIN users u ON al.user_id = u.user_id
    LEFT JOIN user_roles ur ON u.role_id = ur.role_id
    $whereClause
    ORDER BY al.created_at DESC
    LIMIT ? OFFSET ?
";
$params[] = $perPage;
$params[] = $offset;
$logs = $db->fetchAll($query, $params);

// Get unique actions for filter
$actions = $db->fetchAll("SELECT DISTINCT action FROM audit_logs ORDER BY action");

// Get unique tables for filter
$tables = $db->fetchAll("SELECT DISTINCT table_name FROM audit_logs WHERE table_name IS NOT NULL ORDER BY table_name");

// Get users for filter
$users = $db->fetchAll("SELECT user_id, username, first_name, last_name FROM users ORDER BY username");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Audit Logs - Internal Auditor</title>
    <link rel="stylesheet" href="../assets/css/admin.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            margin: 0;
        }
        
        .page-header {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .page-title {
            font-size: 24px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 10px;
        }
        
        .filters-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 15px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
        }
        
        .form-label {
            font-size: 12px;
            font-weight: 600;
            color: #718096;
            margin-bottom: 5px;
            text-transform: uppercase;
        }
        
        .form-control {
            padding: 10px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background: #3498db;
            color: white;
        }
        
        .btn-primary:hover {
            background: #2980b9;
        }
        
        .btn-secondary {
            background: #718096;
            color: white;
        }
        
        .btn-group {
            display: flex;
            gap: 10px;
        }
        
        .table-container {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .table th {
            background: #f7fafc;
            padding: 12px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: #718096;
            text-transform: uppercase;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .table td {
            padding: 12px;
            border-bottom: 1px solid #e2e8f0;
            font-size: 14px;
            color: #2d3748;
        }
        
        .table tr:hover {
            background: #f7fafc;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .badge-success { background: #d4edda; color: #155724; }
        .badge-info { background: #d1ecf1; color: #0c5460; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger { background: #f8d7da; color: #721c24; }
        
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            margin-top: 20px;
        }
        
        .pagination a,
        .pagination span {
            padding: 8px 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            text-decoration: none;
            color: #2d3748;
            transition: all 0.3s;
        }
        
        .pagination a:hover {
            background: #f7fafc;
        }
        
        .pagination .active {
            background: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        .action-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }
        
        .action-link:hover {
            text-decoration: underline;
        }
        
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal.show {
            display: flex;
        }
        
        .modal-content {
            background: white;
            border-radius: 10px;
            padding: 30px;
            max-width: 800px;
            width: 90%;
            max-height: 80vh;
            overflow-y: auto;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }
        
        .modal-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d3748;
        }
        
        .close-btn {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #718096;
        }
        
        .detail-row {
            display: flex;
            padding: 10px 0;
            border-bottom: 1px solid #f7fafc;
        }
        
        .detail-label {
            font-weight: 600;
            color: #718096;
            width: 150px;
        }
        
        .detail-value {
            flex: 1;
            color: #2d3748;
        }
        
        .json-data {
            background: #f7fafc;
            padding: 15px;
            border-radius: 6px;
            font-family: 'Courier New', monospace;
            font-size: 12px;
            overflow-x: auto;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
    </style>
</head>
<body>
    <div class="page-header">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h1 class="page-title">📜 System Audit Logs</h1>
                <p style="color: #718096;">Comprehensive audit trail of all system activities</p>
            </div>
            <div class="btn-group">
                <a href="index.php" class="btn btn-secondary">← Back to Dashboard</a>
                <button onclick="exportLogs()" class="btn btn-primary">📥 Export Logs</button>
            </div>
        </div>
    </div>
    
    <!-- Filters -->
    <div class="filters-section">
        <h3 style="margin-bottom: 15px; color: #2d3748;">🔍 Filter Logs</h3>
        <form method="GET" action="">
            <div class="filter-grid">
                <div class="form-group">
                    <label class="form-label">Action</label>
                    <select name="action" class="form-control">
                        <option value="">All Actions</option>
                        <?php foreach ($actions as $action): ?>
                        <option value="<?php echo htmlspecialchars($action['action']); ?>" 
                                <?php echo $filters['action'] === $action['action'] ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($action['action']); ?>
                        </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Module/Table</label>
                    <select name="table_name" class="form-control">
                        <option value="">All Modules</option>
                        <?php foreach ($tables as $table): ?>
                        <option value="<?php echo htmlspecialchars($table['table_name']); ?>"
                                <?php echo $filters['table_name'] === $table['table_name'] ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($table['table_name']); ?>
                        </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">User</label>
                    <select name="user_id" class="form-control">
                        <option value="">All Users</option>
                        <?php foreach ($users as $user): ?>
                        <option value="<?php echo $user['user_id']; ?>"
                                <?php echo $filters['user_id'] == $user['user_id'] ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($user['username'] . ' - ' . $user['first_name'] . ' ' . $user['last_name']); ?>
                        </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Date From</label>
                    <input type="date" name="date_from" class="form-control" 
                           value="<?php echo htmlspecialchars($filters['date_from']); ?>">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Date To</label>
                    <input type="date" name="date_to" class="form-control" 
                           value="<?php echo htmlspecialchars($filters['date_to']); ?>">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Search</label>
                    <input type="text" name="search" class="form-control" 
                           placeholder="Search user, action..." 
                           value="<?php echo htmlspecialchars($filters['search']); ?>">
                </div>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">Apply Filters</button>
                <a href="audit_logs.php" class="btn btn-secondary">Clear Filters</a>
            </div>
        </form>
    </div>
    
    <!-- Results Info -->
    <div style="background: white; padding: 15px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
        <p style="margin: 0; color: #2d3748;">
            Showing <strong><?php echo number_format($offset + 1); ?></strong> to 
            <strong><?php echo number_format(min($offset + $perPage, $totalRecords)); ?></strong> of 
            <strong><?php echo number_format($totalRecords); ?></strong> records
        </p>
    </div>
    
    <!-- Audit Logs Table -->
    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Timestamp</th>
                    <th>Action</th>
                    <th>Module</th>
                    <th>User</th>
                    <th>Role</th>
                    <th>IP Address</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($logs)): ?>
                    <?php foreach ($logs as $log): ?>
                    <tr>
                        <td><?php echo $log['log_id']; ?></td>
                        <td><?php echo formatDateTime($log['created_at']); ?></td>
                        <td>
                            <span class="badge badge-<?php 
                                echo strpos($log['action'], 'DELETE') !== false ? 'danger' : 
                                    (strpos($log['action'], 'CREATE') !== false ? 'success' : 
                                    (strpos($log['action'], 'UPDATE') !== false ? 'warning' : 'info')); 
                            ?>">
                                <?php echo htmlspecialchars($log['action']); ?>
                            </span>
                        </td>
                        <td><?php echo htmlspecialchars($log['table_name'] ?: 'N/A'); ?></td>
                        <td><?php echo htmlspecialchars($log['user_name']); ?></td>
                        <td><?php echo htmlspecialchars($log['role_name']); ?></td>
                        <td><?php echo htmlspecialchars($log['ip_address']); ?></td>
                        <td>
                            <a href="#" onclick="viewLogDetails(<?php echo $log['log_id']; ?>); return false;" 
                               class="action-link">View Details</a>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 40px; color: #718096;">
                            No audit logs found matching your criteria.
                        </td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
    
    <!-- Pagination -->
    <?php if ($totalPages > 1): ?>
    <div class="pagination">
        <?php if ($page > 1): ?>
            <a href="?page=<?php echo ($page - 1); ?><?php echo http_build_query(array_filter($filters)) ? '&' . http_build_query(array_filter($filters)) : ''; ?>">
                Previous
            </a>
        <?php endif; ?>
        
        <?php
        $startPage = max(1, $page - 2);
        $endPage = min($totalPages, $page + 2);
        
        for ($i = $startPage; $i <= $endPage; $i++):
        ?>
            <?php if ($i == $page): ?>
                <span class="active"><?php echo $i; ?></span>
            <?php else: ?>
                <a href="?page=<?php echo $i; ?><?php echo http_build_query(array_filter($filters)) ? '&' . http_build_query(array_filter($filters)) : ''; ?>">
                    <?php echo $i; ?>
                </a>
            <?php endif; ?>
        <?php endfor; ?>
        
        <?php if ($page < $totalPages): ?>
            <a href="?page=<?php echo ($page + 1); ?><?php echo http_build_query(array_filter($filters)) ? '&' . http_build_query(array_filter($filters)) : ''; ?>">
                Next
            </a>
        <?php endif; ?>
    </div>
    <?php endif; ?>
    
    <!-- Log Details Modal -->
    <div id="logModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Audit Log Details</h2>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div id="logDetailsContent">
                Loading...
            </div>
        </div>
    </div>
    
    <script>
        function viewLogDetails(logId) {
            const modal = document.getElementById('logModal');
            const content = document.getElementById('logDetailsContent');
            
            modal.classList.add('show');
            content.innerHTML = 'Loading...';
            
            // Fetch log details via AJAX
            fetch('get_log_details.php?id=' + logId)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        content.innerHTML = formatLogDetails(data.log);
                    } else {
                        content.innerHTML = '<p style="color: red;">Error loading log details.</p>';
                    }
                })
                .catch(error => {
                    content.innerHTML = '<p style="color: red;">Error: ' + error.message + '</p>';
                });
        }
        
        function closeModal() {
            document.getElementById('logModal').classList.remove('show');
        }
        
        function formatLogDetails(log) {
            let html = '<div>';
            
            html += '<div class="detail-row"><div class="detail-label">Log ID:</div><div class="detail-value">' + log.log_id + '</div></div>';
            html += '<div class="detail-row"><div class="detail-label">Action:</div><div class="detail-value"><span class="badge badge-info">' + log.action + '</span></div></div>';
            html += '<div class="detail-row"><div class="detail-label">Module:</div><div class="detail-value">' + (log.table_name || 'N/A') + '</div></div>';
            html += '<div class="detail-row"><div class="detail-label">Record ID:</div><div class="detail-value">' + (log.record_id || 'N/A') + '</div></div>';
            html += '<div class="detail-row"><div class="detail-label">User:</div><div class="detail-value">' + log.user_name + ' (' + log.username + ')</div></div>';
            html += '<div class="detail-row"><div class="detail-label">Role:</div><div class="detail-value">' + log.role_name + '</div></div>';
            html += '<div class="detail-row"><div class="detail-label">IP Address:</div><div class="detail-value">' + log.ip_address + '</div></div>';
            html += '<div class="detail-row"><div class="detail-label">User Agent:</div><div class="detail-value">' + (log.user_agent || 'N/A') + '</div></div>';
            html += '<div class="detail-row"><div class="detail-label">Timestamp:</div><div class="detail-value">' + log.created_at + '</div></div>';
            
            if (log.old_values) {
                html += '<div style="margin-top: 20px;"><strong>Old Values:</strong><div class="json-data">' + 
                        JSON.stringify(JSON.parse(log.old_values), null, 2) + '</div></div>';
            }
            
            if (log.new_values) {
                html += '<div style="margin-top: 20px;"><strong>New Values:</strong><div class="json-data">' + 
                        JSON.stringify(JSON.parse(log.new_values), null, 2) + '</div></div>';
            }
            
            html += '</div>';
            return html;
        }
        
        function exportLogs() {
            const params = new URLSearchParams(window.location.search);
            window.location.href = 'export_logs.php?' + params.toString();
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('logModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>