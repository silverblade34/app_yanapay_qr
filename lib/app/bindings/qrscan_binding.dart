import 'package:app_yanapay_qr/app/controllers/qrscan_controller.dart';
import 'package:get/get.dart';

class QrScanBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<QrScanController>(() => QrScanController());
  }
}