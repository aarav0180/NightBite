import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widgets/service_widget.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(193,216,195,1),

      appBar: AppBar(backgroundColor: const Color.fromRGBO(106,156,137,1),title: Text("Forgot Password", style: TextStyle(color: Colors.black, fontSize: 24)),),

      body: Container(
        child: Column(
          children: [
            SizedBox(height: 60,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              decoration: BoxDecoration(color: const Color.fromRGBO(255,245,228,1), borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(border: InputBorder.none, hintText: "Enter email"),
              ),
            ),
            const SizedBox(height: 40,),

            GestureDetector(
              onTap: () {
                auth.sendPasswordResetEmail(email: emailController.text).then((
                    value) {
                  Fluttertoast.showToast(
                      msg: "Reset Email Sent",
                      toastLength: Toast.LENGTH_SHORT,
                      // or Toast.LENGTH_LONG
                      gravity: ToastGravity.BOTTOM,
                      // Position: top, bottom, center
                      timeInSecForIosWeb: 1,
                      // Duration for iOS and Web
                      backgroundColor: Colors.black,
                      // Background color
                      textColor: Colors.white,
                      // Text color
                      fontSize: 16.0 // Font size
                  );
                }).onError((error, stackTrace) {
                  Fluttertoast.showToast(
                      msg: error.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      // or Toast.LENGTH_LONG
                      gravity: ToastGravity.BOTTOM,
                      // Position: top, bottom, center
                      backgroundColor: Colors.black,
                      // Background color
                      textColor: Colors.white,
                      // Text color
                      fontSize: 16.0 // Font size
                  );
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20, ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: const Color.fromRGBO(205,92,8,1), borderRadius: BorderRadius.circular(14)),
                child: Center(child: Text("Reset Password", style: AppWidget.semiBoldTextStyle(),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
