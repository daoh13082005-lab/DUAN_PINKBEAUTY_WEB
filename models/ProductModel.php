<?php
    class ProductModel {
        public function select_products_limit($limit) {
           $sql = "SELECT * FROM products WHERE status = 1 ORDER BY product_id DESC LIMIT $limit";

           return pdo_query($sql);
        }

        public function select_products_by_id($id) {
            $sql = "SELECT * FROM products WHERE product_id = ?";
 
            return pdo_query_one($sql, $id);
        }

        public function select_products_order_by($limit, $order_by) {
            $sql = "SELECT * FROM products WHERE status = 1 ORDER BY product_id $order_by LIMIT $limit";
 
            return pdo_query($sql);
        }

        public function select_cate_in_product($product_id) {
            $sql = "SELECT category_id FROM products WHERE product_id = ?";
 
            return pdo_query_one($sql, $product_id);
        }

        public function select_products_similar($id) {
            $sql = "SELECT * FROM products WHERE category_id = ? ORDER BY product_id LIMIT 4";
 
            return pdo_query($sql, $id);
        }

        public function search_products($query) {
            $sql = "SELECT * FROM products WHERE name LIKE '%$query%' ";
 
            return pdo_query($sql);
        }

        public function search_products_by_price($from_price, $to_price) {
            $sql = "SELECT * FROM products WHERE sale_price BETWEEN '$from_price' AND '$to_price' ";
 
            return pdo_query($sql);
        }

        public function get_min_max_prices() {
            $sql = "SELECT MIN(sale_price) AS min_price, MAX(sale_price) AS max_price FROM products WHERE status = 1";
        
            return pdo_query_one($sql);
        }

        public function select_all_products() {
            $sql = "SELECT * FROM products WHERE status = 1 ORDER BY product_id DESC";

            return pdo_query($sql);
        }

        public function select_products_by_cate($category_id) {
            $sql = "SELECT * FROM products WHERE category_id = ?";
 
            return pdo_query($sql, $category_id);
        }

        public function get_rating_by_product($product_id) {
            $sql = "SELECT AVG(rating) AS avg_rating, COUNT(*) AS total_rating 
                    FROM ratings 
                    WHERE product_id = ?";
            return pdo_query_one($sql, $product_id);
        }

        public function insert_rating($product_id, $user_id, $rating) {
            $sql = "INSERT INTO ratings(product_id, user_id, rating)
                    VALUES (?, ?, ?)
                    ON DUPLICATE KEY UPDATE rating = VALUES(rating)";
            return pdo_execute($sql, $product_id, $user_id, $rating);
        }

        public function get_all_ratings() {
            $sql = "SELECT product_id, AVG(rating) AS avg_rating, COUNT(*) AS total_rating
                    FROM ratings
                    GROUP BY product_id";
            $result = pdo_query($sql);
            
            $ratings = [];
            foreach($result as $row) {
                $ratings[$row['product_id']] = [
                    'avg_rating' => $row['avg_rating'],
                    'total_rating' => $row['total_rating']
                ];
            }
            return $ratings;
        }

        public function check_user_purchased_product($user_id, $product_id) {
            // ⚠️ LƯU Ý: Bạn cần đảm bảo đã đổi tên bảng đơn hàng gốc là 'orders' (hoặc tên chính xác của bạn)
            // và ID trạng thái 'Đã hoàn thành' là 3 (hoặc số chính xác của bạn)

            $sql = "SELECT COUNT(od.product_id) 
                    FROM orderdetails od 
                    JOIN orders o ON od.order_id = o.order_id
                    WHERE o.user_id = ? 
                    AND od.product_id = ? 
                    AND o.status = 4"; 

            $result = pdo_query_value($sql, $user_id, $product_id);
            
            return $result > 0;
        }

        public function get_products_with_rating($limit, $order_by, $where = '') {
            $sql = "
                SELECT 
                    p.*,
                    r.id AS rating_id,
                    r.rating,
                    r.user_id,
                    r.created_at
                FROM products p
                LEFT JOIN ratings r ON p.product_id = r.product_id
                ORDER BY $orderBy
                LIMIT $limit
            ";
                    
        }

        public function check_user_reviewed_product($user_id, $product_id) {
            // Truy vấn SQL: Đếm số bản ghi đánh giá (ratings) mà người dùng (user_id) 
            // đã thực hiện cho sản phẩm (product_id) này.
            $sql = "SELECT COUNT(*) FROM ratings WHERE user_id = ? AND product_id = ?"; // <--- Đây là SQL kiểm tra đã đánh giá chưa
            $result = pdo_query_value($sql, $user_id, $product_id);
            
            return $result > 0;
        }

        function select_list_products($page, $perPage) {
            // Tính toán vị trí bắt đầu của kết quả trên trang hiện tại
            $start = ($page - 1) * $perPage;
        
            // Bắt đầu câu truy vấn SQL
            $sql = "SELECT * FROM products WHERE 1";
            
        
            // Sắp xếp theo id giảm dần
            $sql .= " AND status = 1 ORDER BY product_id DESC";
        
            // Thêm phần phân trang
            $sql .= " LIMIT " . $start . ", " . $perPage;
        
            return pdo_query($sql);
        }

        // Đếm sản phẩm
        public function count_products() {
            $sql = "SELECT product_id FROM products";

            return pdo_query($sql);
        }
        

        public function discount_percentage($price, $sale_price) {
            $discount_percentage = ($price - $sale_price) / $price * 100;

            $round__percentage = round($discount_percentage, 0)."%";
            return $round__percentage;
        }

        public function formatted_price($price) {
            $format = number_format($price, 0, ',', '.') . 'đ';
            return $format;
        }

        public function update_views($product_id ) {
            $sql = "UPDATE products SET views = views + 1 WHERE product_id  = ?";
            pdo_execute($sql, $product_id );
            
        }

        public function update_quantity_product($product_id, $quantity) {
            $sql = "UPDATE products SET quantity = quantity - ? WHERE product_id  = ?";
            pdo_execute($sql, $quantity , $product_id );
        }

        public function update_sell_quantity_product($product_id, $quantity) {
            $sql = "UPDATE products SET sell_quantity = sell_quantity + ? WHERE product_id  = ?";
            pdo_execute($sql, $quantity , $product_id );
        }

    }

    $ProductModel = new ProductModel();
?>