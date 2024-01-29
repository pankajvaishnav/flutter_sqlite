import 'package:get/get.dart';
import 'package:test_app/screens/product_details.dart';
import 'package:test_app/screens/search_screen.dart';

class Routes {
  static final routes = [
    GetPage(name: '/search', page: () => const SearchScreen()),
    GetPage(name: '/product_details', page: () => const ProductDetails()),
  ];
}
