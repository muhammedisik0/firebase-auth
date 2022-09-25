import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/pages/reset_password_page.dart';
import 'package:firebase_authentication/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
    required this.onTapSignUp,
  }) : super(key: key);

  final Function() onTapSignUp;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Hey there, welcome back!', style: TextStyle(fontSize: 24)),
        const SizedBox(height: 40),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: signIn,
          style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
          child: const Text('Log in'),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
          ),
          child: const Text(
            'Forgot password?',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No account?'),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: widget.onTapSignUp,
              child: const Text(
                'Sign up',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    Navigator.pop(context);
  }
}
