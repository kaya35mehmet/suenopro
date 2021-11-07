import 'package:massageapppro/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:massageapppro/model/constant.dart';
import 'package:massageapppro/model/userprofile.dart';
import 'package:toast/toast.dart';

class UpdatePassword extends StatefulWidget {
  UpdatePassword({Key key, this.guid}) : super(key: key);
  final String guid;
  @override
  UpdatePasswordState createState() => UpdatePasswordState();
}

class UpdatePasswordState extends State<UpdatePassword> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController expasswordCnt = TextEditingController();
  TextEditingController newpasswordCnt = TextEditingController();
  TextEditingController renewpasswordCnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  getAppBarUI(),
                  _buildinputs(expasswordCnt, "Old Password",
                      "Enter your password", Icons.lock, true),
                  _buildinputs(newpasswordCnt, "New Password",
                      "Enter new password", Icons.lock, true),
                  _buildinputs(renewpasswordCnt, "Email", "Enter new password",
                      Icons.lock, true),
                  _buildLoginBtn(),
                ],
              ),
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

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (newpasswordCnt.text == renewpasswordCnt.text) {
            changepassword(
              expasswordCnt.text,
              newpasswordCnt.text,
            ).then((value) {
              if (value == "ok") {
                Toast.show("Successful!", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              } 
              else if(value == "Wrong old password"){
                Toast.show(value, context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              }
              else {
                Toast.show("Failed!", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              }
            });
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SAVE',
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
                  'Change Password',
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
}
