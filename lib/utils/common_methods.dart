import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonMethods {
  showSnackBar(msg, color) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      // isDismissible: false,
      snackStyle: SnackStyle.FLOATING,
      messageText: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      titleText: Container(),
      margin: const EdgeInsets.only(
          bottom: kBottomNavigationBarHeight + 5, top: 5, left: 10, right: 10),
      padding: const EdgeInsets.only(bottom: 4, left: 16, right: 16),
      borderRadius: 4,
      backgroundColor: color,
      //colorText: Theme.of(context).colorScheme.surface,
      // mainButton: TextButton(
      //   child: Text('Undo'),
      //   onPressed: () {},
      // ),
    );
  }

  getValue(value) {
    return value == null
        ? 0
        : value.toInt() == value.toDouble()
            ? value.toInt()
            : value.toDouble().toStringAsFixed(2);
  }
}
