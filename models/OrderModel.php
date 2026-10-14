    <?php
    class OrderModel {

        // 🔹 Lấy ID đơn hàng mới nhất
        public function select_order_id() {
            $sql = "SELECT order_id FROM orders ORDER BY date DESC LIMIT 1";
            return pdo_query_one($sql);
        }

        // 🔹 Lấy danh sách đơn hàng theo user_id
        public function select_list_orders($user_id) {
            $sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_id DESC";
            return pdo_query($sql, $user_id);
        }

        // 🔹 Lấy chi tiết đơn hàng kèm sản phẩm
        public function select_orderdetails_and_products($order_id) {
            $sql = "
                SELECT
                    products.product_id,
                    products.name AS product_name,
                    products.image,
                    orderdetails.quantity,
                    orderdetails.price AS product_price
                FROM
                    products
                JOIN
                    orderdetails ON products.product_id = orderdetails.product_id
                WHERE order_id = ?;
            ";
            return pdo_query($sql, $order_id);
        }

        // 🔹 Lấy toàn bộ thông tin chi tiết của 1 đơn hàng (có join user, products)
        public function getFullOrderInformation($user_id, $order_id) {
            $sql = "
                SELECT
                    orders.order_id,
                    orders.user_id,
                    orders.date AS order_date,
                    orders.total,
                    orders.address AS order_address,
                    orders.phone AS order_phone,
                    orders.note,
                    orders.status,
                    users.full_name,
                    users.email,
                    users.phone AS user_phone,
                    orderdetails.product_id,
                    orderdetails.quantity,
                    orderdetails.price,
                    products.name AS product_name,
                    products.image AS product_image
                FROM
                    orders
                JOIN
                    users ON orders.user_id = users.user_id
                JOIN
                    orderdetails ON orders.order_id = orderdetails.order_id
                JOIN
                    products ON orderdetails.product_id = products.product_id
                WHERE orders.user_id = ? AND orders.order_id = ?
            ";
            return pdo_query($sql, $user_id, $order_id);
        }

        // 🔹 Thêm đơn hàng mới
        public function insert_orders($user_id, $total, $address, $phone, $note) {
            $sql = "INSERT INTO orders(user_id, total, address, phone, note) VALUES(?,?,?,?,?)";
            pdo_execute($sql, $user_id, $total, $address, $phone, $note);
        }

        // 🔹 Thêm chi tiết đơn hàng
        public function insert_orderdetails($order_id, $product_id, $quantity, $price) {
            $sql = "INSERT INTO orderdetails(order_id, product_id, quantity, price) VALUES(?,?,?,?)";
            pdo_execute($sql, $order_id, $product_id, $quantity, $price);
        }
        // ✅ Xóa đơn hàng theo order_id
        public function delete_order($order_id) {
            // Xóa chi tiết đơn hàng trước
            $sqlDetails = "DELETE FROM orderdetails WHERE order_id = ?";
            pdo_execute($sqlDetails, $order_id);

            // Xóa đơn hàng
            $sqlOrder = "DELETE FROM orders WHERE order_id = ?";
            pdo_execute($sqlOrder, $order_id);
        }
        // 🔹 Xóa giỏ hàng sau khi đặt đơn
        public function delete_cart_by_user_id($user_id) {
            $sql = "DELETE FROM carts WHERE user_id = ?";
            pdo_execute($sql, $user_id);
        }
        public function get_order_sold_by_day($limit_day = 10) {
       $dates = [];
       for ($i = $limit_day - 1; $i >= 0; $i--) {
           $dates[] = date('Y-m-d', strtotime("-$i days"));
       }
    
       $results = [];
       foreach ($dates as $d) {
           $sql = "
               SELECT COALESCE(SUM(orderdetails.quantity), 0) AS total_sold_quantity
               FROM orders
               JOIN orderdetails ON orders.order_id = orderdetails.order_id
               WHERE DATE(orders.date) = ?
           ";
           $row = pdo_query_one($sql, $d);
           $results[] = [
               'order_date' => $d,
               'total_sold_quantity' => $row['total_sold_quantity'] ?? 0
           ];
       }
    
       return $results;
    }
    
        // 🔹 ✅ Thêm hàm bị thiếu: lấy đơn hàng theo ID
        public function select_order_by_id($order_id) {
            $sql = "SELECT * FROM orders WHERE order_id = ?";
            return pdo_query_one($sql, $order_id);
        }
        
    }

    $OrderModel = new OrderModel();
    ?>
