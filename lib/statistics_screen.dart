import 'package:flutter/material.dart';
import 'package:massageapppro/model/consts.dart';
import 'package:massageapppro/model/statistic.dart';
import 'package:massageapppro/model/userprofile.dart';
import 'package:massageapppro/widgets/colors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:toast/toast.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final String avatar = "avatars[0]";

  final TextStyle whiteText = TextStyle(color: Colors.white);

  Statistic list;
  Future<Statistic> data;

  @override
  void initState() {
    data = getData();
    super.initState();
  }

  Future<Statistic> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
    var list = await statistic();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          _buildHeader(),
          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<Statistic>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      Consts.earning,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: _buildTile(
                              color: Colors.grey,
                              icon: Icons.public,
                              title: Consts.totalearning,
                              data: snapshot.data.sumCount.totalearned == null
                                  ? "0"
                                  : snapshot.data.sumCount.totalearned + "₸",
                              fontSize: 28),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: _buildTile(
                              color: Colors.green,
                              icon: Icons.widgets,
                              title: Consts.earningswithdrawn,
                              data: snapshot.data.withdrawn.withdrawn + "₸",
                              fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: Colors.white,
                            
                          ),
                          onPressed: () {
                            withdrawnresponse().then((value){
                              if(value == "ok"){
                                  Toast.show(Consts.succesful, context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                              }
                            });

                          },
                          child: Text(Consts.withdrawalrequest),
                        )),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      Consts.bookings,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _buildTile(
                            color: Colors.pink,
                            icon: Icons.favorite,
                            title: Consts.favourite,
                            data: snapshot.data.favourites.favourites,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: _buildTile(
                            color: Colors.blue,
                            icon: Icons.check,
                            title: Consts.allbookings,
                            data: snapshot.data.sumCount.allbookings,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: _buildTile(
                            color: Colors.orange,
                            icon: Icons.cancel,
                            title: Consts.cancelled,
                            data: snapshot.data.sumCount.canceled,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      Consts.cancelled,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(width: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: _buildTile(
                              color: Colors.amber,
                              icon: Icons.public,
                              title: Consts.averagescore,
                              data: snapshot.data.star.avarage,
                              fontSize: 38,
                              fontSizeTitle: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  rating(1.0, snapshot.data.star.star1),
                  const SizedBox(height: 20.0),
                  rating(2.0, snapshot.data.star.star2),
                  const SizedBox(height: 16.0),
                  rating(3.0, snapshot.data.star.star3),
                  const SizedBox(height: 20.0),
                  rating(4.0, snapshot.data.star.star4),
                  const SizedBox(height: 16.0),
                  rating(5.0, snapshot.data.star.star5),
                  const SizedBox(height: 20.0),
                ],
              );
            } else {
              return Container(
                // margin: EdgeInsets.only(
                //     left: MediaQuery.of(context).size.width / 3,
                //     top: MediaQuery.of(context).size.height / 3),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      new CircularProgressIndicator(),
                      new Text(Consts.loading),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: MyColors.navy,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(
              Consts.statistic,
              style: whiteText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            trailing: CircleAvatar(
              radius: 25.0,
              // backgroundImage: NetworkImage(avatar),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

  Container _buildTile(
      {Color color,
      IconData icon,
      String title,
      String data,
      double height,
      double fontSizeTitle,
      double fontSize}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            title,
            style: whiteText.copyWith(
                fontWeight: FontWeight.bold, fontSize: fontSizeTitle),
          ),
          Text(
            data,
            style: whiteText.copyWith(
                fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ],
      ),
    );
  }

  Container _buildTile2(
      {Color color, IconData icon, String title, String data}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: whiteText.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            data,
            textAlign: TextAlign.center,
            style:
                whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  Widget rating(rating, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          SmoothStarRating(
            rating: rating,
            isReadOnly: true,
            size: 50,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            color: Colors.yellow[700],
            borderColor: Colors.yellow[800],
            starCount: 5,
            allowHalfRating: true,
            spacing: 2.0,
            onRated: (value) {},
          ),
          Expanded(
            child: _buildTile2(
              color: MyColors.navy,
              icon: Icons.favorite,
              title: Consts.review,
              data: data,
            ),
          ),
        ],
      ),
    );
  }
}
