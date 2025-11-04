<?php
/**
 * Download Report Handler - Internal Auditor
 * Handles report download in various formats
 */

define('QUICKBILL_305', true);

require_once '../config/config.php';
require_once '../config/database.php';
require_once '../includes/functions.php';

session_start();

require_once '../includes/auth.php';

if (!isLoggedIn() || !isInternalAuditor()) {
    header('Location: ../auth/login.php');
    exit();
}

// Get report data from session
if (!isset($_SESSION['report_data']) || !isset($_SESSION['report_type']) || !isset($_SESSION['report_format'])) {
    setFlashMessage('error', 'No report data available');
    header('Location: reports.php');
    exit();
}

$reportData = $_SESSION['report_data'];
$reportType = $_SESSION['report_type'];
$format = $_SESSION['report_format'];

// Clear session data
unset($_SESSION['report_data']);
unset($_SESSION['report_type']);
unset($_SESSION['report_format']);

$filename = str_replace('_', '-', $reportType) . '_report_' . date('Y-m-d_H-i-s');

// Handle different formats
switch ($format) {
    case 'csv':
        downloadCSV($reportData, $reportType, $filename);
        break;
    case 'excel':
        downloadExcel($reportData, $reportType, $filename);
        break;
    case 'pdf':
        downloadPDF($reportData, $reportType, $filename);
        break;
    default:
        setFlashMessage('error', 'Invalid format');
        header('Location: reports.php');
        exit();
}

/**
 * Download report as CSV
 */
function downloadCSV($data, $type, $filename) {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filename . '.csv"');
    header('Pragma: no-cache');
    header('Expires: 0');
    
    $output = fopen('php://output', 'w');
    fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF)); // BOM for Excel
    
    if ($type === 'financial_summary') {
        // Special handling for financial summary
        fputcsv($output, ['FINANCIAL SUMMARY REPORT']);
        fputcsv($output, ['Generated: ' . date('Y-m-d H:i:s')]);
        fputcsv($output, []);
        
        // Total Payments
        fputcsv($output, ['Total Payments']);
        fputcsv($output, ['Count', 'Total Amount', 'Average Amount']);
        fputcsv($output, [
            $data['total_payments']['count'] ?? 0,
            '₵ ' . number_format($data['total_payments']['total'] ?? 0, 2),
            '₵ ' . number_format($data['total_payments']['average'] ?? 0, 2)
        ]);
        fputcsv($output, []);
        
        // Payment Methods
        fputcsv($output, ['Payment Methods Breakdown']);
        fputcsv($output, ['Method', 'Count', 'Total']);
        foreach ($data['payment_methods'] as $method) {
            fputcsv($output, [
                $method['payment_method'],
                $method['count'],
                '₵ ' . number_format($method['total'], 2)
            ]);
        }
        
    } else {
        // Regular data export
        if (!empty($data)) {
            // Headers from first row keys
            fputcsv($output, array_keys($data[0]));
            
            // Data rows
            foreach ($data as $row) {
                fputcsv($output, $row);
            }
        }
    }
    
    fclose($output);
    exit();
}

/**
 * Download report as Excel (HTML table that Excel can read)
 */
