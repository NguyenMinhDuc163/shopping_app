import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_app/core/error_handling/app_error_state.dart';
import 'package:shopping_app/modules/auth/login/repository/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.repo}) : super(LoginInitial());

  final LoginRepo repo;

  Future onLoginSocial(
  ) async {
    emit(LoginInProgress());
    try {
      final res = await repo.signInWithGoogle();
      if (res) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (e) {
      emit(LoginError(message: AppErrorState.getFriendlyErrorString(e)));
    }
  }
}
