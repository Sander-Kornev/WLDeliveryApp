
// Settings Page
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Cart'
        ),
      ),
      body: Center(
        child: Text('Cart is empty'),
      ),
    );
  }
}