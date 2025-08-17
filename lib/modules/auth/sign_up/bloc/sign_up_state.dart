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
