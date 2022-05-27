import 'package:emory_app/domain/entities/user_pagination_entity.dart';
import 'package:emory_app/domain/usecases/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {
  UsersInitial();
}

class UsersLoading extends UsersState {
  UsersLoading();
}

class UsersLoaded extends UsersState {
  final UserPaginationEntity data;
  final bool? isReached;

  UsersLoaded({required this.data, this.isReached = false});
}

class UsersError extends UsersState {
  final String message;

  UsersError(this.message);
}

abstract class UsersEvent {}

class FetchUsers extends UsersEvent {}

class FetchMoreUsers extends UsersEvent {
  final int page;

  FetchMoreUsers(this.page);
}

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserUseCase useCase;

  UsersBloc(this.useCase) : super(UsersInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UsersLoading());
      final result = await useCase.getUsers(page: 1);
      result.fold((l) => emit(UsersError(l.message)),
          (r) => emit(UsersLoaded(data: r, isReached: r.totalPages == r.page)));
    });

    on<FetchMoreUsers>((event, emit) async {
      emit(UsersLoading());
      final result = await useCase.getUsers(page: event.page);
      result.fold((l) => emit(UsersError(l.message)),
          (r) => emit(UsersLoaded(data: r, isReached: r.data.isEmpty)));
    });
  }
}
