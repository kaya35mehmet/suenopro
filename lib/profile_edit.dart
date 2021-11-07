import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:massageapppro/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:massageapppro/home_screen.dart';
import 'package:massageapppro/model/cities.dart';
import 'package:massageapppro/model/constant.dart';
import 'package:massageapppro/model/consts.dart';
import 'package:massageapppro/model/userprofile.dart';
import 'package:massageapppro/profile.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.employeeProfile}) : super(key: key);
  final EmployeeProfile employeeProfile;
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File file;
  final picker = ImagePicker();
  String _selected = '';
  String photopath;
  @override
  void initState() {
    if (widget.employeeProfile != null) {
      nameCnt.text = widget.employeeProfile.name;
      surnameCnt.text = widget.employeeProfile.surname;
      emailCnt.text = widget.employeeProfile.username;
      phoneNumberCnt.text = widget.employeeProfile.phoneNumber;
      addressCnt.text = widget.employeeProfile.address;
      aboutCnt.text = widget.employeeProfile.about;
      photopath = widget.employeeProfile.photo;
    } else {
      getuser().then((value) {
        nameCnt.text = value.name;
        surnameCnt.text = value.surname;
        emailCnt.text = value.username;
        phoneNumberCnt.text = value.phoneNumber;
        addressCnt.text = value.address;
        aboutCnt.text = value.about;
        photopath = value.photo;
      });
    }
    super.initState();
  }

  TextEditingController nameCnt = TextEditingController();
  TextEditingController surnameCnt = TextEditingController();
  TextEditingController emailCnt = TextEditingController();
  TextEditingController phoneNumberCnt = TextEditingController();
  TextEditingController addressCnt = TextEditingController();
  TextEditingController aboutCnt = TextEditingController();

  List<Cities> list;

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    list = await getcities();
    if (widget.employeeProfile.cityid != "0") {
      _selected = list
          .firstWhere((element) => element.id == widget.employeeProfile.cityid)
          .name;
    } else {
      _selected = "Choose";
    }
    return true;
  }

  Future<bool> getall() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Consts.updateprofile),
      ),
      body: Container(
        color: AppTheme.nearlyWhite,
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: AppTheme.nearlyWhite,
            body: Column(
              children: <Widget>[
                // getAppBarUI(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        FutureBuilder<bool>(
                          future: getData(),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    new CircularProgressIndicator(),
                                  ],
                                ),
                              );
                            } else {
                              return Form(
                                key: _formKey,
                                child: Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 250,
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: file == null
                                                  ? photo(photopath)
                                                  : Image.file(file),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _buildinputs(
                                          nameCnt,
                                          Consts.name,
                                          Consts.enteryourname,
                                          Icons.perm_identity,
                                          false),
                                      _buildinputs(
                                          surnameCnt,
                                          Consts.surname,
                                          Consts.enteryoursurname,
                                          Icons.person,
                                          false),
                                      _buildinputs(
                                          emailCnt,
                                          Consts.email,
                                          Consts.enteryouremailaddress,
                                          Icons.email,
                                          false),
                                      _buildinputs(
                                          phoneNumberCnt,
                                          Consts.phone,
                                          Consts.enteryourphonenumber,
                                          Icons.phone,
                                          false),
                                      _buildinputs(
                                          addressCnt,
                                          Consts.address,
                                          Consts.enteryouraddress,
                                          Icons.location_on,
                                          false),
                                      _builddropdown(),
                                      _buildinputs(
                                          aboutCnt,
                                          Consts.about,
                                          Consts.enteryourabout,
                                          Icons.people,
                                          false),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                _buildLoginBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildinputs(TextEditingController cnt, String labeltext,
      String hintText, IconData icon, bool isobsecure) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15.0),
        Text(
          labeltext,
          style: kLabelStyleProfile,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleProfile,
          height: 60.0,
          child: TextFormField(
            controller: cnt,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                icon,
                color: Colors.black38,
              ),
              hintText: hintText,
              hintStyle: kHintTextStyleProfile,
            ),
            obscureText: isobsecure,
          ),
        ),
      ],
    );
  }

  Widget _builddropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15.0),
        Text(
          Consts.city,
          style: kLabelStyleProfile,
        ),
        InkWell(
          highlightColor: Colors.transparent,
          onTap: () => showModal(context),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyleProfile,
            height: 60.0,
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              child: Text(
                _selected,
                // _selected != '' ? _selected : 'Select',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w500, color: AppTheme.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.all(25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          editprofile(
                  nameCnt.text,
                  surnameCnt.text,
                  emailCnt.text,
                  phoneNumberCnt.text,
                  addressCnt.text,
                  aboutCnt.text,
                  widget.employeeProfile.cityid)
              .then((value) {
            if (value == "1") {
              Toast.show(Consts.succesful, context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(
                    pageIndex: 3,
                  ),
                ),
              );
            } else {
              Toast.show(Consts.succesful, context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(),
                ),
              );
            }
          });
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          Consts.save,
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.nearlyWhite,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  Consts.updateprofile,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
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

  void showModal(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(12),
            height: 350,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text(list[index].name),
                      ),
                      onTap: () {
                        setState(() {
                          _selected = list[index].name;
                          widget.employeeProfile.cityid = list[index].id;
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
