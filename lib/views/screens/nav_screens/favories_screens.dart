import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/currency_formatter.dart';
import 'package:multi_store_app/provider/favorite_provider.dart';
import 'package:multi_store_app/views/screens/main_screen.dart';

class FavoriesScreens extends ConsumerStatefulWidget {
  const FavoriesScreens({super.key});

  @override
  ConsumerState<FavoriesScreens> createState() => _FavoriesScreensState();
}

class _FavoriesScreensState extends ConsumerState<FavoriesScreens> {
  @override
  Widget build(BuildContext context) {
    final wishItemData = ref.watch(favoriesProvider);
    final wishListProvider = ref.read(favoriesProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/cartb.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 60,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/cart.png',
                      width: 35,
                      height: 35,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            wishItemData.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 65,
                child: Text(
                  'Yêu thích',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
      body: wishItemData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Danh sách yêu thích đang trống\n Hãy thêm sản phẩm vào giỏ hàng',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const MainScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('Mua ngay'))
                ],
              ),
            )
          : ListView.builder(
              itemCount: wishItemData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final wishData = wishItemData.values.toList()[index];

                return Padding(
                  padding: const EdgeInsets.all(
                    8,
                  ),
                  child: Container(
                    width: 400,
                    height: 96,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 400,
                              height: 97,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color(
                                    0xffeff0f2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 13,
                            top: 9,
                            child: Container(
                              width: 78,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xffbcc5ff,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 275,
                            top: 16,
                            child: Text(
                              CurrencyFormatter.formatToVND(
                                wishData.productPrice,
                              ),
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(
                                  0xff0b0c1f,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 101,
                            top: 14,
                            child: SizedBox(
                              width: 162,
                              child: Text(
                                wishData.productName,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 23,
                            top: 14,
                            child: Image.network(
                              wishData.image[0],
                              width: 56,
                              height: 67,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 340,
                            top: 60,
                            child: IconButton(
                              onPressed: () {
                                wishListProvider
                                    .removeFavoriesItem(wishData.productId);
                              },
                              icon: const Icon(
                                Icons.delete,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
