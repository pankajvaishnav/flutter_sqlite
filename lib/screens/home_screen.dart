import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:hexcolor/hexcolor.dart';
import '../constants/constants.dart';
import '../controllers/main_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:countup/countup.dart';

import '../services/sqlite_service.dart';
import '../utils/common_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final mc = Get.put(MainController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  _onRefresh() async {
    mc.isDataLoading.value = true;
    final handler = DataBase();
    await handler.deleteProducts();
    await mc.getData();
    await mc.addProducts();
    mc.isDataLoading.value = false;
    CommonMethods().showSnackBar("Data Updated !", Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => mc.isDataLoading.value
          ? Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Welcome",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: HexColor(primaryColor),
              ),
              body: Center(
                child: CircularProgressIndicator(
                  color: HexColor(primaryColor),
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Welcome",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: HexColor(primaryColor),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: !mc.isDataLoading.value ? _onRefresh : null,
                child: const Icon(Icons.refresh),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Material(
                      child: TextField(
                        onTap: () => Get.toNamed("search"),
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "Search here",
                            hintStyle: const TextStyle(
                                // color: Colors.grey,
                                // fontWeight: FontWeight.w500
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            suffixIcon: const Icon(Icons.search),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20)),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Countup(
                              begin: 0,
                              end: mc.data['ProductCount'].toDouble(),
                              duration: const Duration(seconds: 2),
                              separator: ',',
                              style: const TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Text("Items found")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
