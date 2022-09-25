import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Reset your password!', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  return email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetPassword,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: const Text('Reset Password'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) => const Center(child: CircularProgressIndicator())),
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password reset email was sent.', Colors.green);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
