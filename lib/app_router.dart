import 'package:auth_template/presentation/auth/reset_password_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'presentation/auth/otp_input_page.dart';
import 'presentation/auth/forgot_password_page.dart';
import 'presentation/auth/login_page.dart';
import 'presentation/auth/register_page.dart';
import 'providers/auth.dart';
import 'presentation/main/home_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomePage(),
        redirect: (context, state) async {
          if (!(await context.read<AuthProvider>().isLoggedIn)) {
            return '/auth/login';
          } else {
            return null;
          }
        },
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
          GoRoute(
            path: "forgot-password",
            builder: (context, state) => const ForgotPasswordPage(),
          ),
          GoRoute(
            path: "otp-input/:email",
            builder: (context, state) => OtpInputPage(
              email: state.pathParameters['email'] ?? "",
            ),
          ),
          GoRoute(
            path: "reset-password/:email/:token",
            builder: (context, state) => ResetPasswordPage(
              email: state.pathParameters['email'] ?? "",
              token: state.pathParameters['token'] ?? "",
            ),
          ),
        ],
        redirect: (context, state) async {
          if (await context.read<AuthProvider>().isLoggedIn) {
            return '/';
          } else {
            return null;
          }
        },
      ),
    ],
  );
}
