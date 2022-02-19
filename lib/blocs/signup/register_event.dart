part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressedEvent extends RegisterEvent {
  final String? email, password;
  final int? data;
  const SignUpButtonPressedEvent({required this.email, required this.password, required this.data});

  @override
  List<Object> get props => [email!, password!, data!];
}