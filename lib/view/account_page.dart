import 'package:flutter/material.dart';
import 'package:strawberry_disease_detection/constant/size.dart';

import 'package:strawberry_disease_detection/common/widget/menu_item.dart';
import 'package:strawberry_disease_detection/common/widget/menu_item_category.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: TSize.defaultSpace / 2,
        top: TSize.defaultSpace,
        left: TSize.defaultSpace / 2,
        bottom: TSize.defaultSpace / 2,
      ),
      child: Column(
        children: [
          profileInfo(context),
          const SizedBox(height: 30),
          profileMenuItems(context),
        ],
      ),
    );
  }

  Widget profileInfo(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: TSize.defaultSpace / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 5, color: Colors.transparent),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/icons/launcher_icon.png'),
              ),
            ),
          ),
          SizedBox(width: TSize.defaultSpace * 0.75),
          Expanded(
            child: SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const Text(
                    'mine',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
              onTap: () {

              },
              child: Padding(
                padding: const EdgeInsets.all(TSize.defaultSpace * 0.5),
                child: const Icon(Icons.logout),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileMenuItems(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSize.defaultBorderRadius),
      ),
      child: Column(
        children: [
          const MenuItem(
            prefix: Icons.person,
            text: 'Profile',
          ),
          MenuItemCategory(
            prefix: Icons.settings,
            text: 'General Settings',
            subitems: [
              SubMenuItem(
                icon: Icons.language,
                text: 'Languages',
                endWidget: Text(
                  'English',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
