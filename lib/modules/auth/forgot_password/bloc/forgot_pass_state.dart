sealed class ForgotPassState{}

class ForgotPassInitial extends ForgotPassState {}

class ForgotPassInProgress extends ForgotPassState {}

class ForgotPassSuccess extends ForgotPassState {}

class ForgotPassFailure extends ForgotPassState {
  final String message;

  ForgotPassFailure({this.message = 'Gửi mã OTP thất bại'});
}

class ForgotPassError extends ForgotPassState {
  final String message;

  ForgotPassError({this.message = 'Đã xảy ra lỗi'});
}