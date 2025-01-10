import 'package:gym_log/config/db.dart';
import 'package:gym_log/data/models/user.dart';
import 'package:sqflite/sqflite.dart';

//classe responsável por gerenciar as transações do usuário com o banco de dados
//basicamente ela tem os métodos de criar o usuário e de retornar o nome dele.
class UserRepository {
  late Database db;

  Future<UserModel?> getUser(String email) async {
    try {
      db = await DB.instance.database;
      List response = await db.query(
        'user',
        where: "email= ?",
        whereArgs: [email],
      );
      if (response.isNotEmpty) {
        UserModel user = UserModel.fromMap(response.first);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserModel?> getDefaultUser() async {
    try {
      db = await DB.instance.database;
      List response = await db.query('user', limit: 1);
      if (response.isNotEmpty) {
        UserModel user = UserModel.fromMap(response.first);
        print("👍");
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  createUser(String fullName, String email) async {
    try {
      db = await DB.instance.database;
      var dto = {
        'fullName': fullName,
        'email': email,
      };
      db.insert('user', dto);
    } catch (e) {
      print(e);
    }
  }

  updateUser(String email) async {
    try {
      db = await DB.instance.database;
      db.update(
        'user',
        {'email': email},
      );
    } catch (e) {
      print(e);
    }
  }
}
