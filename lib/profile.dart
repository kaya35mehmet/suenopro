import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:massageapppro/dayscreen.dart';
import 'package:massageapppro/login/loginscreen.dart';
import 'package:massageapppro/model/consts.dart';
import 'package:massageapppro/model/userprofile.dart';
import 'package:massageapppro/profile_edit.dart';
import 'package:massageapppro/skillscreen.dart';
import 'package:massageapppro/update_password.dart';
import 'package:massageapppro/widgets/colors.dart';
import 'package:octo_image/octo_image.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final storage = new FlutterSecureStorage();
  String _selectedGuid;
  File file;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  EmployeeProfile data;
  Future<EmployeeProfile> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
    data = await getuser();
    return data;
  }

  Future<File> _choose() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print(Consts.noimageselected);
      }
    });
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: MyColors.navy,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.person),
              backgroundColor: Colors.blue,
              label: Consts.updateprofile,
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.of(context)
                    .push(
                      new MaterialPageRoute(
                          builder: (_) => ProfileScreen(employeeProfile: data),
                          fullscreenDialog: false),
                    )
                    .then((val) => getData());
              }),
          SpeedDialChild(
            child: Icon(Icons.lock),
            backgroundColor: Colors.green,
            label: Consts.changepassword,
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => UpdatePassword(
                          guid: _selectedGuid,
                        ),
                    fullscreenDialog: true),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.logout),
            backgroundColor: Colors.red,
            label: Consts.logout,
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              storage.deleteAll();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: FutureBuilder<EmployeeProfile>(
          future: getData(),
          builder:
              (BuildContext context, AsyncSnapshot<EmployeeProfile> snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: OctoImage(
                      image: CachedNetworkImageProvider(snapshot.data.photo),
                      placeholderBuilder: OctoPlaceholder.blurHash(
                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                      ),
                      errorBuilder: OctoError.icon(color: Colors.red),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(16.0),
                              margin: EdgeInsets.only(top: 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 96.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.name +
                                              " " +
                                              snapshot.data.surname,
                                          style:
                                              Theme.of(context).textTheme.subtitle1,
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.all(0),
                                          title: Text(snapshot.data.cityName),
                                          subtitle: Text(snapshot.data.active == 1 ? "": "Аккаунт неактивен", style: TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Align(
                                    alignment: Alignment(0, 0.8),
                                    child: MaterialButton(
                                      minWidth: 0,
                                      elevation: 0.5,
                                      color: Colors.white,
                                      child: Icon(
                                        Icons.camera,
                                        color: Colors.pink,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      onPressed: () => _choose().then((value) =>
                                          upload(value).then((value) {
                                            Toast.show(Consts.updateimage, context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.CENTER);
                                          })),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data.photo),
                                    fit: BoxFit.cover),
                              ),
                              margin: EdgeInsets.only(left: 16.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: ListTile(
                                    title: Text(Consts.myskills),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.arrow_right_alt),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SkillsScreen(),
                                        ),
                                      );
                                    }),
                              ],
                            )),
                        SizedBox(height: 20.0),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: ListTile(
                                    title: Text(Consts.workdays),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.arrow_right_alt),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DayScreen(workhour: snapshot.data.workhours,),
                                        ),
                                      );
                                    }),
                              ],
                            )),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(Consts.userinformation),
                              ),
                              Divider(),
                              ListTile(
                                title: Text(Consts.email),
                                subtitle: Text(snapshot.data.username),
                                leading: Icon(Icons.email),
                              ),
                              ListTile(
                                title: Text(Consts.phone),
                                subtitle: Text(snapshot.data.phoneNumber),
                                leading: Icon(Icons.phone),
                              ),
                              ListTile(
                                title: Text(Consts.address),
                                subtitle: Text(snapshot.data.address),
                                leading: Icon(Icons.web),
                              ),
                              ListTile(
                                title: Text(Consts.about),
                                subtitle: Text(snapshot.data.about),
                                leading: Icon(Icons.person),
                              ),
                              ListTile(
                                title: Text(Consts.joineddate),
                                subtitle: Text(snapshot.data.createdDate),
                                leading: Icon(Icons.calendar_view_day),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  )
                ],
              );
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new CircularProgressIndicator(),
                      new Text(Consts.loading),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget photo(val) {
    if (val != null) {
      try {
        return Image.network(val, fit: BoxFit.cover);
      } catch (e) {
        return Image.asset('assets/logo.png', fit: BoxFit.cover);
      }
    } else {
      return Image.asset('assets/logo.png', fit: BoxFit.cover);
    }
  }
}
