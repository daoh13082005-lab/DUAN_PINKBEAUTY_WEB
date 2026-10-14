<?php
   if(isset($_GET['id_sp'])) {
        $id_sp = $_GET['id_sp'];
        $id_danhmuc = $_GET['id_dm'];

        $product_details = $ProductModel->update_views($id_sp);
        
        $product_details = $ProductModel->select_products_by_id($id_sp);
        $similar_product = $ProductModel->select_products_similar($id_danhmuc);
        $name_catgoty = $CategoryModel->select_name_categories();
    } 
    
?>

<?php
    extract($product_details);
    $discount_percentage = $ProductModel->discount_percentage($price, $sale_price);

    $ratingData = $ProductModel->get_rating_by_product($id_sp);
    $avg_rating = $ratingData['avg_rating'] ?? 0;
    $total_rating = $ratingData['total_rating'] ?? 0;

    // Bình luận
    if(isset($_GET['id_sp'])) {
        $product_id = $_GET['id_sp'];
        $list_comments = $CommentModel->select_comments_by_id($product_id);
    }
?>
<!-- Breadcrumb Begin -->
<div class="breadcrumb-option">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb__links">
                    <a href="index.php"><i class="fa fa-home"></i> Trang chủ</a>
                    <a href="index.php?url=cua-hang">Sản phẩm </a>
                    <a href="index.php?url=danh-muc-san-pham&id=<?=$id_danhmuc?>">
                        <?php foreach ($name_catgoty as $value) {
                                if($value['category_id'] == $id_danhmuc) {
                                    echo $value['name'];
                                }
                            } ?>
                    </a>
                    <span><?=$name?></span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb End -->

