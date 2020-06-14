import 'package:flutter/material.dart';

class InfoOneHospital extends StatelessWidget {


  final String title;
  final String detail;
  final double long;
  final double lat;
  InfoOneHospital({this.title, this.detail, this.long, this.lat});
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin:
      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Expanded(
            child: new Row(
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 100,
                  height: 100,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: new DecorationImage(
                      image: AssetImage('assets/images/hospital.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(title),
                      new Text(
                        detail,
                        style: new TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Icon(
                  Icons.navigation,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
