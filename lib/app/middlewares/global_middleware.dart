import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalMiddleware extends GetMiddleware {
  final box = GetStorage();

  @override
  RouteSettings? redirect(String? route) {
    final authStatusInitial = box.read("statusInitial");
    if (authStatusInitial != null) {
      if (route == '/splash' && !authStatusInitial) {
        return null;
      } else if (route == '/splash' && authStatusInitial) {
        return const RouteSettings(name: '/home');
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
