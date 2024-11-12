import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/banner.dart';

class BannerProvider extends StateNotifier<List<BannerModel>>{
  BannerProvider() : super([]);

  void setBanners(List<BannerModel> banners){
    state = banners;
  }
}

final bannerProvider = StateNotifierProvider<BannerProvider, List<BannerModel>>((ref) => BannerProvider()); 
