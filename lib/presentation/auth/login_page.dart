import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../utils/validators.dart';
import '../../models/network_response.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text("Email"),
                  ),
                  validator: (value) {
                    if (!Validators.validateEmail(value ?? "")) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: const Text("Password"),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                ),
                const Gap(12),
                TextButton(
                  onPressed: () {
                    context.pushReplacement("/auth/register");
                  },
                  child: const Text("Don't have an account? Register"),
                ),
                const Gap(8),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        NetworkResponseModel response =
                            await context.read<AuthProvider>().login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                        if (response.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response.message),
                              backgroundColor: Colors.red[400],
                            ),
                          );
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    }
                  },
                  child: const Text("Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
