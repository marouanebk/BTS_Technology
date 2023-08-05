// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String? name;
  final String? unity;
  final num buyingPrice;
  final num grosPrice;
  final int alertQuantity;

  const Article({
    this.name,
    this.unity,
    required this.buyingPrice,
    required this.grosPrice,
    required this.alertQuantity,
  });

  @override
  List<Object?> get props =>
      [name, unity, buyingPrice, grosPrice, alertQuantity];
}
