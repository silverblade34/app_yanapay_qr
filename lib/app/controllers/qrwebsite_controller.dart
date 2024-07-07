import 'package:get/get.dart';

class QrWebsiteController extends GetxController {
  var url = ''.obs;
  var qrData = ''.obs;

  void setUrl(String value) {
    url.value = value;
  }

  bool _isValidURL(String url) {
    const urlPattern = r'^(https?:\/\/)?([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$';
    final result = RegExp(urlPattern).hasMatch(url);
    return result;
  }

  void generateQr() {
    if (_isValidURL(url.value)) {
      qrData.value = url.value;
    } else {
      Get.snackbar("Error", "Por favor, ingrese un enlace válido.");
    }
  }
}
