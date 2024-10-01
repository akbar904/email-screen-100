
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.flutter_cubit_app/models/user.dart';

void main() {
	group('User Model Tests', () {
		test('User Model should have an email field', () {
			final user = User(email: 'test@example.com');
			expect(user.email, 'test@example.com');
		});

		test('User Model should support JSON serialization', () {
			final user = User(email: 'test@example.com');
			final json = user.toJson();
			expect(json['email'], 'test@example.com');
		});

		test('User Model should support JSON deserialization', () {
			final json = {'email': 'test@example.com'};
			final user = User.fromJson(json);
			expect(user.email, 'test@example.com');
		});
	});
}
