import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/error_handling/app_error_state.dart';
import 'package:shopping_app/modules/auth/sign_up/bloc/sign_up_state.dart';
import 'package:shopping_app/modules/auth/sign_up/repository/sign_up_repo.dart';
import 'package:shopping_app/utils/helpers/validators.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.repo}) : super(SignUpInitial()) {
    // lay tu repo => co token => emit AuthGenToken
    // tach dang nhap dang ky
    // Viet interceptor de tu + vào url
    // throw messgae khi call api lõi
    // xu ly luu token o repo
    // them messgae neu loi
  }

  final SignUpRepo repo;
  Timer? _emailDebounceTimer;
  Timer? _usernameDebounceTimer;

  Future onRegisterStarted({
    required String username,
    required String password,
    required String email,
  }) async {
    emit(SignUpInProgress());

    try {
      final res = await repo.register(username: username, password: password, email: email);
      if (res) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure(message: 'Thông tin đăng ký không hợp lệ hoặc tài khoản đã tồn tại'));
      }
    } catch (e) {
      emit(SignUpError(message: AppErrorState.getFriendlyErrorString(e)));
      return;
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
      return;
    }
  }

  void onEmailChanged(String email) {
    final trimmed = email.trim();

    _emailDebounceTimer?.cancel();

    if (trimmed.length < 3 || !Validators.isValidEmail(trimmed)) {
      return;
    }

    _emailDebounceTimer = Timer(const Duration(milliseconds: 500), () async {
      await checkEmail(email: trimmed);
    });
  }

  Future checkEmail({required String email}) async {
    emit(CheckEmailInProgress());

    try {
      final res = await repo.checkEmail(email: email);
      if (res) {
        emit(CheckEmailSuccess(isAvailable: true));
      } else {
        emit(CheckEmailSuccess(isAvailable: false));
      }
    } catch (e) {
      emit(CheckEmailFailure(message: AppErrorState.getFriendlyErrorString(e)));
      return;
    }
  }
}
