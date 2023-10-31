// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class LoadingProgressBarIndicator extends StatefulWidget {
//   const LoadingProgressBarIndicator({super.key});

//   @override
//   State<LoadingProgressBarIndicator> createState() =>
//       _LoadingProgressBarIndicatorState();
// }

// class _LoadingProgressBarIndicatorState
//     extends State<LoadingProgressBarIndicator> {
//   bool _loading = false;
//   double _progressval = 0.0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loading = true;
//     _progressval = 0.3;
//   }

//   @override
//   Widget build(BuildContext context) {
//     setState(() {
//       _updateProgress();
//     });
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         LinearProgressIndicator(
//             backgroundColor: Colors.white,
//             valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
//             value: _progressval),
//       ],
//     );
//   }

//   double _updateProgress() {
//     const oneSec = const Duration(seconds: 1);
//     Timer.periodic(oneSec, (Timer t) {
//       setState(() {
//         _progressval += 0.1;
//         if (_progressval.toStringAsFixed(1) == '1.0') {
//           t.cancel();
//           return;
//         }
//       });
//     });
//     return _progressval;
//   }
// }
