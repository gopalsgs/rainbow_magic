
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/ui/pages/HomePage.dart';
import 'LoginPage.dart';


class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    _isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          body: Center(
            child: Text('Rainbow Magic', style: Theme.of(context).textTheme.headline5,),
          ),
        )
    );
  }

  void _isUserLoggedIn() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    var user = await auth.currentUser();

    await Future.delayed(Duration(seconds: 3));
    if(user !=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage(user: user,)));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginPage()));
    }
  }


}
