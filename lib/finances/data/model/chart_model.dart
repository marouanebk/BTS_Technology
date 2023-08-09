import 'package:bts_technologie/finances/domaine/entities/chart_entity.dart';

class ChartBarModel extends ChartBarEntity {
  const ChartBarModel({
    required num date,

  }) : super(
          date: date,

        );


  factory ChartBarModel.fromJson(Map<String, dynamic> json) {
    return ChartBarModel(
      date: json["month"],


    );
  }
}
