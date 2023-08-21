import 'package:equatable/equatable.dart';

class UserStatEntity extends Equatable {
  final String? id;
  final String? fullname;

  final String? username;
  final num numberOfCommands;
  final num totalMoneyMade;
  final String? phonenumber;

  const UserStatEntity({
    this.id,
    this.fullname,
    this.username,
    this.phonenumber,
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
        phonenumber,
      ];
}
