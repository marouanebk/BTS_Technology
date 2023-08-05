import 'package:bts_technologie/logistiques/domaine/entities/article_entity.dart';

class ArticleModel extends Article {
  const ArticleModel({
    String? name,
    String? unity,
    required num buyingPrice,
    required num grosPrice,
    required int alertQuantity,
  }) : super(name: name, unity: unity, buyingPrice: buyingPrice, grosPrice: grosPrice, alertQuantity :alertQuantity);

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      name: json["name"],
      unity: json["Unity"],
      buyingPrice: json["buyingPrice"],
      grosPrice: json["grosPrice"],
      alertQuantity : json["alertQuantity"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "buyingPrice": buyingPrice,
      "grosPrice": grosPrice,
      "alertQuantity" : alertQuantity,
    };
  }
}
