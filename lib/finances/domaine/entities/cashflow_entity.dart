// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CashFlow extends Equatable {
  final String? id;
  final num day;
  final num month;
  final num year;

  const CashFlow({
    this.id,
    required this.day,
    required this.month,
    required this.year,
  });

  @override
  List<Object?> get props => [id, day, month, year];
}
