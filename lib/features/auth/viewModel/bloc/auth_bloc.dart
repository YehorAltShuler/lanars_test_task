import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_test_task/features/auth/model/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthSignIn>(_onSignIn);
  }

  Future<void> _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    if (!event.formKey.currentState!.validate()) {
      return;
    }
    emit(AuthLoading());
    try {
      await _authRepository.signIn(event.email, event.password);
      emit(AuthLoaded());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
