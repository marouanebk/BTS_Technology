import 'package:equatable/equatable.dart';

class UserStatEntity extends Equatable {
  final String? id;
  final String? fullname;

  final String? username;
  final num numberOfCommands;
  final num totalMoneyMade;

  const UserStatEntity({
    this.id,
    this.fullname,
    this.username,
    required this.numberOfCommands,
    required this.totalMoneyMade,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        username,
        numberOfCommands,
        totalMoneyMade,
      ];
}
