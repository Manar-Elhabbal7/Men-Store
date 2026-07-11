part of 'signup_cubit.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final String message;
  SignupSuccess(this.message);
}

final class SignupFailure extends SignupState {
  final String error;
  SignupFailure(this.error);
}
