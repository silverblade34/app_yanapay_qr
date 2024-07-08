import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> pickIcon() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setQrIcon(image.path);
    }
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: qrColor.value,
              onColorChanged: (color) {
                setQrColor(color);
                selectColor.text = color.value.toRadixString(16).padLeft(6, '0').toUpperCase();
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Seleccionar'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
