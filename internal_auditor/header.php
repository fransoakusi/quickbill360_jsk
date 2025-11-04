<?php
/**
 * Shared Header Template for Internal Auditor
 * File: internal_auditor/header.php
 */

if (!defined('QUICKBILL_305')) {
    die('Direct access not permitted');
}

$currentUser = getCurrentUser();
$userDisplayName = getUserDisplayName($currentUser);
$currentPage = basename($_SERVER['PHP_SELF']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo isset($pageTitle) ? $pageTitle . ' - ' : ''; ?>Internal Auditor - <?php echo APP_NAME; ?></title>
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
        }

        .brand {
            font-size: 20px;
            font-weight: bold;
            color: white;
            text-decoration: none;
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
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
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
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
        }

        .btn-logout {
            background: rgba(255,255,255,0.2);
            color: white;
        }

        .btn-logout:hover {
            background: rgba(255,255,255,0.3);
        }

        /* Layout Container */
        .container {
            margin-top: 70px;
            display: flex;
            min-height: calc(100vh - 70px);
        }

        /* Sidebar */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #2d3748 0%, #1a202c 100%);
            color: white;
            transition: all 0.3s ease;
            overflow: hidden;
            flex-shrink: 0;
            position: fixed;
            height: calc(100vh - 70px);
            overflow-y: auto;
        }

        .sidebar.hidden {
            width: 0;
        }

        .sidebar-content {
            width: 280px;
            padding: 20px 0;
        }

        .nav-section {
            margin-bottom: 25px;
        }

        .nav-title {
            color: #a0aec0;
            font-size: 11px;
            font-weight: bold;
            text-transform: uppercase;
            padding: 0 20px;
            margin-bottom: 10px;
            letter-spacing: 1px;
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

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 20px;
            transition: margin-left 0.3s;
        }

        .sidebar.hidden + .main-content {
            margin-left: 0;
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
                z-index: 999;
            }

            .sidebar.mobile-show {
                transform: translateX(0);
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
            <a href="index.php" class="brand">🔍 <?php echo APP_NAME; ?> - Audit</a>
        </div>

        <div class="user-section">
            <div class="user-profile">
                <div class="user-avatar">
                    <?php echo strtoupper(substr($currentUser['first_name'], 0, 1)); ?>
                </div>
                <div class="user-info">
                    <div class="user-name"><?php echo htmlspecialchars($userDisplayName); ?></div>
                    <div class="user-role">Internal Auditor</div>
                </div>
            </div>
            <a href="../auth/logout.php" class="btn btn-logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-content">
                <!-- Dashboard -->
                <div class="nav-section">
                    <div class="nav-item">
                        <a href="index.php" class="nav-link <?php echo $currentPage === 'index.php' ? 'active' : ''; ?>">
                            📊 Dashboard
                        </a>
                    </div>
                </div>

                <!-- Audit Activities -->
                <div class="nav-section">
                    <div class="nav-title">Audit Activities</div>
                    <div class="nav-item">
                        <a href="audit_logs.php" class="nav-link <?php echo $currentPage === 'audit_logs.php' ? 'active' : ''; ?>">
                            📜 Audit Logs
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="findings.php" class="nav-link <?php echo $currentPage === 'findings.php' ? 'active' : ''; ?>">
                            🔍 Audit Findings
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="reports.php" class="nav-link <?php echo $currentPage === 'reports.php' ? 'active' : ''; ?>">
                            📈 Audit Reports
                        </a>
                    </div>
                </div>

                <!-- View Only Access -->
                <div class="nav-section">
                    <div class="nav-title">View Only Access</div>
                    <div class="nav-item">
                        <a href="view_businesses.php" class="nav-link <?php echo $currentPage === 'view_businesses.php' ? 'active' : ''; ?>">
                            🏢 Businesses
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="view_properties.php" class="nav-link <?php echo $currentPage === 'view_properties.php' ? 'active' : ''; ?>">
                            🏠 Properties
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="view_payments.php" class="nav-link <?php echo $currentPage === 'view_payments.php' ? 'active' : ''; ?>">
                            💳 Payments
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="view_bills.php" class="nav-link <?php echo $currentPage === 'view_bills.php' ? 'active' : ''; ?>">
                            📄 Bills
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="view_users.php" class="nav-link <?php echo $currentPage === 'view_users.php' ? 'active' : ''; ?>">
                            👥 Users
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <?php
            // Display flash messages
            $messages = getFlashMessages();
            foreach ($messages as $message):
            ?>
            <div class="alert alert-<?php echo $message['type'] === 'success' ? 'success' : 'error'; ?>" style="padding: 15px; border-radius: 6px; margin-bottom: 20px; <?php echo $message['type'] === 'success' ? 'background: #d4edda; color: #155724; border-left: 4px solid #28a745;' : 'background: #f8d7da; color: #721c24; border-left: 4px solid #dc3545;'; ?>">
                <?php echo htmlspecialchars($message['message']); ?>
            </div>
            <?php endforeach; ?>

            <!-- Page content starts here -->