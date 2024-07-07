import 'package:app_yanapay_qr/app/bindings/home_binding.dart';
import 'package:app_yanapay_qr/app/bindings/qrwebsite_binding.dart';
import 'package:app_yanapay_qr/app/middlewares/global_middleware.dart';
import 'package:app_yanapay_qr/app/ui/pages/home/home_page.dart';
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
    )
  ];
}
