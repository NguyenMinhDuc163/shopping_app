import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/core/error_handling/app_error_state.dart';
import 'package:shopping_app/modules/auth/sign_up/bloc/sign_up_state.dart';
import 'package:shopping_app/modules/auth/sign_up/repository/sign_up_repo.dart';

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

  Future onRegisterStarted({
    required String username,
    required String password,
    required String email,
  }) async {
    emit(SignUpInProgress());

    try {
      final res = await repo.register(
        username: username,
        password: password,
        email: email,
      );
      if (res) {
        emit(SignUpSuccess());
      } else {
        emit(
          SignUpFailure(
            message: 'Thông tin đăng ký không hợp lệ hoặc tài khoản đã tồn tại',
          ),
        );
      }
    } catch (e) {
      emit(SignUpError(message: AppErrorState.getFriendlyErrorString(e)));
      return;
    }
  }
}
