import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:quiz/constants.dart';
import 'package:quiz/pages/quiz.dart';

class TopicPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TopicPageState();
  }
}

class _TopicPageState extends State<TopicPage> {
  List topics = [];

  _fetchTopics() async {
    final response = await http.get(Constants().apiURL + "api/settings");
    if (response.statusCode == 200) {
      final settings = json.decode(response.body);
      topics = settings['categorylist'] as List;
      // print(topics);
      setState(() {
        topics = topics;
      });
    } else {
      print("Failed");
      // throw Exception('Failed');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fetchTopics();

    return Scaffold(
      backgroundColor: Color(0xff142850),
      appBar: AppBar(
        title: Text("Topics"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20.0),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Color(0xff193469),
                ),
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      topics[index],
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white70,
                    )
                  ],
                )),
            onTap: () {
              final url = Constants().apiURL +
                  "api/questions?limit=" +
                  Constants().defaultCount.toString() +
                  "&t_name=" +
                  topics[index];

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage(url)),
              );
            },
          );
        },
      ),
    );
  }
}
