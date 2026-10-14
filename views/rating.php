<?php
require_once "models/ProductModel.php";
session_start();

if(isset($_POST['rating'])) {
    $product_id = $_POST['product_id'] ?? null;
    $user_id = $_POST['user_id'] ?? null;
    $rating = $_POST['rating'] ?? null;

    if($product_id && $user_id && $rating) {
        $ProductModel->insert_rating($product_id, $user_id, $rating);
        header("Location: index.php?url=chitietsanpham&id_sp=$product_id&id_dm=" . ($_GET['id_dm'] ?? 0));
        exit();
    } else {
        echo "<script>alert('Dữ liệu đánh giá không hợp lệ');</script>";
    }
}
?>
