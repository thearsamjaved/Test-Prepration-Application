import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingProgressBarIndicator extends StatefulWidget {
  final double progressval;
  const LoadingProgressBarIndicator({super.key, required this.progressval});

  @override
  State<LoadingProgressBarIndicator> createState() =>
      _LoadingProgressBarIndicatorState();
}

class _LoadingProgressBarIndicatorState
    extends State<LoadingProgressBarIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        backgroundColor: Color.fromARGB(255, 223, 217, 217),
        value: widget.progressval,
        minHeight: 10,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
      ),
    );
  }
}
