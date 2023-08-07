// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String? id;
  final String? name;
  final String? unity;
  final num buyingPrice;
  final num grosPrice;
  final int alertQuantity;
  final List<Variant?> variants;

  const Article({
    this.id,
    this.name,
    this.unity,
    required this.variants,
    required this.buyingPrice,
    required this.grosPrice,
    required this.alertQuantity,
  });

  @override
  List<Object?> get props =>
      [id, name, unity, buyingPrice, grosPrice, alertQuantity, variants];
}

class Variant extends Equatable {
  final String? id;
  final String colour;
  final String colourCode;
  final String taille;
  final int quantity;
  final String family;

  const Variant({
    this.id,
    required this.colour,
    required this.colourCode,
    required this.taille,
    required this.quantity,
    required this.family,
  });
  @override
  List<Object?> get props => [id, colour, colourCode, taille, quantity, family];
}
