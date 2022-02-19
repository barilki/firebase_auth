import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()){
    final userRepository = UserRepository();

    on<SignInButtonPressedEvent>((event,emit) async{
      emit(LoginLoading());
      try{
        print("test");
        String? user = await userRepository.signIn(event.email!, event.password!);
        emit(LoginSucceeded(user: user!));
      }
      catch(e){
        emit(LoginFailed(message: e.toString()));
      }
    });
  }

}