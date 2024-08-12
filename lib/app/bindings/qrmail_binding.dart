import 'package:app_yanapay_qr/app/controllers/qrmail_controller.dart';
import 'package:get/get.dart';

class QRMailBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<QRMailController>(() => QRMailController());
  }
}