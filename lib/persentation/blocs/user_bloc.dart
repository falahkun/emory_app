import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/domain/usecases/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;

  UserLoaded(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

class FetchUser {
  final int userId;

  FetchUser(this.userId);
}

class UserBloc extends Bloc<FetchUser, UserState> {
  final UserUseCase useCase;

  UserBloc(this.useCase) :super(UserInitial()) {
    on<FetchUser>((event, emit) async {
      emit(UserLoading());
      final result = await useCase.getUser(event.userId);
      result.fold((l) => emit(UserError(l.message)), (r) =>
          emit(UserLoaded(r)));
    });
  }
}