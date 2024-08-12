import 'package:app_yanapay_qr/app/controllers/qrwebsite_controller.dart';
import 'package:app_yanapay_qr/app/ui/pages/qrwebsite/widgets/row_selected.dart';
import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
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
                    const Text("Escribe tu URL Aquí",
                        style: TextStyle(fontSize: H3)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller.linkUrl,
                      decoration:
                          const InputDecoration(hintText: 'Ingrese el link'),
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
                    const Text("O seleccione un logo: "),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Image.asset(
                            'assets/images/facebook.png',
                            width: 38,
                            height: 38,
                          ),
                          onTap: () {
                            controller
                                .setQrIconAsset('assets/images/facebook.png');
                          },
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          child: Image.asset(
                            'assets/images/instagram.jpg',
                            width: 38,
                            height: 38,
                          ),
                          onTap: () {
                            controller
                                .setQrIconAsset('assets/images/instagram.jpg');
                          },
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          child: Image.asset(
                            'assets/images/linkedin.png',
                            width: 38,
                            height: 38,
                          ),
                          onTap: () {
                            controller
                                .setQrIconAsset('assets/images/linkedin.png');
                          },
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          child: Image.asset(
                            'assets/images/tiktok.png',
                            width: 38,
                            height: 38,
                          ),
                          onTap: () {
                            controller
                                .setQrIconAsset('assets/images/tiktok.png');
                          },
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          child: Image.asset(
                            'assets/images/youtube.png',
                            width: 38,
                            height: 38,
                          ),
                          onTap: () {
                            controller
                                .setQrIconAsset('assets/images/youtube.png');
                          },
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          child: Image.asset(
                            'assets/images/google.png',
                            width: 38,
                            height: 38,
                          ),
                          onTap: () {
                            controller
                                .setQrIconAsset('assets/images/google.png');
                          },
                        ),
                      ],
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
