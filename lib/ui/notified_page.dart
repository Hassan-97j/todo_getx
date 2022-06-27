import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          label.toString().split("|")[0],
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 400,
          decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            label.toString().split("|")[1],
            style:
                TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black,fontSize: 22),
          )),
        ),
      ),
    );
  }
}
