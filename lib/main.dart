import "package:flutter/material.dart";
import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';
import 'package:heartstone_task/screens/main_screen.dart';
import 'package:package_info/package_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppCenter.startAsync(
    appSecretAndroid:
        '42cc4a5d-35e5-4ed5-b605-a0424bd90f64', // Replace when you've created Android app in AppCenter.ms
    appSecretIOS:
        'AppCenter GUID', // Replace when you've created iOS app in AppCenter.ms
    enableDistribute: true,
  );
  await AppCenter.configureDistributeDebugAsync(enabled: false);
  runApp(MyFlutterApp());
}

class MyFlutterApp extends StatefulWidget {
  MyFlutterApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyFlutterApp> {
  PackageInfo _packageInfo;
  bool _isCrashesEnabled;
  bool _isAnalyticsEnabled;
  bool _isDistributeEnabled;

  @override
  void initState() {
    super.initState();
    AppCenter.trackEventAsync('_MyAppState.initState');
    PackageInfo.fromPlatform().then((v) {
      setState(() {
        _packageInfo = v;
      });
    });
    AppCenter.isCrashesEnabledAsync().then((v) {
      setState(() {
        _isCrashesEnabled = v;
      });
    });
    AppCenter.isAnalyticsEnabledAsync().then((v) {
      setState(() {
        _isAnalyticsEnabled = v;
      });
    });
    AppCenter.isDistributeEnabledAsync().then((v) {
      setState(() {
        _isDistributeEnabled = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My first app.",
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: MainScreen(),
          ),
        ));
  }
}
