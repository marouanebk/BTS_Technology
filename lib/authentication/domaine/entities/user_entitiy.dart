import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? fullname;
  final List<String?>? pages;

  final List<String?>? commandeTypes;
  final String username;
  final String? password;
  final String? role;

  const User({
    this.id,
    this.fullname,
    this.role,
    this.pages,
    this.commandeTypes,
    required this.username,
     this.password,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        username,
        password,
        role,
        pages,
        commandeTypes,
      ];
}
