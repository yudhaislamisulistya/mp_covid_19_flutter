import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:mpcovid19/admin/ui/cases/AdminCasesScreen.dart';
import 'package:mpcovid19/admin/ui/hospital/AdminHospitalScreen.dart';
import 'package:mpcovid19/admin/ui/spot/AdminSpotScreen.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
      return new AdminHospitalScreen();
    } else if (_page == 1) {
      return new AdminCasesScreen();
    } else if (_page == 2) {
      return new AdminSpotScreen();
    }
  }
}
