import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:night_bite/Pages/bottomNav.dart';
import 'package:night_bite/Pages/home.dart';
import 'package:night_bite/Pages/Login.dart';
import 'package:random_string/random_string.dart';

import '../Widgets/service_widget.dart';
import '../services/database.dart';
import '../services/shared_pref.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  String? name, email, password;
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async{
    name = nameController.text;
    email = emailController.text;
    password=passwordController.text;

    if (password!=null && name!=null && email!=null){
      try{
        UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text("registered Successfully", style: TextStyle(color: Colors.black, fontSize: 16))));

        Navigator.push(context,MaterialPageRoute(builder: (context) => BottomNav()) );


        //Adding data to database firebase
        String Id= randomAlphaNumeric(10);

        await SharedPreferenceHelper().saveUserEmail(emailController.text);
        await SharedPreferenceHelper().saveUserName(nameController.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserImage("https://firebasestorage.googleapis.com/v0/b/perfectnew-cc234.appspot.com/o/androgynous-avatar-non-binary-queer-person.jpg?alt=media&token=7a864647-6db0-4544-8753-7dcc00f56feb");


        Map<String, dynamic> userInfoMap= {
          "Name": nameController.text,
          "Email": emailController.text,
          "Password": passwordController.text,
          "Id": Id,
          "Image": "https://firebasestorage.googleapis.com/v0/b/perfectnew-cc234.appspot.com/o/androgynous-avatar-non-binary-queer-person.jpg?alt=media&token=7a864647-6db0-4544-8753-7dcc00f56feb"

        };
        await DatabaseMethods().addUserDetails(userInfoMap, Id);



      }on FirebaseException catch(e) {
        if(e.code=="weak-password"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("password provided is too weak", style: TextStyle(color: Colors.black, fontSize: 16))));
        }

        else if(e.code=="email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text("account already exist", style: TextStyle(color: Colors.black, fontSize: 16))));

        }
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor:const Color.fromRGBO(255,245,228,1),
      body: SingleChildScrollView(

        child: Container(
          //padding:const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Image.asset('image/logoblack.png'),
              //const SizedBox(height: 10,),


              Container(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height/1.8,
                decoration: const BoxDecoration(color: Color.fromRGBO(106,156,137,1), borderRadius: BorderRadius.only(topLeft: Radius.circular(41), topRight: Radius.circular(41))),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 10,),
                      const Center(child: const Text("Sign Up", style: TextStyle(color: Colors.black, fontSize: 54, fontWeight: FontWeight.bold,))),
                      const SizedBox(height: 30,),

                      //Text("Login", style: AppWidget.semiBoldTextStyle(),),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        decoration: BoxDecoration(color: const Color.fromRGBO(255,245,228,1), borderRadius: BorderRadius.circular(14)),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(border: InputBorder.none, hintText: "Name"),
                        ),
                      ),

                      const SizedBox(height: 30,),

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
                          decoration: InputDecoration(border: InputBorder.none, hintText: "Email"),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        decoration: BoxDecoration(color: const Color.fromRGBO(255,245,228,1), borderRadius: BorderRadius.circular(14)),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: passwordController,
                          decoration: InputDecoration(border: InputBorder.none, hintText: "Password"),
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(color: const Color.fromRGBO(193,216,195,1), borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [

                                  SvgPicture.asset('image/google.svg', height: 30, width: 30,),
                                  SizedBox(width: 9,),
                                  Text("Google", style: TextStyle(color: Colors.black, fontSize: 18),),
                                ],),
                            ),

                            SizedBox(width: 40,),
                            //Text("Don't have an account ?", style: AppWidget.lightTextStyle(),),
                            Container(
                              padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(color:const Color.fromRGBO(193,216,195,1), borderRadius: BorderRadius.circular(15) ),
                              child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => Login()) );
                                  },
                                  child: const Text("Existing User ?", style: TextStyle(color: Colors.black, fontSize: 16),)),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(height: 30,),

                      GestureDetector(
                        onTap: () {
                          if(_formkey.currentState!.validate()){
                            setState(() {

                              registration();
                            });
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 20, ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: const Color.fromRGBO(205,92,8,1), borderRadius: BorderRadius.circular(14)),
                          child: Center(child: Text("Sign Up", style: AppWidget.semiBoldTextStyle(),)),
                        ),
                      ),

                      SizedBox(height: 30,),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
