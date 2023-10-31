import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../resources/components/large_buttons.dart';

class AcademicTest extends StatefulWidget {
  const AcademicTest({super.key});

  @override
  State<AcademicTest> createState() => _AcademicTestState();
}

class _AcademicTestState extends State<AcademicTest> {
  final _db = FirebaseFirestore.instance;
  var path =
      "/Army/info/initial_test/tests/intelligence_test/mcq_test/academic_test/academic_test_document";
  void getcolname() async {
    var collecdata = await _db
        .collection(
            '/Army/info/initial_test/tests/intelligence_test/mcq_test/academic_test/academic_test_document')
        .doc('academic_test_document')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Test'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: _db
                .collection(
                    '/Army/info/initial_test/tests/intelligence_test/mcq_test/academic_test')
                .doc('academic_test_document')
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.data() != 'null') {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                var list = data.entries.map((e) => (e.key)).toList();
                var listval = data.entries.map((e) => (e.value)).toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomANimatedButton(
                            lines: 1,
                            alignment: Alignment.centerLeft,
                            onpress: () {
                              if (list[index] == "Daily Science" ||
                                  list[index] == "Islamiyat" ||
                                  list[index] == "Math" ||
                                  list[index] == "Physics") {
                                Navigator.pushNamed(
                                    context, RouteNames.mcq_train,
                                    arguments: '$path/${listval[index]}');
                              } else if (list[index] == 'Computer') {
                                Navigator.pushNamed(
                                    context, RouteNames.additional_academic,
                                    arguments: {
                                      'coladdress': '$path/${listval[index]}',
                                      'docname': 'computer'
                                    });
                              } else if (list[index] == 'English') {
                                Navigator.pushNamed(
                                    context, RouteNames.additional_academic,
                                    arguments: {
                                      'coladdress': '$path/${listval[index]}',
                                      'docname': 'English'
                                    });
                              } else if (list[index] == 'General Knowledge') {
                                Navigator.pushNamed(
                                    context, RouteNames.additional_academic,
                                    arguments: {
                                      'coladdress': '$path/${listval[index]}',
                                      'docname': 'General_knowledge'
                                    });
                              } else if (list[index] == 'Pak Studies') {
                                Navigator.pushNamed(
                                    context, RouteNames.additional_academic,
                                    arguments: {
                                      'coladdress': '$path/${listval[index]}',
                                      'docname': 'Pak_studies'
                                    });
                              }
                            },
                            height: 60.0,
                            text: ' ${list[index]}'),
                      );
                    },
                  ),
                );
              } else {
                return Text(snapshot.error.toString());
              }
            },
          )
        ],
      ),
    );
  }
}
