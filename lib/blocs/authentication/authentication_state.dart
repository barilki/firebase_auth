part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticateState extends AuthenticationState {
  User? user;
  int? userData;
  int? randomData;
  AuthenticateState({this.user,this.userData,this.randomData});
}

class UnAuthenticateState extends AuthenticationState {}