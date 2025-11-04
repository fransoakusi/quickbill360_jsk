<?php
/**
 * Audit Reports Generation - Internal Auditor
 * Generate various audit reports with customizable filters
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

// Handle report generation
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['generate_report'])) {
    if (!verifyCsrfToken()) {
        setFlashMessage('error', 'Security validation failed');
    } else {
        $reportType = sanitizeInput($_POST['report_type']);
        $dateFrom = sanitizeInput($_POST['date_from']);
        $dateTo = sanitizeInput($_POST['date_to']);
        $format = sanitizeInput($_POST['format']);
        
        // Save report metadata
        try {
            $reportData = generateReportData($reportType, $dateFrom, $dateTo, $db);
            
            $query = "
                INSERT INTO audit_reports 
                (report_title, report_type, date_from, date_to, report_data, generated_by)
                VALUES (?, ?, ?, ?, ?, ?)
            ";
            
            $reportTitle = ucfirst(str_replace('_', ' ', $reportType)) . " Report - " . date('Y-m-d H:i');
            
            $db->execute($query, [
                $reportTitle,
                $reportType,
                $dateFrom,
                $dateTo,
                json_encode($reportData),
                $currentUser['user_id']
            ]);
            
            logUserAction('GENERATE_AUDIT_REPORT', 'audit_reports', $db->lastInsertId());
            
            setFlashMessage('success', 'Report generated successfully');
            
            // Redirect to download
            $_SESSION['report_data'] = $reportData;
            $_SESSION['report_type'] = $reportType;
            $_SESSION['report_format'] = $format;
            header('Location: download_report.php');
            exit();
            
        } catch (Exception $e) {
            setFlashMessage('error', 'Error generating report: ' . $e->getMessage());
        }
    }
}

// Get recent reports
$recentReports = $db->fetchAll("
    SELECT 
        ar.*,
        CONCAT(u.first_name, ' ', u.last_name) as generated_by_name
    FROM audit_reports ar
    LEFT JOIN users u ON ar.generated_by = u.user_id
    WHERE ar.generated_by = ?
    ORDER BY ar.generated_at DESC
    LIMIT 10
", [$currentUser['user_id']]);

/**
 * Generate report data based on type
 */
