import 'package:flutter/material.dart';

class Undefined extends StatelessWidget {
  final String? name;
  const Undefined({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}
