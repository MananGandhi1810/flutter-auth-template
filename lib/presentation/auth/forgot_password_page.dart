import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../utils/validators.dart';
import '../../models/network_response.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
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
                TextButton(
                  onPressed: () {
                    context.pushReplacement("/auth/login");
                  },
                  child: const Text("Came here by mistake? Login"),
                ),
                const Gap(8),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        NetworkResponseModel response = await context
                            .read<AuthProvider>()
                            .requestPasswordReset(
                              _emailController.text,
                            );
                        ScaffoldMessenger.of(context).clearSnackBars();
                        if (response.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(response.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                          context
                              .push("/auth/otp-input/${_emailController.text}");
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
                  child: const Text("Get OTP"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
