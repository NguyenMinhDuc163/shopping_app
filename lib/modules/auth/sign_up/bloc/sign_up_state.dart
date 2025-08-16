import 'package:equatable/equatable.dart';

sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpInProgress extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {}

class SignUpError extends SignUpState {}
