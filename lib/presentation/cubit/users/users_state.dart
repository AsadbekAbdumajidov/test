part of 'users_cubit.dart';

@freezed
class UsersState with _$UsersState {
  const factory UsersState({
    @Default(Status.UNKNOWN) Status status,
    @Default(UnknownFailure()) Failure failure,
    @Default([]) List<UsersResponse> response,
  }) = _UsersState;
}
