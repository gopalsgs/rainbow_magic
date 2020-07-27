import 'package:flutter/material.dart';
import 'package:magic/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRDisplayPage extends StatelessWidget {

  final value;
  const QRDisplayPage({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${EnvironmentConfig.APP_NAME}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Text('$value',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),),
          ),
          Container(
            child: Center(
              child: QrImage(
                data: '$value',
                version: QrVersions.auto,
                size: 250.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
