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
          // Detectar si es un enlace para agregar a calendario
          else if (qrContent.value.startsWith("googlecalendar")) {
            _openCalendar(qrContent.value);
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

  // Función para abrir la interfaz de calendario
  void _openCalendar(String calendarUrl) async {
    try {
      Uri url = Uri.parse(calendarUrl);
      launchUrl(url);
    } catch (e) {
      print("---------------------------------------ERROR-----------------------------");
      print(e.toString());
    }
  }
}
