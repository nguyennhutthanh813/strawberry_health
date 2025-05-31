import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/constant/size.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.prefix,
    required this.text
  });

  final IconData prefix;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
        onTap: () {},
        child: Container(
          height: 74,
          padding: EdgeInsets.symmetric(
              vertical: TSize.defaultSpace, horizontal: TSize.defaultSpace * 0.75),
          child: Row(
            children: [
              Icon(prefix),
              SizedBox(width: 20),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_right,
                size: 22,
              )
            ],
          ),
        ),
      ),
    );
  }
}