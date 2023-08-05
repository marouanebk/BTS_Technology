// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Livreur extends Equatable {
  final String livreurName;

  const Livreur({
    required this.livreurName,
  });

  @override
  List<Object?> get props => [livreurName];
}
