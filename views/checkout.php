<!-- Breadcrumb Begin -->
<?php
$success = '';
$error = '';

try {    
    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["checkout"])) {
        // Lấy dữ liệu từ form
        $user_id = $_POST["user_id"];
        $total = $_POST["total_checkout"];
        $address = $_POST["address"];
        $phone = $_POST["phone"];
        $note = $_POST["note"];
        $payment_method = $_POST["payment_method"];

        // Table orderdetails
        $arr_product_id = $_POST["product_id"];
        $arr_quantity = $_POST["quantity"];
        $arr_price = $_POST["price"];

        // ✅ KIỂM TRA TỒN KHO TRƯỚC KHI TẠO ĐƠN
        $insufficient_stock = false;
        $insufficient_products = [];

        for ($i = 0; $i < count($arr_product_id); $i++) {
            $product = $ProductModel->select_products_by_id($arr_product_id[$i]);
            if ($arr_quantity[$i] > $product['quantity']) {
                $insufficient_stock = true;
                $insufficient_products[] = $product['name'];
            }
        }

        if ($insufficient_stock) {
            $error = " Không thể đặt hàng. Sản phẩm hết hàng: " . implode(", ", $insufficient_products);
            echo "<script>alert('$error'); window.history.back();</script>";
            exit;
        }

        // ✅ Nếu phương thức là MoMo, lưu tạm vào session
        if ($payment_method == 'momo') {
            $_SESSION['temp_order'] = [
                'user_id' => $user_id,
                'total' => $total,
                'address' => $address,
                'phone' => $phone,
                'note' => $note,
                'products' => [],
            ];

            for ($i = 0; $i < count($arr_product_id); $i++) {
                $_SESSION['temp_order']['products'][] = [
                    'product_id' => $arr_product_id[$i],
                    'quantity' => $arr_quantity[$i],
                    'price' => $arr_price[$i],
                ];
            }

            // Chuyển sang trang thanh toán MoMo
            header("Location: index.php?url=thanh-toan-momo");
            exit();
        }

        // ✅ Nếu phương thức COD, tạo đơn hàng trực tiếp
        $OrderModel->insert_orders($user_id, $total, $address, $phone, $note);
        $result_select = $OrderModel->select_order_id();
        $order_id = $result_select['order_id'];

        if(!empty($order_id)) {
            // Thêm chi tiết đơn hàng và cập nhật tồn kho
            for ($i = 0; $i < count($arr_product_id); $i++) {
                $product_id = $arr_product_id[$i];
                $quantity = $arr_quantity[$i];
                $price = $arr_price[$i];

                $OrderModel->insert_orderdetails($order_id, $product_id, $quantity, $price);
                $ProductModel->update_quantity_product($product_id, $quantity);
                $ProductModel->update_sell_quantity_product($product_id, $quantity);
            }

            // Xóa giỏ hàng của user
            if ($payment_method == 'cod') {
                $OrderModel->delete_cart_by_user_id($user_id);
            }

            // Redirect sau khi thanh toán
            header("Location: cam-on");
            exit;
        }
    }
} catch (Exception $e) {
    $error_message = $e->getMessage();
    echo $error_message;
}
?>

