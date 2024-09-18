import 'package:dummy/constants/routes.dart';
import 'package:dummy/services/auth/bloc/auth_bloc.dart';
import 'package:dummy/services/auth/bloc/auth_event.dart';
import 'package:dummy/services/auth/bloc/auth_state.dart';
import 'package:dummy/services/auth/firebase_auth_provider.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (contex) => const NotesView(),
        verifyEmailRoute: (contex) => const VerifyEmailView(),
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        } // main.dart is now handling the logics of state changes, in login or notes view we are not specifying where to go
      },
    );
  }
}
