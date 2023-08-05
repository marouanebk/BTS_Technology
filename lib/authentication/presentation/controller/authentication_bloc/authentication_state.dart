import 'package:equatable/equatable.dart';
import 'package:bts_technologie/authentication/data/models/user_model.dart';

abstract class UserBlocState extends Equatable {
  const UserBlocState();

  @override
  List<Object> get props => [];
}

class UserBlocStateInitial extends UserBlocState {}

class LoadingUserBlocState extends UserBlocState {}

class ErrorUserBlocState extends UserBlocState {
  final String message;

  const ErrorUserBlocState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageUserBlocState extends UserBlocState {
  final String message;

  const MessageUserBlocState({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedState extends UserBlocState {}

class UnAuthenticatedState extends UserBlocState {}

class SignOuState extends UserBlocState {}

class UserDetailsState extends UserBlocState {
  final String fullname;
  final String email;

  const UserDetailsState({required this.fullname, required this.email});
  @override
  List<Object> get props => [fullname, email];
}

class AdministratorLoginState extends UserBlocState {}
class PageAdminLoginState extends UserBlocState {}
class FinancesLoginState extends UserBlocState {}
class LogistiquesLoginState extends UserBlocState {}

class StudentLoginState extends UserBlocState {}

class BioSuccessState extends UserBlocState {}

class UserDetailState extends UserBlocState {
  final UserModel usermodel;

  const UserDetailState({required this.usermodel});
  @override
  List<Object> get props => [usermodel];
}
