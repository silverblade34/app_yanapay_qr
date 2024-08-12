import 'package:app_yanapay_qr/app/bindings/home_binding.dart';
import 'package:app_yanapay_qr/app/bindings/qrevent_binding.dart';
import 'package:app_yanapay_qr/app/bindings/qrmail_binding.dart';
import 'package:app_yanapay_qr/app/bindings/qrscan_binding.dart';
import 'package:app_yanapay_qr/app/bindings/qrtext_binding.dart';
import 'package:app_yanapay_qr/app/bindings/qrwebsite_binding.dart';
import 'package:app_yanapay_qr/app/middlewares/global_middleware.dart';
import 'package:app_yanapay_qr/app/ui/pages/home/home_page.dart';
import 'package:app_yanapay_qr/app/ui/pages/qrevent/qrevent_page.dart';
import 'package:app_yanapay_qr/app/ui/pages/qrmail/qrmail_page.dart';
import 'package:app_yanapay_qr/app/ui/pages/qrscan/qrscan_page.dart';
import 'package:app_yanapay_qr/app/ui/pages/qrtext/qrtext_page.dart';
import 'package:app_yanapay_qr/app/ui/pages/qrwebsite/qrwebsite_page.dart';
import 'package:app_yanapay_qr/app/ui/pages/splash/splash_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      transition: Transition.fadeIn,
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.QR_WEBSITE,
      page: () => const QrWebsitePage(),
      transition: Transition.fadeIn,
      binding: QrWebsiteBinding(),
    ),
    GetPage(
      name: Routes.QR_TEXT,
      page: () => const QrTextPage(),
      transition: Transition.fadeIn,
      binding: QrTextBinding(),
    ),
    GetPage(
      name: Routes.QR_SCAN,
      page: () => QrScanPage(),
      transition: Transition.fadeIn,
      binding: QrScanBinding(),
    ),
    GetPage(
      name: Routes.QR_MAIL,
      page: () => const QRMailPage(),
      transition: Transition.fadeIn,
      binding: QRMailBinding(),
    ),
    GetPage(
      name: Routes.QR_EVENT,
      page: () => const QrEventPage(),
      transition: Transition.fadeIn,
      binding: QrEventBinding(),
    )
  ];
}
