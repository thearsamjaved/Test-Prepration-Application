import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:adil_fyp/resources/components/large_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MockTest extends StatefulWidget {
  const MockTest({super.key});

  @override
  State<MockTest> createState() => _MockTestState();
}

class _MockTestState extends State<MockTest> {
  final _db = FirebaseFirestore.instance;
  final String colfield =
      '/Army/info/initial_test/tests/intelligence_test/mcq_test/mock_test/tests';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verbal'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: _db
                .collection(
                    '/Army/info/initial_test/tests/intelligence_test/mcq_test/mock_test')
                .doc('tests')
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
                              Navigator.pushNamed(
                                context,
                                RouteNames.mcq_test_screen,
                                arguments: '$colfield/${listval[index]}',
                              );
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
          ),
        ],
      ),
    );
  }
}
