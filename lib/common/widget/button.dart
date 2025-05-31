import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/constant/size.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.color});
  final Widget text;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(TSize.defaultBorderRadius)),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
                onTap: () {
                  onPressed();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: text,
                  padding:
                  EdgeInsets.symmetric(horizontal: TSize.defaultSpace / 2),
                ))));
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color
  });

  final String text;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(TSize.defaultBorderRadius)),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
                onTap: () {
                  onPressed();
                },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: TSize.defaultSpace / 2),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: color ?? Theme.of(context).colorScheme.primary,
                      ),

                    )
                )
            )
        )
    );
  }
}

// ignore: must_be_immutable
class IconButtonWidget extends StatefulWidget {
  IconButtonWidget({
    super.key,
    this.onPressed,
    this.color,
    required this.icon,
  });

  final Color? color;
  final IconData icon;
  final Function? onPressed;
  late Function onTap;
  set setonTap(func) {
    onTap = func;
  }

  @override
  _IconButtonWidgetState createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.onPressed != null) {
      widget.onTap = widget.onPressed!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color ?? Theme.of(context).colorScheme.primary),
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                  splashColor: Colors.transparent,
                  customBorder: CircleBorder(),
                  onTap: () {
                    widget.onTap();
                  },
                  child: Icon(
                    widget.icon,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
              )
          )
      ),
    );
  }
}