import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:night_bite/Pages/order.dart';
import 'package:night_bite/Pages/home.dart';
import 'package:night_bite/Pages/profile.dart';
import 'package:night_bite/api/apis.dart';



class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  late List<Widget> Pages;

  late HomePage home;

  late Orders order;
  late ProfileScreen profile;
  int currentTabIndex=0;
  bool _isInitialized = false; // Add a flag to track initialization

  @override
  void initState() {
    super.initState();
    // Initialize the user info and setup the screens
    _initialize();
  }

  Future<void> _initialize() async {
  await APIs.getSelfInfo();
  setState(() {
  order = Orders();
  home = HomePage();
  profile = ProfileScreen(user: APIs.me);
  Pages = [home, order,  profile];
  _isInitialized = true;
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: CurvedNavigationBar(
          height: 70,
          backgroundColor: const Color(0xfff2f2f2),
          color: Colors.black,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (int index){
            setState(() {
              currentTabIndex = index;
            });
          },
          items: const [
            Icon(Icons.home_outlined, color: Colors.white,),
            Icon(Icons.shopping_cart_outlined, color: Colors.white,),
            Icon(Icons.person_outlined, color: Colors.white,)
          ],),
      ),
      body: Pages[currentTabIndex],
    );
  }
}