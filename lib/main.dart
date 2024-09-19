import 'package:dummy/constants/routes.dart';
import 'package:dummy/helpers/loading/loading_screen.dart';
import 'package:dummy/services/auth/bloc/auth_bloc.dart';
import 'package:dummy/services/auth/bloc/auth_event.dart';
import 'package:dummy/services/auth/bloc/auth_state.dart';
import 'package:dummy/services/auth/firebase_auth_provider.dart';
import 'package:dummy/views/forgot_password_view.dart';
import 'package:dummy/views/login_view.dart';
import 'package:dummy/views/notes/create_update_note_view.dart';
import 'package:dummy/views/notes/notes_view.dart';
import 'package:dummy/views/register_view.dart';
import 'package:dummy/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'QuickNotes',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 255, 204, 0),
          foregroundColor: Colors.black,
        ),
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (contex) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        } // main.dart is now handling the logics of state changes, in login or notes view we are not specifying where to go
      },
    );
  }
}
