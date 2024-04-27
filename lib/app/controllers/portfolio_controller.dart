import 'package:flutter/material.dart';
import '/resources/widgets/logo_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'controller.dart';

class PortfolioController extends Controller {

  showAbout() {
    showAboutDialog(
      context: context!,
      applicationName: getEnv('APP_NAME'),
      applicationIcon: const Logo(),
      applicationVersion: nyloVersion,
    );
  }
}
