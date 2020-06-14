import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:mpcovid19/member/ui/components/InfoCard.dart';
import 'package:mpcovid19/member/ui/dial/DialScreen.dart';
import 'package:mpcovid19/member/ui/login/LoginScreen.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int confirmedCases = 0;
  int totalDeaths = 0;
  int totalRecovered = 0;
  int newCases = 0;

  void  _getDataDay() async {
    final casesListAPIUrl =
        "http://mp-covid19-api.000webhostapp.com/public/api/cases/day";
    final response = await http.get(casesListAPIUrl);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        newCases = data["new_cases"];
      });
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  void _getDataTotal() async{
    final casesListAPIUrl =
        "http://mp-covid19-api.000webhostapp.com/public/api/cases/total";
    final response = await http.get(casesListAPIUrl);
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        confirmedCases = data[0];
        totalDeaths = data[1];
        totalRecovered = data[2];
      });
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  @override
  void initState() {
    super.initState();
    _getDataDay();
    _getDataTotal();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackgroundColorSecondary,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.03),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                children: <Widget>[
                  InfoCard(
                    title: "Terkonfirmasi",
                    iconColor: Color(0xFFFF8C00),
                    effectedNum: confirmedCases,
                    press: () {},
                  ),
                  InfoCard(
                    title: "Total Kematian",
                    iconColor: Color(0xFFFF2D55),
                    effectedNum: totalDeaths,
                    press: () {},
                  ),
                  InfoCard(
                    title: "Total Sembuh",
                    iconColor: Color(0xFF50E3C2),
                    effectedNum: totalRecovered,
                    press: () {},
                  ),
                  InfoCard(
                    title: "Kasus Baru",
                    iconColor: Color(0xFF5856D6),
                    effectedNum: newCases,
                    press: () {
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "3 Pencegahan Utama",
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildPreventation(),
                    SizedBox(height: 40),
                    new GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return new DialScreen();
                            },
                          ),
                        );
                      },
                      child: buildHelpCard(context),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Row buildPreventation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PreventitonCard(
          svgSrc: "assets/icons/hand_wash.svg",
          title: "Cuci Tangan",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/use_mask.svg",
          title: "Pakai Masker",
        ),
        PreventitonCard(
          svgSrc: "assets/icons/Clean_Disinfect.svg",
          title: "Bersihkan Diri",
        ),
      ],
    );
  }

  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dial 999 for \nMedical Help!\n",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "Jika ada Gejala yang Muncul",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor.withOpacity(.03),
      elevation: 0,
      title: new Text(
        'Dashboard',
        style: new TextStyle(
          color: kPrimaryColor,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: new Icon(
            Icons.person,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (BuildContext context) {
                  return new LoginScreen();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;

  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
