sealed class SignInState {}

class SignInInitial extends SignInState {}

class SignInInProgress extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {
  final String message;

  SignInFailure({this.message = 'Đăng nhập thất bại'});
}

class SignInError extends SignInState {
  final String message;

  SignInError({this.message = 'Đã xảy ra lỗi'});
}

class SignInAuthenticated extends SignInState {}
