import 'package:equatable/equatable.dart';
import 'package:task_manager_app/features/auth/domain/entities/auth_entities.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthIntial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthEntities user;

  AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UsersLoaded extends AuthState {
  final List<AuthEntities> users;

  UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}
