import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:movie_db_bloc/Screens/home_screen/home_screen.dart';
import 'package:movie_db_bloc/Screens/login_signup/signup.dart';
import 'package:movie_db_bloc/model/user_table.dart';

import 'my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isError = false;
  HashMap<String, String> hs = HashMap<String, String>();
  Future<void> loadList() async {
    var box = await Hive.openBox<UserTable>('userTable');

    for (int i = 0; i < box.length; i++) {
      hs.putIfAbsent(box.getAt(i)!.userName, () => box.getAt(i)!.password);
    }
  }

  @override
  void initState() {
    loadList();
    super.initState();
  }

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
              Text(
                isError ? "Error UserName Or Password Wrong" : "Welcome Back !",
                style: GoogleFonts.lato(
                  color: isError ? Colors.red : Colors.black,
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
                                if (hs.containsKey(userName)) {
                                  if (hs[userName] == password) {
                                    setState(() {
                                      isError = false;
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    userName: userName,
                                                  )));
                                    });
                                  }
                                } else {
                                  setState(() {
                                    isError = true;
                                  });
                                }
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
                      builder: (context) => const SignupScreen()));
                },
                child: Text(
                  "Sing Up",
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
