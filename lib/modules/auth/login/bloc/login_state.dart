part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({this.message = 'Đăng nhập thất bại'});
}

class LoginError extends LoginState {
  final String message;

  LoginError({this.message = 'Đã xảy ra lỗi'});
}