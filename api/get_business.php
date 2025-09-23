<?php

header("Content-Type: application/json");

$host = '127.0.0.1';      // or RDS endpoint
$dbname = 'quickbill_305';
$user = 'francis';
$pass = 'Mum@vida1';

try {
    // Connect to DB
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Check which parameter is provided
    $account_number = $_GET['account_number'] ?? null;
    $property_number = $_GET['property_number'] ?? null;

    if (!$account_number && !$property_number) {
        echo json_encode(['error' => 'Either account_number or property_number parameter is required']);
        exit;
    }

    $result = null;
    $source_table = '';

    // Try to fetch from businesses table first if account_number is provided
    if ($account_number) {
        $stmt = $pdo->prepare("SELECT *, 'business' as record_type FROM businesses WHERE account_number = :account_number");
        $stmt->execute(['account_number' => $account_number]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $source_table = 'businesses';
    }

    // Try to fetch from properties table if property_number is provided and no business found
    if (!$result && $property_number) {
        $stmt = $pdo->prepare("SELECT *, 'property' as record_type FROM properties WHERE property_number = :property_number");
        $stmt->execute(['property_number' => $property_number]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $source_table = 'properties';
    }

    // If still no result and both parameters provided, try the other table
    if (!$result && $account_number && $property_number) {
        if ($source_table === 'businesses') {
            $stmt = $pdo->prepare("SELECT *, 'property' as record_type FROM properties WHERE property_number = :property_number");
            $stmt->execute(['property_number' => $property_number]);
            $result = $stmt->fetch(PDO::FETCH_ASSOC);
        }
    }

    if ($result) {
        echo json_encode($result);
    } else {
        $error_msg = 'No record found';
        if ($account_number && $property_number) {
            $error_msg = 'No business or property found with the provided numbers';
        } elseif ($account_number) {
            $error_msg = 'Business not found';
        } elseif ($property_number) {
            $error_msg = 'Property not found';
        }
        echo json_encode(['error' => $error_msg]);
    }

} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>