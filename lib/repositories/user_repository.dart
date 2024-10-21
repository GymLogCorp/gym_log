import 'package:gym_log/config/db.dart';
import 'package:gym_log/models/user.dart';
import 'package:sqflite/sqflite.dart';

//classe responsável por gerenciar as transações do usuário com o banco de dados
//basicamente ela tem os métodos de criar o usuário e de retornar o nome dele.
class UserRepository {
  late Database db;

  Future<UserModel?> getUser(String email) async {
    db = await DB.instance.database;
    List response = await db.query(
      'user',
      limit: 1,
      where: "email= ?",
      whereArgs: [email],
    );
    if (response.isNotEmpty) {
      UserModel user = UserModel.fromMap(response.first);
      return user;
    } else {
      return null;
    }
  }

  createUser(String fullName, String email) async {
    db = await DB.instance.database;
    var dto = {
      'fullName': fullName,
      'email': email,
    };
    db.insert('user', dto);
  }

  updateUser(String email) async {
    db = await DB.instance.database;
    db.update(
      'user',
      {'email': email},
    );
  }
}
