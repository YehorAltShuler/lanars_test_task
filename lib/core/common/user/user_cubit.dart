import 'package:flutter_bloc/flutter_bloc.dart';
import 'user.dart';
import 'user_repository.dart';

class UserCubit extends Cubit<User?> {
  final UserRepository _repository;

  UserCubit(this._repository) : super(null) {
    _initialize();
  }

  void _initialize() {
    loadUser();
  }

  void loadUser() {
    try {
      final user = _repository.fetchUser();
      emit(user);
    } catch (e) {
      emit(null);
    }
  }

  void clearUser() {
    _repository.clearUser();
    emit(null);
  }
}
