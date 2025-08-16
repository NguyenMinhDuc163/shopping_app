sealed class SignInState {}

class SignInInitial extends SignInState {}

class SignInInProgress extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInFailure extends SignInState {}

class SignInError extends SignInState {}

class SignInAuthenticated extends SignInState {}
