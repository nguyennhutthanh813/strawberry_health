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
    return PreferredSize(
      preferredSize: Size.fromHeight(TSize.defaultSpace * 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TSize.defaultBorderRadius * 2),
        child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.green.shade100,
          ),
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(TSize.defaultBorderRadius / 2),
              color: Colors.green.shade600
            ),
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.black54,
            tabs: [
              ...tabTexts.map((text) => Tab(
                text: text,
              ))
            ],
          ),
        ),
      ),
    );
  }
}