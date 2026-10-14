<?php
if (isset($_GET['resultCode'])) {
    $resultCode = $_GET['resultCode'];

    if ($resultCode == 0 && isset($_SESSION['temp_order'])) {
        // ✅ Thanh toán thành công
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
    } else {
        echo "<script>
            alert('Thanh toán thất bại hoặc bị hủy. Giỏ hàng của bạn vẫn được giữ lại.');
            window.location.href = 'index.php?url=gio-hang';
        </script>";
        exit;
    }
}

?>

<!-- ✅ Trang cảm ơn chỉ hiển thị nếu thanh toán thành công -->
<div class='d-flex justify-content-center align-items-center' style='height: 400px; margin-bottom: 300px;'>
    <div>
        <div class='mb-4 text-center'>
            <svg xmlns='http://www.w3.org/2000/svg' class='text-success' width='75' height='75' fill='currentColor' viewBox='0 0 16 16'>
                <path d='M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z'/>
            </svg>
        </div>
        <div class='text-center'>
            <h3 class='mb-2'>Cảm ơn quý khách hàng đã mua hàng!</h3>
            <h5 class='mb-3'>Rất mong quý khách hàng sẽ luôn luôn tin tưởng và ủng hộ PinkBeauty 💖</h5>
            <a href='index.php?url=don-hang' class='btn btn-primary'>Xem đơn hàng</a>
        </div>
    </div>
</div>
