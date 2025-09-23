<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

$host = '127.0.0.1';
$dbname = 'quickbill_305';
$user = 'francis';
$pass = 'Mum@vida1';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    if (!isset($_GET['phone_number'])) {
        echo json_encode(['success' => false, 'error' => 'phone_number parameter is required']);
        exit;
    }

    $phone_number = $_GET['phone_number'];

    // Query all businesses for this phone number
    $stmt = $pdo->prepare("SELECT * FROM businesses WHERE telephone = :phone_number OR telephone = :phone_number");
    $stmt->execute(['phone_number' => $phone_number]);
    $businesses = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Also query properties if user has any
    $stmt = $pdo->prepare("SELECT *, 'property' as record_type FROM properties WHERE telephone = :phone_number");
    $stmt->execute(['phone_number' => $phone_number]);
    $properties = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $all_records = array_merge($businesses, $properties);

    echo json_encode([
        'success' => true, 
        'businesses' => $businesses,
        'properties' => $properties,
        'total_records' => count($all_records)
    ]);

} catch (PDOException $e) {
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>