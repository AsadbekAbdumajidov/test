import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/core/constants/constants.dart';
import 'package:test/core/error/error.dart';
import 'package:test/core/usecase/usecase.dart';
import 'package:test/data/domain/usecase/user_uscase.dart';
import 'package:test/data/model/users_response/users_response.dart';
part 'users_state.dart';
part 'users_cubit.freezed.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit(this._usersUseCase) : super(const UsersState());
  final UsersUseCase _usersUseCase;
  
  Future<void> getUsers() async {
    emit(state.copyWith(status: Status.LOADING));
    var result = await _usersUseCase.call(NoParams());
    result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: Status.ERROR)),
        (success) async {
      emit(state.copyWith(response: success, status: Status.SUCCESS));
    });
  }
}
