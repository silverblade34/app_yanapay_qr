import 'dart:io';

import 'package:app_yanapay_qr/app/controllers/qrwebsite_controller.dart';
import 'package:app_yanapay_qr/app/ui/pages/qrwebsite/widgets/row_selected.dart';
import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';

class QrWebsitePage extends GetView<QrWebsiteController> {
  const QrWebsitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Sitio web',
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
                      return Center(
                        child: QrImageView(
                          data: controller.qrData.value,
                          version: QrVersions.auto,
                          size: 200.0,
                          // ignore: deprecated_member_use
                          foregroundColor: controller.qrColor.value,
                          gapless: false,
                          errorCorrectionLevel: QrErrorCorrectLevel.H,
                          embeddedImage: controller.qrIcon.isNotEmpty
                              ? Image.file(
                                  File(controller.qrIcon.value),
                                ).image
                              : null,
                          embeddedImageStyle: const QrEmbeddedImageStyle(
                            size: Size(40, 40),
                          ),
                        ),
                      );
                    } else {
                      return Image.asset(
                        "assets/images/qr-example.png",
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
                    const Text("Escribe tu URL Aquí",
                        style: TextStyle(fontSize: H3)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller.linkUrl,
                      decoration:
                          const InputDecoration(hintText: 'Ingrese el link'),
                    ),
                    const SizedBox(height: 30),
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
                    const Text("Seleccione un icono: "),
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
                            onPressed: () {},
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
