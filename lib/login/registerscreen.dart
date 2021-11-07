import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:massageapppro/app_theme.dart';
import 'package:massageapppro/login/loginscreen.dart';
import 'package:massageapppro/model/cities.dart';
import 'package:massageapppro/model/constant.dart';
import 'package:massageapppro/model/consts.dart';
import 'package:massageapppro/model/register.dart';
import 'package:toast/toast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = "";
  String surname = "";
  String email = "";
  String password = "";
  String repassword = "";
  String phoneNumber = "";
  String _selected = 'Choose';
  String _gender = 'Choose';
  String cityid;
  List<Cities> list;
  List<String> gender = ["male", "female"];

  void initState() {
    fetch();
    super.initState();
  }

  fetch() async {
    list = await getcities();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Consts.name,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.perm_identity,
                color: Colors.white,
              ),
              hintText: Consts.enteryourname,
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) {
              name = value;
            },
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          Consts.surname,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: Consts.enteryoursurname,
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) {
              surname = value;
            },
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          Consts.email,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (value) {
              email = value;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: Consts.enteryouremailaddress,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        _builddropdown(),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15.0),
            Text(
              Consts.gender,
              style: kLabelStyle,
            ),
            InkWell(
              highlightColor: Colors.transparent,
              onTap: () => showModal2(context),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: kBoxDecorationStyle,
                height: 60.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  child: Text(
                    _gender,
                    // _selected != '' ? _selected : 'Select',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w500,
                        color: AppTheme.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          Consts.phone,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (value) {
              phoneNumber = value;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              hintText: Consts.enteryourphonenumber,
              hintStyle: kHintTextStyle,
            ),
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
          style: kLabelStyle,
        ),
        InkWell(
          highlightColor: Colors.transparent,
          onTap: () => showModal(context),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              child: Text(
                _selected,
                // _selected != '' ? _selected : 'Select',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w500,
                    color: AppTheme.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Consts.password,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: Consts.enteryourpassword,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          Consts.password,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (value) {
              repassword = value;
            },
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: Consts.enteryourpassword,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (name != "" && surname != "" && email != "" && phoneNumber != "") {
            if (password.length > 5) {
              if (password == repassword) {
                register(name, surname, phoneNumber, email, cityid, _gender,
                        password)
                    .then((value) {
                  if (value == "ok") {
                    Toast.show("Профиль создан. Пожалуйста, войдите.", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  }
                });
              } else {
                Toast.show("Пароли разные", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              }
            } else {
              Toast.show(
                  "Пароль должен состоять не менее чем из 6 символов", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            }
          } else {
            Toast.show("Входные данные не должны быть нулевыми", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFAB00),
        title: Text(
          Consts.signup,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: (){},
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFAB00),
                      Color(0xFFFFC400),
                      Color(0xFFFFD740),
                      Color(0xFFFFE57F),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildEmailTF(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPasswordTF(),
                      _buildLoginBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
                          cityid = list[index].id;
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }

  void showModal2(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(12),
            height: 150,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: gender.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text(gender[index]),
                      ),
                      onTap: () {
                        setState(() {
                          _gender = gender[index];
                        });
                        Navigator.of(context).pop();
                      });
                }),
          );
        });
  }
}
