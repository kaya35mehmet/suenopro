import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:massageapppro/model/consts.dart';
import 'package:massageapppro/model/days.dart';
import 'package:massageapppro/model/userprofile.dart';
import 'package:massageapppro/widgets/colors.dart';

class DayScreen extends StatefulWidget {
  final String workhour;
  DayScreen({Key key, this.workhour}) : super(key: key);

  @override
  DayScreenState createState() => DayScreenState();
}

class DayScreenState extends State<DayScreen> {
  List<List<Object>> list;
  Future<List<List<Object>>> data;
  String starthour = "Choose";
  String endhour = "Chose";
  @override
  void initState() {
    var hr = widget.workhour.split(",");
    starthour = hr[0];
    endhour = hr[1];
    data = getData();
    super.initState();
  }

  Future<List<List<Object>>> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    list = await getdays();
    return list;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Consts.workdays),
      ),
      body: FutureBuilder<List<List<Object>>>(
          future: data,
          builder: (BuildContext context,
              AsyncSnapshot<List<List<Object>>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("часы",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () => showModalBot("start"),
                          child: Text(
                            "$starthour:00",
                            style: TextStyle(fontSize: 22),
                          )),
                      Text("<->"),
                      GestureDetector(
                        onTap: () => showModalBot("end"),
                        child: Text(
                          "$endhour:00",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("дней",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                            title: Text(snapshot.data[index][0]),
                            value: snapshot.data[index][2],
                            activeColor: Colors.deepPurple[400],
                            checkColor: Colors.white,
                            onChanged: (bool value) {
                              setdays(snapshot.data[index][1]).then((val) {
                                setState(() {
                                  snapshot.data[index][2] = value;
                                });
                              });
                            },
                          );
                        }),
                  ),
                ]);
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Error..",
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
                );
              }
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Expanded(
                        child: Text(
                          "Loading..",
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
              );
            }
          }),
    );
  }

  showModalBot(type) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 260.0,
          child: TimePickerSpinner(
            is24HourMode: true,
            spacing: 50,
            isShowSeconds: false,
            secondsInterval: 60,
            itemHeight: 80,
            isForce2Digits: true,
            minutesInterval: 59,
            onTimeChange: (time) {
              if (type == "start") {
                setState(() {
                  starthour = time.hour.toString();
                });
              } else {
                setState(() {
                  endhour = time.hour.toString();
                });
                workhours(starthour + "," + endhour);
              }
            },
          ),
        );
      },
    );
  }
}
