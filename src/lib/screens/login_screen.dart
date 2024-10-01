
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
	@override
	_LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	final _formKey = GlobalKey<FormState>();
	final _emailController = TextEditingController();
	final _passwordController = TextEditingController();

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Form(
					key: _formKey,
					child: Column(
						children: [
							TextFormField(
								controller: _emailController,
								decoration: InputDecoration(labelText: 'Email'),
								validator: (value) {
									if (value == null || value.isEmpty) {
										return 'Please enter your email';
									}
									return null;
								},
							),
							TextFormField(
								controller: _passwordController,
								decoration: InputDecoration(labelText: 'Password'),
								obscureText: true,
								validator: (value) {
									if (value == null || value.isEmpty) {
										return 'Please enter your password';
									}
									return null;
								},
							),
							SizedBox(height: 20),
							ElevatedButton(
								onPressed: () {
									if (_formKey.currentState!.validate()) {
										final email = _emailController.text;
										final password = _passwordController.text;
										context.read<AuthCubit>().login(email, password);
									}
								},
								child: Text('Login'),
							),
						],
					),
				),
			),
		);
	}
}
