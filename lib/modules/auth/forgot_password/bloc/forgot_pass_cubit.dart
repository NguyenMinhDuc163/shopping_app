import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/error_handling/app_error_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/repository/forgot_pass_repo.dart';

class ForgotPassCubit extends Cubit<ForgotPassState> {
  final ForgotPassRepo repo;

  ForgotPassCubit({required this.repo}) : super(ForgotPassInitial());

  Future onSendOtp({required String email}) async {
    emit(ForgotPassInProgress());
    try {
      final res = await repo.sendOPT(email: email);
      if (res) {
        emit(ForgotPassSuccess());
      } else {
        emit(ForgotPassFailure());
      }
    } catch (e) {
      emit(ForgotPassError(message: AppErrorState.getFriendlyErrorString(e)));
      throw Exception(e);
    }
  }
}
