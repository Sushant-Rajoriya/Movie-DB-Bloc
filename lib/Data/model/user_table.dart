import 'package:hive/hive.dart';

part 'user_table.g.dart';

@HiveType(typeId: 0)
class UserTable {
  @HiveField(0)
  late String userName;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late int age;

  @HiveField(3)
  late String email;

  UserTable(this.userName, this.password, this.age, this.email);
}
