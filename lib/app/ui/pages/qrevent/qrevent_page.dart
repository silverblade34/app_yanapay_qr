import 'package:app_yanapay_qr/app/controllers/qrevent_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrEventPage extends GetView<QrEventController> {
  const QrEventPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(title: Text('QrEventPage')),

    body: SafeArea(
      child: Text('QrEventController'))
    );
  }
}