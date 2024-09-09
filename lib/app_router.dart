import 'package:go_router/go_router.dart';

import 'presentation/splash_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SplashPage(),
      ),
    ],
  );
}
