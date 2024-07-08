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
              const SizedBox(height: 20),
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
                          embeddedImage: controller.qrIcon.isNotEmpty
                              ? AssetImage(controller.qrIcon.value)
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
              const SizedBox(height: 10),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.selectColor,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              hintText: "#FFFFFF",
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: 60,
                          height: 56.5,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            border: Border(
                              top: BorderSide(width: 1.3, color: GREY_HARD),
                              right: BorderSide(width: 1.3, color: GREY_HARD),
                              bottom: BorderSide(width: 1.3, color: GREY_HARD),
                              left: BorderSide.none,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.pickColor(context);
                            },
                            child: Obx(
                              () => Container(
                                decoration: BoxDecoration(
                                    color: controller.qrColor.value),
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text("Seleccione un icono: "),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                              ),
                              hintText: "Selecciona una imagen",
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          width: 60,
                          height: 56.5,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            border: Border(
                              top: BorderSide(width: 1.3, color: GREY_HARD),
                              right: BorderSide(width: 1.3, color: GREY_HARD),
                              bottom: BorderSide(width: 1.3, color: GREY_HARD),
                              left: BorderSide.none,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.pickIcon();
                            },
                            child: Image.asset(
                              "assets/images/icon-image.png",
                              width: 20,
                            ),
                          ),
                        )
                      ],
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
