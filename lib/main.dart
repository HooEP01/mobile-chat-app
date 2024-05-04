import 'package:flutter/material.dart';
import '/bootstrap/app.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bootstrap/boot.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Nylo nylo = await Nylo.init(setup: Boot.nylo, setupFinished: Boot.finished);
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(
    AppBuild(
      navigatorKey: NyNavigator.instance.router.navigatorKey,
      onGenerateRoute: nylo.router!.generator(),
      debugShowCheckedModeBanner: false,
      initialRoute: nylo.getInitialRoute(),
      navigatorObservers: nylo.getNavigatorObservers(),
    ),
  );
}
