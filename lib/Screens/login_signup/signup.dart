import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_db_bloc/Blocs/auth_cubit/auth_cubit.dart';
import 'package:movie_db_bloc/Screens/login_signup/my_text_field.dart';

import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    String userName = "";
    String password = "";
    String age = "";
    String email = "";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.saveData) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Save Data in Database !'),
                        duration: Duration(microseconds: 600),
                      ),
                    );
                  }
                },
                child: const SizedBox(height: 40),
              ),
              const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 30,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Welcome !",
                style: GoogleFonts.lato(
                  color: Colors.black,
                  textStyle: const TextStyle(letterSpacing: .5, fontSize: 35),
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
                              "Sign up",
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
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                            MyTextField(
                              labelText: 'Age',
                              keyboardType: TextInputType.number,
                              isPassword: false,
                              onChanged: (value) {
                                age = value;
                              },
                            ),
                            MyTextField(
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              isPassword: false,
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<AuthCubit>(context).singUp(
                                    userName, password, int.parse(age), email);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
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
                      builder: (context) => const LoginScreen()));
                },
                child: Text(
                  "Login",
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
