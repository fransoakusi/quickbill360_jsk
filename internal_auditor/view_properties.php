<?php
/**
 * View Properties - Internal Auditor (Read-Only)
 * Display all properties with filtering - NO edit/delete capabilities
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
$propertyUse = $_GET['property_use'] ?? '';
$zone = $_GET['zone'] ?? '';

// Build query
$where = [];
$params = [];

if (!empty($search)) {
    $where[] = "(owner_name LIKE ? OR property_number LIKE ? OR location LIKE ?)";
    $searchTerm = '%' . $search . '%';
    $params[] = $searchTerm;
    $params[] = $searchTerm;
    $params[] = $searchTerm;
}

if (!empty($propertyUse)) {
    $where[] = "property_use = ?";
    $params[] = $propertyUse;
}

if (!empty($zone)) {
    $where[] = "zone_id = ?";
    $params[] = $zone;
}

$whereClause = !empty($where) ? 'WHERE ' . implode(' AND ', $where) : '';

// Get total count
$countQuery = "SELECT COUNT(*) as total FROM properties $whereClause";
$totalResult = $db->fetchRow($countQuery, $params);
$totalRecords = $totalResult['total'];
$totalPages = ceil($totalRecords / $perPage);

// Get properties
$query = "
    SELECT 
        p.*,
        z.zone_name,
        sz.sub_zone_name
    FROM properties p
    LEFT JOIN zones z ON p.zone_id = z.zone_id
    LEFT JOIN sub_zones sz ON p.sub_zone_id = sz.sub_zone_id
    $whereClause
    ORDER BY p.created_at DESC
    LIMIT ? OFFSET ?
";
$params[] = $perPage;
$params[] = $offset;
$properties = $db->fetchAll($query, $params);

// Get zones for filter
$zones = $db->fetchAll("SELECT zone_id, zone_name FROM zones ORDER BY zone_name");

// Calculate statistics
$stats = [
    'total' => $totalRecords,
    'commercial' => $db->fetchRow("SELECT COUNT(*) as count FROM properties WHERE property_use = 'Commercial'")['count'],
    'residential' => $db->fetchRow("SELECT COUNT(*) as count FROM properties WHERE property_use = 'Residential'")['count'],
    'total_payable' => $db->fetchRow("SELECT SUM(amount_payable) as total FROM properties")['total'] ?? 0
];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Properties - Internal Auditor</title>
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
                    Properties 
                    <span class="read-only-badge">READ-ONLY VIEW</span>
                </h1>
                <p style="color: #718096; margin-top: 5px;">View all registered properties - No edit/delete rights</p>
            </div>
            <a href="index.php" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </div>
    
    <div class="info-banner">
        <div class="info-banner-text">
            As an Internal Auditor, you can view all property information but cannot create, edit, or delete records.
        </div>
    </div>
    
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['total']); ?></div>
            <div class="stat-label">Total Properties</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['commercial']); ?></div>
            <div class="stat-label">Commercial</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><?php echo number_format($stats['residential']); ?></div>
            <div class="stat-label">Residential</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">₵ <?php echo number_format($stats['total_payable'], 2); ?></div>
            <div class="stat-label">Total Payable</div>
        </div>
    </div>
    
    <div class="filters-section">
        <form method="GET" action="">
            <div class="filter-grid">
                <div class="form-group">
                    <label class="form-label">Search</label>
                    <input type="text" name="search" class="form-control" placeholder="Owner name, property number..." value="<?php echo htmlspecialchars($search); ?>">
                </div>
                <div class="form-group">
                    <label class="form-label">Property Use</label>
                    <select name="property_use" class="form-control">
                        <option value="">All Types</option>
                        <option value="Commercial" <?php echo $propertyUse === 'Commercial' ? 'selected' : ''; ?>>Commercial</option>
                        <option value="Residential" <?php echo $propertyUse === 'Residential' ? 'selected' : ''; ?>>Residential</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Zone</label>
                    <select name="zone" class="form-control">
                        <option value="">All Zones</option>
                        <?php foreach ($zones as $z): ?>
                        <option value="<?php echo $z['zone_id']; ?>" <?php echo $zone == $z['zone_id'] ? 'selected' : ''; ?>>
                            <?php echo htmlspecialchars($z['zone_name']); ?>
                        </option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="form-group" style="justify-content: flex-end;">
                    <label class="form-label">&nbsp;</label>
                    <div style="display: flex; gap: 10px;">
                        <button type="submit" class="btn btn-primary">Apply Filters</button>
                        <a href="view_properties.php" class="btn btn-secondary">Clear</a>
                    </div>
                </div>
            </div>
        </form>