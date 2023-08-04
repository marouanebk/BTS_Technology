import 'package:bts_technologie/authentification/data/Models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;

  const ErrorAuthState({required this.message});
  @override
  List<Object> get props => [message];
}

class AdminLoginState extends AuthState {}

class AdminPageLoginState extends AuthState {}

class FinancesLoginState extends AuthState {}

class LogistiquesLoginState extends AuthState {}





//////////



class MessageAuthState extends AuthState {
  final String message;

  const MessageAuthState({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedState extends AuthState {}

class UnAuthenticatedState extends AuthState {}

class SignOuState extends AuthState {}

class UserDetailsState extends AuthState {
  final String fullname;
  final String email;

  const UserDetailsState({required this.fullname, required this.email});
  @override
  List<Object> get props => [fullname, email];
}

class TeacherLoginState extends AuthState {}

class StudentLoginState extends AuthState {}

class BioSuccessState extends AuthState {}

class UserDetailState extends AuthState {
  final UserModel usermodel;

  const UserDetailState({required this.usermodel});
  @override
  List<Object> get props => [usermodel];
}
