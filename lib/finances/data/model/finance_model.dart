
import 'package:bts_technologie/finances/domaine/entities/finance_entity.dart';
class FinanceModel extends FinanceEntity {
  const FinanceModel({
    String? id,
    required String label,
    required num money,
  }) : super(
          id: id,
          label: label,
          money: money,
        );

  factory FinanceModel.fromJson(Map<String, dynamic> json) {
    return FinanceModel(
      id: json['_id'],
      label: json["label"],
      money: json["money"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "money": money,
    };
  }
}
