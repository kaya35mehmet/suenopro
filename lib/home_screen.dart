import 'package:flutter/material.dart';
import 'package:massageapppro/bottombar.dart';
import 'package:massageapppro/model/consts.dart';
import 'package:massageapppro/statistics_screen.dart';
import 'package:massageapppro/past_booking.dart';
import 'package:massageapppro/profile.dart';
import 'dart:async';
import 'package:massageapppro/upcoming_booking.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.pageIndex}) : super(key: key);
  final int pageIndex;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int page;

  PageController pageController;
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage:widget.pageIndex);
  }

  @override
  void dispose() {
    indexcontroller.close();
    super.dispose();
  }
  
  
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          indexcontroller.add(index);
        },
        controller: pageController,
        children: <Widget>[
          UpcomingScreen(),
          PastScreen(),
          StatisticsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: StreamBuilder<Object>(
          initialData: widget.pageIndex,
          stream: indexcontroller.stream,
          builder: (context, snapshot) {
            int cIndex = snapshot.data;
            return FancyBottomNavigation(
              currentIndex: cIndex,
              items: <FancyBottomNavigationItem>[
                FancyBottomNavigationItem(
                    icon: Icon(Icons.arrow_upward), title: Text(Consts.upcoming)),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.arrow_downward), title: Text(Consts.past)),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.attach_money), title: Text(Consts.statistic)),
                FancyBottomNavigationItem(
                    icon: Icon(Icons.person), title: Text(Consts.profile)),
              ],
              onItemSelected: (int value) {
                indexcontroller.add(value);
                pageController.jumpToPage(value);
              },
            );
          }),
    );
  }
}
