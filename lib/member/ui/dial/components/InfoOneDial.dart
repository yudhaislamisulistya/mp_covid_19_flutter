import 'package:flutter/material.dart';
import 'package:mpcovid19/Constants.dart';

class InfoOneDial extends StatelessWidget {
  final String name;
  final String callphone;

  InfoOneDial({this.name, this.callphone});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                  child: new Icon(
                    Icons.call,
                    color: kPrimaryColor,
                  ),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(callphone),
                      new Text(
                        name,
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
        ],
      ),
    );
  }
}
