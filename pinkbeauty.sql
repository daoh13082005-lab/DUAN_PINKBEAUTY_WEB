-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 10, 2025 at 08:58 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pinkbeauty`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`id`, `user_id`, `address`) VALUES
(17, 15, 'Vĩnh Long 123'),
(18, 6, 'Hà Nội');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `product_image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`cart_id`, `product_id`, `user_id`, `product_name`, `product_price`, `product_quantity`, `product_image`) VALUES
(299, 32, 18, 'Son romand', 127000, 1, 'sonrmm.png');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`, `image`, `status`) VALUES
(1, 'Son môi', 'son3ce.png', 1),
(2, 'Tẩy trang', 'taytrangga.png', 1),
(4, 'Sữa rửa mặt', 'srmcoc.png', 1),
(6, 'Serum', 'srtor.png', 1),
(16, 'Kem dưỡng', 'kdme.png', 1),
(17, 'Kem chống nắng', 'kcnbe.png', 1),
(19, 'Toner', 'tonerkl.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 ẩn 1 hiện',
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `content`, `date`, `status`, `user_id`, `product_id`) VALUES
(15, 'son đẹp, em yêu shop\r\n', '2025-11-01 15:20:14', 1, 18, 32);

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `orderdetails_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderdetails`
--

INSERT INTO `orderdetails` (`orderdetails_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(228, 161, 31, 1, 126000),
(229, 162, 32, 1, 127000),
(230, 163, 32, 1, 127000),
(231, 164, 32, 1, 127000),
(232, 165, 32, 1, 127000),
(233, 168, 32, 1, 127000),
(234, 169, 32, 1, 127000),
(235, 170, 32, 1, 127000),
(236, 171, 32, 1, 127000),
(237, 172, 32, 1, 127000),
(238, 173, 32, 1, 127000),
(239, 174, 32, 1, 127000),
(240, 175, 32, 1, 127000),
(241, 176, 32, 1, 127000),
(242, 177, 32, 1, 127000),
(243, 178, 32, 1, 127000);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `total` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `note` text NOT NULL,
  `payment_method` varchar(50) NOT NULL DEFAULT 'cod',
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `momo_order_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `date`, `total`, `address`, `phone`, `note`, `payment_method`, `status`, `momo_order_id`) VALUES
(161, 18, '2025-11-08 10:35:24', 126000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(162, 18, '2025-11-08 10:35:53', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(163, 18, '2025-11-08 10:44:49', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(164, 18, '2025-11-08 10:45:05', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(165, 18, '2025-11-08 14:37:23', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(166, 18, '2025-11-08 14:40:25', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(167, 18, '2025-11-08 14:40:30', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(168, 18, '2025-11-08 14:44:07', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(169, 18, '2025-11-08 14:44:13', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(170, 18, '2025-11-08 14:47:39', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(171, 18, '2025-11-08 14:55:09', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(172, 18, '2025-11-08 14:58:47', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(173, 18, '2025-11-08 15:16:56', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(174, 18, '2025-11-08 15:23:17', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(175, 18, '2025-11-08 15:23:30', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(176, 18, '2025-11-08 15:24:29', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(177, 18, '2025-11-08 15:34:23', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL),
(178, 18, '2025-11-08 16:19:36', 127000, 'Bắc Ninh', '0378741289', '', 'cod', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `sell_quantity` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL,
  `sale_price` int(11) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `views` int(11) NOT NULL DEFAULT 0,
  `details` text NOT NULL,
  `short_description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `name`, `image`, `quantity`, `sell_quantity`, `price`, `sale_price`, `create_date`, `views`, `details`, `short_description`, `status`) VALUES
