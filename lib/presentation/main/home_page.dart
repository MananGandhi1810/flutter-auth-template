import 'package:auth_template/main.dart';
import 'package:auth_template/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Text("Welcome, ${context.watch<AuthProvider>().user?.name}"),
      ),
    );
  }
}
