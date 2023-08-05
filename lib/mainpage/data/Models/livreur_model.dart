import 'package:bts_technologie/mainpage/domaine/Entities/livreur_entity.dart';

class LivreurModel extends Livreur {
  const LivreurModel({
    required String livreurName,
  }) : super(
          livreurName: livreurName,
        );

  factory LivreurModel.fromJson(Map<String, dynamic> json) {
    return LivreurModel(
      livreurName: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": livreurName,
    };
  }
}
