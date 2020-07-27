import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:magic/features/useraccess/bloc/register_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _isPasswordVisible = false;

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _isPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ChangeNotifierProvider(
          create: (_)=> RegisterBloc(context),
          child: Consumer<RegisterBloc>(
            builder: (context, bloc, child) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0,vertical: 8.0),
                    child: Form(
                      key: _registerFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,

                        children: <Widget>[
                          Spacer(),
                          Text(
                            'Register',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Spacer(),
                          _buildEmailField(bloc),
                          SizedBox(height: 16.0,),
                          _buildPasswordField(bloc),
                          SizedBox(height: 16.0,),
                          _buildLoginButton(bloc),
                          Spacer(flex: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Already having account? '),
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Login', style: TextStyle(decoration: TextDecoration.underline),),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  RaisedButton _buildLoginButton(RegisterBloc bloc) {
    return RaisedButton(
      onPressed: () {
//        if (_loginFormKey.currentState.validate())
        bloc.register(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: FractionalOffset.center,
            height: 45,
            child: bloc.isLoading
                ? SpinKitFadingCircle(size: 24, color: Colors.white,)
                : Text(
              "REGISTER",
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(),
    );
  }

  TextFormField _buildPasswordField(RegisterBloc bloc) {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      obscureText: !_isPasswordVisible,
      focusNode: focusPassword,
      onFieldSubmitted: (term) {
        focusPassword.unfocus();
      },
      inputFormatters: [LengthLimitingTextInputFormatter(60)],
      decoration: InputDecoration(
          hintText: 'Password',
          suffixIcon: IconButton(
              icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              })),
    );
  }

  TextFormField _buildEmailField(RegisterBloc bloc) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: focusEmail,
      onFieldSubmitted: (term) {
        focusEmail.unfocus();
        FocusScope.of(context).requestFocus(focusPassword);
      },
      inputFormatters: [LengthLimitingTextInputFormatter(50)],
      decoration: InputDecoration(
        hintText: 'Email',
      ),
    );
  }

  void _register(email, password) async {

    print('_RegisterPageState._register');
    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;

    if(user!=null){
      //Todo: Save user and Go to home page
      user.email;
    }
    else{
      //Todo: Display Error
    }

  }
}

