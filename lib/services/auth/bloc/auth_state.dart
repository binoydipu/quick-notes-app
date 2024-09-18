import 'package:dummy/services/auth/auth_user.dart';
import 'package:flutter/foundation.dart' show immutable;

/// Every state that comes out of AuthBloc, is this Generic AuthState type
/// Immutable means every states of this class and it's sub-class is going to be final
@immutable
abstract class AuthState {
  const AuthState();
}

/// In loading state, [Ex. While app is initializing or communicating with firebase]
class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

/// In user logged in state, contains AuthUser
class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

/// In login Error state, [Ex: Exception occured while loggin in], contains Exception
class AuthStateLoginFailure extends AuthState {
  final Exception exception;
  const AuthStateLoginFailure(this.exception);
}

/// User currently logged in, but didn't verify his email
class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification();
}

/// Logged out state
class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut();
}

/// In logout error state, [Ex. Firebase API call error], contains Exception
class AuthStateLogoutFailure extends AuthState {
  final Exception exception;
  const AuthStateLogoutFailure(this.exception);
}
