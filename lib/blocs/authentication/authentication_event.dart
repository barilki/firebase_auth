part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//
class AppLoadedEvent extends AuthenticationEvent {}

class SignOutEvent extends AuthenticationEvent {}


class NumberGeneratedEvent extends AuthenticationEvent {
  User? user;
  int? userData;
  int? randomData;
  NumberGeneratedEvent({this.user, this.userData, this.randomData});
}

