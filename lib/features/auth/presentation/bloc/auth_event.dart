import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class FetchAllUsers extends AuthEvent {}

class AddUserRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String role;

  AddUserRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [name, email, password, role];
}
