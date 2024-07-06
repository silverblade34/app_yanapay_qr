import 'package:app_yanapay_qr/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('HomePage')),

    body: SafeArea(
      child: Text('HomeController'))
    );
  }
}