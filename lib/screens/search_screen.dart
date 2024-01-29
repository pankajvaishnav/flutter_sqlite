import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_app/constants/constants.dart';
import 'package:test_app/controllers/main_controller.dart';
import 'package:test_app/models/product_model.dart';
import 'package:test_app/utils/common_methods.dart';

import '../../utils/size_config.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final mc = Get.put(MainController());
  Map matchingIndexes = {};
  String dishSearchText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => mc.isDataLoading.value
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: HexColor(primaryColor),
                automaticallyImplyLeading: false,
                title: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      dishSearchText = value;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.circular(30)), //<-- SEE HERE
                      prefixIcon: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back),
                      )),
                ),
              ),
              body: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder(
                  future: mc.handler.retrieveProducts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data![index].option
                                  .toString()
                                  .toLowerCase()
                                  .contains(dishSearchText.trim().toLowerCase())
                              ? displayProducts(context, snapshot.data![index])
                              : const SizedBox.shrink();
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )),
            ),
    );
  }

  Widget displayProducts(context, Product product) {
    return InkWell(
      onTap: () => Get.toNamed('product_details', arguments: product),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.height * 100 * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              product.qrCode,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 16,
                  // color: Colors.black54,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.imageUrl.isEmpty
                    ? const SizedBox.shrink()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, url, error) =>
                              const SizedBox.shrink(),
                          height: 48,
                          width: 48,
                        ),
                      ),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(
                              // text: 'Hello ',
                              // style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                for (int i = 0; i < product.option.length; i++)
                                  TextSpan(
                                    text: product.option[i],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: changeCharColor(
                                                  dishSearchText,
                                                  product.option
                                                      .toString()
                                                      .substring(i),
                                                  i,
                                                  product.option)
                                              .contains(i)
                                          ? HexColor(primaryColor)
                                              .withOpacity(0.7)
                                          : Colors.black,
                                      // fontWeight: FontWeight.w500
                                    ),
                                  ),
                                TextSpan(
                                  text: ', ${product.fit}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(product.color,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700)),
                          if (product.description.isNotEmpty)
                            Text(
                              product.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text('\$${CommonMethods().getValue(product.mrp)}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w700)),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Sizes: ',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    // fontWeight: FontWeight.w400
                  ),
                ),
                // for (final size in product.availableSizes)
                Text(
                  product.ean.keys.join(', '),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 12,
                      color: HexColor(primaryColor),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.1,
            )
          ],
        ),
      ),
    );
  }

  List changeCharColor(String dishSearchText, String subValue, int index, id) {
    List indexList = [];
    if (dishSearchText.length == subValue.length) {
      if (dishSearchText.toLowerCase() == subValue.toLowerCase()) {
        for (int i = index; i < index + dishSearchText.length; i++) {
          indexList.add(i);
        }
        matchingIndexes[id] = indexList;
      }
    } else if (dishSearchText.length <= subValue.length) {
      if (dishSearchText.toLowerCase() ==
          subValue.substring(0, dishSearchText.length).toLowerCase()) {
        for (int i = index; i < index + dishSearchText.length; i++) {
          indexList.add(i);
        }
        matchingIndexes[id] = indexList;
      }
    }
    return matchingIndexes[id] ?? [];
  }
}