function generateReportData($reportType, $dateFrom, $dateTo, $db) {
    $data = [];
    
    switch ($reportType) {
        case 'user_activity':
            $data = $db->fetchAll("
                SELECT 
                    al.action,
                    al.table_name,
                    al.created_at,
                    u.username,
                    CONCAT(u.first_name, ' ', u.last_name) as user_name,
                    ur.role_name,
                    al.ip_address
                FROM audit_logs al
                LEFT JOIN users u ON al.user_id = u.user_id
                LEFT JOIN user_roles ur ON u.role_id = ur.role_id
                WHERE DATE(al.created_at) BETWEEN ? AND ?
                ORDER BY al.created_at DESC
            ", [$dateFrom, $dateTo]);
            break;
            
        case 'payment_audit':
            $data = $db->fetchAll("
                SELECT 
                    p.payment_reference,
                    p.payment_date,
                    p.amount_paid,
                    p.payment_method,
                    p.payment_status,
                    b.bill_number,
                    b.bill_type,
                    CASE 
                        WHEN b.bill_type = 'Business' THEN bs.business_name
                        WHEN b.bill_type = 'Property' THEN pr.owner_name
                    END as account_name,
                    CONCAT(u.first_name, ' ', u.last_name) as processed_by
                FROM payments p
                LEFT JOIN bills b ON p.bill_id = b.bill_id
                LEFT JOIN businesses bs ON b.bill_type = 'Business' AND b.reference_id = bs.business_id
                LEFT JOIN properties pr ON b.bill_type = 'Property' AND b.reference_id = pr.property_id
                LEFT JOIN users u ON p.processed_by = u.user_id
                WHERE DATE(p.payment_date) BETWEEN ? AND ?
                ORDER BY p.payment_date DESC
            ", [$dateFrom, $dateTo]);
            break;
            
        case 'bill_generation':
            $data = $db->fetchAll("
                SELECT 
                    b.bill_number,
                    b.bill_type,
                    b.billing_year,
                    b.current_bill,
                    b.amount_payable,
                    b.status,
                    b.generated_at,
                    CASE 
                        WHEN b.bill_type = 'Business' THEN bs.business_name
                        WHEN b.bill_type = 'Property' THEN pr.owner_name
                    END as account_name,
                    CASE 
                        WHEN b.bill_type = 'Business' THEN bs.account_number
                        WHEN b.bill_type = 'Property' THEN pr.property_number
                    END as account_number,
                    CONCAT(u.first_name, ' ', u.last_name) as generated_by
                FROM bills b
                LEFT JOIN businesses bs ON b.bill_type = 'Business' AND b.reference_id = bs.business_id
                LEFT JOIN properties pr ON b.bill_type = 'Property' AND b.reference_id = pr.property_id
                LEFT JOIN users u ON b.generated_by = u.user_id
                WHERE DATE(b.generated_at) BETWEEN ? AND ?
                ORDER BY b.generated_at DESC
            ", [$dateFrom, $dateTo]);
            break;
            
        case 'system_changes':
            $data = $db->fetchAll("
                SELECT 
                    al.action,
                    al.table_name,
                    al.record_id,
                    al.old_values,
                    al.new_values,
                    al.created_at,
                    CONCAT(u.first_name, ' ', u.last_name) as changed_by,
                    ur.role_name
                FROM audit_logs al
                LEFT JOIN users u ON al.user_id = u.user_id
                LEFT JOIN user_roles ur ON u.role_id = ur.role_id
                WHERE DATE(al.created_at) BETWEEN ? AND ?
                AND al.action IN ('UPDATE', 'CREATE', 'DELETE', 'SYSTEM_SETTINGS_CHANGE')
                ORDER BY al.created_at DESC
            ", [$dateFrom, $dateTo]);
            break;
            
        case 'financial_summary':
            $data = [
                'total_payments' => $db->fetchRow("
                    SELECT 
                        COUNT(*) as count,
                        SUM(amount_paid) as total,
                        AVG(amount_paid) as average
                    FROM payments
                    WHERE payment_status = 'Successful'
                    AND DATE(payment_date) BETWEEN ? AND ?
                ", [$dateFrom, $dateTo]),
                
                'payment_methods' => $db->fetchAll("
                    SELECT 
                        payment_method,
                        COUNT(*) as count,
                        SUM(amount_paid) as total
                    FROM payments
                    WHERE payment_status = 'Successful'
                    AND DATE(payment_date) BETWEEN ? AND ?
                    GROUP BY payment_method
                ", [$dateFrom, $dateTo]),
                
                'bills_generated' => $db->fetchRow("
                    SELECT 
                        COUNT(*) as count,
                        SUM(current_bill) as total_billed,
                        SUM(amount_payable) as total_outstanding
                    FROM bills
                    WHERE DATE(generated_at) BETWEEN ? AND ?
                ", [$dateFrom, $dateTo]),
                
                'payment_status' => $db->fetchAll("
                    SELECT 
                        status,
                        COUNT(*) as count,
                        SUM(amount_payable) as total
                    FROM bills
                    WHERE DATE(generated_at) BETWEEN ? AND ?
                    GROUP BY status
                ", [$dateFrom, $dateTo])
            ];
            break;
    }
    
    return $data;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Audit Reports - Internal Auditor</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            padding: 20px;
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
            margin-bottom: 5px;
        }
        
        .page-subtitle {
            color: #718096;
            font-size: 14px;
        }
        
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            font-size: 14px;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #3498db;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
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
        
        .btn-block {
            width: 100%;
        }
        
        .report-type-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 10px;
        }
        
        .report-type-option {
            padding: 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .report-type-option:hover {
            border-color: #3498db;
            background: #f7fafc;
        }
        
        .report-type-option input[type="radio"] {
            margin-right: 10px;
        }
        
        .report-type-option label {
            cursor: pointer;
            font-weight: 500;
        }
        
        .report-description {
            font-size: 12px;
            color: #718096;
            margin-top: 5px;
            margin-left: 25px;
        }
        
        .recent-reports-list {
            list-style: none;
        }
        
        .report-item {
            padding: 15px;
            border-bottom: 1px solid #e2e8f0;
            transition: background 0.3s;
        }
        
        .report-item:hover {
            background: #f7fafc;
        }
        
        .report-item:last-child {
            border-bottom: none;
        }
        
        .report-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
        }
        
        .report-meta {
            font-size: 12px;
            color: #718096;
        }
        
        .alert {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .info-box {
            background: #e7f3ff;
            border-left: 4px solid #3498db;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        
        .info-box-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
        }
        
        .info-box-text {
            font-size: 13px;
            color: #4a5568;
        }
        
        @media (max-width: 768px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <?php
    $messages = getFlashMessages();
    foreach ($messages as $message):
    ?>
    <div class="alert alert-<?php echo $message['type'] === 'success' ? 'success' : 'error'; ?>">
        <?php echo htmlspecialchars($message['message']); ?>
    </div>
    <?php endforeach; ?>
    
    <div class="page-header">
        <h1 class="page-title">Audit Reports</h1>
        <p class="page-subtitle">Generate comprehensive audit reports for analysis and compliance</p>
    </div>
    
    <div class="content-grid">
        <!-- Generate New Report -->
        <div class="card">
            <h2 class="card-title">Generate New Report</h2>
            
            <div class="info-box">
                <div class="info-box-title">Report Generation</div>
                <div class="info-box-text">
                    Select a report type and date range to generate a comprehensive audit report. 
                    Reports can be exported in PDF, Excel, or CSV format.
                </div>
            </div>
            
            <form method="POST" action="">
                <?php echo csrfField(); ?>
                <input type="hidden" name="generate_report" value="1">
                
                <div class="form-group">
                    <label class="form-label">Report Type</label>
                    <div class="report-type-grid">
                        <div class="report-type-option">
                            <input type="radio" name="report_type" value="user_activity" id="type1" required>
                            <label for="type1">User Activity Report</label>
                            <div class="report-description">
                                Complete log of all user actions and system activities
                            </div>
                        </div>
                        
                        <div class="report-type-option">
                            <input type="radio" name="report_type" value="payment_audit" id="type2">
                            <label for="type2">Payment Audit Report</label>
                            <div class="report-description">
                                Detailed analysis of all payment transactions
                            </div>
                        </div>
                        
                        <div class="report-type-option">
                            <input type="radio" name="report_type" value="bill_generation" id="type3">
                            <label for="type3">Bill Generation Report</label>
                            <div class="report-description">
                                Summary of all bills generated and their status
                            </div>
                        </div>
                        
                        <div class="report-type-option">
                            <input type="radio" name="report_type" value="system_changes" id="type4">
                            <label for="type4">System Changes Report</label>
                            <div class="report-description">
                                Track all system modifications and configuration changes
                            </div>
                        </div>
                        
                        <div class="report-type-option">
                            <input type="radio" name="report_type" value="financial_summary" id="type5">
                            <label for="type5">Financial Summary Report</label>
                            <div class="report-description">
                                Comprehensive financial analysis and statistics
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Date From</label>
                    <input type="date" name="date_from" class="form-control" 
                           value="<?php echo date('Y-m-01'); ?>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Date To</label>
                    <input type="date" name="date_to" class="form-control" 
                           value="<?php echo date('Y-m-d'); ?>" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Export Format</label>
                    <select name="format" class="form-control" required>
                        <option value="pdf">PDF Document</option>
                        <option value="excel">Excel Spreadsheet</option>
                        <option value="csv">CSV File</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block">
                    Generate Report
                </button>
            </form>
        </div>
        
        <!-- Recent Reports -->
        <div class="card">
            <h2 class="card-title">Recent Reports</h2>
            
            <?php if (!empty($recentReports)): ?>
            <ul class="recent-reports-list">
                <?php foreach ($recentReports as $report): ?>
                <li class="report-item">
                    <div class="report-title">
                        <?php echo htmlspecialchars($report['report_title']); ?>
                    </div>
                    <div class="report-meta">
                        Type: <?php echo ucfirst(str_replace('_', ' ', $report['report_type'])); ?> |
                        Period: <?php echo date('M j, Y', strtotime($report['date_from'])); ?> - 
                        <?php echo date('M j, Y', strtotime($report['date_to'])); ?> |
                        Generated: <?php echo formatDateTime($report['generated_at']); ?>
                    </div>
                </li>
                <?php endforeach; ?>
            </ul>
            <?php else: ?>
            <p style="text-align: center; color: #718096; padding: 40px;">
                No reports generated yet. Create your first report above.
            </p>
            <?php endif; ?>
            
            <div style="margin-top: 20px;">
                <a href="index.php" class="btn btn-secondary btn-block">
                    Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</body>
</html>