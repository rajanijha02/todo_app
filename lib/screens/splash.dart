import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'TodoScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(TodoScreen());
    });

    return Scaffold(
      backgroundColor: Color(0xff184b75),
      body: Center(
        child: Text(
          'To-Do App',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
