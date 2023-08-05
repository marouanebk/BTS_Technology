import 'dart:developer';

import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';

class ArticleModel extends Article {
  const ArticleModel({
    String? name,
    String? unity,
    List<Variant?> variants = const [],
    required num buyingPrice,
    required num grosPrice,
    required int alertQuantity,
  }) : super(
            name: name,
            unity: unity,
            buyingPrice: buyingPrice,
            grosPrice: grosPrice,
            alertQuantity: alertQuantity,
            variants: variants);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    var variantList = json['variants'] as List<dynamic>?;

    List<Variant> variants = [];
    if (variantList != null) {
      variants = variantList.map((variantJson) {
        return Variant(
          colour: variantJson['colour'],
          colourCode: variantJson['colourCode'],
          taille: variantJson['taille'],
          quantity: variantJson['quantity'],
          family: variantJson['family'],
        );
      }).toList();
    }

    return ArticleModel(
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
    if (variants != null) {
      log(variants.toString());
      variantList = variants!.map((variant) {
        return {
          'colour': variant!.colour,
          'colourCode': variant.colourCode,
          'taille': variant.taille,
          'quantity': variant.quantity,
          'family': variant.family,
        };
      }).toList();
    }

    return {
      "name": name,
      "Unity": unity,
      "buyingPrice": buyingPrice,
      "grosPrice": grosPrice,
      "alertQuantity": alertQuantity,
      "variants": variantList,
    };
  }
}
