import 'package:dummy/services/auth/auth_provider.dart';
import 'package:dummy/services/auth/bloc/auth_event.dart';
import 'package:dummy/services/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Putting AuthState and AuthEvent together in logic inside AuthBloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Super provides the initial state of our AuthBloc
  AuthBloc(AuthProvider provider) : super(const AuthStateLoading()) {
    // event comes in from the AuthEvent, emit goes out as AuthState
    // emit is our communication channel to the outside world (i.e. the UI)

    // for Initialize event
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut());
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification());
      } else {
        emit(AuthStateLoggedIn(user));
      }
    });

    // for Login event
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoading());
      // event stores the (email and password) provided by AuthEventLogIn class
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        emit(AuthStateLoggedIn(user));
      } on Exception catch (e) {
        emit(AuthStateLoginFailure(e));
      } // If we fail to Login than our provider will throw an Exception that we already wrote in provider methods
    });

    // for Logout event
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(const AuthStateLoading());
        await provider.logOut();
        emit(const AuthStateLoggedOut());
      } on Exception catch (e) {
        emit(AuthStateLogoutFailure(e));
      }
    });
  }
}
