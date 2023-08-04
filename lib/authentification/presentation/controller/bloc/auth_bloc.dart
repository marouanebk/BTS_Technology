import 'dart:developer';

import 'package:bts_technologie/authentification/domaine/Entities/user.dart';
import 'package:bts_technologie/authentification/domaine/UseCase/login_usecase.dart';
import 'package:bts_technologie/authentification/domaine/UseCase/signup_usecase.dart';
import 'package:bts_technologie/authentification/presentation/controller/bloc/auth_event.dart';
import 'package:bts_technologie/authentification/presentation/controller/bloc/auth_state.dart';
import 'package:bts_technologie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUserCase;
  final SignUpUseCase createUserUseCase;


  AuthBloc(
    this.loginUserCase,
    this.createUserUseCase,
  ) : super(AuthStateInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is CreateUserEvent) {
        emit(LoadingAuthState());
        final failuerOrDoneMessage = await createUserUseCase(event.user);
        emit(_login(
            result: failuerOrDoneMessage, message: "ADD_SUCCESS_MESSAGE"));
      } else if (event is LoginuserEvent) {
        log("log blocked");
        emit(LoadingAuthState());
        final failuerOrDoneMessage = await loginUserCase(event.user);
        emit(_login(
            result: failuerOrDoneMessage, message: "UPDATE_SUCCESS_MESSAG"));
      }
    });
  }
  // AuthState _logOut(
  //     {required Either<Failure, bool> result, required String message}) {
  //   return result.fold(
  //       (l) => ErrorAuthState(message: (l)),
  //       (r) => SignOuState());
  // }


  AuthState _login(
      {required Either<Failure, User> result, required String message}) {
    return result.fold((l) {
      return ErrorAuthState(message: l.message);
    }, (r) {
      if (r == 1) {
        return StudentLoginState();
      } else if (r == 2) {
        return TeacherLoginState();
      } else {
        return StudentLoginState();
      }
    });
  }
}


