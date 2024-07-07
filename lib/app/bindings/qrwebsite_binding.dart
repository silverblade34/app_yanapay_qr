import 'package:app_yanapay_qr/app/controllers/qrwebsite_controller.dart';
import 'package:get/get.dart';

class QrWebsiteBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<QrWebsiteController>(() => QrWebsiteController());
  }
}