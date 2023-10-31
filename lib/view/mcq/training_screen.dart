import 'package:adil_fyp/model/mcq_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class McqScreen extends StatefulWidget {
  dynamic coladdress;
  McqScreen({super.key, required this.coladdress});

  @override
  State<McqScreen> createState() => _McqScreenState();
}

class _McqScreenState extends State<McqScreen>
    with SingleTickerProviderStateMixin {
  var _db = FirebaseFirestore.instance;
  int mcqno = 0;
  int mcq_count = 1;
  int count = 0;
  bool isMcqShown = true;
  List<mcqModel> datalist = [];
  dynamic data;
  dynamic getmcq() async {
    QuerySnapshot _querysnapshot =
        await _db.collection(widget.coladdress.toString()).get().then((value) {
      data = value.docs.map((e) => e.data()).toList();
      datalist.clear();
      for (Map<String, dynamic> i in data) {
        datalist.add(mcqModel.fromMap(i));
        setState(() {});
      }
      return value;
    });
  }

  @override
  void initState() {
    super.initState();
    getmcq();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(datalist[mcqno].a.toString());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('MCQs'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: data == null
                        ? CircularProgressIndicator()
                        : Text(
                            '$mcq_count/${data.length}',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  datalist.isEmpty
                      ? Text('')
                      : Text(
                          '1 ${datalist[mcqno].q}',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: datalist.isEmpty
                              ? Text('')
                              : Text(
                                  ' A ${datalist[mcqno].a}',
                                  style: TextStyle(
                                      color:
                                          datalist[mcqno].ans.toLowerCase() ==
                                                      'a' &&
                                                  isMcqShown == true
                                              ? Colors.green
                                              : Colors.black),
                                )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: datalist.isEmpty
                            ? Text('')
                            : Text(
                                ' B ${datalist[mcqno].b}',
                                style: TextStyle(
                                  color: datalist[mcqno].ans.toLowerCase() ==
                                              'b' &&
                                          isMcqShown == true
                                      ? Colors.green
                                      : Colors.black,
                                ),
                                maxLines: 2,
                              ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: datalist.isEmpty
                              ? Text('')
                              : Text(
                                  ' C ${datalist[mcqno].c}',
                                  style: TextStyle(
                                      color:
                                          datalist[mcqno].ans.toLowerCase() ==
                                                      'c' &&
                                                  isMcqShown == true
                                              ? Colors.green
                                              : Colors.black),
                                )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: datalist.isEmpty
                              ? Text('')
                              : Text(
                                  ' D ${datalist[mcqno].d}',
                                  style: TextStyle(
                                      color:
                                          datalist[mcqno].ans.toLowerCase() ==
                                                      'd' &&
                                                  isMcqShown == true
                                              ? Colors.green
                                              : Colors.black),
                                )),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Show Answers'),
                      Switch(
                          value: isMcqShown,
                          onChanged: (value) {
                            isMcqShown = !isMcqShown;
                            setState(() {});
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (mcqno == 0) {
                              Null;
                            } else {
                              mcqno--;
                              count--;
                              mcq_count--;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.3,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (mcqno == datalist.length - 1) {
                              Navigator.pop(context);
                            } else {
                              mcqno++;
                              count++;
                              mcq_count++;
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: size.width * 0.3,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
          );
        },
        // child:
      ),
    );
  }
}
