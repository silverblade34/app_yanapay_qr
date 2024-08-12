import 'package:app_yanapay_qr/app/controllers/qrmail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QRMailPage extends GetView<QRMailController> {
  const QRMailPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('QRMailPage')),

    body: SafeArea(
      child: Text('QRMailController'))
    );
  }
}