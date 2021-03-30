
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Orders'
        ),
      ),
      body: Center(
        child: Text('No orders yet'),
      ),
    );
  }
}