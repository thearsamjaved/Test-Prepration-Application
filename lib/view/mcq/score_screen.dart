import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  String score;
  ScoreScreen({super.key, required this.score});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'You have got ' + widget.score.toString() + ' MCQs right',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
