import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  login({
    @required email,
    @required password,
  }) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      return e.message;
    }
  }

  register({
    @required email,
    @required password,
  }) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      return e.message;
    }
  }

}