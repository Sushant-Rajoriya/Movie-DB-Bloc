import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db_bloc/Blocs/auth_cubit/auth_cubit.dart';
import 'package:movie_db_bloc/Blocs/fatch_movie_cubit/fatch_movie_cubit.dart';
import 'package:movie_db_bloc/Screens/home_screen/home_screen.dart';
import 'package:movie_db_bloc/Screens/login_signup/signup.dart';

import 'my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    String userName = "";
    String password = "";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 30,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.hasData) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<FatchMovieCubit>(context),
                              child: HomeScreen(
                                userName: userName,
                              ),
                            )));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Username or Password Worng '),
                        duration: Duration(microseconds: 10000),
                      ),
                    );
                  }
                },
                child: Text(
                  "Welcome Back !",
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    textStyle: const TextStyle(letterSpacing: .5, fontSize: 35),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Log in",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                textStyle: const TextStyle(
                                    letterSpacing: .5, fontSize: 25),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            MyTextField(
                              labelText: 'User Name',
                              keyboardType: TextInputType.text,
                              isPassword: false,
                              onChanged: (value) {
                                userName = value;
                              },
                            ),
                            MyTextField(
                              labelText: 'Password',
                              keyboardType: TextInputType.text,
                              isPassword: true,
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context)
                                    .login(userName, password);
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<AuthCubit>(context),
                            child: const SignupScreen(),
                          )));
                },
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.lato(
                    color: Colors.blueAccent,
                    textStyle: const TextStyle(letterSpacing: .5, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
