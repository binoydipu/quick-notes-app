import 'package:flutter/foundation.dart' show immutable;

/// Every event that may occure for Authentication is a sub-class of AuthEvent
@immutable
abstract class AuthEvent {
  const AuthEvent();
}

/// Event of initializing firebase
class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

/// Event of Login, contains email and password
class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn(this.email, this.password);
}

/// Event of Logout
class AuthEventLogOut extends AuthEvent {
  const AuthEventLogOut();
}
