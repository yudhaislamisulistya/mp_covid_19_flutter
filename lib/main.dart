import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:mpcovid19/member/ui/dashboard/DashboardScreen.dart';
import 'package:mpcovid19/member/ui/hospital/HospitalScreen.dart';
import 'package:mpcovid19/member/ui/spot/SpotScreen.dart';

void main() {
  runApp(new MaterialApp(
    title: "MP Covid-19",
    home: Main(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(textTheme: GoogleFonts.kanitTextTheme()),
  ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _page = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();

  Color colorIconHospital;
  Color colorIconDashboard;
  Color colorIconSpot;
  @override
  void initState() {
    this.colorIconHospital = kPrimaryColor;
    this.colorIconDashboard = Colors.white;
    this.colorIconSpot = kPrimaryColor;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.local_hospital,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.dashboard,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.location_city,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: kPrimaryColor,
        backgroundColor: KBackgroundColorSecondary,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
            print(index);
            if(index == 0){
              colorIconHospital = kPrimaryColor;
            }else if(index == 1){
              colorIconDashboard = kPrimaryColor;
              colorIconHospital = colorIconSpot = Colors.white;
            }else if(index == 2){
              colorIconSpot = kPrimaryColor;
              colorIconDashboard = colorIconHospital = Colors.white;
            }
          });
        },
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    if (_page == 0) {
      return new HospitalScreen();
    } else if (_page == 1) {
      return new DashboardScreen();
    } else if (_page == 2) {
      return new SpotScreen();
    }
  }
}
