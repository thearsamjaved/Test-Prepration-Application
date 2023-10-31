import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:adil_fyp/resources/components/large_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AnfIntelligenceTest extends StatefulWidget {
  const AnfIntelligenceTest({super.key});

  @override
  State<AnfIntelligenceTest> createState() => _AnfIntelligenceTestState();
}

class _AnfIntelligenceTestState extends State<AnfIntelligenceTest> {
  var _db = FirebaseFirestore.instance;
  List paths = [
    '/anf/Test_content/intelligence test/English.pdf',
    '/anf/Test_content/intelligence test/Pakistan study.pdf',
    '/anf/Test_content/intelligence test/personality assessment test.pdf',
    '/anf/Test_content/intelligence test/islamiat.pdf',
    '/anf/Test_content/intelligence test/Urdu.pdf',
    '/anf/Test_content/intelligence test/general knowldge.pdf',
    '/anf/Test_content/intelligence test/daily science.pdf',
  ];
  final _Storageref = FirebaseStorage.instance.ref();
  List Urls = [];
  Future getUrls() async {
    for (var i = 0; i < paths.length; i++) {
      var temp = await _Storageref.child(paths[i].toString()).getDownloadURL();
      Urls.add(temp);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUrls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intelligence Test'),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: _db
                  .collection('/ANF/info/test/tests/intelligence_test')
                  .doc('subjects')
                  .get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data!.data() != 'null') {
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
                                Navigator.pushNamed(
                                    context, RouteNames.viewerscreen,
                                    arguments: {
                                      'url': Urls[index],
                                      'name': list[index],
                                    });
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
              })
        ],
      ),
    );
  }
}
