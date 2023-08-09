import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAllAccountsEvent extends AccountEvent {}
class GetPagesEvent extends AccountEvent {}
class GetLivreursEvent extends AccountEvent {}
class GetAdminUserStatsEvent extends AccountEvent {}

class GetEntrepriseInfoEvent extends AccountEvent {}
class GetCommandsStatsEvent extends AccountEvent {}


