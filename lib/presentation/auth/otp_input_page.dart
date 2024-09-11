import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../models/network_response.dart';
import '../../providers/auth.dart';

class OtpInputPage extends StatefulWidget {
  const OtpInputPage({super.key, required this.email});

  final String email;

  @override
  State<OtpInputPage> createState() => _OtpInputPageState();
}

class _OtpInputPageState extends State<OtpInputPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _otpController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        NetworkResponseModel response =
            await context.read<AuthProvider>().verifyOtp(
                  widget.email,
                  _otpController.text,
                );
        ScaffoldMessenger.of(context).clearSnackBars();
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message),
              backgroundColor: Colors.green,
            ),
          );
          context.go(
              "/auth/reset-password/${widget.email}/${response.data['token']}");
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify OTP"),
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
                Pinput(
                  length: 6,
                  controller: _otpController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "OTP must not be empty";
                    }
                    if (value.length != 6) {
                      return "OTP must be of 6 digits";
                    }
                    return null;
                  },
                  defaultPinTheme: PinTheme(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 28,
                    ),
                    height: 60,
                    width: 100,
                  ),
                  autofocus: true,
                  onCompleted: (_) => _submit(),
                ),
                const Gap(12),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Verify OTP"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
