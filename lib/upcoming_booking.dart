import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:massageapppro/app_theme.dart';
import 'package:massageapppro/model/consts.dart';
import 'package:massageapppro/model/reservation.dart';
import 'package:massageapppro/widgets/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class UpcomingScreen extends StatefulWidget {
  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen>
    with TickerProviderStateMixin {
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  List<Reservations> list;
  Future<List<Reservations>> data;
  @override
  void initState() {
    data = getData();
    super.initState();
  }

  Future<List<Reservations>> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    list = await upcomingReservations();
    return list;
  }

  @override
  void dispose() {
    super.dispose();
  }

  var childCount = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservations>>(
      future: data,
      builder: (context, snapshot) {
        Widget newsListSliver;
        if (snapshot.hasData) {
          if (snapshot.data.length != 0) {
            newsListSliver = SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return buildList(snapshot.data[index]);
            }, childCount: snapshot.data.length));
          } else {
            newsListSliver = SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                         Consts.noreservation,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: 0.5,
                            color: MyColors.navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          newsListSliver = SliverToBoxAdapter(
            child: Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Text(Consts.noreservation),
                  ],
                ),
              ),
            ),
          );
        }

        return CustomScrollView(
          slivers: <Widget>[appbar(), newsListSliver],
        );
      },
    );
  }

  Widget buildList(Reservations arrayval) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 250,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 3, color: secondary),
                    // image: DecorationImage(
                    //     image: NetworkImage(arrayval.photo), fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        arrayval.userNameSurname,
                        style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: secondary,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(arrayval.addressname,
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 13,
                                    letterSpacing: .3)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.school,
                            color: secondary,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(arrayval.date + " " + arrayval.hour,
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 13,
                                  letterSpacing: .3)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 62.0,
                  height: 62.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.call),
                    onPressed: () {
                      showAlertDialog(context, arrayval.phoneNumber);
                    },
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 62.0,
                  height: 62.0,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      var dd = arrayval.lanLat.split(",");
                      launch("yandexmaps://maps.yandex.ru/?pt="+ dd[1] +","+ dd[0] +"&z=12&l=map");
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }

   Widget appbar() {
    return SliverAppBar(
      backgroundColor: MyColors.navy,
      expandedHeight: 180.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          Consts.upcoming,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppTheme.white,
              fontFamily: "Roboto",
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, number) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () => _callNumber(number),
    );
    AlertDialog alert = AlertDialog(
      title: Text("Call"),
      content: Text("Would you like to continue call costumer?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _callNumber(number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
