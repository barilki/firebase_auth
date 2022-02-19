import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/user_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()){
    final userRepository = UserRepository();
    on<SignUpButtonPressedEvent>((event,emit) async{
      emit(RegisterLoading());
      try{
        String? user = await userRepository.signUp(event.email!, event.password!);
        await userRepository.addData(event.data!);
        emit(RegisterSucceeded(user: user!));
      }
      catch(e){
        emit(RegisterFailed(message: e.toString()));
      }
    });
  }

}