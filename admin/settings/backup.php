<?php
/**
 * Admin Backup Management - QuickBill 305
 * Create and manage database backups
 */

// Define application constant
define('QUICKBILL_305', true);

// Include configuration files
require_once '../../config/config.php';
require_once '../../config/database.php';
require_once '../../includes/functions.php';

// Start session
session_start();

// Include auth and security
require_once '../../includes/auth.php';
require_once '../../includes/security.php';

// Initialize auth and security
initAuth();
initSecurity();

// Check if user is logged in and is admin
if (!isLoggedIn()) {
    header('Location: ../../auth/login.php');
    exit();
}

if (!isAdmin()) {
    setFlashMessage('error', 'Access denied. Admin privileges required.');
    header('Location: ../index.php');
    exit();
}

$currentUser = getCurrentUser();
$userDisplayName = getUserDisplayName($currentUser);

// Backup directory
$backupDir = '../../storage/backups';
if (!is_dir($backupDir)) {
    if (!mkdir($backupDir, 0755, true)) {
        setFlashMessage('error', 'Failed to create backup directory.');
    }
}

// Handle backup actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $action = $_POST['action'] ?? '';
        $db = new Database();

        switch ($action) {
            case 'create_backup':
                $backupType = $_POST['backup_type'] ?? 'Full';
                $includeUploads = isset($_POST['include_uploads']);
                
                // Generate backup filename
                $timestamp = date('Y-m-d_H-i-s');
                $backupFilename = "quickbill_305_backup_{$timestamp}.sql";
                $backupPath = $backupDir . '/' . $backupFilename;
                
                // Log backup start
                $logSql = "INSERT INTO backup_logs (backup_type, backup_path, status, started_by, started_at) VALUES (?, ?, 'In Progress', ?, NOW())";
                $db->execute($logSql, [$backupType, $backupPath, $currentUser['user_id']]);
                $backupLogId = $db->lastInsertId();

                // Create database backup
                $backupResult = createDatabaseBackup($backupPath, $backupType, $db);
                
                if ($backupResult['success']) {
                    $backupSize = filesize($backupPath);
                    
                    // Include uploads if requested
                    if ($includeUploads) {
                        $zipPath = str_replace('.sql', '_with_uploads.zip', $backupPath);
                        $zipResult = createFullBackupWithUploads($backupPath, $zipPath);
                        
                        if ($zipResult['success']) {
                            unlink($backupPath); // Remove SQL file as it's now in ZIP
                            $backupPath = $zipPath;
                            $backupSize = filesize($zipPath);
                        }
                    }
                    
                    // Update backup log
                    $updateSql = "UPDATE backup_logs SET status = 'Completed', backup_size = ?, completed_at = NOW() WHERE backup_id = ?";
                    $db->execute($updateSql, [$backupSize, $backupLogId]);
                    
                    // Log audit activity
                    logActivity($currentUser['user_id'], 'BACKUP_CREATED', 'backup_logs', $backupLogId, 
                                   json_encode(['type' => $backupType, 'size' => $backupSize]));
                    
                    setFlashMessage('success', "Backup created successfully: " . basename($backupPath));
                } else {
                    // Update backup log with error
                    $updateSql = "UPDATE backup_logs SET status = 'Failed', error_message = ?, completed_at = NOW() WHERE backup_id = ?";
                    $db->execute($updateSql, [$backupResult['error'], $backupLogId]);
                    
                    throw new Exception($backupResult['error']);
                }
                break;

            case 'download_backup':
                $filename = $_POST['filename'];
                $filepath = $backupDir . '/' . $filename;
                
                if (!file_exists($filepath) || strpos($filename, '..') !== false) {
                    throw new Exception('Backup file not found or invalid');
                }
                
                logActivity($currentUser['user_id'], 'BACKUP_DOWNLOADED', 'backup_logs', null, 
                               json_encode(['filename' => $filename]));
                
                // Force download
                header('Content-Type: application/octet-stream');
                header('Content-Disposition: attachment; filename="' . $filename . '"');
                header('Content-Length: ' . filesize($filepath));
                header('Cache-Control: must-revalidate');
                readfile($filepath);
                exit;

            case 'delete_backup':
                $filename = $_POST['filename'];
                $filepath = $backupDir . '/' . $filename;
                
                if (!file_exists($filepath) || strpos($filename, '..') !== false) {
                    throw new Exception('Backup file not found or invalid');
                }
                
                if (unlink($filepath)) {
                    logActivity($currentUser['user_id'], 'BACKUP_DELETED', 'backup_logs', null, 
                                   json_encode(['filename' => $filename]));
                    setFlashMessage('success', 'Backup file deleted successfully');
                } else {
                    throw new Exception('Failed to delete backup file');
                }
                break;
        }

    } catch (Exception $e) {
        error_log("Backup management error: " . $e->getMessage());
        setFlashMessage('error', $e->getMessage());
    }

    header('Location: backup.php');
    exit();
}

