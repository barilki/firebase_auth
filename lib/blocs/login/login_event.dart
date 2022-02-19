part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SignInButtonPressedEvent extends LoginEvent {
  final String? email, password;
  const SignInButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email!, password!];
}