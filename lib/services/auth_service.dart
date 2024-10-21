import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_log/Exceptions/auth_exception.dart';
import 'package:gym_log/models/user.dart';
import 'package:gym_log/repositories/user_repository.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userRepository = UserRepository();
  User? usuario;
  bool isLoading = false;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  createAccount(String fullName, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(
          fullName); //desse jeito nós podemos cadastrar o nome fornecido pela pessoa
      await userRepository.createUser(fullName, email);
      notifyListeners();

      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Esse email fornecido já está em uso.');
      } else {
        throw AuthException("Erro ao fazer o cadastro.");
      }
    }
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      UserModel? userLocal = await userRepository.getUser(email);
      if (userLocal == null) {
        await userRepository.updateUser(email);
      }
      _getUser();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Usuário não encontrado.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta.');
      } else {
        throw AuthException('Erro ao fazer login.');
      }
    }
  }

// Método para exibir o Snackbar com a mensagem de erro
  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
