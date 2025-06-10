import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/common/widget/divider.dart';
import 'dart:math';
import 'package:strawberry_disease_detection/constant/size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strawberry_disease_detection/model/plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strawberry_disease_detection/service/plant_service.dart';
import 'package:strawberry_disease_detection/common/widget/custom_tab_bar.dart';
import 'package:strawberry_disease_detection/common/widget/sort_menu.dart';
import 'package:strawberry_disease_detection/common/widget/menu_item.dart';
import 'package:strawberry_disease_detection/common/widget/menu_item_category.dart';
import 'package:strawberry_disease_detection/common/widget/button.dart';
import 'package:strawberry_disease_detection/common/widget/dialog.dart';
import 'package:strawberry_disease_detection/common/widget/history_plant.dart';

class PlantPage extends StatefulWidget {
  const PlantPage({super.key});

  @override
  _PlantPageState createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PlantService _plantService = PlantService();
  List<Plant> plants = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _loadPlants();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<void> _loadPlants() async {
    List<Plant> fetchedPlants = await _plantService.getAllPlants();
    setState(() {
      plants = fetchedPlants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.only(top: TSize.defaultSpace, bottom: TSize.defaultSpace / 2),
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: TSize.defaultSpace / 2),
          child: CustomTabBar(
            tabController: _tabController,
            tabTexts: ['My Plants', 'History'],
          )
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: TSize.defaultSpace / 2),
              child: Column(
                children: [
                  Container(
                    height: 54,
                    margin: EdgeInsets.symmetric(vertical: TSize.defaultSpace),
                    child: Row(children: [
                      Expanded(
                        child: SearchBar(
                          hintText: "Search",
                        ),
                      ),
                      SizedBox(width: 20),
                      SortMenuBox(options: [
                          SortItem(text: 'Date'),
                          SortItem(text: 'Alphabet')
                      ]),
                    ]),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
                      child: MyPlants(plantList: plants),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: TSize.defaultSpace / 2),
              child: Column(
                children: [
                  Container(
                    height: 54,
                    margin: EdgeInsets.only(top: TSize.defaultSpace),
                    child: Row(children: [
                      Expanded(
                        child: SearchBar(
                          hintText: "Search",
                        ),
                      ),
                      SizedBox(width: 20),
                      SortMenuBox(options: [
                        SortItem(text: 'Latest'),
                        SortItem(text: 'Oldest')
                      ])
                    ]),
                  ),
                  Container(
                      height: 34,
                      margin:
                      EdgeInsets.symmetric(vertical: TSize.defaultSpace / 2),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(TSize.defaultBorderRadius),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ButtonWidget(
                                text: Text('Disease',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary)),
                                onPressed: () {},
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              DividerWidget(),
                              ButtonWidget(
                                  text: Text('Clear All',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary)),
                                  color: Theme.of(context).colorScheme.error,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DeleteDialog(
                                              onPressed: () {
                                                plants.clear();
                                              },
                                              title:
                                              'Do you want to clear history?');
                                        });
                                  })
                            ]),
                      )),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
                      child: HistoryPlants(plantList: plants),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ]),
    );
  }
}