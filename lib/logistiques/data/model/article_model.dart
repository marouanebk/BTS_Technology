import 'dart:io';

import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';

class ArticleModel extends Article {
  const ArticleModel({
    String? id,
    String? name,
    String? unity,
    File? photo,
    List<Variant?> variants = const [],
    required num buyingPrice,
    required num grosPrice,
    required int alertQuantity,
  }) : super(
          id: id,
          name: name,
          unity: unity,
          photo: photo,
          buyingPrice: buyingPrice,
          grosPrice: grosPrice,
          alertQuantity: alertQuantity,
          variants: variants,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    var variantList = json['variants'] as List<dynamic>?;

    List<Variant> variants = [];
    if (variantList != null) {
      variants = variantList.map((variantJson) {
        return Variant(
          id: variantJson['_id'],
          colour: variantJson['colour'],
          colourCode: variantJson['colourCode'],
          taille: variantJson['taille'],
          quantity: variantJson['quantity'],
          family: variantJson['family'],
        );
      }).toList();
    }

    return ArticleModel(
      id: json['_id'],
      name: json["name"],
      unity: json["Unity"],
      buyingPrice: json["buyingPrice"],
      grosPrice: json["grosPrice"],
      alertQuantity: json["alertQuantity"],
      variants: variants,
    );
  }
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> variantList = [];
    variantList = variants.map((variant) {
      return {
        'colour': variant!.colour,
        'colourCode': variant.colourCode,
        'taille': variant.taille,
        'quantity': variant.quantity,
        'family': variant.family,
      };
    }).toList();

    return {
      // "photo": photo,
      "name": name,
      "Unity": unity,
      "buyingPrice": buyingPrice,
      "grosPrice": grosPrice,
      "alertQuantity": alertQuantity,
      "variants": variantList,
    };
  }
}
