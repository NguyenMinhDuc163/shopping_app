import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/error_handling/app_error_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/bloc/forgot_pass_state.dart';
import 'package:shopping_app/modules/auth/forgot_password/repository/forgot_pass_repo.dart';

class ForgotPassCubit extends Cubit<ForgotPassState> {
  final ForgotPassRepo repo;
  Timer? _usernameDebounceTimer;

  ForgotPassCubit({required this.repo}) : super(ForgotPassInitial());

  Future onSendOtp({required String username}) async {
    emit(ForgotPassInProgress());
    try {
      final res = await repo.sendOPT(username: username);
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

  void onUsernameChanged(String username) {
    final trimmed = username.trim();

    _usernameDebounceTimer?.cancel();

    if (trimmed.length < 3) {
      return;
    }

    _usernameDebounceTimer = Timer(const Duration(milliseconds: 500), () async {
      await checkUserName(username: trimmed);
    });
  }

  Future checkUserName({required String username}) async {
    emit(CheckUsernameInProgress());

    try {
      final res = await repo.checkUserName(username: username);
      if (res) {
        emit(CheckUsernameSuccess(isAvailable: true));
      } else {
        emit(CheckUsernameSuccess(isAvailable: false));
      }
    } catch (e) {
      emit(CheckUsernameFailure(message: AppErrorState.getFriendlyErrorString(e)));
    }
  }
}
