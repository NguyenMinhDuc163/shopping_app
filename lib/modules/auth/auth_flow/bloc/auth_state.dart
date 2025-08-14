sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {}

class AuthLoginError extends AuthState {}


class AuthRegisterInProgress extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

class AuthRegisterFailure extends AuthState {}

class AuthGenToken extends AuthState {}
class AuthRegisterError extends AuthState {}