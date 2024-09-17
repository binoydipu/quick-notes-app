import 'package:dummy/constants/routes.dart';
import 'package:dummy/services/auth/auth_exceptions.dart';
import 'package:dummy/services/auth/auth_service.dart';
import 'package:dummy/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                await AuthService.firebase().sendEmailVerification();
                if (context.mounted) {
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                }
              } on WeakPasswordAuthException {
                if (context.mounted) {
                  await showErrorDialog(
                    context,
                    'Weak Password',
                  );
                }
              } on EmailAlreadyInUseAuthException {
                if (context.mounted) {
                  await showErrorDialog(
                    context,
                    'Email is already in use',
                  );
                }
              } on InvalidEmailAuthException {
                if (context.mounted) {
                  await showErrorDialog(
                    context,
                    'This is an invalid email address',
                  );
                }
              } on GenericAuthException {
                if (context.mounted) {
                  await showErrorDialog(
                    context,
                    'Registration failed',
                  );
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!'),
          ),
        ],
      ),
    );
  }
}
