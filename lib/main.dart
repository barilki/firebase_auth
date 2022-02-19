//Made by Bar-Ilan Kimbarovski
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_app/blocs/login/login_bloc.dart';
import 'package:flutter_app/blocs/signup/register_bloc.dart';
import 'package:flutter_app/presentation/home_screen.dart';
import 'package:flutter_app/presentation/signup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final authBloc = AuthenticationBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  authBloc.add(AppLoadedEvent());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //If snapshot has data, app keep logged in. Home screen is displayed.
              if (snapshot.hasData) {
                return HomeScreen();
              }
              //Otherwise, user not signed in. Sign up screen is displayed.
              return SignupScreen();
            },
          ),
        ),
      ),
    );
  }
}
