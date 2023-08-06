// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Entreprise extends Equatable {
  final String? name;
  final num? numberRC;
  final int? numberIF;
  final int? numberART;
  final int? numberRIB;
  final String? adresse;
  final int? phoneNumber;

  const Entreprise({
    this.name,
    this.numberRC,
    this.numberIF,
    this.numberART,
    this.numberRIB,
    this.adresse,
    this.phoneNumber,
  });

  @override
  List<Object?> get props =>
      [name, numberRC, numberIF, numberART, numberRIB, adresse, phoneNumber];
}
