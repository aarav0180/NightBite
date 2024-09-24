import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:night_bite/Pages/bottomNav.dart';
import '../api/apis.dart';
import '../main.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>{
  Color hexToColor(String hexCode) {
    return Color(int.parse(hexCode.substring(1, 7), radix: 16) + 0xFF000000);
  }
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), (){
      //To exit full screen
      SystemChrome.setEnabledSystemUIMode((SystemUiMode.edgeToEdge));
      //Status bar can be customized too
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      //To Navigate to home screen or login screen
      if(FirebaseAuth.instance.currentUser != null){
        print('\nUser: ${APIs.auth.currentUser}\n');
        Navigator.pushReplacement((context), MaterialPageRoute(builder: (_)=>BottomNav()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>Login()));
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    //  Initialising media query
    mq = MediaQuery.of(context).size;


    return Scaffold(
      body: Container(
        color: hexToColor('#ffe6cc'),
        child: Stack(
          children: [

            Positioned(
              top: mq.height * .2,
              width: mq.width * .95,
              right: mq.width * .006,
              child: Image.asset('image/logoblack.png'),
            ),
            // Positioned(
            //   bottom: mq.height * .15,
            //   left: mq.width * .35,
            //   width: mq.width,
            //   child: Text("Made By",style: TextStyle(
            //       fontSize:30,
            //       fontWeight: FontWeight.w500,
            //       fontFamily: 'Font1',
            //       color: Colors.black
            //   ),),
            // ),
            Positioned(
              bottom: mq.height * .08,
              left: mq.width * .32,
              width: mq.width * .99999,
              child: Text("𝑫𝒆𝒗𝑨𝒍𝒄𝒉𝒆𝒎𝒊𝒔𝒕𝒔",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Font1',
                  color: Colors.black
              ),),
            ),
          ],
        ),
      ),
    );
  }
}