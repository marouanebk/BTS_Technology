import 'package:bts_technologie/authentification/domaine/Entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthEvent {
  final User user;

  const CreateUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class LogOutUserEvent extends AuthEvent {
  const LogOutUserEvent();

  @override
  List<Object> get props => [];
}

class ChooseTypeEvent extends AuthEvent {
  final int number;
  const ChooseTypeEvent({required this.number});

  @override
  List<Object> get props => [number];
}

class LoginuserEvent extends AuthEvent {
  final User user;

  const LoginuserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class SetBiographyEvent extends AuthEvent {
  final String bio;
  const SetBiographyEvent({required this.bio});

  @override
  List<Object> get props => [bio];
}

class GetUserDetailsEvent extends AuthEvent {
  final String id;
  const GetUserDetailsEvent({required this.id});

  @override
  List<Object> get props => [id];
}
