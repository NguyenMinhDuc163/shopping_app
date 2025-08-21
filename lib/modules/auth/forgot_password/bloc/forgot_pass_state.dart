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

sealed class ResetPassState extends ForgotPassState{}


class ResetPassInProgress extends ResetPassState {}

class ResetPassSuccess extends ResetPassState {}

class ResetPassFailure extends ResetPassState {
  final String message;

  ResetPassFailure({this.message = 'Đổi mật khẩu thất bại'});
}

class ResetPassError extends ResetPassState {
  final String message;

  ResetPassError({this.message = 'Đã xảy ra lỗi'});
}
