// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FinanceEntity extends Equatable {
  final String? id;
  final String label;
  final num money;
  final String? date;

  const FinanceEntity({
    this.id,
    required this.money,
    required this.label,
    this.date,
  });

  @override
  List<Object?> get props => [id, label, money, date];
}
