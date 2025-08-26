import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/error_handling/app_error_state.dart';
import 'package:shopping_app/core/values/login_type.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_state.dart';
import 'package:shopping_app/modules/auth/sign_in/repository/sign_in_repo.dart';
import 'package:shopping_app/modules/auth/sign_in/use_case/social_login.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepo repo;
  final SocialLogin socialLogin;

  SignInCubit({required this.repo, required this.socialLogin}) : super(SignInInitial()) {
    // lay tu repo => co token => emit AuthGenToken
    // tach dang nhap dang ky
    // Viet interceptor de tu + vào url
    // throw messgae khi call api lõi
    // xu ly luu token o repo
    // them messgae neu loi
    // TODO dang xuat
    // TODO tim hieu thu vien flutter secure_storage
    _checkExistingToken();
  }

  Future<void> _checkExistingToken() async {
    final String? token = repo.authService.accessToken;
    if (token != null) {
      emit(SignInAuthenticated());
    }
  }

  Future onLoginStarted({required String username, required String password}) async {
    emit(SignInInProgress());
    try {
      await repo.login(username: username, password: password);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInError(message: AppErrorState.getFriendlyErrorString(e)));
    }
  }

  Future onLoginSocial() async {
    emit(SignInInProgress());
    try {
      // final res = await repo.signInWithGoogle();
      final res = await socialLogin.call(LoginType.google);
      if (res == true) {
        emit(SignInSuccess());
      } else if (res == null) {
        emit(SignInInitial());
      } else {
        emit(SignInFailure());
      }
    } catch (e) {
      emit(SignInError(message: AppErrorState.getFriendlyErrorString(e)));
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await repo.logout();
      emit(SignInInitial());
    } catch (e) {
      emit(SignInError(message: AppErrorState.getFriendlyErrorString(e)));
    }
  }
}
