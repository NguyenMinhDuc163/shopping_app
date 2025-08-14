import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/auth/auth_flow/bloc/auth_state.dart';
import 'package:shopping_app/modules/auth/auth_flow/repository/auth_repo.dart';
import 'package:shopping_app/modules/auth/auth_flow/repository/constants.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.repo}) : super(AuthInitial()) {
    // lay tu repo => co token => emit AuthGenToken
    // tach dang nhap dang ky
    // Viet interceptor de tu + vào url
    // throw messgae khi call api lõi
    // xu ly luu token o repo
    // them messgae neu loi

    Future.delayed(const Duration(seconds: 2), () async {
      String? token = await repo.authLocalDataSource.getToken();
      if (token != null) {
        emit(AuthGenToken());
      }
    });
  }

  final AuthRepo repo;

  Future onLoginStarted({
    required String username,
    required String password,
  }) async {
    emit(AuthLoginInProgress());
    try {
      final res = await repo.login(username: username, password: password);
      if (res) {
        emit(AuthLoginSuccess());
      } else {
        emit(AuthLoginFailure());
      }
    } catch (e) {
      emit(AuthLoginFailure());
    }
  }

  Future onRegisterStarted({
    required String username,
    required String password,
    required String email,
  }) async {
    emit(AuthRegisterInProgress());

    try{
      final res = await repo.register(username: username, password: password, email: email);
      if(res){
        emit(AuthRegisterSuccess());
      }else{
        emit(AuthRegisterFailure());
      }
    }catch(e){
      emit(AuthRegisterError());
      return;
    }
  }
}
