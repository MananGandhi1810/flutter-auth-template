import 'package:auth_template/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (!mounted) {
                return;
              }
              context.go('/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text("Welcome, ${context.watch<AuthProvider>().user?.name}"),
      ),
    );
  }
}
