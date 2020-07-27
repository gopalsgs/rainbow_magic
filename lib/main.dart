
import 'package:flutter/material.dart';

import 'features/useraccess/ui/splash_screen.dart';


class EnvironmentConfig {
  static const BUNDLE_ID_SUFFIX = String.fromEnvironment('BUNDLE_ID_SUFFIX');
  static const APP_NAME = String.fromEnvironment('APP_NAME');
}

class Const{
  static const BETA = 'beta';
  static const PROD = 'prod';
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${EnvironmentConfig.APP_NAME}',
      debugShowCheckedModeBanner: false,
      theme: EnvironmentConfig.BUNDLE_ID_SUFFIX == Const.BETA ? _getThemeDataDev() : _getThemeDataProd(),
      home: SplashScreenPage(),
    );
  }


  ThemeData _getThemeDataProd() {
    Color color = Colors.black;
    return ThemeData(

      primarySwatch: Colors.grey,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      brightness: Brightness.light,
      primaryColor: color,

      textTheme: textTheme(color),

      buttonColor: Colors.red,

      inputDecorationTheme: inputDecorationTheme(color),

    );
  }

  ThemeData _getThemeDataDev() {
    Color color = Colors.blue;

    return ThemeData(

      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      brightness: Brightness.light,
      primaryColor: Colors.blue,

      textTheme: textTheme(color),

      buttonColor: color,

      inputDecorationTheme: inputDecorationTheme(color),

    );
  }


  TextTheme textTheme(Color color) {
    return TextTheme(
      headline4: TextStyle(
          color: color
      ),
      button: TextStyle(
          color: Colors.white
      ),
    );
  }

  InputDecorationTheme inputDecorationTheme(Color color) {
    return InputDecorationTheme(
        filled: true,
        fillColor: color.withOpacity(0.2),
        contentPadding: EdgeInsets.all(12),
        focusedErrorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusColor: Colors.red
    );
  }


}




