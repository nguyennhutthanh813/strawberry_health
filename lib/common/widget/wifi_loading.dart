import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';

class WifiLoading extends StatelessWidget {
  const WifiLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingBouncingLine.circle(
        borderColor: Colors.green,
        backgroundColor: Colors.green,
        size: 50.0,
      ),
    );
  }
}
