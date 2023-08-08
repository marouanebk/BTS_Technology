import 'package:bts_technologie/finances/domaine/entities/finance_entity.dart';

class FinanceModel extends FinanceEntity {
  const FinanceModel({
    String? date,
    String? id,
    required String label,
    required num money,
  }) : super(
          date: date,
          id: id,
          label: label,
          money: money,
        );

  static List<FinanceModel> fromJsonList(Map<String, dynamic> json) {
    final dateKeys = json.keys.toList();

    final List<FinanceModel> financeModels = [];

    for (var dateKey in dateKeys) {
      final dateData = json[dateKey];

      dateData.forEach((data) {
        final financeModel = FinanceModel(
          date: dateKey,
          id: data["_id"],
          label: data["label"],
          money: data["money"],
        );

        // Add the CommandModel instance to the list
        financeModels.add(financeModel);
      });
    }

    return financeModels;
  }

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
