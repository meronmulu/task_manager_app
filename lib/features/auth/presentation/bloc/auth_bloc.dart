// auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:task_manager_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:task_manager_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthIntial()) {
    on<LoginRequested>(_onLoginRequested);
    on<FetchAllUsers>(_onFetchAllUsers);
    on<AddUserRequested>(_onAddUserRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await repository.login(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onFetchAllUsers(
    FetchAllUsers event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final users = await repository.getAllUsers();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAddUserRequested(
    AddUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final newUser = await repository.addUser(
        name: event.name,
        email: event.email,
        password: event.password,
        role: event.role,
      );

      emit(AuthSuccess(newUser));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
