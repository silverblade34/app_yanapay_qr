// To parse this JSON data, do
//
//     final typeQr = typeQrFromJson(jsonString);

import 'dart:convert';

TypeQr typeQrFromJson(String str) => TypeQr.fromJson(json.decode(str));

String typeQrToJson(TypeQr data) => json.encode(data.toJson());

class TypeQr {
    String image;
    String name;
    String to;

    TypeQr({
        required this.image,
        required this.name,
        required this.to,
    });

    factory TypeQr.fromJson(Map<String, dynamic> json) => TypeQr(
        image: json["image"],
        name: json["name"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "to": to,
    };
}
