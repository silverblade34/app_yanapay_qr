import 'package:app_yanapay_qr/app/models/type_qr.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  RxList<TypeQr> dataTypeQr = RxList([
    TypeQr(
      image: "assets/images/website.png",
      name: "Sitio web",
      to: "/qrwebsite",
    ),
    TypeQr(
      image: "assets/images/correo.png",
      name: "Correo",
      to: "/emailqr",
    ),
    TypeQr(
      image: "assets/images/texto.png",
      name: "Texto",
      to: "/textoqr",
    ),
    TypeQr(
      image: "assets/images/llamada.png",
      name: "Llamada",
      to: "/llamadaqr",
    ),
    TypeQr(
      image: "assets/images/sms.png",
      name: "SMS",
      to: "/smsqr",
    ),
    TypeQr(
      image: "assets/images/vcard.png",
      name: "V-Card",
      to: "/vcard",
    ),
    TypeQr(
      image: "assets/images/geolocalizacion.png",
      name: "Geolocalización",
      to: "/geolocalizacion",
    ),
    TypeQr(
      image: "assets/images/wifi.png",
      name: "Wi-Fi",
      to: "/wifi",
    ),
  ]);
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    box.write("statusInitial", true);
  }
}
