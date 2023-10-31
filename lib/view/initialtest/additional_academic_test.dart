import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Utality/routes/route_name.dart';
import '../../resources/components/large_buttons.dart';

class AdditionalAcademic extends StatefulWidget {
  dynamic data;

  AdditionalAcademic({super.key, required this.data});

  @override
  State<AdditionalAcademic> createState() => _AdditionalAcademicState();
}

class _AdditionalAcademicState extends State<AdditionalAcademic> {
  final _db = FirebaseFirestore.instance;

  // void getcolname() async {
  //   var collecdata = await _db
  //       .collection(widget.data['coladdress'])
  //       .doc(widget.data['docname'])
  //       .get();
  // }

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
                .collection(widget.data['coladdress'])
                .doc(widget.data['docname'])
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
                              print(
                                  '${widget.data['coladdress']}/${widget.data['docname']}/${listval[index]}');
                              Navigator.pushNamed(
                                context,
                                RouteNames.mcq_train,
                                arguments:
                                    '${widget.data['coladdress']}/${widget.data['docname']}/${listval[index]}',
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
          )
        ],
      ),
    );
  }
}