function downloadExcel($data, $type, $filename) {
    header('Content-Type: application/vnd.ms-excel');
    header('Content-Disposition: attachment; filename="' . $filename . '.xls"');
    header('Pragma: no-cache');
    header('Expires: 0');
    
    echo '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel">';
    echo '<head><meta charset="utf-8"></head>';
    echo '<body>';
    echo '<table border="1">';
    
    if ($type === 'financial_summary') {
        echo '<tr><th colspan="3" style="background: #3498db; color: white;">FINANCIAL SUMMARY REPORT</th></tr>';
        echo '<tr><td colspan="3">Generated: ' . date('Y-m-d H:i:s') . '</td></tr>';
        echo '<tr><td colspan="3">&nbsp;</td></tr>';
        
        echo '<tr><th colspan="3" style="background: #95a5a6;">Total Payments</th></tr>';
        echo '<tr><th>Count</th><th>Total Amount</th><th>Average Amount</th></tr>';
        echo '<tr>';
        echo '<td>' . ($data['total_payments']['count'] ?? 0) . '</td>';
        echo '<td>₵ ' . number_format($data['total_payments']['total'] ?? 0, 2) . '</td>';
        echo '<td>₵ ' . number_format($data['total_payments']['average'] ?? 0, 2) . '</td>';
        echo '</tr>';
        
        echo '<tr><td colspan="3">&nbsp;</td></tr>';
        echo '<tr><th colspan="3" style="background: #95a5a6;">Payment Methods Breakdown</th></tr>';
        echo '<tr><th>Method</th><th>Count</th><th>Total</th></tr>';
        foreach ($data['payment_methods'] as $method) {
            echo '<tr>';
            echo '<td>' . htmlspecialchars($method['payment_method']) . '</td>';
            echo '<td>' . $method['count'] . '</td>';
            echo '<td>₵ ' . number_format($method['total'], 2) . '</td>';
            echo '</tr>';
        }
    } else {
        if (!empty($data)) {
            // Header row
            echo '<tr style="background: #3498db; color: white;">';
            foreach (array_keys($data[0]) as $header) {
                echo '<th>' . htmlspecialchars(ucwords(str_replace('_', ' ', $header))) . '</th>';
            }
            echo '</tr>';
            
            // Data rows
            foreach ($data as $row) {
                echo '<tr>';
                foreach ($row as $cell) {
                    echo '<td>' . htmlspecialchars($cell ?? '') . '</td>';
                }
                echo '</tr>';
            }
        }
    }
    
    echo '</table>';
    echo '</body></html>';
    exit();
}

/**
 * Download report as PDF (simplified HTML version)
 */
function downloadPDF($data, $type, $filename) {
    // For basic PDF, we'll output HTML that can be printed to PDF
    // In production, use a library like TCPDF or mPDF for proper PDF generation
    
    header('Content-Type: text/html; charset=utf-8');
    
    echo '<!DOCTYPE html>';
    echo '<html><head>';
    echo '<meta charset="utf-8">';
    echo '<title>' . ucfirst(str_replace('_', ' ', $type)) . ' Report</title>';
    echo '<style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h1 { color: #2c3e50; border-bottom: 3px solid #3498db; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #3498db; color: white; padding: 12px; text-align: left; }
        td { padding: 10px; border-bottom: 1px solid #ddd; }
        tr:nth-child(even) { background: #f8f9fa; }
        .header { margin-bottom: 20px; }
        .date { color: #7f8c8d; font-size: 14px; }
        @media print {
            button { display: none; }
        }
    </style>';
    echo '</head><body>';
    
    echo '<div class="header">';
    echo '<h1>' . ucfirst(str_replace('_', ' ', $type)) . ' Report</h1>';
    echo '<p class="date">Generated: ' . date('F j, Y g:i A') . '</p>';
    echo '<button onclick="window.print()">Print to PDF</button>';
    echo '</div>';
    
    echo '<table>';
    
    if ($type === 'financial_summary') {
        echo '<tr><th colspan="3">Total Payments Summary</th></tr>';
        echo '<tr><th>Metric</th><th>Value</th><th></th></tr>';
        echo '<tr><td>Total Count</td><td>' . ($data['total_payments']['count'] ?? 0) . '</td><td></td></tr>';
        echo '<tr><td>Total Amount</td><td>₵ ' . number_format($data['total_payments']['total'] ?? 0, 2) . '</td><td></td></tr>';
        echo '<tr><td>Average Amount</td><td>₵ ' . number_format($data['total_payments']['average'] ?? 0, 2) . '</td><td></td></tr>';
        
        echo '<tr><th colspan="3">Payment Methods</th></tr>';
        echo '<tr><th>Method</th><th>Count</th><th>Total</th></tr>';
        foreach ($data['payment_methods'] as $method) {
            echo '<tr>';
            echo '<td>' . htmlspecialchars($method['payment_method']) . '</td>';
            echo '<td>' . $method['count'] . '</td>';
            echo '<td>₵ ' . number_format($method['total'], 2) . '</td>';
            echo '</tr>';
        }
    } else {
        if (!empty($data)) {
            echo '<tr>';
            foreach (array_keys($data[0]) as $header) {
                echo '<th>' . htmlspecialchars(ucwords(str_replace('_', ' ', $header))) . '</th>';
            }
            echo '</tr>';
            
            foreach ($data as $row) {
                echo '<tr>';
                foreach ($row as $cell) {
                    echo '<td>' . htmlspecialchars($cell ?? '') . '</td>';
                }
                echo '</tr>';
            }
        }
    }
    
    echo '</table>';
    echo '</body></html>';
    exit();
}
?>