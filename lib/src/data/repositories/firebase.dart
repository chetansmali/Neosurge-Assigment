import 'package:firebase_auth/firebase_auth.dart';
import 'package:neosurge_finance/src/core/utils/auth.dart';

class FirebaseHandler{
  final String name;
  final String email;
  final String password;
  final String confirenPass;

  final _auth = FirebaseAuth.instance;
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  FirebaseHandler(this.name, this.confirenPass, this.password,{required this.email});

  void signup () async{
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    _auth.currentUser?.updateDisplayName(name);
  }

  void login() async{
    await _auth.signInWithEmailAndPassword(
        email: email,
        password: password);
  }

}