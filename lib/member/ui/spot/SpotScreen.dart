import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mpcovid19/Constants.dart';
import 'package:mpcovid19/member/ui/spot/components/InfoOneSpot.dart';
import 'package:mpcovid19/models/Spot.dart';



class SpotScreen extends StatefulWidget {
  @override
  _SpotScreenState createState() => _SpotScreenState();
}

class _SpotScreenState extends State<SpotScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Posko'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SpotsListView(),
    );
  }
}

class SpotsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Spot>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Spot> data = snapshot.data;
          return _spotsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return new Container(
          child: new Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Future<List<Spot>> _fetchJobs() async {
    final spotsListAPIUrl =
        "https://mp-covid19-api.000webhostapp.com/public/api/spots";
    final response = await http.get(spotsListAPIUrl);
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((spot) => new Spot.fromJson(spot))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _spotsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return new InfoOneSpot(
            title: data[index].name,
            detail: data[index].address,
            location: data[index].city,
          );
        });
  }
}
