
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_cubit.dart';

// Mock dependencies if any, within the scope of lib/cubits/auth_cubit.dart
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = AuthCubit();
		});

		tearDown(() {
			authCubit.close();
		});

		test('initial state is AuthInitial', () {
			expect(authCubit.state, AuthInitial());
		});

		blocTest<AuthCubit, AuthState>(
			'login emits [AuthLoading, AuthAuthenticated] when successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password'),
			expect: () => [
				AuthLoading(),
				AuthAuthenticated(),
			],
		);

		blocTest<AuthCubit, AuthState>(
			'login emits [AuthLoading, AuthError] when unsuccessful',
			build: () => authCubit,
			act: (cubit) => cubit.login('invalid@example.com', 'wrongpassword'),
			expect: () => [
				AuthLoading(),
				AuthError('Invalid credentials'),
			],
		);

		blocTest<AuthCubit, AuthState>(
			'logout emits [AuthUnauthenticated]',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [
				AuthUnauthenticated(),
			],
		);
	});
}
