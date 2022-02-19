//Made by Bar-Ilan Kimbarovski
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/signup/register_bloc.dart';
import 'package:flutter_app/presentation/home_screen.dart';
import 'package:flutter_app/presentation/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController? userController = TextEditingController();
  TextEditingController? passController = TextEditingController();
  TextEditingController? textController = TextEditingController();

  RegisterBloc? _registerBloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        //Listen to new changes in the state
        if (state is RegisterLoading) {
          const Center(child: Text("Wait.."));
        }

        if (state is RegisterSucceeded) {
          print("SUCCEEDED");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
        }
        if (state is RegisterFailed) {
          print("failed");
          Center(child: Text(state.message));
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return MaterialApp(
            home: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFill(
                      labelText: "Enter user name",
                      textController: userController),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFill(
                      labelText: "Enter password",
                      textController: passController),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFill(
                    labelText: "Enter value",
                    textController: textController,
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
                      isSubmitted(context);
                    },
                    child: Text('Sign Up'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      child: Text("Sign In"),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => SignInScreen()));
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //Add register event
  void isSubmitted(BuildContext context) {
    BlocProvider.of<RegisterBloc>(context).add(SignUpButtonPressedEvent(
      email: userController?.text,
      password: passController?.text,
      data: int.parse(textController!.text),
    ));
  }
}
