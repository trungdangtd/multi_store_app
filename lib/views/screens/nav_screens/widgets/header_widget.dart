import 'package:flutter/material.dart';
import 'package:multi_store_app/views/screens/detail/screens/search_product_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Stack(
        children: [
          Image.asset("assets/icons/searchBanner.jpeg",
              width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
          Positioned(
            left: 48,
            top: 68,
            child: SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SearchProductScreen();
                  }));
                },
                decoration: InputDecoration(
                    hintText: 'Nhập tên sản phẩm',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7F7F7F),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    prefixIcon: Image.asset(
                      "assets/icons/search.png",
                    ),
                    suffixIcon: Image.asset(
                      "assets/icons/cam.png",
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    focusColor: Colors.black),
              ),
            ),
          ),
          Positioned(
            left: 360,
            top: 78,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                  onTap: () {},
                  overlayColor:
                      WidgetStateProperty.all(const Color(0x000c7f7f)),
                  child: Ink(
                    width: 31,
                    height: 31,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icons/bell.png'))),
                  )),
            ),
          ),
          Positioned(
              left: 403,
              top: 78,
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                    onTap: () {},
                    overlayColor:
                        WidgetStateProperty.all(const Color(0x000c7f7f)),
                    child: Ink(
                      width: 31,
                      height: 31,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/message.png'))),
                    )),
              ))
        ],
      ),
    );
  }
}
