import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:strawberry_disease_detection/constant/size.dart';
import 'package:strawberry_disease_detection/common/widget/more_menu.dart';
import 'package:strawberry_disease_detection/model/plant.dart';

class HistoryPlants extends StatefulWidget {
  const HistoryPlants({
    super.key,
    required this.plantList
  });
  final List<Plant> plantList;

  @override
  _HistoryPlantsState createState() => _HistoryPlantsState();
}

class _HistoryPlantsState extends State<HistoryPlants> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.plantList.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 15,
      ),
      itemBuilder: (context, index) {
        Plant _plantCard = widget.plantList[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
          child: Dismissible(
            background: removeWidget(),
            secondaryBackground: addWidget(),
            key: ValueKey(_plantCard),
            child: PlantTile(
              plantCard: _plantCard,
              packed: true,
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                widget.plantList.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }

  removeWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: TSize.defaultSpace / 2),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
          color: Theme.of(context).colorScheme.error
      ),
      child: Text(
        'Remove',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),

    );
  }

  addWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: TSize.defaultSpace / 2),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
          color: Theme.of(context).colorScheme.primary
      ),
      child: Text(
        'Add',
        style: TextStyle(
            color: Theme.of(context).colorScheme.onError,
            fontSize: 32,
            fontWeight: FontWeight.bold),
      ),

    );
  }
}

class MyPlants extends StatefulWidget {
  const MyPlants({
    super.key,
    required this.plantList
  });

  final List<Plant> plantList;

  @override
  _MyPlantsState createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.plantList.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 15,
      ),
      itemBuilder: (context, index) {
        Plant _plantCard = widget.plantList[index];
        return ClipRRect(
            borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
            child: PlantTile(plantCard: _plantCard));
      },
    );
  }
}

class PlantTile extends StatelessWidget {
  const PlantTile({
    super.key, required Plant plantCard, this.packed = false
  }) : _plantCard = plantCard;

  final Plant _plantCard;
  final bool packed;

  @override
  Widget build(BuildContext context) {
    DateFormat _format = DateFormat.yMMMd();
    return Container(
      padding: EdgeInsets.all(TSize.defaultSpace * 0.6),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color:
              Theme.of(context).colorScheme.secondary,
              blurRadius: 6.0,
            ),
          ],
          color: Theme.of(context).scaffoldBackgroundColor
      ),
      child: Stack(children: [
        Row(
          children: [
            Container(
              height: packed ? 95 : 130,
              width: packed ? 95 : 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(_plantCard.imageUrl),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: packed ? 95 : 130,
              padding: EdgeInsets.symmetric(
                  vertical: packed
                      ? TSize.defaultSpace * 0.1
                      : TSize.defaultSpace * 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: TSize.defaultSpace * 0.2,
                        horizontal: TSize.defaultSpace * 0.5
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(TSize.defaultBorderRadius),
                    ),
                    child: Text(
                      'condition',
                      style: TextStyle(
                          fontSize: 12,

                          fontWeight: FontWeight.bold),
                    ),

                  ),
                  Spacer(),
                  Text(_format.format(_plantCard.date)),
                ],
              ),
            )
          ],
        ),
        packed
            ? Center()
            : Positioned(
            right: 0,
            top: TSize.defaultSpace * 0.3,
            child: MoreMenuBox(
              options: [
                MoreItem(text: 'Rename'),
                MoreItem(
                  text: 'Delete',
                  red: true,
                )
              ],
            ))
      ]),

    );
  }
}
