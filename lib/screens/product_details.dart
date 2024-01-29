import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_app/constants/constants.dart';
import 'package:test_app/utils/common_methods.dart';

import '../controllers/main_controller.dart';
import '../models/product_model.dart';
import '../services/sqlite_service.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final mc = Get.put(MainController());
  Product currentProduct = Get.arguments as Product;
  late DataBase handler;
  List products = [];
  List images = [
    "assets/images/img1.jpeg",
    "assets/images/img2.jpeg",
    "assets/images/img3.jpeg",
  ];
  String selectedSize = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      retrieveData();
    });
  }

  retrieveData() async {
    try {
      mc.isDataLoading.value = true;
      setState(() {
        handler = DataBase();
      });
      handler.retrieveSpecificProducts(currentProduct.name).then((value) {
        setState(() {
          products = value;
          mc.isDataLoading.value = false;
        });
      });
    } finally {
      mc.isDataLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => mc.isDataLoading.value
        ? Center(
            child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ))
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              surfaceTintColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text("${products.length} Options (Tap to Select)"),
                          const Spacer(),
                          const Text("Total Qty: "),
                          Text(
                            "${currentProduct.minQuantity}",
                            style: TextStyle(
                                color: HexColor(primaryColor),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            for (final Product product in products)
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: InkWell(
                                  onTap: () => setState(() {
                                    currentProduct = product;
                                    mc.isDataLoading.value = true;
                                    mc.isDataLoading.value = false;
                                  }),
                                  child: Stack(
                                    children: [
                                      Container(
                                        // padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                                color: HexColor(primaryColor),
                                                width: currentProduct.option ==
                                                        product.option
                                                    ? 3
                                                    : 0)),
                                        child: product.imageUrl.isEmpty &&
                                                product
                                                    .technologyImageUrl.isEmpty
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.asset(
                                                  "assets/images/img1.jpeg",
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, url,
                                                          error) =>
                                                      const SizedBox.shrink(),
                                                  height: 148,
                                                  width: 148,
                                                ),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  product.technologyImageUrl
                                                          .isEmpty
                                                      ? product.imageUrl
                                                      : product
                                                          .technologyImageUrl,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, url,
                                                          error) =>
                                                      const SizedBox.shrink(),
                                                  height: 148,
                                                  width: 148,
                                                ),
                                              ),
                                      ),
                                      if (currentProduct.option ==
                                          product.option)
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Checkbox(
                                              value: true, onChanged: (val) {}),
                                        )
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                              // text: 'Hello ',
                              // style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: currentProduct.option,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,

                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                                TextSpan(
                                  text: ', ${currentProduct.fit}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                                TextSpan(
                                  text: '\n${currentProduct.color}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$${CommonMethods().getValue(currentProduct.mrp)}",
                            style: TextStyle(
                                fontSize: 22,
                                color: HexColor(primaryColor),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Size',
                        style: TextStyle(
                          fontSize: 18,
                          // color: HexColor(primaryColor),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          children: [
                            for (final String size in currentProduct.ean.keys)
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: InkWell(
                                  onTap: () => setState(() {
                                    mc.isDataLoading.value = true;
                                    mc.isDataLoading.value = false;
                                  }),
                                  child: GestureDetector(
                                    onTap: () => setState(() {
                                      selectedSize = size;
                                    }),
                                    child: Container(
                                        height: 48,
                                        width: 48,
                                        // padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: selectedSize == size
                                                ? HexColor(primaryColor)
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: HexColor(primaryColor),
                                                width: 1)),
                                        child: Center(
                                          child: Text(
                                            size,
                                            style: TextStyle(
                                                fontWeight: selectedSize == size
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                                color: selectedSize == size
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        )),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 20,
                                // color: HexColor(primaryColor),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: currentProduct.brand,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${currentProduct.description}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 20,
                                // color: HexColor(primaryColor),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Brand',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.brand}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Category',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.category}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Collection',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\n${currentProduct.collection}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Sub-Category',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\n${currentProduct.subCategory}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Fit',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.fit}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Theme',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.theme}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Finish',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.finish}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Offer',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        for (String offer
                                            in currentProduct.offerMonths)
                                          TextSpan(
                                            text: '\n$offer',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Gender',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.gender}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Name',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.name}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Fabric',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.fabric}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Materiel',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '\n${currentProduct.material}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Quality',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor(primaryColor),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '\n${currentProduct.quality.isEmpty}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ));
  }
}
