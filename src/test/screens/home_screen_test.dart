
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';

class MockAuthCubit extends MockCubit<void> {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays "Home" text', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);
			
			expect(find.text('Home'), findsOneWidget);
		});
		
		testWidgets('displays Logout button', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);
			
			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Logout'), findsOneWidget);
		});
	});
	
	group('HomeScreen Cubit Tests', () {
		late MockAuthCubit mockAuthCubit;

		setUp(() {
			mockAuthCubit = MockAuthCubit();
		});
		
		testWidgets('calls logout on button press', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);
			
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();
			
			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
