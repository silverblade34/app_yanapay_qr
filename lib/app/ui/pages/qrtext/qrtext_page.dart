import 'package:app_yanapay_qr/app/controllers/qrtext_controller.dart';
import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QrTextPage extends GetView<QrTextController> {
  const QrTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Generar QR')),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: controller.textController,
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
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text("Generar QR",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(() => PrettyQrView(
                      qrImage: QrImage(QrCode.fromData(
                        data: controller.qrValue.value,
                        errorCorrectLevel: QrErrorCorrectLevel.H,
                      )),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
