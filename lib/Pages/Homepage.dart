import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:night_bite/Pages/Login.dart';

import '../api/apis.dart'; // Make sure APIs.auth is properly initialized
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12, right: 10),
        child: FloatingActionButton(
          onPressed: () async {
            await APIs.auth.signOut(); // Ensure APIs.auth is correctly initialized
            await GoogleSignIn().signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Login()), // Navigate to LoginPage
            );
          },
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      body: Center( // Wrap the text in a Center widget for proper alignment
        child: Text("Kaarya pragati me hai"),
      ),
    );
  }
}
