import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_bloc/Screens/home_screen/home_screen.dart';
import 'package:movie_db_bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_db_bloc/search_bloc/search_bloc_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBlocBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(
          userName: 'Shaan',
        ),
      ),
    );
  }
}
