import 'package:dummy/services/auth/auth_user.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:equatable/equatable.dart';

/// Every state that comes out of AuthBloc, is this Generic AuthState type
/// Immutable means every states of this class and it's sub-class is going to be final
@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required super.isLoading});
}

/// User is registering right now, but could have an exception
class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering(
      {required this.exception, required super.isLoading});
}

/// In user logged in state, contains AuthUser
class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required super.isLoading});
}

/// User currently logged in, but didn't verify his email
class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required super.isLoading});
}

/// Logged out state, contains exception and isLoading flag to convey the right message for conbination of these
class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required super.isLoading,
    super.loadingText = null,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}
