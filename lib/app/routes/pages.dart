import 'package:app_yanapay_qr/app/ui/pages/home/home_page.dart';
import 'package:app_yanapay_qr/app/ui/pages/splash/splash_page.dart';
import 'package:get/get.dart';
part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
    ),
      GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
    )
  ];
}
