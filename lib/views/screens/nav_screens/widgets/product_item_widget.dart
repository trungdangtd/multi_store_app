import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/currency_formatter.dart';
import 'package:multi_store_app/models/product.dart';
import 'package:multi_store_app/views/screens/detail/screens/product_detail_screen.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(
            product: product,
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
                    product.images[0],
                    height: 170,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Image.asset(
                      'assets/icons/love.png',
                      width: 26,
                      height: 26,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Image.asset(
                      'assets/icons/cart.png',
                      width: 26,
                      height: 26,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(),
            Text(
              product.productName,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  color: const Color(
                    0xFF212121,
                  ),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              product.category,
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: const Color(0xff868d94),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              CurrencyFormatter.formatToVND(product.productPrice),
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
