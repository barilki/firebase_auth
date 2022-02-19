import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/user_repository.dart';
import 'package:flutter_app/models/shared_preferences.dart';


part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    final userRepository = UserRepository();

    on<AppLoadedEvent>((event, emit) async {
      try {
        var isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn) {
          var user = await userRepository.getCurrentUser(); //Get current user email
          var data = await userRepository.getData(); //Get user data(number)
          var rand = data;
          timerFun(user, data, rand);
        } else {
          emit(UnAuthenticateState());
        }
      } catch (e) {
        emit(UnAuthenticateState());
      }
    });


    on<NumberGeneratedEvent>((event, emit) {
      emit(AuthenticationInitial());
      emit(AuthenticateState(
          user: event.user,
          userData: event.userData,
          randomData: event.randomData));
    });

    //Sign out event.
    on<SignOutEvent>((event, emit) async {
      await userRepository.signOut();
      emit(UnAuthenticateState());
    });

  }

  //Timer, add event every second.
  void timerFun(var user, var data, var rand) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (rand > 0) {
        rand = (rand! - 1);
        add(NumberGeneratedEvent(user: user, userData: data, randomData: rand));
      } else {
        timer.cancel();
      }
    });
  }



}
