sealed class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpInProgress extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {}

class VerifyOtpFailure extends VerifyOtpState {
  final String message;

  VerifyOtpFailure({this.message = 'Gửi mã OTP thất bại'});
}

class VerifyOtpError extends VerifyOtpState {
  final String message;

  VerifyOtpError({this.message = 'Đã xảy ra lỗi'});
}
