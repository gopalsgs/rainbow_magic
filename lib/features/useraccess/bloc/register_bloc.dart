
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:magic/Utils/UIUtils.dart';
import 'package:magic/core/base_bloc.dart';
import 'package:magic/features/home/ui/pages/HomePage.dart';

import 'authentication_service.dart';

class RegisterBloc extends BaseBloc{

  BuildContext context;
  AuthService _authService;
  RegisterBloc(this.context){
    _authService = AuthService();
  }

  void register({@required email, @required password}) async{

    setLoading(true);
    var result = await _authService.register(email: email, password: password);
    setLoading(false);

    if(result == null){
      //UnKnown error
      UIUtils.displayDialog(context: context, title: 'Error', message: 'Something went wrong pleas try again later.');
    }
    else if(result.runtimeType == AuthResult){
      //Login successful
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> HomePage(user:(result as AuthResult).user)), (_)=>false);
    }
    else{
      // Error message returned as String
      print('RegisterBloc.register');
      UIUtils.displayDialog(context: context, title: 'Error', message: '$result');
    }

  }

}
