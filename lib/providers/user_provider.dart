import 'package:flutter/foundation.dart';
import 'package:gym_log/data/models/user.dart';
import 'package:gym_log/data/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel(id: 1, fullName: 'Usuário', email: '');
  UserModel defaultUser = UserModel(id: 1, fullName: '', email: '');
  final UserRepository _userRepository = UserRepository();
  Future<void> getUSer(String email) async {
    user = (await _userRepository.getUser(email))!;
    notifyListeners();
  }

  Future<void> getDefaultUser() async {
    defaultUser = (await _userRepository.getDefaultUser())!;
    notifyListeners();
  }

  Future<void> createUserAccount(String fullName, String email) async {
    await _userRepository.createUser(fullName, email);
    notifyListeners();
  }

  Future<void> updateUserAccount(String email) async {
    await _userRepository.updateUser(email);
    notifyListeners();
  }
}
