// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FacePage extends Equatable {
  final String pageName;

  const FacePage({
    required this.pageName,
  });

  @override
  List<Object?> get props => [pageName];
}
