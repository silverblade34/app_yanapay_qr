import 'package:app_yanapay_qr/app/controllers/splash_controller.dart';
import 'package:app_yanapay_qr/app/ui/pages/home/home_page.dart';
import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionSlider(
      items: [
        IntroductionSliderItem(
          logo: Image.asset(
            'assets/images/icono-llama-qr.png',
            width: 300,
            height: 300,
          ),
          title: const Text(
            "QR Yanapa",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: PRIMARY),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Lee y genera codigos QR",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(255, 80, 80, 80)),
            ),
          ),
          backgroundColor: BACK_LIGHT,
        ),
        IntroductionSliderItem(
          logo: Image.asset(
            'assets/images/icono-splash-qr.png',
            width: 350,
            height: 350,
          ),
          title: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Rapido y personalizable",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Poppins',
                color: PRIMARY,
              ),
            ),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Genera codigos QR personalizables",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          backgroundColor: BACK_LIGHT_INDIGO,
        ),
      ],
      done: Done(
        animationDuration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.check),
        ),
        home: const HomePage(),
      ),
      next: const Next(
        child: Icon(Icons.arrow_forward),
        animationDuration: Duration(milliseconds: 500),
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(PRIMARY),
        ),
      ),
      back: const Back(
        child: Icon(Icons.arrow_back),
        animationDuration: Duration(milliseconds: 500),
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(PRIMARY),
        ),
      ),
      dotIndicator: const DotIndicator(selectedColor: PRIMARY),
    );
  }
}
