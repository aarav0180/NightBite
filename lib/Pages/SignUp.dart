import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Widgets/service_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 10,),
                    const Center(child: const Text("Login", style: TextStyle(color: Colors.black, fontSize: 54, fontWeight: FontWeight.bold,))),
                    const SizedBox(height: 30,),

                    //Text("Login", style: AppWidget.semiBoldTextStyle(),),

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
                        //controller: emailController,
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Email"),
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
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        //controller: emailController,
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Password"),
                      ),
                    ),

                    const SizedBox(height: 20,),

                    Container(
                      margin:const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Forget Password ?", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20,),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding:const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
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
                            padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(color:const Color.fromRGBO(193,216,195,1), borderRadius: BorderRadius.circular(15) ),
                            child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Signup()) );
                                },
                                child: const Text("New User ?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),)),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 30,),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20, ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(color: const Color.fromRGBO(205,92,8,1), borderRadius: BorderRadius.circular(14)),
                      child: Center(child: Text("Login", style: AppWidget.semiBoldTextStyle(),)),
                    ),

                    SizedBox(height: 30,),

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
