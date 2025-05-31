import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/common/widget/drop_down_box.dart';
import 'package:strawberry_disease_detection/constant/size.dart';
import 'package:strawberry_disease_detection/common/widget/button.dart';
import 'package:strawberry_disease_detection/common/widget/check_mark.dart';

class SortMenuBox extends DropDownBox {
  SortMenuBox({
    Key? key,
    required this.options,
  }) : super(
      key: key,
      button: IconButtonWidget(icon: Icons.sort),
      childWidth: 180);
  final List<SortItem> options;
  final double boxWidth = 180;

  @override
  SortMenuBoxState createState() => SortMenuBoxState();
}

class SortMenuBoxState extends DropDownBoxState<SortMenuBox> {
  int selectedIndex = 0;
  @override
  Widget buildChildWidget(AnimationController animationController,
      OverlayEntry _overlayEntry, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: widget.boxWidth,
          padding: EdgeInsets.only(bottom: TSize.defaultSpace / 2),
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
              children: widget.options
                  .map((_filterItem) => SortItem(
                  text: _filterItem.text,
                  active:
                  selectedIndex == widget.options.indexOf(_filterItem),
                  onPressed: () async {
                    selectedIndex = widget.options.indexOf(_filterItem);
                    debugPrint(selectedIndex.toString());
                    await animationController.reverse();
                    _overlayEntry.remove();
                  }))
                  .toList()),

        ),
        Positioned(
            bottom: -18,
            child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: TSize.defaultSpace * 0.3,
                    horizontal: TSize.defaultSpace * 0.8
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(TSize.defaultBorderRadius)
                ),
                child: Center(
                  child: Text(
                    'Sort by:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
            )
        )
      ],
    );
  }
}

class SortItem extends StatelessWidget {
  const SortItem({
    super.key,
    required this.text,
    this.onPressed,
    this.active = false
  });
  final String text;
  final bool active;
  final VoidCallback? onPressed;
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
                    vertical: TSize.defaultSpace * 0.75,
                    horizontal: TSize.defaultSpace * 0.5),
                child: Row(children: [
                      active
                      ? CheckMark()
                      : SizedBox(
                    width: 20,
                  ),
                  SizedBox(width: 10),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Spacer()
                ])
            )
        )
    );
  }
}