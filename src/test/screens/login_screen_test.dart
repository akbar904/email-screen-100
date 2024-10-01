
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/screens/login_screen.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display email and password fields', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider(
						create: (_) => MockAuthCubit(),
						child: LoginScreen(),
					),
				),
			);

			expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password fields
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider(
						create: (_) => MockAuthCubit(),
						child: LoginScreen(),
					),
				),
			);

			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('LoginScreen Cubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthAuthenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [
				AuthLoading(),
				AuthAuthenticated(),
			],
			verify: (_) {
				verify(() => authCubit.login('test@example.com', 'password123')).called(1);
			},
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, AuthError] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
			expect: () => [
				AuthLoading(),
				AuthError('Invalid credentials'),
			],
			verify: (_) {
				verify(() => authCubit.login('test@example.com', 'wrongpassword')).called(1);
			},
		);
	});
}
