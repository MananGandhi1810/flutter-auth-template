import 'package:auth_template/presentation/auth/login_page.dart';
import 'package:auth_template/presentation/auth/register_page.dart';
import 'package:auth_template/providers/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'presentation/splash_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SplashPage(),
        routes: [],
      ),
      GoRoute(
        path: "/auth",
        routes: [
          GoRoute(
            path: "login",
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: "register",
            builder: (context, state) => const RegisterPage(),
          ),
        ],
        redirect: (context, state) {
          if (context.read<AuthProvider>().isLoggedIn) {
            return '/';
          } else {
            return null;
          }
        },
      ),
    ],
  );
}
