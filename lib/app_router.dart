import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => const Placeholder()),
    ],
  );
}
