import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? fullname;
  final String username;
  final String password;
  final String? role;

  const User({
    this.id,
    this.fullname,
    this.role,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [id, fullname, username, password , role];
}
