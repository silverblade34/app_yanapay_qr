import 'package:app_yanapay_qr/app/controllers/qrevent_controller.dart';
import 'package:app_yanapay_qr/app/ui/pages/qrwebsite/widgets/row_selected.dart';
import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class QrEventPage extends GetView<QrEventController> {
  const QrEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Evento',
          style: TextStyle(fontSize: 19, color: Colors.white),
        ),
        backgroundColor: PRIMARY,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    if (controller.qrData.isNotEmpty) {
                      return Screenshot(
                        controller: controller.screenshotController,
                        child: Container(
                          width: 220,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: PrettyQrView(
                            qrImage: QrImage(
                              QrCode.fromData(
                                data: controller.qrData.value,
                                errorCorrectLevel: QrErrorCorrectLevel.H,
                              ),
                            ),
                            decoration: PrettyQrDecoration(
                              background: Colors.white,
                              shape: PrettyQrSmoothSymbol(
                                color: controller.qrColor.value,
                              ),
                              image: controller.qrIconImageProvider.value !=
                                      null
                                  ? PrettyQrDecorationImage(
                                      scale: 0.13,
                                      image:
                                          controller.qrIconImageProvider.value!,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Image.asset(
                        "assets/images/qr-example.jpeg",
                        width: 220,
                      );
                    }
                  }),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Inicio evento: ",
                      style: TextStyle(
                        fontSize: H3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.dateStart,
                            decoration: const InputDecoration(
                              hintText: 'dd/mm/aaaa HH:mm',
                              icon: Icon(Icons.date_range),
                              border: UnderlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                            ),
                            onTap: () async {
                              DateTime? dateSelected = await controller
                                  .showDateTimePicker(Get.context!,
                                      initialDateTimeStr:
                                          controller.dateStart.text);
                              if (dateSelected != null) {
                                String formattedTime =
                                    dateFormat.format(dateSelected);
                                controller.dateStart.text = formattedTime;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Fin evento: ",
                      style: TextStyle(
                        fontSize: H3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.dateEnd,
                            decoration: const InputDecoration(
                              hintText: 'dd/mm/aaaa HH:mm',
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.date_range),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                            ),
                            onTap: () async {
                              DateTime? dateSelected = await controller
                                  .showDateTimePicker(Get.context!,
                                      initialDateTimeStr:
                                          controller.dateEnd.text);
                              if (dateSelected != null) {
                                String formattedTime =
                                    dateFormat.format(dateSelected);
                                controller.dateEnd.text = formattedTime;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Descripción del evento",
                      style: TextStyle(fontSize: H3),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller.description,
                      decoration: const InputDecoration(
                          hintText: 'Ingrese la descripción del evento'),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.generateQr();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: SECONDARY,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text("Generar QR",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 5),
                        Text("Opciones", style: TextStyle(fontSize: H3)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text("Seleccione un color: "),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        controller.pickColor(context);
                      },
                      child: Obx(
                        () => RowSelected(
                          controller: controller.selectColor,
                          childInput: Container(
                            decoration:
                                BoxDecoration(color: controller.qrColor.value),
                            width: 40,
                            height: 40,
                          ),
                          placeholder: "#FFFFFF",
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text("Suba un logo: "),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () async {
                        await controller.pickIcon(context);
                      },
                      child: RowSelected(
                        controller: controller.selectImage,
                        childInput: Image.asset(
                          "assets/images/icon-image.png",
                          width: 20,
                        ),
                        placeholder: "Selecciona una imagen",
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.saveQrImage();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              backgroundColor: PRIMARY,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text("Descargar",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.shareQrImage();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              backgroundColor: BACK_LIGHT_INDIGO,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Icon(
                              Icons.share,
                              color: PRIMARY,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
