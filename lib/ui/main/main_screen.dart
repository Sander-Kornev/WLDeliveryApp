
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Restaurants'
        ),
      ),
      body: Center(
        child: Text('No restaurants yet'),
      ),
    );
  }
}