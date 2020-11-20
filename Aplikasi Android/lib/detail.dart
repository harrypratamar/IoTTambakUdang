import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:hello/info_screen.dart';
import 'package:hello/monitoring.dart';
import 'package:hello/prediksi.dart';

class Detail extends StatefulWidget {
  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<Detail>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;

  final GoogleSignIn googleSignIn = GoogleSignIn();
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
        child: Center(
            child: isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 40.0),
                      )),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "   Detail Monitoring (Data Realtime)",
                              style: new TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      new Container(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 25.0),
                      )),
                      new StreamBuilder<Event>(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child('Monitoring')
                            .onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot<Event> event) {
                          Map<dynamic, dynamic> data =
                              event.data.snapshot.value;
                          return Column(children: [
                            new Center(
                                child: new Container(
                                    width: 380.0,
                                    height: 75.0,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.indigo[400],
                                            Colors.indigo[500]
                                          ],
                                        ),
                                        border: Border.all(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: Text(
                                                '    Hari & Waktu',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Container(
                                            child: Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                          ),
                                        )),
                                        Container(
                                          child: Text(
                                            'Hari : '
                                            '${data['Hari']['Data']}'
                                            '           Waktu : '
                                            '${data['Waktu']['Data']}',
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
                      new Center(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 10.0),
                      )),
                      new StreamBuilder<Event>(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child('Monitoring')
                            .onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot<Event> event) {
                          Map<dynamic, dynamic> data =
                              event.data.snapshot.value;
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
                                            Colors.indigo[400],
                                            Colors.indigo[500]
                                          ],
                                        ),
                                        border: Border.all(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(children: <Widget>[
                                      Container(
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: 8.0,
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: Text(
                                              '    Kecerahan (Lux)',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 17.5,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Container(
                                          child: Text(
                                        '',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      )),
                                      Container(
                                        child: Text(
                                          "  Cerah        Standar Deviasi         Rata-Rata",
                                          style: new TextStyle(
                                              color: Colors.white54,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          " ",
                                          style: new TextStyle(
                                            color: Colors.white54,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: Text(
                                        '${data['Cerah']['Data'].toInt()}'
                                        "                    "
                                        '${data['Cerah_stdv']['Data'].toInt()}'
                                        "                           "
                                        '${data['Cerah_mean']['Data'].toInt()}'
                                        "    ",
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ))
                                    ])))
                          ]);
                        },
                      ),
                      new Center(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 10.0),
                      )),
                      /*new Center(
                          child: new Text(
                        "Suhu Air (Dalam °C)",
                        style: new TextStyle(
                            color: Colors.grey[600], fontSize: 20.0),
                      )),*/
                      new StreamBuilder<Event>(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child('Monitoring')
                            .onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot<Event> event) {
                          Map<dynamic, dynamic> data =
                              event.data.snapshot.value;
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
                                            Colors.indigo[400],
                                            Colors.indigo[500]
                                          ],
                                        ),
                                        border: Border.all(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(children: <Widget>[
                                      Container(
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: 8.0,
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            child: Text(
                                              '    Suhu',
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
                                          fontSize: 10.0,
                                        ),
                                      )),
                                      Container(
                                        child: Text(
                                          "Suhu Air                        Suhu Kotak Alat",
                                          style: new TextStyle(
                                              color: Colors.white54,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          " ",
                                          style: new TextStyle(
                                            color: Colors.white54,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: Text(
                                        '${data['Suhu']['Data'].toInt()} °C'
                                        "                                "
                                        '${data['SuhuAlat']['Data'].toInt()} °C'
                                        "        ",
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ))
                                    ])))
                          ]);
                        },
                      ),
                      new Center(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 10.0),
                      )),
                      new StreamBuilder<Event>(
                        stream: FirebaseDatabase.instance
                            .reference()
                            .child('Monitoring')
                            .onValue,
                        builder:
                            (BuildContext context, AsyncSnapshot<Event> event) {
                          Map<dynamic, dynamic> data =
                              event.data.snapshot.value;
                          return Column(children: [
                            new Center(
                                child: new Container(
                                    width: 380.0,
                                    height: 75.0,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.indigo[400],
                                            Colors.indigo[500]
                                          ],
                                        ),
                                        border: Border.all(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 8.0,
                                            ),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: Text(
                                                '    Status Suhu Air',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Container(
                                            child: Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                          ),
                                        )),
                                        Container(
                                          child: Text(
                                            '${data['StatusSuhu']['Data']}',
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
                      new Center(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 25.0),
                      )),
                      SizedBox(),
                      new Center(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 15.0),
                      )),
                      _monitoring(),
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
                        style:
                            new TextStyle(color: Colors.black, fontSize: 10.0),
                      )),
                      _prediksi(),
                      new Center(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 20.0),
                      )),
                    ],
                  )
                : Text(
                    'Loading',
                    style: TextStyle(fontSize: 30),
                  )),
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
      highlightElevation: 0,
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                ' Info Akun ',
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

  Widget _prediksi() {
    return RaisedButton(
      splashColor: Colors.grey,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              _fetchData();
              _fetchData2();
              return KnnProgram();
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 5,
      color: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'Prediksi KNN',
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

  Widget _monitoring() {
    return RaisedButton(
      splashColor: Colors.grey,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Monitoring();
            },
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 5,
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'Monitoring',
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
}
