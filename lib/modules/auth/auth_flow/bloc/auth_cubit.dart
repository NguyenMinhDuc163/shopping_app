import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/auth/auth_flow/bloc/auth_state.dart';
import 'package:shopping_app/modules/auth/auth_flow/repository/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.repo}) : super(AuthInitial());

  final AuthRepo repo;

  Future onLoginStarted({
    required String username,
    required String password,
  }) async {
    emit(AuthLoginInProgress());
    try {
      await repo.login(username: username, password: password);
      emit(AuthLoginSuccess());
    } catch (e) {
      emit(AuthLoginFailure());
    }
  }
}
