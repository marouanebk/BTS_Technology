// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String? name;
  final String? unity;
  final num buyingPrice;
  final num grosPrice;
  final int alertQuantity;
  final List<Variant?> variants;

  const Article({
    this.name,
    this.unity,
    required this.variants,
    required this.buyingPrice,
    required this.grosPrice,
    required this.alertQuantity,
  });

  @override
  List<Object?> get props =>
      [name, unity, buyingPrice, grosPrice, alertQuantity , variants];
}

class Variant extends Equatable {
  final String colour;
  final String colourCode;
  final String taille;
  final int quantity;
  final String family;

  const Variant({
    required this.colour,
    required this.colourCode,
    required this.taille,
    required this.quantity,
    required this.family,
  });
  @override
  List<Object?> get props => [colour, colourCode, taille, quantity, family];
}
