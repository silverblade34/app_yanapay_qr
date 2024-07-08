import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrWebsiteController extends GetxController {
  TextEditingController linkUrl = TextEditingController();
    TextEditingController selectColor = TextEditingController();
  var qrData = ''.obs;
  var qrColor = Colors.black.obs;
  var qrIcon = ''.obs;

 
  void setQrColor(Color color) {
    qrColor.value = color;
  }

  void setQrIcon(String path) {
    qrIcon.value = path;
  }

  bool _isValidURL(String url) {
    const urlPattern = r'^(https?:\/\/)?([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$';
    final result = RegExp(urlPattern).hasMatch(url);
    return result;
  }

  void generateQr() {
    if (_isValidURL(linkUrl.text)) {
      qrData.value = linkUrl.text;
    } else {
      Get.snackbar("Error", "Por favor, ingrese un enlace válido.");
    }
  }
}
