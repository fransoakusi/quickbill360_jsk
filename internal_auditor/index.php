<?php
/**
 * Internal Auditor Dashboard for QUICKBILL 305
 * Comprehensive audit overview with read-only access
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
require_once '../includes/restriction_warning.php';

// Check if user is logged in
if (!isLoggedIn()) {
    header('Location: ../auth/login.php');
    exit();
}

// Check if user is Internal Auditor
if (!isInternalAuditor()) {
    setFlashMessage('error', 'Access denied. Internal Auditor privileges required.');
    redirectToDashboard();
    exit();
}

$currentUser = getCurrentUser();
$userDisplayName = getUserDisplayName($currentUser);

// Get audit statistics
try {
    $db = new Database();
    
    // Total audit logs
    $auditLogsCount = $db->fetchRow("SELECT COUNT(*) as count FROM audit_logs")['count'] ?? 0;
    
    // Audit logs today
    $auditLogsToday = $db->fetchRow("SELECT COUNT(*) as count FROM audit_logs WHERE DATE(created_at) = CURDATE()")['count'] ?? 0;
    
    // Open audit findings
    $openFindings = $db->fetchRow("SELECT COUNT(*) as count FROM audit_findings WHERE status IN ('Open', 'Under Review')")['count'] ?? 0;
    
    // Critical findings
    $criticalFindings = $db->fetchRow("SELECT COUNT(*) as count FROM audit_findings WHERE severity = 'Critical' AND status != 'Closed'")['count'] ?? 0;
    
    // Payment transactions this month
    $monthlyPayments = $db->fetchRow("
        SELECT COUNT(*) as count, SUM(amount_paid) as total
        FROM payments 
        WHERE payment_status = 'Successful'
        AND YEAR(payment_date) = YEAR(CURDATE())
        AND MONTH(payment_date) = MONTH(CURDATE())
    ");
    $paymentCount = $monthlyPayments['count'] ?? 0;
    $paymentTotal = $monthlyPayments['total'] ?? 0;
    
    // Bills generated this year
    $billsCount = $db->fetchRow("
        SELECT COUNT(*) as count 
        FROM bills 
        WHERE YEAR(generated_at) = YEAR(CURDATE())
    ")['count'] ?? 0;
    
    // User activities this week
    $weeklyActivities = $db->fetchRow("
        SELECT COUNT(*) as count 
        FROM audit_logs 
        WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
    ")['count'] ?? 0;
    
    // Recent audit logs (last 10)
    $recentLogs = $db->fetchAll("
        SELECT 
            al.log_id,
            al.action,
            al.table_name,
            al.created_at,
            u.username,
            CONCAT(u.first_name, ' ', u.last_name) as user_name,
            ur.role_name
        FROM audit_logs al
        LEFT JOIN users u ON al.user_id = u.user_id
        LEFT JOIN user_roles ur ON u.role_id = ur.role_id
        ORDER BY al.created_at DESC
        LIMIT 10
    ");
    
    // Recent findings
    $recentFindings = $db->fetchAll("
        SELECT 
            af.finding_id,
            af.finding_title,
            af.severity,
            af.status,
            af.identified_at,
            CONCAT(u.first_name, ' ', u.last_name) as identified_by_name
        FROM audit_findings af
        LEFT JOIN users u ON af.identified_by = u.user_id
        ORDER BY af.identified_at DESC
        LIMIT 5
    ");
    
    // Activity by action type (for chart)
    $activityByType = $db->fetchAll("
        SELECT 
            action,
            COUNT(*) as count
        FROM audit_logs
        WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
        GROUP BY action
        ORDER BY count DESC
        LIMIT 10
    ");
    
    // Daily activity for last 7 days (for chart)
    $dailyActivity = $db->fetchAll("
        SELECT 
            DATE(created_at) as activity_date,
            COUNT(*) as count
        FROM audit_logs
        WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
        GROUP BY DATE(created_at)
        ORDER BY activity_date
    ");
    
} catch (Exception $e) {
    $auditLogsCount = 0;
    $auditLogsToday = 0;
    $openFindings = 0;
    $criticalFindings = 0;
    $paymentCount = 0;
    $paymentTotal = 0;
    $billsCount = 0;
    $weeklyActivities = 0;
    $recentLogs = [];
    $recentFindings = [];
    $activityByType = [];
    $dailyActivity = [];
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Internal Auditor Dashboard - <?php echo APP_NAME; ?></title>
    
    <script src="../assets/js/chart.min.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            overflow-x: hidden;
        }

        /* Top Navigation */
        .top-nav {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 15px 20px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .nav-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .toggle-btn {
            background: rgba(255,255,255,0.2);
            border: none;
            color: white;
            font-size: 18px;
            padding: 10px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
        }

        .toggle-btn:hover {
            background: rgba(255,255,255,0.3);
        }

        .brand {
            font-size: 24px;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            padding: 8px 12px;
            border-radius: 10px;
            transition: all 0.3s;
        }

        .user-profile:hover {
            background: rgba(255,255,255,0.1);
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(255,255,255,0.3) 0%, rgba(255,255,255,0.1) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            border: 2px solid rgba(255,255,255,0.2);
        }

        .user-info {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-weight: 600;
            font-size: 14px;
        }

        .user-role {
            font-size: 12px;
            opacity: 0.8;
            background: rgba(231, 76, 60, 0.3);
            padding: 2px 8px;
            border-radius: 10px;
            display: inline-block;
        }

        /* Layout */
        .container {
            margin-top: 80px;
            display: flex;
            min-height: calc(100vh - 80px);
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #2d3748 0%, #1a202c 100%);
            color: white;
            transition: all 0.3s ease;
            overflow: hidden;
            flex-shrink: 0;
        }

        .sidebar.hidden {
            width: 0;
            min-width: 0;
        }

        .sidebar-content {
            width: 280px;
            padding: 20px 0;
            transition: all 0.3s ease;
        }

        .sidebar.hidden .sidebar-content {
            opacity: 0;
        }

        .nav-section {
            margin-bottom: 30px;
        }

        .nav-title {
            color: #a0aec0;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
            padding: 0 20px;
            margin-bottom: 10px;
        }

        .nav-item {
            margin-bottom: 2px;
        }

        .nav-link {
            color: #e2e8f0;
            text-decoration: none;
            padding: 12px 20px;
            display: block;
            transition: all 0.3s;
            border-left: 3px solid transparent;
            display: flex;
            align-items: center;
        }

        .nav-link:hover {
            background: rgba(255,255,255,0.1);
            color: white;
            border-left-color: #e74c3c;
        }

        .nav-link.active {
            background: rgba(231, 76, 60, 0.3);
            color: white;
            border-left-color: #e74c3c;
        }

        .nav-icon {
            display: inline-block;
            width: 20px;
            margin-right: 12px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            padding: 30px;
            background: #f8f9fa;
            transition: all 0.3s ease;
            min-width: 0;
        }

        /* Welcome Card */
        .welcome-card {
            background: linear-gradient(135deg, #2c3e50 0%, #e74c3c 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .welcome-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .welcome-subtitle {
            font-size: 16px;
            opacity: 0.9;
        }

        .read-only-badge {
            display: inline-block;
            background: rgba(255,255,255,0.2);
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin-top: 10px;
            border: 1px solid rgba(255,255,255,0.3);
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 18px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }

        .stat-card.primary { border-left: 4px solid #3498db; }
        .stat-card.warning { border-left: 4px solid #f39c12; }
        .stat-card.danger { border-left: 4px solid #e74c3c; }
        .stat-card.success { border-left: 4px solid #27ae60; }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .stat-title {
            font-size: 12px;
            color: #718096;
            font-weight: 600;
            text-transform: uppercase;
        }

        .stat-icon {
            font-size: 24px;
            opacity: 0.6;
        }

        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #2d3748;
        }

        .stat-subtitle {
            font-size: 11px;
            color: #718096;
            margin-top: 4px;
        }

        /* Cards */
        .card {
            background: white;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .card-header {
            padding: 20px 25px;
            background: #f7fafc;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin: 0;
        }

        .card-body {
            padding: 25px;
        }

        /* Table */
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

        /* Badges */
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-success { background: #d4edda; color: #155724; }
        .badge-warning { background: #fff3cd; color: #856404; }
        .badge-danger { background: #f8d7da; color: #721c24; }
        .badge-info { background: #d1ecf1; color: #0c5460; }
        .badge-secondary { background: #e2e8f0; color: #4a5568; }

        /* Action Links */
        .action-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .action-link:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
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
            color: white;
        }

        .chart-container {
            position: relative;
            height: 300px;
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                height: calc(100vh - 80px);
                top: 80px;
                left: 0;
                z-index: 999;
                transform: translateX(-100%);
                width: 280px !important;
            }

            .sidebar.mobile-show {
                transform: translateX(0);
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .main-content {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Top Navigation -->
    <div class="top-nav">
        <div class="nav-left">
            <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
            <a href="../internal_auditor/index.php" class="brand">
                🔍 <?php echo APP_NAME; ?> - Audit
            </a>
        </div>

        <div class="user-section">
            <div class="user-profile">
                <div class="user-avatar">
                    <?php echo strtoupper(substr($currentUser['first_name'], 0, 1)); ?>
                </div>
                <div class="user-info">
                    <div class="user-name"><?php echo htmlspecialchars($userDisplayName); ?></div>
                    <div class="user-role"><?php echo htmlspecialchars(getCurrentUserRole()); ?></div>
                </div>
            </div>
            <a href="../auth/logout.php" class="btn btn-primary" style="margin-left: 15px;">Logout</a>
        </div>
    </div>

    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-content">
                <div class="nav-section">
                    <div class="nav-item">
                        <a href="../internal_auditor/index.php" class="nav-link active">
                            <span class="nav-icon">📊</span>
                            Dashboard
                        </a>
                    </div>
                </div>

                <div class="nav-section">
                    <div class="nav-title">Audit Activities</div>
                    <div class="nav-item">
                        <a href="audit_logs.php" class="nav-link">
                            <span class="nav-icon">📜</span>
                            Audit Logs
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="findings.php" class="nav-link">
                            <span class="nav-icon">🔍</span>
                            Audit Findings
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="reports.php" class="nav-link">
                            <span class="nav-icon">📈</span>
                            Audit Reports
                        </a>
                    </div>
                </div>

                <div class="nav-section">
                    <div class="nav-title">View Only Access</div>
                    <div class="nav-item">
                        <a href="view_businesses.php" class="nav-link">
                            <span class="nav-icon">🏢</span>
                            Businesses
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="view_properties.php" class="nav-link">
                            <span class="nav-icon">🏠</span>
                            Properties
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="view_payments.php" class="nav-link">
                            <span class="nav-icon">💳</span>
                            Payments
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="view_bills.php" class="nav-link">
                            <span class="nav-icon">📄</span>
                            Bills
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="view_users.php" class="nav-link">
                            <span class="nav-icon">👥</span>
                            Users
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Welcome Section -->
            <div class="welcome-card">
                <h1 class="welcome-title">Internal Audit Dashboard</h1>
                <p class="welcome-subtitle">Welcome, <?php echo htmlspecialchars($userDisplayName); ?>. Monitor system activities and maintain audit compliance.</p>
                <span class="read-only-badge">🔒 READ-ONLY ACCESS - No Modification Rights</span>
            </div>

            <!-- Statistics Cards -->
            <div class="stats-grid">
                <div class="stat-card primary">
                    <div class="stat-header">
                        <div class="stat-title">Total Audit Logs</div>
                        <div class="stat-icon">📜</div>
                    </div>
                    <div class="stat-value"><?php echo number_format($auditLogsCount); ?></div>
                    <div class="stat-subtitle">Today: <?php echo number_format($auditLogsToday); ?></div>
                </div>

                <div class="stat-card warning">
                    <div class="stat-header">
                        <div class="stat-title">Open Findings</div>
                        <div class="stat-icon">🔍</div>
                    </div>
                    <div class="stat-value"><?php echo number_format($openFindings); ?></div>
                    <div class="stat-subtitle">Requires attention</div>
                </div>

                <div class="stat-card danger">
                    <div class="stat-header">
                        <div class="stat-title">Critical Issues</div>
                        <div class="stat-icon">⚠️</div>
                    </div>
                    <div class="stat-value"><?php echo number_format($criticalFindings); ?></div>
                    <div class="stat-subtitle">Unresolved</div>
                </div>

                <div class="stat-card success">
                    <div class="stat-header">
                        <div class="stat-title">Monthly Payments</div>
                        <div class="stat-icon">💰</div>
                    </div>
                    <div class="stat-value"><?php echo number_format($paymentCount); ?></div>
                    <div class="stat-subtitle">₵ <?php echo number_format($paymentTotal, 2); ?></div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">📋 Recent System Activity</h5>
                    <a href="audit_logs.php" class="btn btn-primary">View All Logs</a>
                </div>
                <div class="card-body">
                    <?php if (!empty($recentLogs)): ?>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Time</th>
                                <th>Action</th>
                                <th>Module</th>
                                <th>User</th>
                                <th>Role</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($recentLogs as $log): ?>
                            <tr>
                                <td><?php echo formatDateTime($log['created_at']); ?></td>
                                <td><span class="badge badge-info"><?php echo htmlspecialchars($log['action']); ?></span></td>
                                <td><?php echo htmlspecialchars($log['table_name'] ?: 'N/A'); ?></td>
                                <td><?php echo htmlspecialchars($log['user_name']); ?></td>
                                <td><?php echo htmlspecialchars($log['role_name']); ?></td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <?php else: ?>
                    <p style="text-align: center; color: #718096; padding: 40px;">No recent activity found.</p>
                    <?php endif; ?>
                </div>
            </div>

            <!-- Recent Findings -->
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">🔍 Recent Audit Findings</h5>
                    <a href="findings.php" class="btn btn-primary">Manage Findings</a>
                </div>
                <div class="card-body">
                    <?php if (!empty($recentFindings)): ?>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Finding</th>
                                <th>Severity</th>
                                <th>Status</th>
                                <th>Identified By</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($recentFindings as $finding): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($finding['finding_title']); ?></td>
                                <td>
                                    <span class="badge badge-<?php 
                                        echo $finding['severity'] === 'Critical' ? 'danger' : 
                                            ($finding['severity'] === 'High' ? 'warning' : 
                                            ($finding['severity'] === 'Medium' ? 'info' : 'secondary')); 
                                    ?>">
                                        <?php echo htmlspecialchars($finding['severity']); ?>
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-<?php 
                                        echo $finding['status'] === 'Open' ? 'warning' : 
                                            ($finding['status'] === 'Resolved' ? 'success' : 'secondary'); 
                                    ?>">
                                        <?php echo htmlspecialchars($finding['status']); ?>
                                    </span>
                                </td>
                                <td><?php echo htmlspecialchars($finding['identified_by_name']); ?></td>
                                <td><?php echo formatDate($finding['identified_at']); ?></td>
                                <td>
                                    <a href="findings.php?view=<?php echo $finding['finding_id']; ?>" class="action-link">View</a>
                                </td>
                            </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                    <?php else: ?>
                    <p style="text-align: center; color: #718096; padding: 40px;">No audit findings recorded yet.</p>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            if (window.innerWidth <= 768) {
                sidebar.classList.toggle('mobile-show');
            } else {
                sidebar.classList.toggle('hidden');
            }
        }
    </script>
</body>
</html>