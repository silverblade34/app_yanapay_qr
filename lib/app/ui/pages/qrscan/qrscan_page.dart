import 'package:app_yanapay_qr/app/controllers/qrscan_controller.dart';
import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class QrScanPage extends GetView<QrScanController> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Yanapay QR',
          style: TextStyle(fontSize: 19, color: Colors.white),
        ),
        backgroundColor: PRIMARY,
        actions: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset(
              "assets/images/icono_llama_qr2.png",
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: controller.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: PRIMARY,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 290,
              ),
            ),
            Obx(() {
              if (controller.qrDetected.value) {
                return Positioned(
                  bottom: 100,
                  left: 10,
                  right: 10,
                  child: IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.qrContent.value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            maxLines: null,
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: controller.copyToClipboard,
                            child: const Icon(
                              Icons.copy,
                              color: GREY_HARD,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: SECONDARY,
        currentIndex: 1,
        onTap: (index) async {
          if (index == 0) {
            Get.offAllNamed("/home");
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: 'Generar QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
      ),
    );
  }
}
