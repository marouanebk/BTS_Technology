import 'package:bts_technologie/mainpage/domaine/Entities/livreur_entity.dart';

class LivreurModel extends Livreur {
  const LivreurModel({
    String? id,
    required String livreurName,
  }) : super(
          livreurName: livreurName,
          id: id,
        );

  factory LivreurModel.fromJson(Map<String, dynamic> json) {
    return LivreurModel(
      livreurName: json["name"],
      id: json["_id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": livreurName,
    };
  }
}
