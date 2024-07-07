import 'package:app_yanapay_qr/app/controllers/qrwebsite_controller.dart';
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
              const SizedBox(
                height: 30,
              ),
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
                        ),
                      );
                    } else {
                      return Image.asset(
                        "assets/images/qr-example.png",
                        width: 250,
                      );
                    }
                  }),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Escribe tu URL Aquí",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Ingrese el link',
                      ),
                      onChanged: (value) {
                        controller.setUrl(value);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
                            borderRadius: BorderRadius.circular(
                                8.0), // Cambia el valor de 8.0 por el radio deseado
                          ),
                        ),
                        child: const Text(
                          "Generar QR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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
