import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/verify_otp_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/repository/forgot_pass_repo.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState>{
  final ForgotPassRepo repo;
  VerifyOtpCubit({required this.repo}) : super(VerifyOtpInitial());

  Future onVerifyOtp({
    required String userName,
    required String otp,
  }) async {
    emit(VerifyOtpInProgress());
    try {
      final res = await repo.verifyOtp(otp: otp, userName: userName);
      if (res) {
        emit(VerifyOtpSuccess());
      } else {
        emit(VerifyOtpFailure());
      }
    } catch (e) {
      emit(VerifyOtpError());
      throw Exception(e);
    }
  }
}