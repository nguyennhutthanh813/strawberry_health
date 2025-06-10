import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/constant/size.dart';

class MenuItemCategory extends StatefulWidget {
  const MenuItemCategory({
    super.key,
    required this.prefix,
    required this.text,
    required this.subitems,
  });

  final IconData prefix;
  final String text;
  final List<SubMenuItem> subitems;

  @override
  _MenuItemCategoryState createState() => _MenuItemCategoryState();
}

class _MenuItemCategoryState extends State<MenuItemCategory>
    with TickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
      height: (_expanded ? widget.subitems.length * 74 : 0) + 74,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            top: _expanded ? 74 : 10,
            child: Column(
              children: [...widget.subitems],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                    _expanded
                        ? animationController.forward()
                        : animationController.reverse();
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: TSize.defaultBorderRadius,
                    horizontal: TSize.defaultBorderRadius * 0.75,
                  ),
                  child: Row(
                    children: [
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.25).animate(
                          CurvedAnimation(
                            parent: animationController,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: Icon(widget.prefix),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.text,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.5).animate(
                          CurvedAnimation(
                            parent: animationController,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_downward,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SubMenuItem extends StatelessWidget {
  const SubMenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.endWidget,
  });

  final Widget endWidget;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 74,
      width: MediaQuery.of(context).size.width - TSize.defaultSpace,
      child: Material(
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
            ),
            padding: EdgeInsets.symmetric(
              vertical: TSize.defaultSpace,
              horizontal: TSize.defaultSpace * 0.75,
            ),
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(width: 20),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                endWidget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
