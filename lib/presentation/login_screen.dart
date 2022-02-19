//Made by Bar-Ilan Kimbarovski
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/login/login_bloc.dart';
import 'package:flutter_app/presentation/home_screen.dart';
import 'package:flutter_app/widgets/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController? userController = TextEditingController();
  TextEditingController? passController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginInitial) {
          const Center(child: Text('Waiting'));
        }
        if (state is LoginLoading) {
          const Center(child: CircularProgressIndicator());
        }
        if (state is LoginSucceeded) {
          print("COOL");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
        }
        if (state is LoginFailed) {
          print("failed");
          Center(child: Text(state.message));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return MaterialApp(
            home: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFill(
                      labelText: "Enter user",
                      textController: userController),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFill(
                    labelText: "Enter password",
                    textController: passController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                    isLogged(context);
                    },
                    child: Text('Sign In'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //Add register event
  void isLogged(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(SignInButtonPressedEvent(
      email: userController?.text,
      password: passController?.text,
    ));
  }

}


