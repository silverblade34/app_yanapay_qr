import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

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
        }
      }
    });
  }

  void vibrateDevice() async {
    bool? canVibrate = await Vibration.hasVibrator();
    if (canVibrate ?? false) {
      Vibration.vibrate(); // Vibrar el dispositivo
    }
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: qrContent.value));
  }
}
