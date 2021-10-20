import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_db_bloc/Data/model/user_table.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(hasData: false, saveData: false));

  Future<void> login(String userName, String password) async {
    var box = await Hive.openBox<UserTable>('userTable');
    bool tmp = false;
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)!.userName == userName &&
          box.getAt(i)!.password == password) {
        tmp = true;
      }
    }
    emit(AuthState(hasData: tmp, saveData: false));
  }

  Future<void> singUp(
      String userName, String password, int age, String email) async {
    var box = await Hive.openBox<UserTable>('userTable');
    box.add(UserTable(
      userName,
      password,
      age,
      email,
    ));
    emit(AuthState(hasData: false, saveData: true));
  }
}
