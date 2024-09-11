import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import 'app_router.dart';

void main() {
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
          lazy: false,
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: AppRouter(context.watch<AuthProvider>()).getRouter(),
            theme: ThemeData.dark(useMaterial3: true),
          );
        }
      ),
    );
  }
}
