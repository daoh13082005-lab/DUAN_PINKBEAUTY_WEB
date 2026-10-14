<?php
session_start();

include_once "../../models/OrderModel.php";  // Sửa lại đường dẫn đúng
include_once "../../models/CartModel.php";   // Nếu có

$OrderModel = new OrderModel();
$CartModel = new CartModel();

if (isset($_GET['resultCode'])) {
    $resultCode = $_GET['resultCode'];

    if ($resultCode == 0 && isset($_SESSION['temp_order'])) {
        $orderData = $_SESSION['temp_order'];

        // Tạo đơn hàng thật trong DB
        $order_id = $OrderModel->insert_orders(
            $orderData['user_id'],
            $orderData['total'],
            $orderData['address'],
            $orderData['phone'],
            $orderData['note']
        );

        // Lưu chi tiết sản phẩm
        foreach ($orderData['products'] as $item) {
            $OrderModel->insert_orderdetails(
                $order_id,
                $item['product_id'],
                $item['quantity'],
                $item['price']
            );
        }

        // Xóa giỏ hàng
        $CartModel->delete_cart_by_user_id($orderData['user_id']);

        // Xóa session tạm
        unset($_SESSION['temp_order']);

        // Chuyển tới trang cảm ơn
        header("Location: ../../index.php?url=thanks");
        exit();
    } else {
        // Thanh toán bị hủy hoặc lỗi -> trở về giỏ hàng hoặc trang chủ
        header("Location: ../../index.php?url=gio-hang");
        exit();
    }
} else {
    // Trường hợp không có resultCode, coi như là hủy -> về giỏ hàng
    header("Location: ../../index.php?url=gio-hang");
    exit();
}
