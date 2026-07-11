import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_service.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final ApiService _apiService = ApiService();

  SignupCubit() : super(SignupInitial());

  Future<void> signup({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (fullName.trim().isEmpty ||
        email.trim().isEmpty ||
        password.trim().isEmpty ||
        confirmPassword.trim().isEmpty) {
      emit(SignupFailure('Please fill in all fields'));
      return;
    }

    if (password != confirmPassword) {
      emit(SignupFailure('Passwords do not match'));
      return;
    }

    emit(SignupLoading());

    try {
      final response = await _apiService.post(
        'users/',
        data: {
          'name': fullName.trim(),
          'email': email.trim(),
          'password': password.trim(),
          'avatar': 'https://picsum.photos/800',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignupSuccess('Account created successfully!'));
      } else {
        emit(SignupFailure('Failed to register. Please try again.'));
      }
    } catch (e) {
      emit(SignupFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
