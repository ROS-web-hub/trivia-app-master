import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:share/share.dart';

class ResultPage extends StatelessWidget {
  double rightAnswerCount = 0;
  double wrongAnswerCount = 0;
  double totalCount = 0;
  List myAnswers = List();

  ResultPage(right, wrong, total, answersList) {
    this.rightAnswerCount = right.toDouble();
    this.wrongAnswerCount = wrong.toDouble();
    this.totalCount = total.toDouble();
    this.myAnswers = answersList;
  }

  @override
  Widget build(BuildContext context) {
    // Data
    final GlobalKey<AnimatedCircularChartState> _chartKey =
        new GlobalKey<AnimatedCircularChartState>();

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(wrongAnswerCount, Colors.red[300],
              rankKey: 'wrong'),
          new CircularSegmentEntry(rightAnswerCount, Colors.green[300],
              rankKey: 'right'),
        ],
        rankKey: 'Your Scores',
      ),
    ];

    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff142850),
      appBar: AppBar(
        title: Text("Your Score"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(12.0),
            child: AnimatedCircularChart(
              key: _chartKey,
              size: const Size(160.0, 160.0),
              initialChartData: data,
              chartType: CircularChartType.Radial,
              labelStyle: TextStyle(color: Colors.white),
              holeLabel: rightAnswerCount.toInt().toString() +
                  " / " +
                  totalCount.toInt().toString(),
            ),
          ),
          Container(
            height: 40.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Share your score',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightBlue,
              onPressed: () => Share.share("I have Scored " +
                  rightAnswerCount.toString() +
                  "/" +
                  totalCount.toString() +
                  " on Quiz App \n \n Download now: http://google.com"),
            ),
          ),
          Container(
            margin: EdgeInsets.all(12.0),
            child: Text(
              "Your Report",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.all(4.0),
            itemCount: myAnswers.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(myAnswers[index]['question'],
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: myAnswers[index]['answer'] ==
                                myAnswers[index]['myAnswer']
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                    Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    Text(myAnswers[index]['answer'],
                                        style: TextStyle(color: Colors.white))
                                  ])
                            : Row(children: <Widget>[
                                Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                Text(myAnswers[index]['myAnswer'],
                                    style: TextStyle(color: Colors.white)),
                                Text(" "),
                                Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                Text(myAnswers[index]['answer'],
                                    style: TextStyle(color: Colors.white)),
                              ]),
                      ),
                      // Text(
                      //   "Answer: " + myAnswers[index]['answer'],
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      // Text(
                      //   "My Answer: " + myAnswers[index]['myAnswer'],
                      //   style: TextStyle(color: Colors.white),
                      // ),
                    ],
                  ));
            },
          )),
        ],
      ),
    );
  }
}
