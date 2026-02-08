import 'package:flutter/material.dart';
import 'package:tharad_task/views/home/pages/home.dart';
import 'package:tharad_task/views/home/pages/profile.dart';

import '../../core/ui/app_image.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final list = [
    _Model("home.svg", HomePage(),"الرئيسية"),
    _Model("profile.svg", ProfilePage(),"حسابي"),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[currentIndex].pages,

      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(color: Colors.grey.shade100),
        child: BottomNavigationBar(
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          currentIndex: currentIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor:  Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: List.generate(
            list.length,
            (index) => BottomNavigationBarItem(
              icon: AppImage(
                image: list[index].icon,
                color: currentIndex == index ?  Theme.of(context).primaryColor : Colors.grey,
              ),
              label: list[index].name,
            ),
          ),
        ),
      ),
    );
  }
}

class _Model {
  final String icon;
  final String name;

  final Widget pages;

  _Model(this.icon, this.pages, this.name);
}
