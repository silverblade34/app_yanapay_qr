import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QrWebsiteController extends GetxController {
  TextEditingController linkUrl = TextEditingController();
  TextEditingController selectColor = TextEditingController();
  TextEditingController selectImage = TextEditingController();
  var qrData = ''.obs;
  var qrColor = Colors.black.obs;
  var qrIcon = ''.obs;
  var qrIconImage = Rx<ui.Image?>(null);

  void setQrColor(Color color) {
    qrColor.value = color;
  }

  void setQrIcon(String path) {
    qrIcon.value = path;
    _loadImage(path).then((image) {
      qrIconImage.value = image;
    });
  }

  Future<ui.Image> _loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
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

  Future<void> pickIcon(BuildContext context) async {
    EasyLoading.show(status: "Cargando...");
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      final img.Image? decodedImage = img.decodeImage(bytes);
      EasyLoading.dismiss();
      if (decodedImage != null &&
          decodedImage.width <= 700 &&
          decodedImage.height <= 700) {
        selectImage.text = image.name;
        setQrIcon(image.path);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Por favor, seleccione una imagen más pequeña (máximo 700x700).'),
          ),
        );
      }
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
                selectColor.text =
                    color.value.toRadixString(16).padLeft(6, '0').toUpperCase();
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
        );
      },
    );
  }

  Future<void> saveQrImage() async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: qrData.value,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.H,
      );
      if (qrValidationResult.status == QrValidationStatus.valid) {
        final painter = QrPainter(
          data: qrData.value,
          version: QrVersions.auto,
          errorCorrectionLevel: QrErrorCorrectLevel.H,
          // ignore: deprecated_member_use
          color: qrColor.value,
          embeddedImage: qrIconImage.value,
          embeddedImageStyle: const QrEmbeddedImageStyle(
            size: Size(40, 40),
          ),
        );
        final tempDir = await getTemporaryDirectory();
        final qrFilePath = '${tempDir.path}/qr_code.png';
        final qrFile = File(qrFilePath);
        final picData = await painter.toImageData(200);
        await qrFile.writeAsBytes(picData!.buffer.asUint8List());
        Get.snackbar('Success', 'QR code saved to $qrFilePath');
      } else {
        Get.snackbar('Error', 'Failed to generate QR code');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> shareQrImage() async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: qrData.value,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.H,
      );
      if (qrValidationResult.status == QrValidationStatus.valid) {
        final painter = QrPainter(
          data: qrData.value,
          version: QrVersions.auto,
          errorCorrectionLevel: QrErrorCorrectLevel.H,
          // ignore: deprecated_member_use
          color: qrColor.value,
          embeddedImage: qrIconImage.value,
          embeddedImageStyle: const QrEmbeddedImageStyle(
            size: Size(40, 40),
          ),
        );
        final tempDir = await getTemporaryDirectory();
        final qrFilePath = '${tempDir.path}/qr_code.png';
        final qrFile = File(qrFilePath);
        final picData = await painter.toImageData(200);
        await qrFile.writeAsBytes(picData!.buffer.asUint8List());
        final xFile = XFile(qrFilePath);
        Share.shareXFiles([xFile], text: 'My QR code');
      } else {
        Get.snackbar('Error', 'Failed to generate QR code');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
