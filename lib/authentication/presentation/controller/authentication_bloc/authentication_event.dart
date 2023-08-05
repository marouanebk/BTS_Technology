import 'package:equatable/equatable.dart';
import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';

abstract class UserBlocEvent extends Equatable {
  const UserBlocEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends UserBlocEvent {
  final User user;

  const CreateUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class LogOutUserEvent extends UserBlocEvent {
  const LogOutUserEvent();

  @override
  List<Object> get props => [];
}


class LoginuserEvent extends UserBlocEvent {
  final User user;

  const LoginuserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class GetUserDetailsEvent extends UserBlocEvent {
  final String id;
  const GetUserDetailsEvent({required this.id});

  @override
  List<Object> get props => [id];
}
