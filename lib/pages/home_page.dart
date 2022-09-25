import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Signed in as', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 5),
                Text(user.email!, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Sign out'),
                ),
              ],
            ),
          )),
    );
  }
}
