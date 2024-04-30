import 'package:flutter/material.dart';
import '/resources/pages/chat_page.dart';
import '/resources/pages/portfolio_page.dart';
import '/resources/widgets/logo_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'controller.dart';

class HomeController extends Controller {

  onTapPortfolio() {
    routeTo(PortfolioPage.path);
  }

  onTapGithub() async {
    await launchUrl(Uri.parse("https://github.com/HooEP01"));
  }

  onTapLinkedln() async {
    await launchUrl(Uri.parse("https://www.linkedin.com/in/hoo-ern-ping-a542b9261/"));
  }

  onTapChat() {
    routeTo(ChatPage.path);
  }

  showAbout() {
    showAboutDialog(
      context: context!,
      applicationName: getEnv('APP_NAME'),
      applicationIcon: const Logo(),
      applicationVersion: nyloVersion,
    );
  }
}
