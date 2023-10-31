import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:adil_fyp/resources/components/large_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});
  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  final _storageref = FirebaseStorage.instance.ref();
  final db = FirebaseFirestore.instance;
  final path = '/army/initial_test/intelligence_test/non_verbal.pdf';
  var url;
  void getUrl() async {
    url = await _storageref.child(path.toString()).getDownloadURL();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intelligence Test'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: db
                .collection('/Army/info/initial_test/tests/intelligence_test')
                .doc('mcq_test')
                .get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != 'null') {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                var list = data.entries.map((e) => (e.key)).toList();
                list.sort();
                print(url.toString());
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      if (index == 1) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomANimatedButton(
                              alignment: Alignment.centerLeft,
                              onpress: () {
                                Navigator.pushNamed(
                                    context, RouteNames.viewerscreen,
                                    arguments: {
                                      'url': url.toString(),
                                      'name': 'Non Verbal'
                                    });
                              },
                              height: 60.0,
                              text: " ${list[index]}"),
                        );
                      } else if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomANimatedButton(
                            alignment: Alignment.centerLeft,
                            onpress: () {
                              Navigator.pushNamed(
                                  context, RouteNames.verbal_test);
                            },
                            height: 60.0,
                            text: " ${list[index]}",
                          ),
                        );
                      } else if (index == 2) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomANimatedButton(
                              alignment: Alignment.centerLeft,
                              onpress: () {
                                Navigator.pushNamed(
                                    context, RouteNames.academic_test);
                              },
                              height: 60.0,
                              text: " ${list[index]}"),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomANimatedButton(
                              alignment: Alignment.centerLeft,
                              onpress: () {
                                Navigator.pushNamed(
                                    context, RouteNames.mocktest_screen);
                              },
                              height: 60.0,
                              text: " ${list[index]}"),
                        );
                      }
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