// Get backup files
$backupFiles = [];
try {
    if (is_dir($backupDir)) {
        $files = scandir($backupDir);
        foreach ($files as $file) {
            if ($file !== '.' && $file !== '..' && (str_ends_with($file, '.sql') || str_ends_with($file, '.zip'))) {
                $filepath = $backupDir . '/' . $file;
                $backupFiles[] = [
                    'filename' => $file,
                    'size' => filesize($filepath),
                    'created' => filemtime($filepath),
                    'type' => str_ends_with($file, '.zip') ? 'Full with Uploads' : 'Database Only'
                ];
            }
        }
        
        // Sort by creation date (newest first)
        usort($backupFiles, function($a, $b) {
            return $b['created'] - $a['created'];
        });
    }
} catch (Exception $e) {
    error_log("Error reading backup directory: " . $e->getMessage());
}

// Get backup logs
try {
    $db = new Database();
    $backupLogs = $db->fetchAll("
        SELECT bl.*, u.first_name, u.last_name 
        FROM backup_logs bl
        LEFT JOIN users u ON bl.started_by = u.user_id
        ORDER BY bl.started_at DESC
        LIMIT 20
    ");
} catch (Exception $e) {
    $backupLogs = [];
}

// Database backup function
function createDatabaseBackup($backupPath, $backupType = 'Full', $db) {
    try {
        $conn = $db->getConnection();
        
        // Start building SQL dump
        $sqlDump = "-- QuickBill 305 Database Backup\n";
        $sqlDump .= "-- Generated on: " . date('Y-m-d H:i:s') . "\n";
        $sqlDump .= "-- Backup Type: $backupType\n\n";
        
        $sqlDump .= "SET SQL_MODE = \"NO_AUTO_VALUE_ON_ZERO\";\n";
        $sqlDump .= "START TRANSACTION;\n";
        $sqlDump .= "SET time_zone = \"+00:00\";\n\n";
        
        // Get all tables
        $tables = $conn->query("SHOW TABLES")->fetchAll(PDO::FETCH_COLUMN);
        
        foreach ($tables as $table) {
            // Get table structure
            $sqlDump .= "\n-- Table structure for table `$table`\n";
            $sqlDump .= "DROP TABLE IF EXISTS `$table`;\n";
            
            $createTable = $conn->query("SHOW CREATE TABLE `$table`")->fetch();
            $sqlDump .= $createTable['Create Table'] . ";\n\n";
            
            // Get table data (skip for incremental backups of audit logs)
            if ($backupType === 'Incremental' && in_array($table, ['audit_logs', 'backup_logs'])) {
                continue;
            }
            
            $sqlDump .= "-- Dumping data for table `$table`\n";
            
            $rows = $conn->query("SELECT * FROM `$table`")->fetchAll(PDO::FETCH_ASSOC);
            
            if (!empty($rows)) {
                $columns = array_keys($rows[0]);
                $columnList = '`' . implode('`, `', $columns) . '`';
                
                $sqlDump .= "INSERT INTO `$table` ($columnList) VALUES\n";
                
                $values = [];
                foreach ($rows as $row) {
                    $rowValues = [];
                    foreach ($row as $value) {
                        if ($value === null) {
                            $rowValues[] = 'NULL';
                        } else {
                            $rowValues[] = "'" . addslashes($value) . "'";
                        }
                    }
                    $values[] = '(' . implode(', ', $rowValues) . ')';
                }
                
                $sqlDump .= implode(",\n", $values) . ";\n\n";
            }
        }
        
        $sqlDump .= "COMMIT;\n";
        
        // Write to file
        if (file_put_contents($backupPath, $sqlDump)) {
            return ['success' => true];
        } else {
            return ['success' => false, 'error' => 'Failed to write backup file'];
        }
        
    } catch (Exception $e) {
        return ['success' => false, 'error' => $e->getMessage()];
    }
}

// Create full backup with uploads
function createFullBackupWithUploads($sqlPath, $zipPath) {
    try {
        // Check if ZipArchive is available
        if (!class_exists('ZipArchive')) {
            return ['success' => false, 'error' => 'ZipArchive extension is not installed. Please enable php_zip extension in your PHP configuration or create database-only backup.'];
        }
        
        $zip = new ZipArchive();
        
        if ($zip->open($zipPath, ZipArchive::CREATE) !== TRUE) {
            return ['success' => false, 'error' => 'Cannot create ZIP file - check directory permissions'];
        }
        
        // Add SQL backup
        if (!$zip->addFile($sqlPath, 'database_backup.sql')) {
            return ['success' => false, 'error' => 'Failed to add database backup to ZIP file'];
        }
        
        // Add uploads directory if it exists
        $uploadsPath = '../../uploads';
        if (is_dir($uploadsPath)) {
            $iterator = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($uploadsPath, RecursiveDirectoryIterator::SKIP_DOTS),
                RecursiveIteratorIterator::LEAVES_ONLY
            );
            
            foreach ($iterator as $file) {
                $filePath = $file->getRealPath();
                $relativePath = 'uploads/' . substr($filePath, strlen($uploadsPath) + 1);
                
                // Add file to zip with error checking
                if (!$zip->addFile($filePath, $relativePath)) {
                    error_log("Failed to add file to ZIP: " . $filePath);
                }
            }
        }
        
        if (!$zip->close()) {
            return ['success' => false, 'error' => 'Failed to finalize ZIP file'];
        }
        
        return ['success' => true];
        
    } catch (Exception $e) {
        return ['success' => false, 'error' => $e->getMessage()];
    }
}

