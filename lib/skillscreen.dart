import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:massageapppro/model/consts.dart';
import 'package:massageapppro/model/skills.dart';
import 'package:massageapppro/widgets/colors.dart';

class SkillsScreen extends StatefulWidget {
  @override
  SkillsState createState() => SkillsState();
}

class SkillsState extends State<SkillsScreen> {
  List<Skills> list;
  Future<List<Skills>> data;
  TextEditingController priceCnt = new TextEditingController();
  @override
  void initState() {
    data = getData();
    super.initState();
  }

  Future<List<Skills>> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    list = await getskills();
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
        title: Text(Consts.myskills),
      ),
      body: FutureBuilder<List<Skills>>(
          future: data,
          builder:
              (BuildContext context, AsyncSnapshot<List<Skills>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return Column(children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CheckboxListTile(
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                snapshot.data[index].massageName,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(6),
                                              child: Text(snapshot
                                                  .data[index].serviceName),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: Colors.deepOrange,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Text(
                                                snapshot.data[index]
                                                        .perHourFee +
                                                    "₸",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    value: snapshot.data[index].durum == 1
                                        ? true
                                        : false,
                                    activeColor: Colors.deepPurple[400],
                                    checkColor: Colors.white,
                                    onChanged: (bool value) {
                                      if (snapshot.data[index].durum == 0) {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => WillPopScope(
                                            onWillPop: () async => false,
                                            child: AlertDialog(
                                              title: Text('цена'),
                                              content: TextField(
                                                decoration: new InputDecoration(
                                                    labelText:
                                                        "Введите вашу цена"),
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: priceCnt,
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, false);

                                                    addskills(
                                                            snapshot.data[index]
                                                                .guid,
                                                            priceCnt.text)
                                                        .then((val) {
                                                      if (val == "ok") {
                                                        setState(() {
                                                          snapshot.data[index]
                                                                  .durum =
                                                              value == true
                                                                  ? 1
                                                                  : 0;
                                                          snapshot.data[index]
                                                                  .perHourFee =
                                                              priceCnt.text;
                                                          priceCnt.text = "";
                                                        });
                                                      }
                                                    });
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        addskills(
                                                snapshot.data[index].guid, "0")
                                            .then((val) {
                                          if (val == "ok") {
                                            setState(() {
                                              snapshot.data[index].durum =
                                                  value == true ? 1 : 0;
                                              snapshot.data[index].perHourFee =
                                                  "0";
                                            });
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
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
                            Consts.noskills,
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
                          Consts.loading,
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
}
