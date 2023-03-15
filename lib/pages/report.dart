import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  List myAnswers = List();

  ReportPage(myAnswers) {
    this.myAnswers = myAnswers;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("My Report"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: myAnswers.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: myAnswers[index]);
          },
        ),
      ),
    );
  }
}
