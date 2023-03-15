import 'package:flutter/material.dart';
import 'package:quiz/pages/quiz.dart';
import 'package:quiz/pages/topics.dart';
import 'package:share/share.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool networkState = true;

  _chkNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          networkState = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        networkState = false;
      });
    }
  }

  _launchURL() async {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    var url = 'https://flutter.dev';
    if (isIOS) {
      url = Constants().appStoreURL;
    } else {
      url = Constants().playStoreURL;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chkNetwork();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xff142850),
        appBar: AppBar(
          title: Text(""),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.all(12.0),
                  height: 160.0,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 80.0,
                    height: 80.0,
                  ),
                ),
              ),
              Text(
                "Flutter Quiz App",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0),
              ),
              Text(""),
              Text(
                "Learn • Take Quiz • Repeat",
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
              SizedBox(height: 28),
              Container(
                padding: EdgeInsets.all(18.0),
                margin: EdgeInsets.all(40.0),
                alignment: FractionalOffset.bottomCenter,
                child: networkState
                    ? Column(
                        children: <Widget>[
                          SizedBox(
                              width: double.infinity,
                              height: 52.0,
                              child: RaisedButton(
                                child: Text(
                                  'PLAY',
                                  style: TextStyle(color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                color: Color(0xFF00a8cc),
                                elevation: 0,
                                onPressed: !networkState
                                    ? null
                                    : () {
                                        final url = Constants().apiURL +
                                            "api/questions?limit=" +
                                            Constants().defaultCount.toString();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  QuizPage(url)),
                                        );
                                      },
                              )),
                          Text(""),
                          SizedBox(
                            width: double.infinity,
                            height: 52.0,
                            child: RaisedButton(
                              color: Color(0xff142850),
                              textColor: Color(0xFF00a8cc),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0),
                                side: BorderSide(
                                    color: Color(0xFF00a8cc), width: 2.0),
                              ),
                              child: Text("TOPICS"),
                              onPressed: !networkState
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TopicPage(),
                                        ),
                                      );
                                    },
                            ),
                          ),
                          Text(""),
                          Text(""),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.share,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      "Share",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                onPressed: () =>
                                    Share.share(Constants().shareText),
                              ),
                              FlatButton(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      "Rate Us",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                                onPressed: _launchURL,
                              ),
                            ],
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          children: <Widget>[
                            Text("No Network Connection"),
                            FlatButton(
                              child: Text("Try Again"),
                              onPressed: () => _chkNetwork(),
                            )
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ));
  }
}
