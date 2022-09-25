import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/utils/utils.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({
    Key? key,
    required this.onTapLogIn,
  }) : super(key: key);

  final Function() onTapLogIn;

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Sign up for free!', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 40),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) {
              return email != null && !EmailValidator.validate(email) ? 'Enter a valid email' : null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (password) {
              return password != null && password.length < 6 ? 'Password must be minimum 6 characters' : null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: signUp,
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            child: const Text('Sign up'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: widget.onTapLogIn,
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> signUp() async {
    final bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    Navigator.pop(context);
  }
}
