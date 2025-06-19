import 'package:flutter/material.dart';

class SensorRow extends StatelessWidget{
  const SensorRow({
    super.key,
    required this.imagePath,
    required this.title,
    required this.value,
  });
  final String imagePath;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 32,
            height: 32,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

}