import 'package:app_yanapay_qr/app/ui/utils/style_utils.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Row RowSelected(
    {required TextEditingController controller,
    required Widget childInput,
    required String placeholder}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: TextField(
          enabled: false,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            hintText: placeholder,
          ),
        ),
      ),
      Container(
          padding: const EdgeInsets.all(6),
          width: 60,
          height: 56.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            border: Border(
              top: BorderSide(width: 1.3, color: TEXT_LIGHT),
              right: BorderSide(width: 1.3, color: TEXT_LIGHT),
              bottom: BorderSide(width: 1.3, color: TEXT_LIGHT),
              left: BorderSide.none,
            ),
          ),
          child: childInput)
    ],
  );
}
