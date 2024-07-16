import 'package:app_yanapay_qr/app/controllers/qrtext_controller.dart';
import 'package:get/get.dart';

class QrTextBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<QrTextController>(() => QrTextController());
  }
}