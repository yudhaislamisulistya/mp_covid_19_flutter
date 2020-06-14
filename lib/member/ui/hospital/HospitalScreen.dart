import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mpcovid19/Constants.dart';
import 'package:mpcovid19/member/ui/hospital/components/InfoOneHospital.dart';
import 'package:mpcovid19/models/Hospital.dart';

class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Rumah Sakit'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: HospitalsListView(),
    );
  }
}

class HospitalsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hospital>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Hospital> data = snapshot.data;
          return _hospitalsListView(data);
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

  Future<List<Hospital>> _fetchJobs() async {
    final hospitalsListAPIUrl =
        "https://mp-covid19-api.000webhostapp.com/public/api/hospitals";
    final response = await http.get(hospitalsListAPIUrl);
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((hospital) => new Hospital.fromJson(hospital))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _hospitalsListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return new InfoOneHospital(
          title: data[index].name,
          detail: data[index].address,
        );
      },
    );
  }
}
