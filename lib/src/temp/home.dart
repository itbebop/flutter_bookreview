import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            context.go('/detail');
          },
          child: const Text(
            '홈',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
