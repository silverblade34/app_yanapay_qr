import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:url_launcher/url_launcher.dart';

class QrScanController extends GetxController {
  RxBool qrDetected = false.obs;
  RxString qrContent = ''.obs;
  String previousQrContent = '';

  onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        if (previousQrContent != scanData.code) {
          qrDetected.value = true;
          qrContent.value = scanData.code!;
          previousQrContent = scanData.code!;
          vibrateDevice();

          // Detectar si es un enlace mailto
          if (qrContent.value.startsWith("mailto:")) {
            _openEmailClient(qrContent.value);
          }
          // Detectar si es un enlace http o https
          else if (qrContent.value.startsWith("http") ||
              qrContent.value.startsWith("https")) {
            _openUrl(qrContent.value);
          }
        }
      }
    });
  }

  void vibrateDevice() async {
    bool? canVibrate = await Vibration.hasVibrator();
    if (canVibrate ?? false) {
      Vibration.vibrate();
    }
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: qrContent.value));
  }

  // Función para abrir URLs http o https
  void _openUrl(String urlString) async {
    Uri url = Uri.parse(urlString);
    launchUrl(url);
  }

  // Función para abrir el cliente de correo
  void _openEmailClient(String mailtoUrl) async {
    Uri url = Uri.parse(mailtoUrl);
    launchUrl(url);
  }
}
