import 'package:app_yanapay_qr/app/routes/pages.dart';
import 'package:app_yanapay_qr/app/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      theme: appThemeData,
      getPages: AppPages.pages,
      builder: (context, widget) {
        widget = EasyLoading.init()(context, widget);
        return widget;
      },
    ),
  );
}