// Helper function to format bytes
function formatBytes($size, $precision = 2) {
    $units = array('B', 'KB', 'MB', 'GB', 'TB');
    
    for ($i = 0; $size > 1024 && $i < count($units) - 1; $i++) {
        $size /= 1024;
    }
    
    return round($size, $precision) . ' ' . $units[$i];
}

// Get flash messages once
$flashMessages = getFlashMessages();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Backup Management - <?php echo APP_NAME; ?></title>
    
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

        /* Emoji Icons */
        .icon-download::before { content: "💾"; }
        .icon-database::before { content: "🗄️"; }
        .icon-archive::before { content: "📦"; }
        .icon-plus::before { content: "➕"; }
        .icon-info::before { content: "ℹ️"; }
        .icon-files::before { content: "📁"; }
        .icon-history::before { content: "📜"; }
        .icon-arrow-left::before { content: "←"; }
        .icon-check::before { content: "✅"; }
        .icon-warning::before { content: "⚠️"; }
        .icon-folder::before { content: "📂"; }
        .icon-clock::before { content: "🕐"; }
        .icon-users::before { content: "👥"; }
        .icon-building::before { content: "🏢"; }
        .icon-invoice::before { content: "📄"; }
        .icon-cog::before { content: "⚙️"; }
        .icon-trash::before { content: "🗑️"; }
        .icon-user::before { content: "👤"; }
        .icon-receipt::before { content: "🧾"; }

        /* Top Navigation */
        .top-nav {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

        .brand {
            font-size: 24px;
            font-weight: bold;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .back-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .back-btn:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 15px;
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
            align-items: flex-start;
        }

        .user-name {
            font-weight: 600;
            font-size: 14px;
            color: white;
        }

        .user-role {
            font-size: 12px;
            opacity: 0.8;
            color: rgba(255,255,255,0.8);
        }

        /* Main Container */
        .main-container {
            margin-top: 80px;
            padding: 30px;
            max-width: 1400px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Page Header */
        .page-header {
            background: white;
            border-radius: 15px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }

        .page-title {
            font-size: 3rem;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: #718096;
            max-width: 600px;
            margin: 0 auto;
        }

        /* Flash Messages */
        .alert {
            border-radius: 12px;
            border: none;
            padding: 20px;
            margin-bottom: 30px;
            font-weight: 500;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }

        .alert-error {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            color: white;
        }

        /* Cards */
        .card {
            background: white;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .card-header {
            background: #f7fafc;
            border-bottom: 1px solid #e2e8f0;
            padding: 25px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-body {
            padding: 30px;
        }

        /* Grid Layout */
        .backup-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 30px;
        }

        /* Forms */
        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            display: block;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s;
            background: white;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        .form-text {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 5px;
        }

        .form-check {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-check-input {
            width: 1.2em;
            height: 1.2em;
        }

        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }

        .form-check-label {
            margin-bottom: 0;
            font-weight: 500;
        }

        /* Buttons */
        .btn {
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-success {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            color: white;
        }

        .btn-outline-primary {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-outline-danger {
            background: transparent;
            color: #f56565;
            border: 2px solid #f56565;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            text-decoration: none;
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 0.875rem;
        }

        .btn-block {
            width: 100%;
        }

        /* Backup Information */
        .backup-info {
            background: #f7fafc;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
        }

        .backup-info h6 {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .backup-items {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .backup-items li {
            padding: 8px 0;
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Stats */
        .backup-stats {
            background: #f7fafc;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .stat-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .stat-item:last-child {
            border-bottom: none;
        }

        .stat-item label {
            font-weight: 500;
            margin-bottom: 0;
            color: #6c757d;
        }

        .badge {
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .badge-primary {
            background: #667eea;
            color: white;
        }

        .badge-info {
            background: #4299e1;
            color: white;
        }

        .badge-secondary {
            background: #6c757d;
            color: white;
        }

        .badge-success {
            background: #48bb78;
            color: white;
        }

        .badge-warning {
            background: #ed8936;
            color: white;
        }

        .badge-danger {
            background: #f56565;
            color: white;
        }

        /* Tables */
        .table {
            width: 100%;
            margin-bottom: 0;
            border-collapse: collapse;
        }

        .table th {
            background: #f7fafc;
            border: none;
            font-weight: 600;
            color: #2d3748;
            padding: 15px;
            text-align: left;
        }

        .table td {
            border-bottom: 1px solid #e2e8f0;
            vertical-align: middle;
            padding: 15px;
        }

        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            color: #6c757d;
        }

        .empty-state .empty-icon {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h5 {
            margin-bottom: 10px;
            color: #2d3748;
        }

        .backup-recommendations {
            margin-top: 20px;
        }

        .backup-recommendations h6 {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .backup-recommendations ul {
            padding-left: 20px;
            margin: 0;
        }

        .backup-recommendations li {
            margin-bottom: 8px;
            color: #6c757d;
        }

        /* Action Buttons Group */
        .action-buttons {
            display: flex;
            gap: 8px;
        }

        /* File Item */
        .file-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .file-icon {
            font-size: 1.2rem;
        }

        .file-details {
            flex: 1;
        }

        .file-name {
            font-weight: 600;
            color: #2d3748;
        }

        /* Loading States */
        .btn.loading {
            position: relative;
            color: transparent;
        }

        .btn.loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            top: 50%;
            left: 50%;
            margin-left: -8px;
            margin-top: -8px;
            border: 2px solid transparent;
            border-top-color: currentColor;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            to {
                transform: rotate(360deg);
            }
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .backup-grid {
                grid-template-columns: 1fr;
            }
            
            .main-container {
                padding: 15px;
            }
            
            .page-header {
                padding: 30px 20px;
            }
            
            .page-title {
                font-size: 2rem;
            }

            .nav-left {
                gap: 10px;
            }

            .user-info {
                display: none;
            }

            .action-buttons {
                flex-direction: column;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in-up {
            animation: fadeInUp 0.6s ease-out;
        }
    </style>
</head>
<body>
    <!-- Top Navigation -->
    <div class="top-nav">
        <div class="nav-left">
            <a href="../index.php" class="brand">
                <span class="icon-receipt"></span>
                <?php echo APP_NAME; ?> Backup
            </a>
        </div>
        
        <div class="user-section">
            <a href="index.php" class="back-btn">
                <span class="icon-arrow-left"></span>
                Back to Settings
            </a>
            <div class="user-avatar">
                <?php echo strtoupper(substr($currentUser['first_name'], 0, 1)); ?>
            </div>
            <div class="user-info">
                <div class="user-name"><?php echo htmlspecialchars($userDisplayName); ?></div>
                <div class="user-role">Administrator</div>
            </div>
        </div>
    </div>

    <div class="main-container">
        <!-- Page Header -->
        <div class="page-header fade-in-up">
            <h1 class="page-title">
                <span class="icon-download"></span>
                Backup Management
            </h1>
            <p class="page-subtitle">Create, download, and manage database backups to protect your system data.</p>
        </div>

        <!-- Flash Messages -->
        <?php if ($flashMessages && isset($flashMessages['type']) && isset($flashMessages['message'])): ?>
            <div class="alert alert-<?php echo $flashMessages['type'] === 'error' ? 'error' : $flashMessages['type']; ?> fade-in-up">
                <span class="icon-<?php echo $flashMessages['type'] === 'error' ? 'warning' : 'check'; ?>"></span>
                <?php echo htmlspecialchars($flashMessages['message']); ?>
            </div>
        <?php endif; ?>

        <!-- Main Content Grid -->
        <div class="backup-grid fade-in-up">
            <!-- Left Column: Create Backup & Info -->
            <div>
                <!-- Create New Backup -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <span class="icon-plus"></span>
                            Create New Backup
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="POST" id="backupForm">
                            <input type="hidden" name="action" value="create_backup">
                            
                            <div class="form-group">
                                <label class="form-label" for="backup_type">Backup Type</label>
                                <select class="form-select" id="backup_type" name="backup_type" required>
                                    <option value="Full">Full Backup</option>
                                    <option value="Incremental">Incremental Backup</option>
                                </select>
                                <div class="form-text">
                                    Full backup includes all data. Incremental excludes logs.
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="include_uploads" name="include_uploads">
                                    <label class="form-check-label" for="include_uploads">
                                        Include Uploaded Files
                                    </label>
                                </div>
                                <div class="form-text">
                                    Creates a ZIP file with database and all uploads
                                </div>
                            </div>
                            
                            <div class="backup-info">
                                <h6>What will be backed up:</h6>
                                <ul class="backup-items">
                                    <li><span class="icon-database"></span> Database structure and data</li>
                                    <li><span class="icon-users"></span> User accounts and roles</li>
                                    <li><span class="icon-building"></span> Business and property records</li>
                                    <li><span class="icon-invoice"></span> Bills and payments</li>
                                    <li><span class="icon-cog"></span> System settings</li>
                                    <li id="uploads-item" style="display: none;"><span class="icon-folder"></span> Uploaded files</li>
                                </ul>
                            </div>
                            
                            <button type="submit" class="btn btn-success btn-block">
                                <span class="icon-download"></span>
                                Create Backup
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Backup Information -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <span class="icon-info"></span>
                            Backup Statistics
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="backup-stats">
                            <div class="stat-item">
                                <label>Total Backups:</label>
                                <span class="badge badge-primary"><?php echo count($backupFiles); ?></span>
                            </div>
                            <div class="stat-item">
                                <label>Storage Used:</label>
                                <span class="badge badge-info">
                                    <?php 
                                    $totalSize = array_sum(array_column($backupFiles, 'size'));
                                    echo formatBytes($totalSize);
                                    ?>
                                </span>
                            </div>
                            <div class="stat-item">
                                <label>Last Backup:</label>
                                <span class="badge badge-secondary">
                                    <?php 
                                    if (!empty($backupFiles)) {
                                        echo date('M d, Y H:i', $backupFiles[0]['created']);
                                    } else {
                                        echo 'Never';
                                    }
                                    ?>
                                </span>
                            </div>
                        </div>
                        
                        <div class="backup-recommendations">
                            <h6>Backup Best Practices:</h6>
                            <ul>
                                <li>Create regular backups before major updates</li>
                                <li>Store backups in multiple secure locations</li>
                                <li>Test backup restoration periodically</li>
                                <li>Keep at least 3 recent backups</li>
                                <li>Include uploads for complete data protection</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Backup Files & History -->
            <div>
                <!-- Available Backups -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <span class="icon-files"></span>
                            Available Backups (<?php echo count($backupFiles); ?>)
                        </h5>
                    </div>
                    <div class="card-body">
                        <?php if (empty($backupFiles)): ?>
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <span class="icon-folder"></span>
                                </div>
                                <h5>No Backups Found</h5>
                                <p>Create your first backup to get started with data protection.</p>
                            </div>
                        <?php else: ?>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Backup File</th>
                                            <th>Type</th>
                                            <th>Size</th>
                                            <th>Created</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($backupFiles as $backup): ?>
                                            <tr>
                                                <td>
                                                    <div class="file-item">
                                                        <span class="file-icon">
                                                            <?php echo str_ends_with($backup['filename'], '.zip') ? '📦' : '🗄️'; ?>
                                                        </span>
                                                        <div class="file-details">
                                                            <div class="file-name"><?php echo htmlspecialchars($backup['filename']); ?></div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="badge badge-<?php echo str_ends_with($backup['filename'], '.zip') ? 'success' : 'info'; ?>">
                                                        <?php echo $backup['type']; ?>
                                                    </span>
                                                </td>
                                                <td><?php echo formatBytes($backup['size']); ?></td>
                                                <td><?php echo date('M d, Y H:i', $backup['created']); ?></td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <form method="POST" style="display: inline;">
                                                            <input type="hidden" name="action" value="download_backup">
                                                            <input type="hidden" name="filename" value="<?php echo htmlspecialchars($backup['filename']); ?>">
                                                            <button type="submit" class="btn btn-outline-primary btn-sm" title="Download">
                                                                <span class="icon-download"></span>
                                                            </button>
                                                        </form>
                                                        
                                                        <form method="POST" style="display: inline;">
                                                            <input type="hidden" name="action" value="delete_backup">
                                                            <input type="hidden" name="filename" value="<?php echo htmlspecialchars($backup['filename']); ?>">
                                                            <button type="submit" class="btn btn-outline-danger btn-sm" title="Delete" 
                                                                    onclick="return confirm('Are you sure you want to delete this backup file?')">
                                                                <span class="icon-trash"></span>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>

                <!-- Backup History -->
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">
                            <span class="icon-history"></span>
                            Recent Backup Activity
                        </h5>
                    </div>
                    <div class="card-body">
                        <?php if (empty($backupLogs)): ?>
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <span class="icon-clock"></span>
                                </div>
                                <h5>No Activity Yet</h5>
                                <p>Backup activity will appear here once you create your first backup.</p>
                            </div>
                        <?php else: ?>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Type</th>
                                            <th>Status</th>
                                            <th>Size</th>
                                            <th>Created By</th>
                                            <th>Date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach (array_slice($backupLogs, 0, 10) as $log): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($log['backup_type']); ?></td>
                                                <td>
                                                    <span class="badge badge-<?php 
                                                        echo $log['status'] === 'Completed' ? 'success' : 
                                                             ($log['status'] === 'Failed' ? 'danger' : 'warning'); 
                                                    ?>">
                                                        <?php echo $log['status']; ?>
                                                    </span>
                                                </td>
                                                <td>
                                                    <?php echo $log['backup_size'] ? formatBytes($log['backup_size']) : '-'; ?>
                                                </td>
                                                <td>
                                                    <?php echo htmlspecialchars(($log['first_name'] ?? '') . ' ' . ($log['last_name'] ?? '')); ?>
                                                </td>
                                                <td><?php echo date('M d, Y H:i', strtotime($log['started_at'])); ?></td>
                                            </tr>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Show/hide uploads item based on checkbox
        document.getElementById('include_uploads').addEventListener('change', function() {
            const uploadsItem = document.getElementById('uploads-item');
            uploadsItem.style.display = this.checked ? 'list-item' : 'none';
        });

        // Form submission handler
        document.getElementById('backupForm').addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            
            // Show loading state
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="icon-download"></span> Creating Backup...';
            
            // Show progress message
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-info';
            alertDiv.style.marginTop = '20px';
            alertDiv.innerHTML = '<span class="icon-info"></span> Creating backup... This may take a few minutes depending on database size and selected options.';
            this.appendChild(alertDiv);
            
            // Re-enable after 2 minutes (fallback)
            setTimeout(() => {
                submitBtn.classList.remove('loading');
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
                if (alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 120000);
        });

        // Auto-dismiss alerts
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    alert.style.opacity = '0';
                    alert.style.transition = 'opacity 0.3s';
                    setTimeout(() => alert.remove(), 300);
                });
            }, 5000);
        });

        // Confirmation for delete actions
        document.querySelectorAll('form button[title="Delete"]').forEach(button => {
            button.addEventListener('click', function(e) {
                e.preventDefault();
                if (confirm('Are you sure you want to delete this backup file? This action cannot be undone.')) {
                    this.closest('form').submit();
                }
            });
        });
    </script>
</body>
</html>