// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ChartBarEntity extends Equatable {
  final num date;

  const ChartBarEntity({
    required this.date,
  });

  @override
  List<Object?> get props => [
        date,
      ];
}
