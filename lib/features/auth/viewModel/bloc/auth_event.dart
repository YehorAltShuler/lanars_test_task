part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  final GlobalKey<FormState> formKey;

  AuthSignIn(
      {required this.email, required this.password, required this.formKey});
}
