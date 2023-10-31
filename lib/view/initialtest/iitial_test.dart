import 'dart:convert';

import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utality/utils.dart';
import '../../resources/components/large_buttons.dart';

class InitialTest extends StatefulWidget {
  String data;
  InitialTest({super.key, required this.data});

  @override
  State<InitialTest> createState() => _InitialTestState();
}

class _InitialTestState extends State<InitialTest> {
  List _armyStoragepaths = [
    '/army/initial_test/physical_test/physical_test.pdf',
    '/army/initial_test/medical_test/medical_test.pdf',
    '/army/initial_test/interview/interview_question.pdf'
  ];
  List _navyStoragepaths = [
    '/navy/initial_test/physical_test/physical_test.pdf',
    '/navy/initial_test/medical_test/medical_test.pdf',
    '/navy/initial_test/interview/interview_question.pdf'
  ];
  List _pafStoragepaths = [
    '/paf/initial_test/physical_test/physical_test.pdf',
    '/paf/initial_test/medical_ytest/medical_test.pdf',
    '/paf/initial_test/interview/interview_question.pdf'
  ];
  List _asfStoragepaths = [
    '/asf/physical_test/physical_test.pdf',
    '/asf/medical_test/medical_test.pdf',
    '/asf/interview/interview_question .pdf'
  ];
  List _anfyStoragepaths = [
    '/anf/Test_content/physical_test/physical_test.pdf',
    '/anf/Test_content/medical_test/medical_test.pdf',
    '/anf/Test_content/interview/interview_question .pdf'
  ];
  final _Storageref = FirebaseStorage.instance.ref();
  List _Urls = [];
  Future geturls() async {
    switch (widget.data) {
      case 'Army':
        _Urls.clear();
        for (var i = 0; i < _armyStoragepaths.length; i++) {
          var temp = await _Storageref.child(_armyStoragepaths[i].toString())
              .getDownloadURL();
          _Urls.add(temp);
          print(_Urls);
        }

        break;
      case 'Navy':
        _Urls.clear();
        for (var i = 0; i < _navyStoragepaths.length; i++) {
          var temp = await _Storageref.child(_navyStoragepaths[i].toString())
              .getDownloadURL();
          _Urls.add(temp);
          print(_Urls);
        }
        break;
      case 'PAF':
        _Urls.clear();
        for (var i = 0; i < _pafStoragepaths.length; i++) {
          var temp = await _Storageref.child(_pafStoragepaths[i].toString())
              .getDownloadURL();
          _Urls.add(temp);
          print(_Urls);
        }
        break;
      case 'ANF':
        _Urls.clear();
        for (var i = 0; i < _anfyStoragepaths.length; i++) {
          var temp = await _Storageref.child(_anfyStoragepaths[i].toString())
              .getDownloadURL();
          _Urls.add(temp);
          print(_Urls);
        }
        break;
      case 'ASF':
        _Urls.clear();
        for (var i = 0; i < _asfStoragepaths.length; i++) {
          var temp = await _Storageref.child(_asfStoragepaths[i].toString())
              .getDownloadURL();
          _Urls.add(temp);
          print(_Urls);
        }
        break;
      default:
    }
  }

  final _db = FirebaseFirestore.instance;
  List list = [];
  dynamic data;
  Future<dynamic> getdata() async {
    return jsonDecode(data);
  }

  void getresponse() async {
    data = await _db.doc("mcq_test").get();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    geturls();
  }

  @override
  Widget build(BuildContext context) {
    print(data.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Arsam Javed'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: widget.data == 'ANF'
                ? _db.collection("/ANF/info/test").doc("tests").get().then(
                    (value) {
                    return value;
                  }).onError(
                    (error, stackTrace) => Utils.toastMessage(error.toString()))
                : widget.data == 'ASF'
                    ? _db
                        .collection("/ANF/info/test")
                        .doc("tests")
                        .get()
                        .then((value) {
                        return value;
                      }).onError((error, stackTrace) =>
                            Utils.toastMessage(error.toString()))
                    : _db
                        .collection("/Army/info/initial_test")
                        .doc("tests")
                        .get()
                        .then((value) {
                        return value;
                      }).onError((error, stackTrace) =>
                            Utils.toastMessage(error.toString())),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data!.exists) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                list = data.entries.map((e) => (e.value)).toList();
                list.sort();

                return Expanded(
                  child: ListView.builder(
                    itemCount: list.length.toInt(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomANimatedButton(
                          alignment: Alignment.centerLeft,
                          onpress: () {
                            if (widget.data == 'ASF' || widget.data == 'ANF') {
                              if (index == 1) {
                                Navigator.pushNamed(
                                    context, RouteNames.anf_intelligence_test);
                              } else {
                                if (index == 0) {
                                  Navigator.pushNamed(
                                      context, RouteNames.viewerscreen,
                                      arguments: {
                                        'url': _Urls[index],
                                        'name': list[index],
                                      });
                                } else {
                                  Navigator.pushNamed(
                                      context, RouteNames.viewerscreen,
                                      arguments: {
                                        'url': _Urls[index - 1],
                                        'name': list[index],
                                      });
                                }
                              }
                            } else {
                              if (index == 0) {
                                Navigator.pushNamed(
                                    context, RouteNames.tests_screen);
                              } else {
                                Navigator.pushNamed(
                                    context, RouteNames.viewerscreen,
                                    arguments: {
                                      'url': _Urls[index - 1],
                                      'name': list[index],
                                    });
                              }
                            }
                          },
                          height: 60.0,
                          text: " ${list[index]}",
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Text(snapshot.data!.data().toString());
              }
            },
          )
        ],
      ),
    );
  }
}