(1, 2, 'Tẩy trang Bioderma', 'taytrangbi.png', 150, 0, 299000, 199000, '2025-10-24 12:02:10', 3, '<p><strong>Bioderma Sensibio H2O</strong> là nước tẩy trang micellar dịu nhẹ, xuất xứ từ Pháp, chuyên dành cho da nhạy cảm. Sản phẩm giúp loại bỏ lớp trang điểm, bụi bẩn và bã nhờn trên da mà không gây khô rát hay kích ứng. Công thức độc đáo với các phân tử micelle hoạt động như nam châm hút sạch tạp chất, đồng thời giữ cho làn da mềm mịn, cân bằng độ ẩm tự nhiên.</p>\r\n\r\n<p>Không chứa xà phòng, paraben hay hương liệu, Bioderma Sensibio H2O phù hợp với mọi loại da, kể cả da nhạy cảm nhất. Với sản phẩm này, làn da được làm sạch sâu nhưng vẫn giữ được sự dịu nhẹ và thoải mái, sẵn sàng cho các bước dưỡng da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Bioderma</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Sensibio H2O</strong></p>\r\n', 1),
(2, 2, 'Tẩy trang Garnier', 'taytrangga.png', 100, 0, 186000, 140000, '2025-10-24 12:00:10', 3, '<p><strong>Garnier Micellar Cleansing Water</strong> là nước tẩy trang dịu nhẹ đến từ Pháp, chuyên làm sạch bụi bẩn, dầu thừa và lớp trang điểm mà không gây khô hay kích ứng da. Sản phẩm sử dụng công nghệ micelle tiên tiến, các phân tử micelle hoạt động như nam châm hút sạch tạp chất, giúp da mềm mịn và cân bằng độ ẩm tự nhiên.</p>\r\n\r\n<p>Sản phẩm không chứa xà phòng, paraben hay hương liệu, phù hợp với mọi loại da, kể cả da nhạy cảm. Chỉ cần dùng bông tẩy trang lau nhẹ, làn da đã được làm sạch sâu, sẵn sàng cho các bước dưỡng da tiếp theo. Với Garnier Micellar Water, việc tẩy trang trở nên nhanh chóng, tiện lợi và nhẹ nhàng hơn bao giờ hết.</p>\r\n', '<p>Nhà sản xuất: <strong>Garnier</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Micellar Cleansing Water</strong></p>\r\n', 1),
(6, 2, 'Tẩy trang Loreal', 'taytranglr.png', 50, 0, 145000, 100000, '2025-10-24 12:00:10', 0, '<p><strong>L’Oréal Paris Micellar Cleansing Water</strong> là nước tẩy trang dịu nhẹ, hiệu quả, giúp loại bỏ lớp trang điểm, bụi bẩn và bã nhờn mà không gây khô hay kích ứng da. Sản phẩm được phát triển với công nghệ micelle tiên tiến, các phân tử micelle hoạt động như nam châm hút sạch tạp chất, giữ cho làn da mềm mịn và cân bằng độ ẩm tự nhiên.</p>\r\n\r\n<p>Sản phẩm không chứa xà phòng, paraben hay hương liệu, phù hợp với mọi loại da, đặc biệt là da nhạy cảm. Chỉ cần lau nhẹ bằng bông tẩy trang, làn da của bạn đã được làm sạch sâu nhưng vẫn dịu nhẹ và thoải mái, sẵn sàng cho các bước dưỡng da tiếp theo. L’Oréal Micellar Water mang đến trải nghiệm tẩy trang nhanh chóng, tiện lợi và hiệu quả cho mọi làn da.</p>\r\n', '<p>Nhà sản xuất: <strong>L’Oréal Paris</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Micellar Cleansing Water</strong></p>\r\n', 1),
(14, 17, 'Kem chống nắng Beplain', 'kcnbe.png', 5, 0, 280000, 249000, '2025-10-24 12:00:10', 0, '<p><strong>Beplain Sun Cream</strong> là kem chống nắng dịu nhẹ, bảo vệ da khỏi tác hại của tia UVA và UVB, đồng thời cung cấp độ ẩm cần thiết cho làn da. Sản phẩm được chiết xuất từ các thành phần thiên nhiên, lành tính, không gây kích ứng, phù hợp với mọi loại da, kể cả da nhạy cảm.</p>\r\n\r\n<p>Với kết cấu mỏng nhẹ, dễ thẩm thấu, Beplain Sun Cream giúp da mềm mịn, không nhờn rít hay bết dính, đồng thời tạo lớp màng bảo vệ chống oxy hóa và ngăn ngừa lão hóa da do ánh nắng mặt trời. Sử dụng hàng ngày sẽ giúp làn da khỏe mạnh, rạng rỡ và được bảo vệ tối ưu dưới ánh nắng.</p>\r\n', '<p>Nhà sản xuất: <strong>Beplain</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Sun Cream</strong></p>\r\n', 1),
(15, 17, 'Kem chống nắng Make prem', 'kcnmp.png', 50, 0, 224000, 165000, '2025-10-24 12:00:10', 0, '<p><strong>Makeprem UV Defense Me Blue Ray Sun Cream</strong> là kem chống nắng dịu nhẹ, bảo vệ làn da khỏi tác hại của tia UVA, UVB và ánh sáng xanh từ thiết bị điện tử. Sản phẩm được nghiên cứu phù hợp với mọi loại da, đặc biệt là da nhạy cảm, nhờ công thức lành tính, không gây kích ứng.</p>\r\n\r\n<p>Với kết cấu mỏng nhẹ, nhanh thẩm thấu, Makeprem Sun Cream giúp da mềm mịn, không bết dính, đồng thời bổ sung độ ẩm và tạo lớp màng bảo vệ chống oxy hóa, ngăn ngừa lão hóa sớm. Sử dụng hàng ngày sẽ giúp làn da khỏe mạnh, rạng rỡ và được bảo vệ tối ưu dưới ánh nắng mặt trời cũng như ánh sáng xanh từ màn hình.</p>\r\n', '<p>Nhà sản xuất: <strong>Makeprem</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>UV Defense Me Blue Ray Sun Cream</strong></p>\r\n', 1),
(16, 17, 'Kem chống nắng Torriden', 'kcntor.png', 199, 1, 339000, 278000, '2025-10-24 12:00:10', 1, '<p><strong>Torriden UV Shield Sun Cream</strong> là kem chống nắng dịu nhẹ, giúp bảo vệ làn da khỏi tác hại của tia UVA và UVB, đồng thời giữ ẩm và nuôi dưỡng da mềm mịn. Sản phẩm được phát triển với công thức lành tính, không gây kích ứng, phù hợp với mọi loại da, kể cả da nhạy cảm.</p>\r\n\r\n<p>Với kết cấu mỏng nhẹ, dễ thẩm thấu, Torriden Sun Cream không gây bết dính hay nhờn rít, tạo lớp màng bảo vệ da trước tác động của ánh nắng và môi trường. Sử dụng hàng ngày giúp làn da khỏe mạnh, rạng rỡ, đồng thời ngăn ngừa lão hóa sớm và duy trì độ ẩm tự nhiên cho da.</p>\r\n', '<p>Nhà sản xuất: <strong>Torriden</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>UV Shield Sun Cream</strong></p>\r\n', 1),
(17, 16, 'Kem Dưỡng Ẩm Neutrogena Hydro Boost Water Gel', 'kdneutro.png', 30, 0, 270000, 187000, '2025-10-24 12:00:10', 1, '<p><strong>Neutrogena Hydro Boost Water Gel</strong> là kem dưỡng ẩm dạng gel nhẹ, cung cấp độ ẩm sâu và giúp duy trì làn da mềm mịn, tươi tắn suốt cả ngày. Sản phẩm được chiết xuất từ hyaluronic acid, giúp hút và giữ nước trên da, đồng thời cải thiện độ đàn hồi và làm dịu da khô, thiếu nước.</p>\r\n\r\n<p>Kết cấu gel mỏng nhẹ, thẩm thấu nhanh, không nhờn rít hay bết dính, phù hợp với mọi loại da, đặc biệt là da thường, da dầu và da hỗn hợp. Sử dụng hàng ngày giúp làn da căng mọng, mềm mại và sẵn sàng cho các bước trang điểm hoặc chăm sóc da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Neutrogena</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Hydro Boost Water Gel</strong></p>\r\n', 1),
(18, 6, 'Serum Centella', 'srcel.png', 66, 0, 289000, 243000, '2025-10-24 12:00:10', 0, '<p><strong>Centella Serum</strong> là serum dưỡng da dịu nhẹ, chuyên sâu giúp làm dịu, phục hồi và cải thiện làn da nhạy cảm, tổn thương. Sản phẩm được chiết xuất chính từ **Centella Asiatica**, kết hợp cùng các thành phần lành tính khác, giúp tăng cường hàng rào bảo vệ da, giảm mẩn đỏ và kích ứng.</p>\r\n\r\n<p>Kết cấu serum nhẹ, thẩm thấu nhanh, không nhờn rít, phù hợp với mọi loại da, đặc biệt là da nhạy cảm hoặc da đang bị mụn, dễ kích ứng. Sử dụng hàng ngày giúp da khỏe mạnh, mềm mịn, đồng thời tăng hiệu quả cho các bước dưỡng da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>[Thương hiệu Centella]</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Centella Serum</strong></p>\r\n', 1),
(20, 1, 'Son Tint Bóng Bền Màu Into You One Shot Lip Tint 2.2g', 'sontint.png', 54, 1, 200000, 126000, '2025-10-24 12:00:10', 0, '<p><strong>Into You One Shot Lip Tint 2.2g</strong> là son tint bóng với khả năng lên màu chuẩn và bền lâu, mang lại đôi môi căng mọng, tươi sáng suốt cả ngày. Sản phẩm kết hợp giữa chất son tint mịn và lớp bóng nhẹ, giúp đôi môi trông đầy đặn, mềm mại và tự nhiên.</p>\r\n\r\n<p>Với công thức dịu nhẹ, không gây khô môi, Into You One Shot Lip Tint còn bổ sung độ ẩm, giúp bảo vệ đôi môi khỏi tình trạng nứt nẻ. Thiết kế nhỏ gọn, tiện lợi, dễ dàng mang theo để dặm lại bất cứ lúc nào, phù hợp cho cả trang điểm hàng ngày hoặc các dịp đặc biệt.</p>\r\n', '<p>Nhà sản xuất: <strong>Into You</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>One Shot Lip Tint 2.2g</strong></p>\r\n', 1),
(21, 19, 'Toner Cocoon', 'tonercoc.png', 20, 0, 295000, 216000, '2025-10-24 12:00:10', 1, '<p><strong>Cocoon Toner</strong> là nước hoa hồng dịu nhẹ, giúp cân bằng độ pH, làm sạch sâu các tạp chất còn sót lại sau bước rửa mặt và chuẩn bị da cho các bước dưỡng tiếp theo. Sản phẩm được chiết xuất từ các thành phần thiên nhiên, lành tính, giúp làm dịu da, giảm kích ứng và tăng cường độ ẩm.</p>\r\n\r\n<p>Kết cấu mỏng nhẹ, thẩm thấu nhanh, Cocoon Toner phù hợp với mọi loại da, kể cả da nhạy cảm. Sử dụng đều đặn hàng ngày giúp làn da mềm mại, tươi sáng, cải thiện tình trạng khô ráp và hỗ trợ hiệu quả cho các bước chăm sóc da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Cocoon</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Toner</strong></p>\r\n', 1),
(23, 19, 'Toner Klairs', 'tonerkl.png', 29, 1, 279000, 210000, '2025-10-24 12:00:10', 2, '<p><strong>Klairs Supple Preparation Toner</strong> là nước hoa hồng dưỡng da dịu nhẹ, giúp cân bằng độ pH, làm sạch các tạp chất còn sót lại sau bước rửa mặt và chuẩn bị da cho các bước dưỡng tiếp theo. Sản phẩm được chiết xuất từ các thành phần thiên nhiên lành tính, giúp làm dịu, cấp ẩm và tăng cường sức khỏe cho làn da.</p>\r\n\r\n<p>Kết cấu lỏng nhẹ, thẩm thấu nhanh, Klairs Toner phù hợp với mọi loại da, đặc biệt là da nhạy cảm. Sử dụng hàng ngày giúp da mềm mại, mịn màng, giảm tình trạng khô ráp, đồng thời tăng hiệu quả cho các bước dưỡng da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Klairs</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Supple Preparation Toner</strong></p>\r\n', 1),
(24, 19, 'Toner Jumiso', 'tonerju.png', 121, 2, 239000, 189000, '2025-10-24 12:00:10', 3, '<p><strong>Jumiso All Day Vitamin Brightening Toner</strong> là nước hoa hồng dưỡng da dịu nhẹ, giúp cân bằng độ pH, làm sạch các tạp chất còn sót lại sau bước rửa mặt và chuẩn bị da cho các bước dưỡng tiếp theo. Sản phẩm được chiết xuất từ vitamin và các thành phần thiên nhiên lành tính, giúp làm sáng da, cấp ẩm và tăng cường sức khỏe cho làn da.</p>\r\n\r\n<p>Kết cấu lỏng nhẹ, thẩm thấu nhanh, Jumiso Toner phù hợp với mọi loại da, đặc biệt là da xỉn màu hoặc thiếu sức sống. Sử dụng hàng ngày giúp da mềm mại, tươi sáng, đều màu, đồng thời tăng hiệu quả cho các bước chăm sóc da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Jumiso</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>All Day Vitamin Brightening Toner</strong></p>\r\n', 1),
(25, 4, 'Sữa rửa mặt Cosrx', 'srmco.png', 48, 2, 159000, 129000, '2025-10-24 12:00:10', 6, '<p><strong>Cosrx Low pH Good Morning Gel Cleanser</strong> là sữa rửa mặt dịu nhẹ, giúp làm sạch bụi bẩn, bã nhờn và lớp trang điểm còn sót lại mà không làm mất cân bằng độ ẩm tự nhiên của da. Sản phẩm có độ pH thấp, phù hợp với mọi loại da, đặc biệt là da nhạy cảm và da dễ nổi mụn.</p>\r\n\r\n<p>Với thành phần chiết xuất từ tràm trà và chiết xuất thiên nhiên, Cosrx Gel Cleanser giúp làm dịu da, ngăn ngừa mụn và giảm tình trạng kích ứng. Kết cấu gel mỏng nhẹ, tạo bọt vừa phải, giúp da sạch sâu nhưng vẫn mềm mại và thoải mái sau khi rửa.</p>\r\n', '<p>Nhà sản xuất: <strong>Cosrx</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Low pH Good Morning Gel Cleanser</strong></p>\r\n', 1),
(26, 16, 'Kem dưỡng Medicube', 'kdme.png', 49, 1, 480000, 430000, '2025-10-24 12:00:10', 15, '<p><strong>Medicube Red Cica Cream</strong> là kem dưỡng da chuyên sâu, giúp phục hồi và làm dịu làn da nhạy cảm, kích ứng hoặc đang bị mẩn đỏ. Sản phẩm được chiết xuất từ **Centella Asiatica** và các thành phần lành tính khác, giúp tăng cường hàng rào bảo vệ da, giảm sưng đỏ và duy trì độ ẩm tự nhiên.</p>\r\n\r\n<p>Kết cấu mỏng nhẹ, thẩm thấu nhanh, Medicube Cream không gây bết dính hay nhờn rít, phù hợp với mọi loại da, đặc biệt là da nhạy cảm hoặc da đang điều trị mụn. Sử dụng đều đặn hàng ngày giúp da khỏe mạnh, mềm mịn và tăng hiệu quả cho các bước chăm sóc da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Medicube</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Red Cica Cream</strong></p>\r\n', 1),
(27, 4, 'Sữa rửa mặt Cocoon', 'srmcoc.png', 28, 2, 295000, 213000, '2025-10-24 12:00:10', 5, '<p><strong>Cocoon Natural Facial Cleanser</strong> là sữa rửa mặt dịu nhẹ, chiết xuất từ các thành phần thiên nhiên, giúp làm sạch bụi bẩn, bã nhờn và lớp trang điểm còn sót lại mà không làm khô da. Sản phẩm giúp cân bằng độ ẩm tự nhiên và làm dịu làn da nhạy cảm.</p>\r\n\r\n<p>Kết cấu mỏng nhẹ, tạo bọt vừa phải, Cocoon Facial Cleanser phù hợp với mọi loại da, đặc biệt là da nhạy cảm và da dễ kích ứng. Sử dụng hàng ngày giúp da mềm mại, tươi sáng và sẵn sàng cho các bước chăm sóc da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Cocoon</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Natural Facial Cleanser</strong></p>\r\n', 1),
(28, 6, 'Serum Torriden', 'srtor.png', 495, 5, 339000, 299000, '2025-10-24 12:00:10', 15, '<p><strong>Torriden Pro Deep Sea Moisture Serum</strong> là serum dưỡng ẩm chuyên sâu, giúp cấp nước tối ưu, làm mềm và phục hồi làn da khô, thiếu sức sống. Sản phẩm chứa các thành phần lành tính từ thiên nhiên và chiết xuất biển sâu, giúp duy trì độ ẩm, cải thiện độ đàn hồi và tăng cường hàng rào bảo vệ da.</p>\r\n\r\n<p>Kết cấu serum mỏng nhẹ, thẩm thấu nhanh, không nhờn rít, phù hợp với mọi loại da, đặc biệt là da khô hoặc da mất nước. Sử dụng đều đặn hàng ngày giúp da mềm mại, căng mịn, khỏe mạnh và tăng hiệu quả cho các bước chăm sóc da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Torriden</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Pro Deep Sea Moisture Serum</strong></p>\r\n', 1),
(29, 4, 'Sữa rửa mặt Simple', 'srmsim.png', 99, 1, 130000, 101000, '2025-10-24 12:00:10', 16, '<p><strong>Simple Kind to Skin Refreshing Facial Wash Gel</strong> là sữa rửa mặt dịu nhẹ, giúp loại bỏ bụi bẩn, bã nhờn và lớp trang điểm còn sót lại mà không làm mất cân bằng độ ẩm tự nhiên của da. Sản phẩm được chiết xuất từ các thành phần lành tính, không chứa hương liệu, paraben hay chất tạo màu, phù hợp với mọi loại da, đặc biệt là da nhạy cảm.</p>\r\n\r\n<p>Kết cấu gel mỏng nhẹ, tạo bọt vừa phải, giúp làm sạch sâu nhưng vẫn giữ da mềm mại và thoải mái sau khi rửa. Sử dụng đều đặn hàng ngày giúp da tươi sáng, sạch sẽ và chuẩn bị tốt cho các bước dưỡng da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Simple</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Kind to Skin Refreshing Facial Wash Gel</strong></p>\r\n', 1),
(30, 16, 'Kem dưỡng garnier', 'kdga.png', 43, 7, 188000, 138000, '2025-10-24 12:00:10', 15, '<p><strong>Garnier Moisture Bomb Cream</strong> là kem dưỡng ẩm dịu nhẹ, cung cấp độ ẩm sâu, giúp làn da mềm mịn và căng mọng suốt cả ngày. Sản phẩm được chiết xuất từ các thành phần thiên nhiên lành tính, giúp duy trì độ ẩm tự nhiên và tăng cường hàng rào bảo vệ da.</p>\r\n\r\n<p>Kết cấu mỏng nhẹ, thẩm thấu nhanh, không gây nhờn rít hay bết dính, phù hợp với mọi loại da, đặc biệt là da thường và da khô. Sử dụng hàng ngày giúp da tươi tắn, mịn màng và sẵn sàng cho các bước trang điểm hoặc chăm sóc da tiếp theo.</p>\r\n', '<p>Nhà sản xuất: <strong>Garnier</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Moisture Bomb Cream</strong></p>\r\n', 1),
(31, 6, 'Serum Jumiso', 'srju.png', 99, 62, 180000, 126000, '2025-10-24 12:00:10', 31, '<p><i><strong>Jumiso Serum</strong></i> (tên tiếng Anh: <i><strong>Jumiso Facial Serum</strong></i>) là dòng tinh chất dưỡng da nổi tiếng đến từ thương hiệu <a href=\"https://www.jumiso.com/\">Jumiso</a> của Hàn Quốc, được nhiều tín đồ làm đẹp yêu thích nhờ hiệu quả dưỡng sáng, phục hồi và cấp ẩm vượt trội.</p><p>Sản phẩm gồm nhiều phiên bản khác nhau đáp ứng nhu cầu của từng loại da: <strong>Jumiso All Day Vitamin Brightening &amp; Balancing Serum</strong> giúp làm sáng và đều màu da; <strong>Jumiso Waterfull Hyaluronic Acid Serum</strong> cung cấp độ ẩm chuyên sâu; <strong>Jumiso Super Soothing Cica &amp; Aloe Serum</strong> làm dịu da nhạy cảm; và <strong>Jumiso Snail Mucin 95 + Peptide Serum</strong> hỗ trợ tái tạo, giảm thâm và ngừa lão hóa. Với kết cấu mỏng nhẹ, thấm nhanh, serum giúp làn da trở nên mềm mại, sáng khỏe và căng bóng tự nhiên.</p><p>Thành phần chính của mỗi dòng serum đều được chiết xuất từ thiên nhiên, an toàn cho da: vitamin C, niacinamide, rau má, nha đam, dịch nhầy ốc sên và peptide. Sản phẩm phù hợp cho mọi loại da, đặc biệt là da khô, da xỉn màu hoặc da đang phục hồi sau mụn.</p>', '<p>Thương hiệu: <strong>Jumiso (Hàn Quốc)</strong> &nbsp; &nbsp; &nbsp; Xuất xứ: <strong>Hàn Quốc</strong></p>', 1),
(32, 1, 'Son romand', 'sonrmm.png', 994, 109, 156000, 127000, '2025-10-24 12:00:10', 68, '<p><strong>Romand Zero Matte Lipstick</strong> là son lì với khả năng lên màu chuẩn và bền lâu, mang lại đôi môi mịn màng, căng mọng và tươi sáng. Sản phẩm có kết cấu mịn, mềm, dễ tán và không gây khô môi, tạo cảm giác nhẹ nhàng khi sử dụng.</p><p>Romand Lipstick được thiết kế với nhiều tông màu trendy, phù hợp cho cả trang điểm hàng ngày và các dịp đặc biệt. Công thức dịu nhẹ, bổ sung độ ẩm giúp bảo vệ đôi môi, hạn chế tình trạng nứt nẻ, mang lại vẻ ngoài rạng rỡ, tự nhiên.</p>', '<p>Nhà sản xuất: <strong>Romand</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Zero Matte Lipstick</strong></p>', 1),
(35, 1, 'Son 3ce', 'son3ce.png', 96, 4, 300000, 199000, '2025-10-24 12:00:10', 16, '<p><strong>3CE Velvet Lip Tint</strong> là son lì dạng tint với khả năng lên màu chuẩn, bền lâu, mang lại đôi môi căng mọng, mềm mại và tươi sáng. Sản phẩm có kết cấu mịn, dễ tán, không gây khô môi và tạo cảm giác nhẹ nhàng, thoải mái khi sử dụng.</p><p>3CE Lip Tint có nhiều tông màu trendy, phù hợp cho cả trang điểm hàng ngày và các dịp đặc biệt. Công thức dưỡng nhẹ giúp duy trì độ ẩm cho đôi môi, hạn chế tình trạng nứt nẻ, mang lại vẻ ngoài rạng rỡ và tự nhiên.</p>', '<p>Nhà sản xuất: <strong>3CE</strong> &nbsp; &nbsp; &nbsp; Dòng sản phẩm: <strong>Velvet Lip Tint</strong></p>', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL COMMENT 'Tên đăng nhập',
  `password` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL COMMENT 'Họ tên',
  `image` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 là khách hàng 1 là nhân viên',
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `full_name`, `image`, `email`, `phone`, `address`, `role`, `active`) VALUES
(8, 'admin', '$2y$10$fMraDBMUC8j1Vxmied196uPQTn5UpoBifgwrH.3DqkaVOWABeSyHG', 'Dương Đình Duy', 'z5809717515239_3762dad6def27d68170ad55ac7de03bb.jpg', 'duongdinhduy28042004@gmail.com', '0378741287', 'Hà Nội', 1, 1),
(18, 'duyyyy', '$2y$10$vmCrGhTqM40DPyQup7ElB.Fv6v7dvMhvGMkhvt70AxJBS0fAtQUKC', 'Dương Đình Duy', 'user-default.png', 'duyy2004@gmail.com', '0378741289', 'Bắc Ninh', 1, 1),
(19, 'NTTH', '$2y$10$adRk0iqR1kppiub84APkleT.fJq3hsuP0l6xyN56ytJg3zb440092', 'NTTH', 'user-default.png', 'ha@gmail.com', '0987654321', 'BN', 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`orderdetails_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_category` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=300;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `orderdetails_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=244;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=179;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1`
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`category_id`)
COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
