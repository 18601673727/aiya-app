import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// import 'common_widgets/error_screen.dart';
// import 'features/auth/ui/auth_screen.dart';
// import 'features/auth/ui/dashboard_screen.dart';
// import 'features/home/ui/home_screen.dart';
// import 'features/movies/ui/movies_paginated_screen.dart';
// import 'features/movies/ui/movies_screen.dart';
import 'screens/viewer.dart';
import 'screens/approvals.dart';
import 'screens/login.dart';
import 'screens/undefined.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  Approvals.route: (context) => const Approvals(),
  Login.route: (context) => const Login(),
  // ErrorScreen.route: (context) => ErrorScreen(),
};

Route<dynamic> appGeneratedRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Viewer.route:
      return PageTransition(child: const Viewer(), type: PageTransitionType.bottomToTop);
    default:
      return MaterialPageRoute(builder: (context) => Undefined(name: settings.name));
  }
}
