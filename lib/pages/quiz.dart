import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz/constants.dart';
import 'package:quiz/pages/result.dart';
import 'package:http/http.dart' as http;

class QuizPage extends StatefulWidget {
  String url;
  QuizPage(url) {
    this.url = url;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QuizPageState();
  }
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  Map currentQuestion = {};
  List questions = List();
  int rightAnswerCount = 0;
  int wrongAnswerCount = 0;
  double percentage = 0.0;
  List myAnswers = [];
  bool isLoading = true;
  // String url;

  _fetchData() async {
    print(widget.url);
    http.get(widget.url).then((res) {
      questions = json.decode(res.body) as List;
      setState(() {
        questions = questions;
        isLoading = false;
      });
    }).catchError((e) {
      print("Error");
      print(e);
      setState(() {
        isLoading = false;
      });
    });
  }

  _validateAnswer(selectedIndex) {
    if (currentIndex <= questions.length) {
      if (selectedIndex == questions[currentIndex]["answer"])
        setState(() => rightAnswerCount = rightAnswerCount + 1);

      myAnswers.add({
        "question": questions[currentIndex]["question"],
        "answer": questions[currentIndex]["options"]
            [questions[currentIndex]["answer"] - 1],
        "myAnswer": questions[currentIndex]["options"][selectedIndex - 1]
      });

      if (currentIndex != questions.length - 1) {
        setState(() {
          myAnswers = myAnswers;
          currentIndex = currentIndex + 1;
          percentage = currentIndex / questions.length;
        });
      } else {
        _moveToResult();
      }
    }
  }

  _moveToResult() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                rightAnswerCount,
                questions.length - rightAnswerCount,
                questions.length,
                myAnswers)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff142850),
        appBar: AppBar(
          title: Text("Quiz Page"),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  "Exit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context))
          ],
          bottom: PreferredSize(
              child: LinearProgressIndicator(
                  backgroundColor: Color(0xff27496d),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xffffd082)),
                  value: percentage)),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(8.0),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : questions.length == 0
                  ? Center(
                      child: Text(
                      "No Data Found, Please Retry",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ))
                  : Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          width: double.infinity,
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    questions[currentIndex]['question'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                questions[currentIndex]['image'] == null
                                    ? Container()
                                    : Image.network(
                                        Constants().storageUrl +
                                            questions[currentIndex]['image'],
                                        height: 200.0,
                                      ),
                              ]),
                        ),
                        Text(""),
                        Text(""),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              height: 48.0,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    questions[currentIndex]['options'][0],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () => _validateAnswer(1)),
                            ),
                            Text(""),
                            SizedBox(
                              width: double.infinity,
                              height: 48.0,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    questions[currentIndex]['options'][1],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () => _validateAnswer(2)),
                            ),
                            Text(""),
                            SizedBox(
                              width: double.infinity,
                              height: 48.0,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    questions[currentIndex]['options'][2],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () => _validateAnswer(3)),
                            ),
                            Text(""),
                            SizedBox(
                              width: double.infinity,
                              height: 48.0,
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  color: Colors.white,
                                  child: Text(
                                    questions[currentIndex]['options'][3],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () => _validateAnswer(4)),
                            ),
                          ],
                        ),
                      ],
                    ),
        ));
  }
}
