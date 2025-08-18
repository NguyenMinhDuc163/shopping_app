sealed class ResetPassState{}

class ResetPassInitial extends ResetPassState {}

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
