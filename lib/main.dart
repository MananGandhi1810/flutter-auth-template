import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';

void main() {
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: ThemeData.dark(useMaterial3: true),
      ),
    );
  }
}
