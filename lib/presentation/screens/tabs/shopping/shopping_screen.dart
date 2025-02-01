import 'package:flutter/material.dart';

class ShoppingScreen extends StatelessWidget {

  static const name = 'shopping-screen';
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Shopping Screen'),
      ),
    );
  }
}