import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrTextController extends GetxController {
  TextEditingController textController = TextEditingController();
  RxString qrValue = "".obs;

  void generateQr() {
    qrValue.value = textController.text;
  }
}
