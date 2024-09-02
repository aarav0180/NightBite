import 'package:flutter/material.dart';
import 'package:night_bite/Pages/SignUp.dart';
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
      backgroundColor:const Color.fromRGBO(255,245,228,1),
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
                height: MediaQuery.of(context).size.height/1.8,
                decoration: const BoxDecoration(color: Color.fromRGBO(106,156,137,1), borderRadius: BorderRadius.only(topLeft: Radius.circular(41), topRight: Radius.circular(41))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 10,),
                    const Center(child: const Text("Login", style: TextStyle(color: Colors.black, fontSize: 54, fontWeight: FontWeight.bold,))),
                    const SizedBox(height: 20,),

                    //Text("Login", style: AppWidget.semiBoldTextStyle(),),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    
                    const SizedBox(height: 30,),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forget Password", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                      ],
                    ),

                    const SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account ?", style: AppWidget.lightTextStyle(),),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Signup()) );
                            },
                            child: const Text("SignUp", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500, fontSize: 18),))
                      ],
                    ),

                    const SizedBox(height: 30,),
                    
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: const Color.fromRGBO(193,216,195,1), borderRadius: BorderRadius.circular(14)),
                      child: Text("Login", style: AppWidget.semiBoldTextStyle(),),
                    ), 

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

//Color.fromRGBO(193,216,195,1)
