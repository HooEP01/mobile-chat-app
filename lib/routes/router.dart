import '/resources/pages/auth_page.dart';
import 'package:flutter_app/routes/guards/auth_route_guard.dart';

import '/resources/pages/profile_page.dart';
import '/resources/pages/chat_page.dart';
import '/resources/pages/portfolio_page.dart';
import '/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
| Learn more https://nylo.dev/docs/5.20.0/router
|-------------------------------------------------------------------------- */

appRouter() => nyRoutes((router) {
  router.route(HomePage.path, (context) => HomePage(), initialRoute: true);

  // Add your routes here

  // router.route(NewPage.path, (context) => NewPage(), transition: PageTransitionType.fade);

  // Example using grouped routes
  router.group(() => {
    "route_guards": [AuthRouteGuard()],
    "prefix": ""
  }, (router) {
    router.route(ChatPage.path, (context) => ChatPage());
    router.route(ProfilePage.path, (context) => ProfilePage());
  });

  router.route(PortfolioPage.path, (context) => PortfolioPage());
  
  router.route(AuthPage.path, (context) => AuthPage(), authPage: true);
});