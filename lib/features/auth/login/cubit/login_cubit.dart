import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService _apiService = ApiService();

  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      emit(LoginFailure('Please fill in all fields'));
      return;
    }

    emit(LoginLoading());

    try {
      final response = await _apiService.post(
        'auth/login',
        data: {'email': email.trim(), 'password': password.trim()},
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        emit(LoginSuccess('Login Successfully!'));
      } else {
        emit(LoginFailure('Failed to login. Please try again.'));
      }
    } catch (e) {
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      if (errorMsg.toLowerCase().contains('unauthorized')) {
        emit(LoginFailure('Incorrect email or password.'));
      } else if (errorMsg.toLowerCase().contains('network') ||
          errorMsg.toLowerCase().contains('connection') ||
          errorMsg.toLowerCase().contains('timeout') ||
          errorMsg.toLowerCase().contains('failed host lookup') ||
          errorMsg.toLowerCase().contains('socketexception')) {
        emit(
          LoginFailure(
            'Network connection error. Please check your internet connection and try again.',
          ),
        );
      } else {
        emit(LoginFailure(errorMsg));
      }
    }
  }
}
