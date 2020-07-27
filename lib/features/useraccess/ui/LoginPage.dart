
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magic/features/useraccess/bloc/login_bloc.dart';
import 'package:magic/features/useraccess/ui/register_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _isPasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ChangeNotifierProvider(
          create: (_) => LoginBloc(context),
          child: Consumer<LoginBloc>(builder: (context, bloc, child) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 8.0),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Spacer(),
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Spacer(),
                        _buildEmailField(bloc),
                        SizedBox(height: 16.0,),
                        _buildPasswordField(bloc),
                        SizedBox(height: 16.0,),
                        _buildLoginButton(bloc),
                        Spacer(flex: 2),
                        _buildSignUpMessage(context),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Row _buildSignUpMessage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Don\'t have an account? '),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => RegisterPage()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'SignUp',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    );
  }

  RaisedButton _buildLoginButton(LoginBloc bloc) {
    return RaisedButton(
      onPressed: () {
//        if (_loginFormKey.currentState.validate())
          bloc.login(
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
              "LOGIN",
              style: Theme.of(context).textTheme.button,
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(),
    );
  }

  TextFormField _buildPasswordField(LoginBloc bloc) {
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

  TextFormField _buildEmailField(LoginBloc bloc) {
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

}
