import 'package:flutter/material.dart';

class SplashViewModel with ChangeNotifier {
  double _progresslevel = 0.0;
  double get progresslevel => _progresslevel;
  setprogresslevel() {
    _progresslevel += 0.3;
    notifyListeners();
  }

  // Future updateProgress() async {
  //   const oneSec = const Duration(seconds: 1);
  //   await Timer.periodic(oneSec, (Timer t) {
  //     _progresslevel = 0.3;

  //     if (_progresslevel.toString() == '1.0') {
  //       t.cancel();
  //       notifyListeners();
  //     }
  //   });
  //   print(_progresslevel);
  //   return _progresslevel;
  // }
}
