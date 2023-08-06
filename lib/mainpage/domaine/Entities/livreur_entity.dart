// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Livreur extends Equatable {
  final String? id;
  final String livreurName;

  const Livreur({
    this.id,
    required this.livreurName,
  });

  @override
  List<Object?> get props => [livreurName];
}
