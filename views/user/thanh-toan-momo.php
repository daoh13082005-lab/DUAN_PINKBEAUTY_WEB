<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

include_once "models/OrderModel.php";

if (!isset($_SESSION['user'])) {
    header("Location: index.php?url=dang-nhap");
    exit();
}

// --- Kiểm tra có dữ liệu tạm không ---
if (!isset($_SESSION['temp_order'])) {
    die("Không có thông tin đơn hàng tạm để thanh toán!");
}

$orderData = $_SESSION['temp_order'];
$amount = $orderData['total'];

// ✅ Sinh mã đơn tạm duy nhất
$order_id = 'TEMP_' . time();

// --- Thông tin MoMo test ---
$endpoint    = "https://test-payment.momo.vn/v2/gateway/api/create";
$partnerCode = "MOMO";
$accessKey   = "F8BBA842ECF85";
$secretKey   = "K951B6PE1waDMi640xX08PD3vg6EkVlz";

// --- Thông tin đơn hàng ---
$requestId   = time();
$orderInfo   = "Thanh toán đơn hàng PinkBeauty";
$extraData   = "";
$returnUrl = "http://localhost/pinkbeauty/views/user/return-momo.php";
$notifyUrl   = "http://localhost/pinkbeauty/views/user/momo-notify.php";

// --- Chuẩn bị dữ liệu gửi ---
$data = [
    'partnerCode' => $partnerCode,
    'accessKey'   => $accessKey,
    'requestId'   => $requestId,
    'amount'      => $amount,
    'orderId'     => $order_id,
    'orderInfo'   => $orderInfo,
    'redirectUrl' => $returnUrl,
    'ipnUrl'      => $notifyUrl,
    'extraData'   => $extraData,
    'requestType' => 'captureWallet',
    'lang'        => 'vi'
];

// --- Tạo chữ ký ---
$rawHash = "accessKey=" . $accessKey .
    "&amount=" . $amount .
    "&extraData=" . $extraData .
    "&ipnUrl=" . $notifyUrl .
    "&orderId=" . $order_id .
    "&orderInfo=" . $orderInfo .
    "&partnerCode=" . $partnerCode .
    "&redirectUrl=" . $returnUrl .
    "&requestId=" . $requestId .
    "&requestType=captureWallet";

$signature = hash_hmac("sha256", $rawHash, $secretKey);
$data['signature'] = $signature;

// --- Gửi request tới MoMo ---
$ch = curl_init($endpoint);
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => json_encode($data)
]);
$response = curl_exec($ch);
curl_close($ch);

$result = json_decode($response, true);

// --- Xử lý kết quả ---
if (isset($result['payUrl'])) {
    header('Location: ' . $result['payUrl']);
    exit;
} else {
    echo "Thanh toán lỗi!<br>";
    echo "<pre>";
    print_r($result);
    echo "</pre>";
}
?>

