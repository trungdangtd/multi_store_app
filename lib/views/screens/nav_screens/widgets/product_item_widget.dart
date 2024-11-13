import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/currency_formatter.dart';
import 'package:multi_store_app/models/product.dart';
import 'package:multi_store_app/provider/cart_provider.dart';
import 'package:multi_store_app/provider/favorite_provider.dart';
import 'package:multi_store_app/services/manage_http_respone.dart';
import 'package:multi_store_app/views/screens/detail/screens/product_detail_screen.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final isInCart = cartData.containsKey(widget.product.id);
    final cartNotifier = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriesProvider.notifier);
    ref.watch(favoriesProvider);
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(
            product: widget.product,
          );
        }));
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Image.network(
                    widget.product.images[0],
                    height: 170,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      onTap: () {
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
                      child: favoriteProviderData.getFavoriesItems
                              .containsKey(widget.product.id)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
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

                              showSnackBar(context, 'Đã thêm vào giỏ hàng');
                            },
                      child: Image.asset(
                        'assets/icons/cart.png',
                        width: 26,
                        height: 26,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(),
            Text(
              widget.product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: const Color(
                    0xFF212121,
                  ),
                  fontWeight: FontWeight.bold),
            ),
            widget.product.averageRating == 0
                ? const SizedBox()
                : Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        widget.product.averageRating.toStringAsFixed(
                          1,
                        ),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            Text(
              widget.product.category,
              style: GoogleFonts.quicksand(
                fontSize: 12,
                color: const Color(0xff868d94),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              CurrencyFormatter.formatToVND(widget.product.productPrice),
              style: GoogleFonts.montserrat(
                fontSize: 15,
                color: const Color.fromARGB(255, 21, 23, 26),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
