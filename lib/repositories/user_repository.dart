import 'package:flutter/material.dart';
import 'package:gym_log/config/db.dart';
import 'package:gym_log/models/user.dart';
import 'package:sqflite/sqflite.dart';

//classe responsável por gerenciar as transações do usuário com o banco de dados
//basicamente ela tem os métodos de criar o usuário e de retornar o nome dele.
class UserRepository extends ChangeNotifier {
  late Database db;
  String _fullName = '';

  get userName => _fullName;

  UserRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getUserName();
  }

  _getUserName() async {
    db = await DB.instance.database;
    List response = await db.query('users', limit: 1);
    _fullName = response.first['fullName'];
    notifyListeners();
  }

  setUser(UserModel user) async {
    db = await DB.instance.database;
    var dto = {
      'fullName': user.fullName,
      'email': user.email,
      'password': user.password
    };
    db.insert('users', dto);
    notifyListeners();
  }
}
