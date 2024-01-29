import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../services/sqlite_service.dart';
import '../utils/common_methods.dart';

class MainController extends GetxController {
  RxBool isDataLoading = false.obs;
  late DataBase handler;
  RxMap data = {}.obs;

  @override
  void onInit() {
    super.onInit();
    handler = DataBase();
    handler.initializedDB().whenComplete(() async {
      setData();
    });
  }

  setData() async {
    try {
      isDataLoading.value = true;

      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (preferences.containsKey('data')) {
        data.value = jsonDecode(preferences.getString('data')!);
      } else {
        await getData();
        await addProducts();
      }
    } finally {
      isDataLoading.value = false;
    }
  }

  Future<int> addProducts() async {
    List<Product> planets = [];

    for (final json in data['Products']) {
      planets.add(
        Product(
          season: json['Season'],
          brand: json['Brand'],
          mood: json['Mood'],
          gender: json['Gender'],
          theme: json['Theme'],
          category: json['Category'],
          name: json['Name'],
          color: json['Color'],
          option: json['Option'],
          mrp: json['MRP'],
          subCategory: json['SubCategory'],
          collection: json['Collection'],
          fit: json['Fit'],
          description: json['Description'],
          qrCode: json['QRCode'],
          looks: json['Looks'] ?? '',
          looksImageUrl: json['LooksImageUrl'] ?? '',
          looksImage: json['LooksImage'] ?? "",
          fabric: json['Fabric'],
          ean: jsonEncode(json['EAN']),
          finish: json['Finish'],
          availableSizes: (json['AvailableSizes']),
          availableSizesWithDeactivated:
              (json['AvailableSizesWithDeactivated']),
          sizeWiseStock: jsonEncode(json['SizeWiseStock']),
          sizeWiseStockPlant: jsonEncode(json['SizeWiseStockPlant']),
          offerMonths: (json['OfferMonths']),
          productClass: json['ProductClass'],
          promoted: json['Promoted'] ? 1 : 0,
          secondary: json['Secondary'] ? 1 : 0,
          deactivated: json['Deactivated'] ? 1 : 0,
          defaultSize: json['DefaultSize'] ?? '',
          material: json['Material'],
          quality: json['Quality'],
          qrCode2: json['QRCode2'],
          displayName: json['DisplayName'],
          displayOrder: json['DisplayOrder'],
          minQuantity: json['MinQuantity'],
          maxQuantity: json['MaxQuantity'],
          qpsCode: json['QPSCode'],
          demandType: json['DemandType'] ?? '',
          image: json['Image'],
          imageUrl: json['ImageUrl'],
          imageUrl2: json['ImageUrl2'],
          imageUrl3: json['ImageUrl3'],
          imageUrl4: json['ImageUrl4'],
          imageUrl5: json['ImageUrl5'],
          imageUrl6: json['ImageUrl6'] ?? '',
          imageUrl7: json['ImageUrl7'] ?? '',
          imageUrl8: json['ImageUrl8'] ?? '',
          imageUrl9: json['ImageUrl9'] ?? '',
          imageUrl10: json['ImageUrl10'] ?? '',
          imageUrl11: json['ImageUrl11'] ?? '',
          imageUrl12: json['ImageUrl12'] ?? '',
          adShoot: json['AdShoot'] ? 1 : 0,
          technology: json['Technology'],
          imageAlt: json['ImageAlt'],
          technologyImage: json['TechnologyImage'] ?? '',
          technologyImageUrl: json['TechnologyImageUrl'] ?? '',
          isCore: json['IsCore'] ? 1 : 0,
          minimumArticleQuantity: json['MinimumArticleQuantity'],
          likeability: json['Likeabilty'],
          brandRank: json['BrandRank'],
          gradeToRatiosApps: (json['GradeToRatiosApps']),
          relatedProducts: (json['RelatedProducts']),
        ),
      );
    }

    return await handler.insertPlanets(planets);
  }

  Future getData() async {
    try {
      //CommonMethods().showLoadingHud();
      var headers = {
        'Cookie':
            'ARRAffinity=a231242b70b5a76f1ccea5926390139d3c18c36a02eee2f49ca9c50c8aa94551; ARRAffinitySameSite=a231242b70b5a76f1ccea5926390139d3c18c36a02eee2f49ca9c50c8aa94551'
      };
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://ios.qartsolutions.com/api/product/GetProductsWithSizes?retailerCode=40984'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Map<String, dynamic> resp =
            jsonDecode(await response.stream.bytesToString());
        data.value = resp;
        // brandsResponse = BrandsResponse.fromJson(resp);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("data", jsonEncode(resp));
      } else {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      if (!Get.isSnackbarOpen) {
        CommonMethods().showSnackBar("Something went wrong !", Colors.red);
      }
    } finally {
      //CommonMethods().dismissLoadingHud();
    }
  }
}
