
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the states for the AuthCubit
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
	final String message;
	AuthError(this.message);
}

// Define the AuthCubit
class AuthCubit extends Cubit<AuthState> {
	AuthCubit() : super(AuthInitial());

	void login(String email, String password) async {
		try {
			emit(AuthLoading());
			// Simulate a network call
			await Future.delayed(Duration(seconds: 2));

			if (email == 'test@example.com' && password == 'password') {
				emit(AuthAuthenticated());
			} else {
				emit(AuthError('Invalid credentials'));
			}
		} catch (e) {
			emit(AuthError(e.toString()));
		}
	}

	void logout() {
		emit(AuthUnauthenticated());
	}
}
