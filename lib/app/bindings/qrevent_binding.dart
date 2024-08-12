import 'package:app_yanapay_qr/app/controllers/qrevent_controller.dart';
import 'package:get/get.dart';

class QrEventBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<QrEventController>(() => QrEventController());
  }
}