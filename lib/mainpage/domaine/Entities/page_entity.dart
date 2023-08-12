// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FacePage extends Equatable {
  final String? id;
  final String pageName;
  final int? numberOfCommands;
  final num? totalMoneyMade;

  const FacePage({
    this.id,
    required this.pageName,
    this.numberOfCommands,
    this.totalMoneyMade,
  });

  @override
  List<Object?> get props => [pageName , numberOfCommands , totalMoneyMade];
}
