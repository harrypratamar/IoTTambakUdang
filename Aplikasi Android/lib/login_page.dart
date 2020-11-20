import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hello/sign_in.dart';

import 'monitoring.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.grey[400], Colors.grey[100]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 130),
              Text(
                " ",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.pink,
                  height: 18, // insert your font size here
                ),
              ),
              SizedBox(height: 20),
              _signInButton(),
            ],
          ),
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

  Widget _signInButton() {
    return RaisedButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                _fetchData();
                _fetchData2();
                return Monitoring();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      highlightElevation: 5,
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'klik Untuk Login / Melanjutkan',
                style: TextStyle(
                  fontSize: 20,
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
