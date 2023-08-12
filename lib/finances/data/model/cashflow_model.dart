import 'package:bts_technologie/finances/domaine/entities/cashflow_entity.dart';

class CashFlowModel extends CashFlow {
  const CashFlowModel({
    String? id,
    required num day,
    required num month,
    required num year,
  }) : super(
          id: id,
          day: day,
          month: month,
          year: year,
        );


  factory CashFlowModel.fromJson(Map<String, dynamic> json) {
    return CashFlowModel(
      id: json['_id'],
      month: json["month"],
      year: json["year"],
      day: json["day"],

    );
  }
}