<!-- Product Details Section Begin -->
<section class="product-details spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="product__details__pic">
                    <div class="product__details__pic__left product__thumb nice-scroll">
                        <a class="pt active" href="#product-1">
                            <img src="upload/<?=$image?>" alt="">
                        </a>
                        <a class="pt" href="#product-2">
                            <img src="upload/<?=$image?>" alt="">
                        </a>
                        <!-- <a class="pt" href="#product-3">
                                <img src="img/product/conan-1.jpg" alt="">
                            </a> -->

                    </div>
                    <div class="product__details__slider__content">
                        <div class="product__details__pic__slider owl-carousel">
                            <img data-hash="product-1" class="product__big__img" src="upload/<?=$image?>" alt="">
                            <img data-hash="product-2" class="product__big__img" src="upload/<?=$image?>" alt="">
                            <img data-hash="product-3" class="product__big__img" src="upload/<?=$image?>" alt="">

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="product__details__text">
                    <h3><?=$name?>
                        <span>
                            Danh mục: <?php foreach ($name_catgoty as $value) {
                                    if($value['category_id'] == $id_danhmuc) {
                                        echo $value['name'];
                                    }
                                } ?>
                        </span>
                    </h3>
                   
                    <div class="product__details__price">
                        <?=$ProductModel->formatted_price($sale_price); ?>
                        <span class="ml-2">
                            <?=$ProductModel->formatted_price($price); ?>
                        </span>
                        <div class="label_right ml-2"><?=$discount_percentage?></div>
                    </div>

                    <div class="short__description">
                        <?=$short_description?>
                    </div>
                    
                    <!-- HIỂN THỊ SAO ĐÁNH GIÁ -->
                    <div class="product__details__rating mt-3">
                        <span class="text-dark">Đánh giá: </span>

                        <?php
                            $fullStars = floor($avg_rating);
                            $halfStar = ($avg_rating - $fullStars >= 0.5) ? 1 : 0;
                            $emptyStars = 5 - ($fullStars + $halfStar);

                            // Sao đầy
                            for($i = 1; $i <= $fullStars; $i++) {
                                echo '<i class="fa fa-star" style="color:#FFD700;"></i>';
                            }
                            // Sao nửa
                            if($halfStar) {
                                echo '<i class="fa fa-star-half-o" style="color:#FFD700;"></i>';
                            }
                            // Sao rỗng
                            for($i = 1; $i <= $emptyStars; $i++) {
                                echo '<i class="fa fa-star-o" style="color:#FFD700;"></i>';
                            }
                        ?>
                        <span class="ml-2">(<?=$total_rating?> đánh giá)</span>
                    </div>

                    <!-- FORM ĐÁNH GIÁ -->
                    <?php if(isset($_SESSION['user'])): ?>
                    <div class="star-rating mt-3">
                        <form action="index.php?url=rating" method="post" id="ratingForm">
                            <input type="hidden" name="product_id" value="<?=$id_sp?>">
                            <input type="hidden" name="user_id" value="<?=$_SESSION['user']['id']?>">
                            <input type="hidden" name="rating" id="ratingValue" value="0">

                             <!-- 5 SAO CLICK -->
                            <span class="star" data-value="1">&#9733;</span>
                            <span class="star" data-value="2">&#9733;</span>
                            <span class="star" data-value="3">&#9733;</span>
                            <span class="star" data-value="4">&#9733;</span>
                            <span class="star" data-value="5">&#9733;</span>

                            <button type="submit" class="btn btn-primary mt-2">Gửi đánh giá</button>
                        </form>
                    </div>
                    
                    <script>
                    const stars = document.querySelectorAll('.star');
                    const ratingInput = document.getElementById('ratingValue');

                    stars.forEach(star => {
                        star.addEventListener('mouseover', () => {
                            const val = star.getAttribute('data-value');
                            highlightStars(val);
                        });

                        star.addEventListener('mouseout', () => {
                            const val = ratingInput.value;
                            highlightStars(val);
                        });

                        star.addEventListener('click', () => {
                            const val = star.getAttribute('data-value');
                            ratingInput.value = val;
                            highlightStars(val);
                        });
                    });

                    function highlightStars(val) {
                        stars.forEach(star => {
                            if(star.getAttribute('data-value') <= val) {
                                star.classList.add('selected');
                            } else {
                                star.classList.remove('selected');
                            }
                        });
                    }
                    </script>

                    <?php else: ?>
                        <div class="mt-3">
                            <a href="dang-nhap" class="text-primary">Đăng nhập để đánh giá sản phẩm</a>
                        </div>
                    <?php endif; ?>

                    <?php if($quantity == 0){?>

                    <div class="quantity">
                        <button style="border: none;" type="submit" class="btn btn-warning">
                            Hết hàng
                        </button>

                    </div>
                    <?php }else{?>

                    <div class="product__details__button">

                        <?php if(isset($_SESSION['user'])) {?>
                        <form action="index.php?url=gio-hang" method="post">
                            <div class="input-group d-flex align-items-center">
                                <span class="text-dark">Số lượng</span>
                                <div class="input-next-cart d-flex mx-4">
                                    <input type="button" value="-" class="button-minus" data-field="quantity">
                                    <input type="number" step="1" max="50" value="1" name="product_quantity"
                                        class="quantity-field-cart">
                                    <input type="button" value="+" class="button-plus" data-field="quantity">
                                </div>
                                <span class="text-dark"><?=$quantity?> sản phẩm có sẵn</span>

                            </div>

                            <input value="<?=$product_id?>" type="hidden" name="product_id">
                            <input value="<?=$_SESSION['user']['id']?>" type="hidden" name="user_id">
                            <input value="<?=$name?>" type="hidden" name="name">
                            <input value="<?=$image?>" type="hidden" name="image">
                            <input value="<?=$sale_price?>" type="hidden" name="price">
                            <!-- <input value="1" type="hidden" name="product_quantity"> -->
                            <input value="<?=$image?>" type="hidden" name="image">

                            <div class="quantity">

                                <button name="add_to_cart" style="border: none;" type="submit"
                                    class="cart-btn btn-primary"><span class="icon_bag_alt"></span> Thêm vào
                                    giỏ</button>
                               
                            </div>
                        </form>
                        <?php }else{?>
                        <div class="input-group d-flex align-items-center">
                            <span class="text-dark">Số lượng</span>
                            <div class="input-next-cart d-flex mx-4">
                                <input type="button" value="-" class="button-minus" data-field="quantity">
                                <input type="number" readonly step="1" max="50" value="1" name="product_quantity"
                                    class="quantity-field-cart">
                                <input type="button" value="+" class="button-plus" data-field="quantity">
                            </div>
                            <span class="text-dark"><?=$quantity?> sản phẩm có sẵn</span>

                        </div>
                        <div class="quantity">
                            <button name="add_to_cart" onclick="alert('Vui lòng dăng nhập để thực hiện chức năng');"
                                style="border: none;" type="submit" class="cart-btn btn-primary">
                                <span class="icon_bag_alt"></span> <a href="dang-nhap" style="color: #ffffff;">Thêm vào
                                    giỏ</a>
                            </button>
                            <button name="add_to_cart" onclick="alert('Vui lòng dăng nhập để thực hiện chức năng');"
                                type="submit" style="background-color: #ca1515; border: none;" class="cart-btn">
                                <span class="icon_bag_alt"></span> <a href="dang-nhap" style="color: #ffffff;">Mua
                                    ngay</a>
                            </button>
                        </div>

                        <?php }?>
                        <ul>        
                    </div>

                    <?php }?>

                </div>
            </div>
            <div class="col-lg-12">
                <div class="product__details__tab">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">Mô tả</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">Bình luận (
                                <?=count($list_comments)?> )</a>
                        </li>

                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tabs-1" role="tabpanel">
                            <h6>Mô tả</h6>
                            <p><?=$details?></p>
                            <p></p>
                        </div>

                        <!-- Bình luận   -->
                        <?php include_once "views/comments.php"; ?>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="related__title">
                    <h5>SẢM PHẨM TƯƠNG TỰ</h5>
                </div>
            </div>
            <?php
                    foreach ($similar_product as $value) {
                        if(is_array($value)) {
                            extract($value);
                            $discount_percentage = $ProductModel->discount_percentage($price, $sale_price);
                        }
                    
                ?>
            <div class="col-lg-3 col-md-4 col-sm-6 mix">
                <div class="product__item sale">
                    <div class="product__item__pic set-bg" data-setbg="upload/<?=$image?>">

                        <div class="label_right sale">-<?=$discount_percentage?></div>
                        <ul class="product__hover">
                            <li><a href="upload/<?=$image?> " class="image-popup"><span class="arrow_expand"></span></a>
                            </li>
                            <li>
                                <a href="index.php?url=chitietsanpham&id_sp=<?=$product_id?>&id_dm=<?=$category_id?>"><span
                                        class="icon_search_alt"></span></a>
                            </li>

                            <li>
                                <form action="blog.html" method="post">
                                    <input type="hidden" name="product_id">
                                    <input type="hidden" name="user_id">
                                    <input type="hidden" name="name">
                                    <input type="hidden" name="price">
                                    <input type="hidden" name="quantity">
                                    <input type="hidden" name="image">
                                    <button type="submit" name="add_to_cart">
                                        <a href="#"><span class="icon_bag_alt"></span></a>
                                    </button>
                                </form>
                            </li>

                        </ul>

                    </div>
                    <div class="product__item__text">
                        <h6 class="text-truncate-1">
                            <a href="index.php?url=chitietsanpham&id_sp=<?=$product_id?>&id_dm=<?=$category_id?>">
                                <?=$name?>
                            </a>
                        </h6>
                        
                        <div class="product__price"><?=$ProductModel->formatted_price($sale_price); ?>
                            <span><?=$ProductModel->formatted_price($price); ?> </span>
                        </div>
                    </div>
                </div>
            </div>
            <?php
                    }
                ?>




        </div>
    </div>
    </div>
</section>
<!-- Product Details Section End -->


<style>
.label_right {
    font-size: 14px;
    color: #ffffff;
    font-weight: 700;
    display: inline-block;
    padding: 2px 8px;
    text-transform: uppercase;
    background: #ca1515;
    border-radius: 5px;
}
.star-rating {
    display: inline-block;
}
.star {
    font-size: 30px;
    color: #ccc;
    cursor: pointer;
    transition: color 0.2s;
}
.star:hover,
.star.hover,
.star.selected {
    color: #FFD700;
}
</style>


