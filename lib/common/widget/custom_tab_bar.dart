import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/constant/size.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key, required TabController tabController, required this.tabTexts})
      : _tabController = tabController;

  final TabController _tabController;
  final List<String> tabTexts;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSize.defaultBorderRadius * 2),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(TSize.defaultBorderRadius * 2),
        ),
        labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        unselectedLabelColor: Theme.of(context).colorScheme.onSecondary,
        tabs: [
          ...tabTexts.map((text) => Tab(
            text: text,
          ))
        ],
      ),
    );
  }
}