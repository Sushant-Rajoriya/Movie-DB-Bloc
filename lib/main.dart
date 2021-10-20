import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_db_bloc/Blocs/auth_cubit/auth_cubit.dart';
import 'package:movie_db_bloc/Blocs/fatch_movie_cubit/fatch_movie_cubit.dart';
import 'package:movie_db_bloc/Blocs/search_movie_cubit/search_movie_cubit.dart';
import 'package:movie_db_bloc/Data/model/user_table.dart';
import 'package:movie_db_bloc/Screens/login_signup/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserTableAdapter());

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
          create: (context) => FatchMovieCubit(),
        ),
        BlocProvider(
          create: (context) => SearchMovieCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginScreen()),
    );
  }
}
