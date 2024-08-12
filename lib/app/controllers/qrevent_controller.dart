import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
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
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class QrEventController extends GetxController {
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController selectColor = TextEditingController();
  TextEditingController selectImage = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  var qrData = ''.obs;
  var qrColor = Colors.black.obs;
  var qrIcon = ''.obs;
  var qrIconImage = Rx<ui.Image?>(null);
  var qrIconImageProvider = Rx<ImageProvider<Object>?>(null);

  void generateQr() {
    if (dateStart.text.isNotEmpty &&
        dateEnd.text.isNotEmpty &&
        description.text.isNotEmpty) {
      DateFormat inputFormat = DateFormat('dd/MM/yyyy HH:mm');
      DateTime startDate = inputFormat.parse(dateStart.text);
      DateTime endDate = inputFormat.parse(dateEnd.text);
      String calendarUrl =
          generateCalendarUrl(description.text, startDate, endDate);

      qrData.value = calendarUrl;
    } else {
      EasyLoading.showInfo("Por favor, rellene los campos.");
    }
  }

  String generateCalendarUrl(
      String title, DateTime startDate, DateTime endDate) {
    final encodedTitle = Uri.encodeComponent(title);
    final encodedDetails = Uri.encodeComponent("Detalles del evento aquí");

    // Restar 5 horas a la hora UTC para ajustar a la zona horaria de Lima
    DateTime startDateInLima = startDate.subtract(const Duration(hours: 5));
    DateTime endDateInLima = endDate.subtract(const Duration(hours: 5));

    final formattedStart =
        DateFormat('yyyyMMddTHHmmss').format(startDateInLima.toUtc());
    final formattedEnd =
        DateFormat('yyyyMMddTHHmmss').format(endDateInLima.toUtc());

    // Especifica la zona horaria 'America/Lima'
    const timeZone = 'America/Lima';

    return 'https://calendar.google.com/calendar/u/0/r/eventedit'
        '?dates=$formattedStart/$formattedEnd'
        '&ctz=$timeZone'
        '&text=$encodedTitle'
        '&details=$encodedDetails';
  }

  showDateTimePicker(BuildContext context,
      {required String initialDateTimeStr}) async {
    DateTime currentUtcDateTime = DateTime.now().toUtc();

    DateTime initialDateTime;
    initialDateTime = currentUtcDateTime.subtract(const Duration(hours: 5));
    if (initialDateTimeStr.isNotEmpty) {
      List<String> dateTimeParts = initialDateTimeStr.split(' ');
      if (dateTimeParts.length == 2) {
        List<String> dateParts = dateTimeParts[0].split('/');
        List<String> timeParts = dateTimeParts[1].split(':');
        if (dateParts.length == 3 && timeParts.length == 2) {
          int year = int.parse(dateParts[2]);
          int month = int.parse(dateParts[1]);
          int day = int.parse(dateParts[0]);
          int hour = int.parse(timeParts[0]);
          int minute = int.parse(timeParts[1]);
          initialDateTime = DateTime(year, month, day, hour, minute);
        }
      }
    }

    final result = await showBoardDateTimePicker(
      context: context,
      pickerType: DateTimePickerType.datetime,
      initialDate: initialDateTime,
      options: const BoardDateTimeOptions(
        languages: BoardPickerLanguages(today: "Hoy", tomorrow: "Mañana"),
        startDayOfWeek: DateTime.sunday,
        pickerFormat: PickerFormat.ymd,
        activeColor: PRIMARY,
      ),
    );
    return result;
  }

  void setQrColor(Color color) {
    qrColor.value = color;
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
    if (qrData.value != "") {
      EasyLoading.show(status: "Procesando...");
      final Uint8List? image = await screenshotController.capture(
        delay: const Duration(milliseconds: 10),
        pixelRatio: 3.0,
      );

      if (image != null) {
        final directory = await getTemporaryDirectory();
        final String timestamp =
            DateTime.now().millisecondsSinceEpoch.toString();
        final imagePath = '${directory.path}/qr_code_$timestamp.png';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(image);
        EasyLoading.dismiss();
        await GallerySaver.saveImage(imageFile.path, albumName: "MyQRCode");
        Get.snackbar("Éxito", "La imagen del QR se ha guardado en la galería");
      }
    } else {
      EasyLoading.showInfo("Aún no ha generado un código QR");
    }
  }

  void setQrIcon(String path) {
    qrIcon.value = path;
    _loadImageProvider(path).then((imageProvider) {
      qrIconImageProvider.value = imageProvider;
    });
  }

  Future<bool> _pedirPermisoGaleria() async {
    final Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.photos,
    ].request();

    return statuses[Permission.storage] == PermissionStatus.granted ||
        statuses[Permission.photos] == PermissionStatus.granted;
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

  Future<void> shareQrImage() async {
    if (qrData.value != "") {
      EasyLoading.show(status: "Procesando...");

      final Uint8List? image = await screenshotController.capture(
        delay: const Duration(milliseconds: 10),
        pixelRatio: 3.0,
      );

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final imagePath = 'qr_code_$timestamp.png';
      EasyLoading.dismiss();

      if (image != null) {
        await Share.file('QR Code', imagePath, image, 'image/png');
      }
    } else {
      EasyLoading.showInfo("Aún no ha generado un código QR");
    }
  }
}