<?php 
if(isset($_SESSION['user'])) { 
    $user_id = $_SESSION['user']['id'];
    $list_carts = $CartModel->select_all_carts($user_id);
    $count_cart = count($CartModel->count_cart($user_id));
?>
<div class="breadcrumb-option">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb__links">
                    <a href="index.php"><i class="fa fa-home"></i> Trang chủ</a>
                    <span>Thanh toán</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb End -->

<!-- Checkout Section Begin -->
<section class="checkout spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h6 class="coupon__link">
                    <span class="icon_tag_alt mr-1"></span>
                    Tiến hành thanh toán đơn hàng 
                    <a class="text-primary" href="gio-hang">Trở lại giỏ hàng</a>
                </h6>
            </div>
        </div>

        <form action="" method="post" class="checkout__form">
            <div class="row">
                <div class="col-lg-8">
                    <h5>CHI TIẾT THANH TOÁN</h5>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="checkout__form__input">
                                <p>Họ tên <span>*</span></p>
                                <input type="text" disabled value="<?= $_SESSION['user']['full_name'] ?>">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="checkout__form__input">
                                <p>Email <span>*</span></p>
                                <input disabled type="text" value="<?= $_SESSION['user']['email'] ?>">
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="checkout__form__input">
                                <p>Địa chỉ <span>*</span></p>
                                <input disabled type="text" value="<?= $_SESSION['user']['address'] ?>">
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="checkout__form__input">
                                <p>Số điện thoại <span>*</span></p>
                                <input disabled type="text" value="<?= $_SESSION['user']['phone'] ?>">
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="checkout__form__input">
                                <p>Ghi chú</p>
                                <input type="text" name="note">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="checkout__order">
                        <h5>ĐƠN HÀNG</h5>
                        <div class="checkout__order__product">
                            <ul>
                                <li><span class="top__text">Sản phẩm</span><span class="top__text__right">Tổng</span></li>
                                <?php
                                $i = 0;
                                $totalPayment = 0;
                                foreach ($list_carts as $value) {
                                    extract($value);
                                    $totalPrice = ($product_price * $product_quantity);
                                    $totalPayment += $totalPrice;
                                    $i++;
                                ?>
                                <li>
                                    <input type="hidden" name="user_id" value="<?=$user_id?>">
                                    <input type="hidden" name="address" value="<?=$_SESSION['user']['address']?>">
                                    <input type="hidden" name="phone" value="<?=$_SESSION['user']['phone']?>">
                                    <input type="hidden" name="total_checkout" value="<?=$totalPayment?>">
                                    <input type="hidden" name="product_id[]" value="<?=$product_id?>">
                                    <input type="hidden" name="quantity[]" value="<?=$product_quantity?>">
                                    <input type="hidden" name="price[]" value="<?=$product_price?>">

                                    <?=$i?>. <?=$product_name?> 
                                    <a class="text-primary">x<?=$product_quantity?></a>
                                    <span><?=number_format($totalPrice)?>đ</span>
                                </li>
                                <?php } ?>
                            </ul>
                        </div>

                        <div class="checkout__order__total">
                            <ul>
                                <li>Tổng <span><?=number_format($totalPayment)?>đ</span></li>
                            </ul>
                        </div>

                        <?php if($count_cart > 0) { ?>
                        <div class="checkout__order__payment mb-3">
                            <h6>Phương thức thanh toán</h6>
                            <label><input type="radio" name="payment_method" value="cod" checked> Thanh toán khi nhận hàng (COD)</label><br>
                            <label><input type="radio" name="payment_method" value="momo"> Thanh toán qua MoMo</label>
                        </div>

                        <button type="button" class="site-btn" data-toggle="modal" data-target="#thanh-toan-1">ĐẶT HÀNG</button>

                        <div class="modal fade" id="thanh-toan-1" tabindex="-1" role="dialog" aria-labelledby="thanh-toan-1" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header"><h4>Xác nhận đặt hàng</h4></div>
                                    <div class="modal-body text-dark">Bạn có muốn tiếp tục đặt hàng?</div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                        <button type="submit" name="checkout" class="btn btn-primary">Xác nhận</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <?php } else { ?>
                        <div class="checkout__order__widget text-center text-primary mb-2">Chưa có sản phẩm trong giỏ hàng</div>
                        <a href="cua-hang" class="site-btn btn">Xem sản phẩm</a>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>
<!-- Checkout Section End -->

<?php } else { ?>
<div class="row" style="margin-bottom: 400px;">
    <div class="col-lg-12 text-center">
        <h4 class="mb-4">Vui lòng đăng nhập để có thể thanh toán</h4>
        <a class="btn btn-primary rounded-pill py-3 px-5" href="index.php?url=dang-nhap">Đăng nhập</a>
        <a class="btn btn-secondary rounded-pill py-3 px-5" href="index.php">Trang chủ</a>
    </div>
</div>
<?php } ?>

<style>
.cart__btn a:hover {
    background-color: #0A68FF;
    color: #fff;
    transition: 0.2s;
}
.checkout__form .checkout__form__input input {
    color: #000000;
}
.checkout__form .checkout__form__input input:focus {
    border: 1px solid #999999;
}
</style>
