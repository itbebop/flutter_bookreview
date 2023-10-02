import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('디테일 Appbar'),
      ),
      body: const Center(
        child: Text(
          '디테일',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
