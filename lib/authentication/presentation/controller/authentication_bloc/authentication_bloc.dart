import 'dart:developer';
import 'package:bts_technologie/authentication/domaine/entities/user_entitiy.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bts_technologie/authentication/domaine/usecases/login_usecase.dart';

import 'package:bts_technologie/authentication/domaine/usecases/signup_usecase.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_event.dart';
import 'package:bts_technologie/authentication/presentation/controller/authentication_bloc/authentication_state.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final LoginUseCase loginUserCase;
  final CreateUserUseCase createUserUseCase;

  UserBloc(
    this.loginUserCase,
    this.createUserUseCase,
  ) : super(UserBlocStateInitial()) {
    on<UserBlocEvent>((event, emit) async {
      if (event is CreateUserEvent) {
        emit(LoadingUserBlocState());
        final failuerOrDoneMessage = await createUserUseCase(event.user);
        emit(_eitherDoneMessageOrErrorState(
            result: failuerOrDoneMessage, message: "ADD_SUCCESS_MESSAGE"));
      } else if (event is LoginuserEvent) {
        log("HEEEEEEEEEEregistered");
        emit(LoadingUserBlocState());
        final failuerOrDoneMessage = await loginUserCase(event.user);
        emit(_login(
            result: failuerOrDoneMessage, message: "UPDATE_SUCCESS_MESSAG"));
      }
    });
  }

  UserBlocState _eitherDoneMessageOrErrorState(
      {required Either<Failure, User> result, required String message}) {
    return result.fold((l) => ErrorUserBlocState(message: l.message),
        (r) => const MessageUserBlocState(message: "ADD_SUCCESS_MESSAGE"));
  }

  UserBlocState _login(
      {required Either<Failure, User> result, required String message}) {
    return result.fold((l) {
      return ErrorUserBlocState(message: l.message);
    }, (r) {
      if (r.role == "admin") {
        return AdministratorLoginState();
      } else if (r.role == "pageAdmin") {
        return PageAdminLoginState();
      } else if (r.role == "financier") {
        return FinancesLoginState();
      } else {
        // (r.role == "logistics")

        //  {
        return LogistiquesLoginState();
      }
    });
  }
}

