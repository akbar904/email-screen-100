
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('main.dart tests', () {
		testWidgets('MyApp has a MaterialApp', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(MaterialApp), findsOneWidget);
		});

		testWidgets('MyApp starts with LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.text('Login'), findsOneWidget);
		});

		group('AuthCubit tests', () {
			late MockAuthCubit mockAuthCubit;

			setUp(() {
				mockAuthCubit = MockAuthCubit();
			});

			blocTest<MockAuthCubit, AuthState>(
				'emits Authenticated state when login is successful',
				build: () => mockAuthCubit,
				act: (cubit) => cubit.emit(AuthState.authenticated()),
				expect: () => [AuthState.authenticated()],
			);

			blocTest<MockAuthCubit, AuthState>(
				'emits Unauthenticated state when logout is successful',
				build: () => mockAuthCubit,
				act: (cubit) => cubit.emit(AuthState.unauthenticated()),
				expect: () => [AuthState.unauthenticated()],
			);
		});
	});
}
