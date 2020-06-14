import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:mpcovid19/member/ui/dial/components/InfoOneDial.dart';
import 'package:mpcovid19/member/ui/spot/components/InfoOneSpot.dart';
import 'package:mpcovid19/models/Dial.dart';
import 'package:http/http.dart' as http;

class DialScreen extends StatefulWidget {
  @override
  _DialScreenState createState() => _DialScreenState();
}

class _DialScreenState extends State<DialScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Telepon Darurat'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: DialsListView(),
    );
  }
}

class DialsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Dial>>(
      future: _getDataAllDials(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Dial> data = snapshot.data;
          return _dialsListView(data);
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

  Future<List<Dial>> _getDataAllDials() async {
    final dialsListAPIUrl =
        "https://mp-covid19-api.000webhostapp.com/public/api/dials";
    final response = await http.get(dialsListAPIUrl);
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((dial) => new Dial.fromJson(dial)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _dialsListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return new InfoOneDial(
          name: data[index].name,
          callphone: data[index].callphone,
        );
      },
    );
  }
}
