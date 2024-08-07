import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class QrWebsiteController extends GetxController {
  TextEditingController linkUrl = TextEditingController();
  TextEditingController selectColor = TextEditingController();
  TextEditingController selectImage = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  var qrData = ''.obs;
  var qrColor = Colors.black.obs;
  var qrIcon = ''.obs;
  var qrIconImage = Rx<ui.Image?>(null);
  var qrIconImageProvider = Rx<ImageProvider<Object>?>(null);

  void setQrColor(Color color) {
    qrColor.value = color;
  }

  void setQrIcon(String path) {
    qrIcon.value = path;
    _loadImage(path).then((image) {
      qrIconImage.value = image;
    });

    _loadImageProvider(path).then((image) {
      qrIconImageProvider.value = image;
    });
  }

  Future<ui.Image> _loadImage(String path) async {
    final File imageFile = File(path);

    if (await imageFile.exists()) {
      final Uint8List bytes = await imageFile.readAsBytes();
      final Completer<ui.Image> completer = Completer();
      ui.decodeImageFromList(bytes, (ui.Image img) {
        completer.complete(img);
      });
      return completer.future;
    } else {
      throw Exception('Image file not found: $path');
    }
  }

  Future<ImageProvider<Object>?> _loadImageProvider(String path) async {
    if (path.isNotEmpty) {
      if (path.startsWith('http')) {
        return NetworkImage(path);
      } else {
        return FileImage(File(path));
      }
    }
    return null;
  }

  bool _isValidURL(String url) {
    const urlPattern = r'^(https?:\/\/)?([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$';
    final result = RegExp(urlPattern).hasMatch(url);
    return result;
  }

  Future<bool> _pedirPermisoGaleria() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.photos,
    ].request();

    return statuses[Permission.storage] == PermissionStatus.granted ||
        statuses[Permission.photos] == PermissionStatus.granted;
  }

  void generateQr() {
    if (_isValidURL(linkUrl.text)) {
      qrData.value = linkUrl.text;
    } else {
      Get.snackbar("Error", "Por favor, ingrese un enlace válido.");
    }
  }

  Future<void> pickIcon(BuildContext context) async {
    if (await _pedirPermisoGaleria()) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        EasyLoading.show(status: "Cargando...");
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
    } else {
      EasyLoading.dismiss();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe otorgar permisos para acceder a la galeria.'),
        ),
      );
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
    final Uint8List? image = await screenshotController.capture();
    if (image != null) {
      final directory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final imagePath = '${directory.path}/qr_code_$timestamp.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);
      await GallerySaver.saveImage(imageFile.path, albumName: "MyQRCode");
      Get.snackbar("Éxito", "La imagen del QR se ha guardado en la galería");
    }
  }

  Future<void> shareQrImage() async {
    final Uint8List? image = await screenshotController.capture();
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final imagePath = 'qr_code_$timestamp.png';
    if (image != null) {
      await Share.file('Indicadores', imagePath, image, 'image/png');
    }
  }
}
