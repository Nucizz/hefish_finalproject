import 'package:flutter/cupertino.dart';
import 'package:hefish_finalproject/class/fish_type.dart';

class Fishes {
  int id;
  int authorId;
  String authorName = "Unknown";
  int typeId;
  String typeName = "Undifined";

  String name = "NULL";
  String price = "Rp0,00";
  String imagePath;
  String description;

  Fishes(
      {required this.id,
      required this.authorId,
      required this.authorName,
      required this.typeId,
      required this.typeName,
      required this.name,
      required this.price,
      required this.imagePath,
      required this.description});

  factory Fishes.fromJson(Map<String, dynamic> json) {
    return Fishes(
      id: json['fish_id'] as int,
      authorId: json['user_id'] as int,
      authorName: json['username'].toString(),
      typeId: json['fish_type_id'] as int,
      typeName: json['name'].toString(),
      name: json['fish_name'].toString(),
      price: "Rp${json['price']}",
      imagePath: json['image_path'].toString(),
      description: json['description'].toString(),
    );
  }
}
