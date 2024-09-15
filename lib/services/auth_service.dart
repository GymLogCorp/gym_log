import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_log/Exceptions/auth_exception.dart';

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth =
      FirebaseAuth.instance; //instância do firebase para utilizar os métodos
  User?
      localUser; //declaração do usuário que etá localmente no aparelho, com o tipo User do firebase
  bool isLoading =
      true; //para usar como alerta pro usuário que a solicitação está carregando

  AuthService() {
    _authCheck(); //Dessa forma toda vez que a pessoa chamar o service, ele via checkar se está logado
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      //vai ouvir mudanças na auth do firebase, e depois verifica se o usuário local é o que está logado no firebase
      localUser = (user == null) ? null : user;
      isLoading = false;
      notifyListeners(); //notifica todos os componentes que escutam esse provider
    });
  }

  //ele vai fazer com que a pessoa já logue quando fazer o registro /login e seja redirecionada quando fizer o logout
  _getUser() {
    localUser = _auth.currentUser;
    notifyListeners();
  }

  createAccount(String fullName, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(
          fullName); //desse jeito nós podemos cadastrar o nome fornecido pela pessoa
      _getUser();
    } on FirebaseAuthException catch (e) {
      //apenas tratamento de exceções personalizado
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Esse email fornecido já está em uso.');
      }
    }
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('O usuário não encontrado');
      } else if (e.code == 'wrong-password') {
        AuthException('A senha está incorreta.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
