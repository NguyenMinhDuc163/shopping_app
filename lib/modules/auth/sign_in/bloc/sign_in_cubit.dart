import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/modules/auth/sign_in/bloc/sign_in_state.dart';
import 'package:shopping_app/modules/auth/sign_in/repository/sign_in_repo.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required this.repo}) : super(SignInInitial()) {
    // lay tu repo => co token => emit AuthGenToken
    // tach dang nhap dang ky
    // Viet interceptor de tu + vào url
    // throw messgae khi call api lõi
    // xu ly luu token o repo
    // them messgae neu loi

    Future.delayed( Duration.zero, () async {
      String? token = await repo.authLocalDataSource.getToken();
      if (token != null) {
        emit(SignInAuthenticated());
      }
    });
  }

  final SignInRepo repo;

  Future onLoginStarted({
    required String username,
    required String password,
  }) async {
    emit(SignInInProgress());
    try {
      final res = await repo.login(username: username, password: password);
      if (res) {
        emit(SignInSuccess());
      } else {
        emit(SignInFailure());
      }
    } catch (e) {
      emit(SignInFailure());
      throw Exception("Lỗi hệ thống");
    }
  }
}
