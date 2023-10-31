import 'dart:async';

import 'package:adil_fyp/viewmodel/services/splash_services.dart';
import 'package:adil_fyp/viewmodel/splash_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../resources/components/splash_progressbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    _splashServices.islogin(context);
    Timer.periodic(Duration(seconds: 1), (t) {
      var _splashViewModel =
          Provider.of<SplashViewModel>(context, listen: false);
      _splashViewModel.setprogresslevel();
      if (_splashViewModel.progresslevel.toStringAsFixed(1) == '1.0') {
        t.cancel();
      }
    });
    super.initState();
    // print(_updateProgress());
    // if (_updateProgress() == 1.0) {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => GuestScreen(),
    //       ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/logo.png"), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Loading",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Consumer<SplashViewModel>(
                  builder: (context, value, child) {
                    return LoadingProgressBarIndicator(
                        progressval: value.progresslevel);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
