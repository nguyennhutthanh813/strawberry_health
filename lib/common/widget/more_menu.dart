import 'package:strawberry_disease_detection/common/widget/drop_down_box.dart';
import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/constant/size.dart';
class MoreMenuBox extends DropDownBox {
  MoreMenuBox({
    super.key,
    required this.options,
  }) : super(button: MoreButton(), childWidth: 120);

  final List<MoreItem> options;
  final double boxWidth = 120;

  @override
  MoreMenuBoxState createState() => MoreMenuBoxState();
}

class MoreMenuBoxState extends DropDownBoxState<MoreMenuBox> {
  int selectedIndex = 0;
  @override
  Widget buildChildWidget(AnimationController animationController,
      OverlayEntry _overlayEntry, BuildContext context) {
    return Container(
      width: widget.boxWidth,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: Theme.of(context).scaffoldBackgroundColor)
          ],
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(TSize.defaultBorderRadius)
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.options
              .map((_filterItem) => MoreItem(
            text: _filterItem.text,
            onPressed: () {},
            red: _filterItem.red,
          ))
              .toList()),

    );
  }
}

class MoreItem extends StatelessWidget {
  final String text;
  final bool red;
  final VoidCallback? onPressed;

  const MoreItem({
    super.key,
    required this.text,
    this.onPressed,
    this.red = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
            onTap: () {
              onPressed!();
            },
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: TSize.defaultSpace * 0.6,
                    horizontal: TSize.defaultSpace * 0.6),
                child: Row(
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: red
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.onBackground,
                        fontSize: 16,
                      ),
                    ),
                    Spacer()
                  ],
                )
            )
        )
    );
  }
}

//ignore: must_be_immutable
class MoreButton extends StatelessWidget {
  MoreButton({super.key});
  late Function onTap;
  set setonTap(func) {
    onTap = func;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 30,
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(TSize.defaultBorderRadius / 2),
                onTap: () {
                  onTap();
                },
                child: Icon(
                  Icons.more,
                )
            )
        )
    );
  }
}