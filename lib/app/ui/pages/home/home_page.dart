import 'package:app_yanapay_qr/app/controllers/home_controller.dart';
import 'package:app_yanapay_qr/app/models/type_qr.dart';
import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final HomeController homeCtrl = Get.put(HomeController());

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Generar codigo QR",
                  style: TextStyle(
                    color: PRIMARY,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Text(
                  "Seleccione su tipo de código QR",
                  style: TextStyle(color: GREY_HARD, fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: screenHeight - 180,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  decoration: const BoxDecoration(
                    color: BACK_INDIGO,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Obx(
                    () => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 3 / 2,
                      ),
                      itemCount: homeCtrl.dataTypeQr.length,
                      itemBuilder: (context, index) {
                        TypeQr item = homeCtrl.dataTypeQr[index];
                        return InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: BACK_LIGHT,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  item.image,
                                  width: 50,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                      color: GREY_LIGHT, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(item.to);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: SECONDARY,
        currentIndex: 0,
        onTap: (index) async {
          print(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: 'Generar QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'Escanear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
      ),
    );
  }
}
