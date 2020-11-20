import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hello/detail.dart';
import 'package:hello/info_screen.dart';

class KnnProgram extends StatefulWidget {
  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<KnnProgram> {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey[100], Colors.blueGrey[200]],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                    child: new Text(
                  " ",
                  style: new TextStyle(color: Colors.black, fontSize: 40.0),
                )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "    Prediksi Kesehatan dan Kondisi Air ",
                        style: new TextStyle(
                            color: Colors.grey[800],
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "     K Nearest Neighbors ",
                        style: new TextStyle(
                            color: Colors.grey[700],
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                new Container(
                    child: new Text(
                  " ",
                  style: new TextStyle(color: Colors.black, fontSize: 30.0),
                )),
                new StreamBuilder<Event>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child('Monitoring')
                      .onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> event) {
                    Map<dynamic, dynamic> data = event.data.snapshot.value;
                    return Column(children: [
                      new Center(
                          child: new Container(
                              width: 380.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.blueAccent[400],
                                      Colors.indigo[500]
                                    ],
                                  ),
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          '    Prediksi Kondisi Air',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Container(
                                      child: Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )),
                                  Container(
                                    child: Text(
                                      '${data['StatusAir']['Data']}',
                                      style: new TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )))
                    ]);
                  },
                ),
                new Center(
                  child: new Text(
                    " ",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                ),
                new StreamBuilder<Event>(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child('Monitoring')
                      .onValue,
                  builder: (BuildContext context, AsyncSnapshot<Event> event) {
                    Map<dynamic, dynamic> data = event.data.snapshot.value;
                    return Column(children: [
                      new Center(
                          child: new Container(
                              width: 380.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.blueAccent[400],
                                      Colors.indigo[500]
                                    ],
                                  ),
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      '',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          '    Prediksi Kondisi Udang',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Container(
                                      child: Text(
                                    '',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  )),
                                  Container(
                                    child: Text(
                                      '${data['StatusKesehatan']['Data']}',
                                      style: new TextStyle(
                                          color: Colors.white70,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )))
                    ]);
                  },
                ),
                SizedBox(),
                new Center(
                    child: new Text(
                  " ",
                  style: new TextStyle(color: Colors.black, fontSize: 140.0),
                )),
                _cekPrediksi(),
                new Center(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 10.0),
                      )),
                _detail(),
                new Center(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 10.0),
                      )),
                _infoButton(),
                new Center(
                    child: new Text(
                  " ",
                  style: new TextStyle(color: Colors.black, fontSize: 20.0),
                )),
              ],
            )));
  }

  _fetchData() async {
    final url = 'https://knnnew.herokuapp.com/air';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('HTTP Request Prediksi Air Berhasil');
    } else {
      print('HTTP Request Prediksi Air Gagal');
    }
  }

  _fetchData2() async {
    final url = 'https://knnnew.herokuapp.com/sehat';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('HTTP Request Prediksi Kesehatan Berhasil');
    } else {
      print('HTTP Request Prediksi Kesehatan Gagal');
    }
  }

  Widget _cekPrediksi() {
    return RaisedButton(
      splashColor: Colors.grey,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            _fetchData();
            _fetchData2();
            return KnnProgram();
          },
        ));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 5,
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(7.0),
              child: Text(
                '  Prediksi  ',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _detail() {
    return RaisedButton(
      splashColor: Colors.grey,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Detail();
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 5,
      color: Colors.indigo,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                'Detail Nilai',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoButton() {
    return RaisedButton(
      splashColor: Colors.grey,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return InfoScreen();
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 5,
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                ' Info Akun ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
