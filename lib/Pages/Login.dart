import 'package:flutter/material.dart';
import 'package:night_bite/Widgets/service_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Color.fromRGBO(255,245,228,1),
      body: SingleChildScrollView(
        child: Container(
          //margin:const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Image.asset("image/logoblack.png"),
              //const SizedBox(height: 10,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Color.fromRGBO(106,156,137,1), borderRadius: BorderRadius.only(topLeft: Radius.circular(41), topRight: Radius.circular(41))),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("Login", style: AppWidget.boldTextfieldStyle(),),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
