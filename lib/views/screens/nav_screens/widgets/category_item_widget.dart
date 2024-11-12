import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_store_app/controller/category_controller.dart';
import 'package:multi_store_app/provider/category_provider.dart';
import 'package:multi_store_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:multi_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoriesWidget extends ConsumerStatefulWidget {
  const CategoriesWidget({super.key});

  @override
  ConsumerState<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends ConsumerState<CategoriesWidget> {
  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final CategoryController categoryController = CategoryController();
    try {
      final categories = await categoryController.loadCategoriess();
      ref.read(cateProvider.notifier).setCategories(categories);
    } catch (e) {
      // ignore: avoid_print
      print("Lỗi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = ref.watch(cateProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: 'Danh mục', subtitle: 'Xem tất cả'),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: category.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 8, mainAxisExtent: 100),
          itemBuilder: (context, index) {
            final categories = category[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return InnerCategoryScreen(
                      category: categories,
                    );
                  },
                ));
              },
              child: Column(
                children: [
                  Image.network(
                    categories.image,
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    categories.name,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
