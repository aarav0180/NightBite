import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _HomepageState();
}

class _HomepageState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: const Text("Kaarya pragati me hai order waala")),
    );
  }
}