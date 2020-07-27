import 'dart:math';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:magic/features/home/ui/widgets/custom_drawer.dart';
import 'package:magic/features/home/ui/widgets/vibgyor.dart';
import 'package:magic/main.dart';
import 'package:package_info/package_info.dart';


class HomePage extends StatefulWidget {
  final FirebaseUser user;

  const HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String appVersion;
  String bundleId;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getPackageInfo();
    super.initState();
  }

  getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
      bundleId = packageInfo.packageName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      appVersion: appVersion,
      bundleId: bundleId,
      user: widget.user,
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          appBar: _buildAppBar(context),
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('AppName: ${EnvironmentConfig.APP_NAME}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text('BundleId: $bundleId',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text('UserId: ${widget.user.email}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Vibgyor(scaffoldKey:scaffoldKey)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('${EnvironmentConfig.APP_NAME}'),
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => CustomDrawer.of(context).open(),
          );
        },
      ),
      centerTitle: true,
    );
  }

}





