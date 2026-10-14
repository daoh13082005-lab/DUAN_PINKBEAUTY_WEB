<?php
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/../../config/config.php';
$conn = pdo_get_connection();

include_once __DIR__ . '/../../components/header.php';

$error = "";
$success = "";

// Khi người dùng nhấn Gửi
if (isset($_POST['submit'])) {
    $email = trim($_POST['email']);

    if (empty($email)) {
        $error = "⚠️ Vui lòng nhập email của bạn!";
    } else {
        try {
            // Kiểm tra email trong DB
            $stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
            $stmt->bindValue(1, $email, PDO::PARAM_STR);
            $stmt->execute();
            $user = $stmt->fetch(PDO::FETCH_ASSOC);

            if ($user) {
                // ✅ Lưu email vào session
                $_SESSION['reset_email'] = $email;

                // ✅ Chuyển hướng đến trang đổi mật khẩu
                header("Location: http://localhost/pinkbeauty/index.php?url=khoi-phuc-mat-khau");
                exit();
            } else {
                $error = "❌ Email này không tồn tại trong hệ thống!";
            }
        } catch (PDOException $e) {
            $error = "Đã xảy ra lỗi khi truy vấn dữ liệu: " . $e->getMessage();
        }
    }
}
?>

<div class="container py-5">
    <div class="card mx-auto" style="max-width: 450px;">
        <div class="card-body">
            <h3 class="text-center mb-4">Quên mật khẩu</h3>

            <?php if (!empty($error)): ?>
                <div class="alert alert-danger text-center"><?= htmlspecialchars($error) ?></div>
            <?php endif; ?>

            <form method="post">
                <label for="email" class="form-label">Email:</label>
                <input type="email" class="form-control" name="email" placeholder="Nhập email của bạn" required>
                <button type="submit" name="submit" class="btn btn-primary w-100 mt-3">Tiếp tục</button>
            </form>

            <div class="text-center mt-3">
                <a href="../../index.php">← Quay lại trang đăng nhập</a>
            </div>
        </div>
    </div>
</div>

<script>
    // Ẩn thông báo sau 3 giây
    setTimeout(() => {
        document.querySelectorAll('.alert').forEach(a => a.remove());
    }, 3000);
</script>

<?php
include_once __DIR__ . '/../../components/footer.php';
?>
