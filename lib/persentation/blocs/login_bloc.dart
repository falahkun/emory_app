import 'package:emory_app/data/models/login_request.dart';
import 'package:emory_app/domain/usecases/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginProcessing extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

class LoginAction {
  final LoginRequest request;

  LoginAction(this.request);
}

class LoginBloc extends Bloc<LoginAction, LoginState> {
  final UserUseCase useCase;

  LoginBloc(this.useCase) : super(LoginInitial()) {
    on<LoginAction>((event, emit) async {
      emit(LoginProcessing());
      final result = await useCase.loginAction(event.request);
      result.fold(
          (l) => emit(LoginError(l.message)), (r) => emit(LoginSuccess()));
    });
  }
}
