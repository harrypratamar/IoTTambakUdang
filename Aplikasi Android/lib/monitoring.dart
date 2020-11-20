import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello/info_screen.dart';
import 'package:hello/detail.dart';

import 'CircleProgress.dart';


class Monitoring extends StatefulWidget {
  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final databaseReference = FirebaseDatabase.instance.reference();
  
  AnimationController progressController;
  Animation<double> suhuAnimation;
  Animation<double> cerahAnimation;

  @override
  void initState() {
    super.initState();

    databaseReference.child('Monitoring').once().then((DataSnapshot snapshot) {
      double suhu = snapshot.value['Suhu']['Data'];
      double cerah = snapshot.value['Cerah']['Data'];

      isLoading = true;
      _dashboardInit(suhu, cerah);
    });
  }

  _dashboardInit(double suhu, double cerah) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000)); //5s

    suhuAnimation =
        Tween<double>(begin: 0, end: suhu).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    cerahAnimation =
        Tween<double>(begin: 0, end: cerah).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    progressController.forward();
  }

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
                            new TextStyle(color: Colors.black, fontSize: 15.0),
                      )),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "   Monitoring (Refresh Untuk Data Baru)",
                              style: new TextStyle(
                                  color: Colors.grey[800], fontSize: 22.0, fontWeight: FontWeight.bold),
                            ),
                          )),
                      new Container(
                          child: new Text(
                        " ",
                        style:
                            new TextStyle(color: Colors.black, fontSize: 13.0),
                      )),
                      CustomPaint(
                        foregroundPainter:
                            CircleProgress(suhuAnimation.value, true),
                        child: Container(
                          width: 195,
                          height: 195,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Suhu'),
                                Text(
                                  '${suhuAnimation.value.toInt()}',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '°C',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      CustomPaint(
                        foregroundPainter:
                            CircleProgress(cerahAnimation.value, false),
                        child: Container(
                          width: 195,
                          height: 195,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Intensitas Cahaya'),
                                Text(
                                  '${cerahAnimation.value.toInt()}',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Lux',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(),
                      _detail(),
                      _infoButton(),
                      _refresh(),
                    ],
                  )
                : Text(
                    'Loading',
                    style: TextStyle(fontSize: 20),
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
      highlightElevation: 5,
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'Info Akun',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight : FontWeight.bold
                ),
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
                  fontWeight : FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _refresh() {
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
      color: Colors.lightBlue,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                'Refresh',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight : FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
