import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/common/widget/divider.dart';
import 'package:strawberry_disease_detection/constant/size.dart';
import 'package:strawberry_disease_detection/common/widget/glass.dart';
import 'package:strawberry_disease_detection/common/widget/button.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    super.key,
    required this.title,
    required this.text,
    required this.child
  });
  final String title;
  final String text;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 200,
        child: Column(
          children: [
            Glass(
              sigma: 20,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(TSize.defaultBorderRadius)),
              child: Container(
                height: 110,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(TSize.defaultBorderRadius)
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 230,
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),

              ),
            ),
            Glass(
                sigma: 6,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(TSize.defaultBorderRadius)),
                child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: TSize.defaultSpace / 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(TSize.defaultBorderRadius)
                      )
                    ),
                    child: child,

                )
            )
          ],
        ),
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.onPressed,
    required this.title
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
        title: title,
        text: "You can't undo this action",
        child: Row(
          children: [
            Expanded(
                child: SecondaryButton(
                    text: "Cancel", onPressed: () => Navigator.pop(context))),
            DividerWidget(),
            Expanded(
              child: SecondaryButton(
                text: 'Delete',
                color: Theme.of(context).colorScheme.error,
                onPressed: () {
                  onPressed();
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ));
  }
}