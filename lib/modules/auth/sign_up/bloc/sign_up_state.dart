import 'package:equatable/equatable.dart';

sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpInProgress extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String message;

  SignUpFailure({this.message = 'Đăng ký thất bại'});
}

class SignUpError extends SignUpState {
  final String message;

  SignUpError({this.message = 'Đã xảy ra lỗi'});
}

class CheckUsernameInProgress extends SignUpState {}

class CheckUsernameSuccess extends SignUpState {
  final bool isAvailable;

  CheckUsernameSuccess({required this.isAvailable});
}

class CheckUsernameFailure extends SignUpState {
  final String message;

  CheckUsernameFailure({this.message = 'Kiểm tra username thất bại'});
}

class CheckEmailInProgress extends SignUpState {}

class CheckEmailSuccess extends SignUpState {
  final bool isAvailable;

  CheckEmailSuccess({required this.isAvailable});
}

class CheckEmailFailure extends SignUpState {
  final String message;

  CheckEmailFailure({this.message = 'Kiểm tra email thất bại'});
}
