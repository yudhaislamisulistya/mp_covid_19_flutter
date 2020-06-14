import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mpcovid19/Constants.dart';
import 'package:mpcovid19/admin/ui/cases/AdminAddCasesScreen.dart';
import 'package:mpcovid19/admin/ui/cases/AdminChangeCasesScreen.dart';
import 'package:mpcovid19/main.dart';
import 'package:mpcovid19/models/Cases.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:status_alert/status_alert.dart';

class AdminCasesScreen extends StatefulWidget {
  @override
  _AdminCasesScreenState createState() => _AdminCasesScreenState();
}

class _AdminCasesScreenState extends State<AdminCasesScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) {
                return new AdminAddCasesScreen();
              },
            ),
          );
        },
        backgroundColor: kPrimaryColor,
        child: new Icon(
          Icons.add,
        ),
      ),
      backgroundColor: KBackgroundColorSecondary,
      appBar: new AppBar(
        title: new Text("Admin Kasus"),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Main()),
                (Route<dynamic> route) => false);
          },
        ),
      ),
      body: AdminCasesListView(),
    );
  }
}

class AdminCasesListView extends StatelessWidget {
  _deleteCasesById(id) async {
    print("Tombol Delete Berhasil di Tekan");
    String url =
        'https://mp-covid19-api.000webhostapp.com/public/api/case/$id/delete';
    print(url);
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response = await http.post(url, headers: headers);
    var statusCode = response.body;
    print(statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cases>>(
      future: _fetchSpots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Cases> data = snapshot.data;
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

  Future<List<Cases>> _fetchSpots() async {
    final hospitalsListAPIUrl =
        "https://mp-covid19-api.000webhostapp.com/public/api/cases/all";
    final response = await http.get(hospitalsListAPIUrl);
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((cases) => new Cases.fromJson(cases)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _hospitalsListView(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _container(
          data[index].idCase,
          data[index].confirmedCases,
          data[index].totalDeaths,
          data[index].totalRecovered,
          data[index].newCases,
          data[index].date,
          context,
        );
      },
    );
  }

  Container _container(
      id, terkonfirmasi, kematian, sembuh, kasusBaru, tanggal, context) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: new InkWell(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) {
                return new AdminChangeCasesScreen(
                  id: id,
                  confirmed_cases: terkonfirmasi,
                  total_deaths: kematian,
                  total_recovered: sembuh,
                  new_cases: kasusBaru,
                  date: tanggal,
                );
              },
            ),
          );
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Hapus Data!"),
                content:
                    Text("Apakah Kamu Benar - Benar Mau Menghapus Data Ini?"),
                actions: [
                  FlatButton(
                    child: Text(
                      "Submit",
                      style: new TextStyle(color: kPrimaryColor),
                    ),
                    onPressed: () {
                      _deleteCasesById(id);
                      Navigator.of(context).pop();
                      StatusAlert.show(
                        context,
                        duration: Duration(seconds: 2),
                        title: 'Data Berhasil di Hapus',
                        configuration: IconConfiguration(
                          icon: Icons.done,
                        ),
                      );
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Keluar",
                      style: new TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                elevation: 5,
              );
            },
          );
        },
        child: new Row(
          children: <Widget>[
            new Icon(
              Icons.report_problem,
              color: Colors.red,
              size: 55,
            ),
            SizedBox(
              width: 10.0,
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("Terkonfirmasi : " + terkonfirmasi.toString()),
                new Text("Kematian : " + kematian.toString()),
                new Text("Sembuh : " + sembuh.toString()),
                new Text("Kasus Baru : " + kasusBaru.toString()),
                new Text(
                  "Tanggal : " + tanggal.toString(),
                  style: new TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
