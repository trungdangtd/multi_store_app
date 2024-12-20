import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controller/product_controller.dart';
import 'package:multi_store_app/currency_formatter.dart';
import 'package:multi_store_app/models/product.dart';
import 'package:multi_store_app/provider/cart_provider.dart';
import 'package:multi_store_app/provider/favorite_provider.dart';
import 'package:multi_store_app/provider/related_product_provider.dart';
import 'package:multi_store_app/services/manage_http_respone.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController
          .loadRelatedProductBySubCategory(widget.product.id);
      ref.read(relatedProductProvider.notifier).setProducts(products);
    } catch (e) {
      // ignore: avoid_print
      print("Lỗi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final relatedProduct = ref.watch(relatedProductProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriesProvider.notifier);
    ref.watch(favoriesProvider);
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'chi tiết sản phẩm',
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              favoriteProviderData.addProductToFavories(
                  productName: widget.product.productName,
                  productPrice: widget.product.productPrice,
                  category: widget.product.category,
                  image: widget.product.images,
                  vendorId: widget.product.vendorId,
                  productQuantity: widget.product.quantity,
                  quantity: 1,
                  productId: widget.product.id,
                  description: widget.product.description,
                  fullName: widget.product.fullName);
              showSnackBar(context,
                  'Đã thêm vào yêu thích ${widget.product.productName}');
            },
            icon: favoriteProviderData.getFavoriesItems
                    .containsKey(widget.product.id)
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 260,
                height: 275,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 0,
                      top: 50,
                      child: Container(
                        width: 260,
                        height: 260,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD8DDFF),
                          borderRadius: BorderRadius.circular(130),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 22,
                      top: 0,
                      child: Container(
                        width: 216,
                        height: 274,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color(0xFF9CA8FF),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: PageView.builder(
                              itemCount: widget.product.images.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  widget.product.images[index],
                                  width: 198,
                                  height: 225,
                                  fit: BoxFit.cover,
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.productName,
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    CurrencyFormatter.formatToVND(widget.product.productPrice),
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product.category,
                style: GoogleFonts.roboto(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            widget.product.totalRating == 0
                ? const Text('')
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          widget.product.averageRating.toStringAsFixed(
                            1,
                          ),
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text("(${widget.product.totalRating})",
                            style: GoogleFonts.montserrat()),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Mô tả sản phẩm:",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.7,
                      color: const Color(0xFF363330),
                    ),
                  ),
                  Text(
                    widget.product.description,
                    style: GoogleFonts.roboto(
                      letterSpacing: 1.5,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const ReusableTextWidget(
              title: 'Sản Phẩm Liên Quan',
              subtitle: '',
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: relatedProduct.length,
                itemBuilder: (context, index) {
                  final product = relatedProduct[index];
                  return ProductItemWidget(
                    product: product,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: isInCart
              ? null
              : () {
                  cartNotifier.addProductToCart(
                      productName: widget.product.productName,
                      productPrice: widget.product.productPrice,
                      category: widget.product.category,
                      image: widget.product.images,
                      vendorId: widget.product.vendorId,
                      productQuantity: widget.product.quantity,
                      quantity: 1,
                      productId: widget.product.id,
                      description: widget.product.description,
                      fullName: widget.product.fullName);

                  showSnackBar(context, widget.product.productName);
                },
          child: Container(
            width: 386,
            height: 46,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: isInCart
                    ? Colors.grey
                    : const Color(
                        0xff3b54EE,
                      ),
                borderRadius: BorderRadius.circular(24)),
            child: Center(
              child: Text(
                "Thêm vào giỏ hàng",
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
