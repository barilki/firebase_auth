//Made by Bar-Ilan Kimbarovski
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
   String? name;
   int? userData, random;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Scaffold(
              body:  state is AuthenticateState ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Welcome, " + state.user!.email.toString(),style: const TextStyle(fontSize: 25))),
                  const SizedBox(height: 10),
                  Center(child: Text("Your number is: " + state.userData.toString(),style: const TextStyle(fontSize: 17))),
                  const SizedBox(height: 15),
                  Center(child: Text("Count down: " + state.randomData.toString(),style: const TextStyle(fontSize: 17))),
                  const SizedBox(height: 15),
                  TextButton(
                      child: Text("Sign Out"),
                      onPressed: () {
                        context.read<AuthenticationBloc>().add(SignOutEvent());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => MyApp()));
                      })
                ],
              ):
            Container(),
            );
        },
      );
  }

  @override
  void initState() {
    //Add app loaded event
    BlocProvider.of<AuthenticationBloc>(context).add(AppLoadedEvent());
    super.initState();
  }
}