import 'package:emory_app/domain/entities/user_entity.dart';
import 'package:emory_app/domain/usecases/user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileProcessing extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String message;

  EditProfileError(this.message);
}

class EditProfileAction {
  final UserEntity user;

  EditProfileAction(this.user);
}

class EditProfileBloc extends Bloc<EditProfileAction, EditProfileState> {
  final UserUseCase useCase;

  EditProfileBloc(this.useCase) : super(EditProfileInitial()) {
    on<EditProfileAction>((event, emit) async {
      emit(EditProfileProcessing());
      final result = await useCase.editUserAction(event.user);
      result.fold((l) => emit(EditProfileError(l.message)),
          (r) => emit(EditProfileSuccess()));
    });
  }
}
