<?php
/**
 * Audit Findings Management - Internal Auditor
 * Create, view, and manage audit findings
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

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    if (!verifyCsrfToken()) {
        setFlashMessage('error', 'Security validation failed');
    } else {
        $action = $_POST['action'];
        
        if ($action === 'create_finding') {
            try {
                $query = "
                    INSERT INTO audit_findings 
                    (finding_title, severity, category, description, affected_module, 
                     record_reference, recommendations, status, identified_by)
                    VALUES (?, ?, ?, ?, ?, ?, ?, 'Open', ?)
                ";
                
                $result = $db->execute($query, [
                    sanitizeInput($_POST['finding_title']),
                    sanitizeInput($_POST['severity']),
                    sanitizeInput($_POST['category']),
                    sanitizeInput($_POST['description']),
                    sanitizeInput($_POST['affected_module']),
                    sanitizeInput($_POST['record_reference']),
                    sanitizeInput($_POST['recommendations']),
                    $currentUser['user_id']
                ]);
                
                if ($result) {
                    logUserAction('CREATE_AUDIT_FINDING', 'audit_findings', $db->lastInsertId());
                    setFlashMessage('success', 'Audit finding created successfully');
                    header('Location: findings.php');
                    exit();
                }
            } catch (Exception $e) {
                setFlashMessage('error', 'Error creating finding: ' . $e->getMessage());
            }
        }
        
        if ($action === 'update_finding') {
            try {
                $findingId = (int)$_POST['finding_id'];
                
                $query = "
                    UPDATE audit_findings 
                    SET finding_title = ?, severity = ?, category = ?, description = ?,
                        affected_module = ?, record_reference = ?, recommendations = ?,
                        status = ?
                    WHERE finding_id = ?
                ";
                
                $result = $db->execute($query, [
                    sanitizeInput($_POST['finding_title']),
                    sanitizeInput($_POST['severity']),
                    sanitizeInput($_POST['category']),
                    sanitizeInput($_POST['description']),
                    sanitizeInput($_POST['affected_module']),
                    sanitizeInput($_POST['record_reference']),
                    sanitizeInput($_POST['recommendations']),
                    sanitizeInput($_POST['status']),
                    $findingId
                ]);
                
                if ($result) {
                    logUserAction('UPDATE_AUDIT_FINDING', 'audit_findings', $findingId);
                    setFlashMessage('success', 'Audit finding updated successfully');
                    header('Location: findings.php');
                    exit();
                }
            } catch (Exception $e) {
                setFlashMessage('error', 'Error updating finding: ' . $e->getMessage());
            }
        }
    }
}

// Get findings
$findings = $db->fetchAll("
    SELECT 
        af.*,
        CONCAT(u.first_name, ' ', u.last_name) as identified_by_name,
        CONCAT(ru.first_name, ' ', ru.last_name) as resolved_by_name
    FROM audit_findings af
    LEFT JOIN users u ON af.identified_by = u.user_id
    LEFT JOIN users ru ON af.resolved_by = ru.user_id
    ORDER BY af.identified_at DESC
");

// Get statistics
$stats = [
    'total' => count($findings),
    'open' => count(array_filter($findings, fn($f) => $f['status'] === 'Open')),
    'under_review' => count(array_filter($findings, fn($f) => $f['status'] === 'Under Review')),
    'resolved' => count(array_filter($findings, fn($f) => $f['status'] === 'Resolved')),
    'critical' => count(array_filter($findings, fn($f) => $f['severity'] === 'Critical' && $f['status'] !== 'Closed'))
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Audit Findings - Internal Auditor</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-title {
            font-size: 24px;
            font-weight: bold;
            color: #2d3748;
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
        
        .btn-primary { background: #3498db; color: white; }
        .btn-secondary { background: #718096; color: white; }
        .btn-success { background: #27ae60; color: white; }
        .btn:hover { opacity: 0.9; }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        
        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .stat-card.critical { border-left: 4px solid #e74c3c; }
        .stat-card.warning { border-left: 4px solid #f39c12; }
        .stat-card.info { border-left: 4px solid #3498db; }
        .stat-card.success { border-left: 4px solid #27ae60; }
        
        .stat-value {
            font-size: 32px;
            font-weight: bold;
            color: #2d3748;
        }
        
        .stat-label {
            font-size: 12px;
            color: #718096;
            text-transform: uppercase;
            margin-top: 5px;
        }
        
        .findings-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .finding-card {
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s;
        }
        
        .finding-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        .finding-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }
        
        .finding-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 5px;
        }
        
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            margin-right: 5px;
        }
        
        .badge-critical { background: #f8d7da; color: #721c24; }
        .badge-high { background: #fff3cd; color: #856404; }
        .badge-medium { background: #d1ecf1; color: #0c5460; }
        .badge-low { background: #d4edda; color: #155724; }
        
        .badge-open { background: #fff3cd; color: #856404; }
        .badge-review { background: #d1ecf1; color: #0c5460; }
        .badge-resolved { background: #d4edda; color: #155724; }
        .badge-closed { background: #e2e8f0; color: #4a5568; }
        
        .finding-meta {
            color: #718096;
            font-size: 13px;
            margin-bottom: 10px;
        }
        
        .finding-description {
            color: #4a5568;
            line-height: 1.6;
            margin-bottom: 10px;
        }
        
        .finding-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        
        .action-link {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            font-size: 14px;
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
        
        .modal.show { display: flex; }
        
        .modal-content {
            background: white;
            border-radius: 10px;
            padding: 30px;
            max-width: 800px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
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
        
        textarea.form-control {
            min-height: 100px;
            resize: vertical;
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
        <div>
            <h1 class="page-title">Audit Findings</h1>
            <p style="color: #718096; margin-top: 5px;">Track and manage audit findings and issues</p>
        </div>
        <div style="display: flex; gap: 10px;">
            <a href="index.php" class="btn btn-secondary">Back to Dashboard</a>
            <button onclick="showCreateModal()" class="btn btn-primary">+ New Finding</button>
        </div>
    </div>
    
    <div class="stats-grid">
        <div class="stat-card critical">
            <div class="stat-value"><?php echo $stats['critical']; ?></div>
            <div class="stat-label">Critical Issues</div>
        </div>
        <div class="stat-card warning">
            <div class="stat-value"><?php echo $stats['open']; ?></div>
            <div class="stat-label">Open Findings</div>
        </div>
        <div class="stat-card info">
            <div class="stat-value"><?php echo $stats['under_review']; ?></div>
            <div class="stat-label">Under Review</div>
        </div>
        <div class="stat-card success">
            <div class="stat-value"><?php echo $stats['resolved']; ?></div>
            <div class="stat-label">Resolved</div>
        </div>
    </div>
    
    <div class="findings-container">
        <h3 style="margin-bottom: 20px; color: #2d3748;">All Findings</h3>
        
        <?php if (!empty($findings)): ?>
            <?php foreach ($findings as $finding): ?>
            <div class="finding-card">
                <div class="finding-header">
                    <div>
                        <div class="finding-title"><?php echo htmlspecialchars($finding['finding_title']); ?></div>
                        <div class="finding-meta">
                            <span class="badge badge-<?php 
                                echo strtolower($finding['severity']); 
                            ?>"><?php echo $finding['severity']; ?></span>
                            <span class="badge badge-<?php 
                                echo strtolower(str_replace(' ', '', $finding['status'])); 
                            ?>"><?php echo $finding['status']; ?></span>
                            <span><?php echo $finding['category']; ?></span>
                            •
                            <span>Identified by: <?php echo htmlspecialchars($finding['identified_by_name']); ?></span>
                            •
                            <span><?php echo formatDate($finding['identified_at']); ?></span>
                        </div>
                    </div>
                </div>
                
                <div class="finding-description">
                    <?php echo nl2br(htmlspecialchars($finding['description'])); ?>
                </div>
                
                <?php if ($finding['affected_module']): ?>
                <div style="color: #718096; font-size: 13px;">
                    <strong>Affected Module:</strong> <?php echo htmlspecialchars($finding['affected_module']); ?>
                    <?php if ($finding['record_reference']): ?>
                        | <strong>Reference:</strong> <?php echo htmlspecialchars($finding['record_reference']); ?>
                    <?php endif; ?>
                </div>
                <?php endif; ?>
                
                <div class="finding-actions">
                    <a href="#" onclick="viewFinding(<?php echo $finding['finding_id']; ?>); return false;" class="action-link">
                        View Details
                    </a>
                    <a href="#" onclick="editFinding(<?php echo $finding['finding_id']; ?>); return false;" class="action-link">
                        Edit
                    </a>
                </div>
            </div>
            <?php endforeach; ?>
        <?php else: ?>
            <p style="text-align: center; color: #718096; padding: 40px;">
                No audit findings recorded yet. Click "New Finding" to create one.
            </p>
        <?php endif; ?>
    </div>
    
    <!-- Create/Edit Modal -->
    <div id="findingModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalTitle">New Audit Finding</h2>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <form method="POST" action="" id="findingForm">
                <?php echo csrfField(); ?>
                <input type="hidden" name="action" id="formAction" value="create_finding">
                <input type="hidden" name="finding_id" id="findingId">
                
                <div class="form-group">
                    <label class="form-label">Category *</label>
                    <select name="category" id="category" class="form-control" required>
                        <option value="Financial">Financial</option>
                        <option value="Operational">Operational</option>
                        <option value="Compliance">Compliance</option>
                        <option value="Security">Security</option>
                        <option value="Data Integrity">Data Integrity</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Description *</label>
                    <textarea name="description" id="description" class="form-control" required></textarea>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Affected Module</label>
                    <input type="text" name="affected_module" id="affectedModule" class="form-control" 
                           placeholder="e.g., Payments, Businesses, Users">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Record Reference</label>
                    <input type="text" name="record_reference" id="recordReference" class="form-control" 
                           placeholder="e.g., Payment ID, Business ID">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Recommendations</label>
                    <textarea name="recommendations" id="recommendations" class="form-control"></textarea>
                </div>
                
                <div class="form-group" id="statusGroup" style="display: none;">
                    <label class="form-label">Status</label>
                    <select name="status" id="status" class="form-control">
                        <option value="Open">Open</option>
                        <option value="Under Review">Under Review</option>
                        <option value="Resolved">Resolved</option>
                        <option value="Closed">Closed</option>
                    </select>
                </div>
                
                <div style="display: flex; gap: 10px; justify-content: flex-end;">
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-success">Save Finding</button>
                </div>
            </form>
        </div>
    </div>
    
    <!-- View Details Modal -->
    <div id="viewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Finding Details</h2>
                <button class="close-btn" onclick="closeViewModal()">&times;</button>
            </div>
            <div id="viewContent"></div>
        </div>
    </div>
    
    <script>
        const findings = <?php echo json_encode($findings); ?>;
        
        function showCreateModal() {
            document.getElementById('modalTitle').textContent = 'New Audit Finding';
            document.getElementById('formAction').value = 'create_finding';
            document.getElementById('findingForm').reset();
            document.getElementById('statusGroup').style.display = 'none';
            document.getElementById('findingModal').classList.add('show');
        }
        
        function editFinding(id) {
            const finding = findings.find(f => f.finding_id == id);
            if (!finding) return;
            
            document.getElementById('modalTitle').textContent = 'Edit Audit Finding';
            document.getElementById('formAction').value = 'update_finding';
            document.getElementById('findingId').value = finding.finding_id;
            document.getElementById('findingTitle').value = finding.finding_title;
            document.getElementById('severity').value = finding.severity;
            document.getElementById('category').value = finding.category;
            document.getElementById('description').value = finding.description;
            document.getElementById('affectedModule').value = finding.affected_module || '';
            document.getElementById('recordReference').value = finding.record_reference || '';
            document.getElementById('recommendations').value = finding.recommendations || '';
            document.getElementById('status').value = finding.status;
            document.getElementById('statusGroup').style.display = 'block';
            
            document.getElementById('findingModal').classList.add('show');
        }
        
        function viewFinding(id) {
            const finding = findings.find(f => f.finding_id == id);
            if (!finding) return;
            
            let html = '<div>';
            html += '<div style="margin-bottom: 15px;"><strong>Title:</strong><br>' + finding.finding_title + '</div>';
            html += '<div style="margin-bottom: 15px;"><strong>Severity:</strong> <span class="badge badge-' + finding.severity.toLowerCase() + '">' + finding.severity + '</span></div>';
            html += '<div style="margin-bottom: 15px;"><strong>Category:</strong> ' + finding.category + '</div>';
            html += '<div style="margin-bottom: 15px;"><strong>Status:</strong> <span class="badge badge-' + finding.status.toLowerCase().replace(' ', '') + '">' + finding.status + '</span></div>';
            html += '<div style="margin-bottom: 15px;"><strong>Description:</strong><br>' + finding.description.replace(/\n/g, '<br>') + '</div>';
            
            if (finding.affected_module) {
                html += '<div style="margin-bottom: 15px;"><strong>Affected Module:</strong> ' + finding.affected_module + '</div>';
            }
            
            if (finding.record_reference) {
                html += '<div style="margin-bottom: 15px;"><strong>Record Reference:</strong> ' + finding.record_reference + '</div>';
            }
            
            if (finding.recommendations) {
                html += '<div style="margin-bottom: 15px;"><strong>Recommendations:</strong><br>' + finding.recommendations.replace(/\n/g, '<br>') + '</div>';
            }
            
            html += '<div style="margin-bottom: 15px;"><strong>Identified By:</strong> ' + finding.identified_by_name + '</div>';
            html += '<div style="margin-bottom: 15px;"><strong>Identified At:</strong> ' + finding.identified_at + '</div>';
            
            if (finding.resolved_by_name) {
                html += '<div style="margin-bottom: 15px;"><strong>Resolved By:</strong> ' + finding.resolved_by_name + '</div>';
                html += '<div style="margin-bottom: 15px;"><strong>Resolved At:</strong> ' + finding.resolved_at + '</div>';
            }
            
            if (finding.resolution_notes) {
                html += '<div style="margin-bottom: 15px;"><strong>Resolution Notes:</strong><br>' + finding.resolution_notes.replace(/\n/g, '<br>') + '</div>';
            }
            
            html += '</div>';
            
            document.getElementById('viewContent').innerHTML = html;
            document.getElementById('viewModal').classList.add('show');
        }
        
        function closeModal() {
            document.getElementById('findingModal').classList.remove('show');
        }
        
        function closeViewModal() {
            document.getElementById('viewModal').classList.remove('show');
        }
        
        window.onclick = function(event) {
            const findingModal = document.getElementById('findingModal');
            const viewModal = document.getElementById('viewModal');
            
            if (event.target == findingModal) {
                closeModal();
            }
            if (event.target == viewModal) {
                closeViewModal();
            }
        }
    </script>
</body>
</html>