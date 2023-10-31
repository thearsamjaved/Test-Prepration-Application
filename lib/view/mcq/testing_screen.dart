import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:adil_fyp/model/mcq_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class McqTestScreen extends StatefulWidget {
  dynamic coladdress;
  McqTestScreen({super.key, required this.coladdress});

  @override
  State<McqTestScreen> createState() => _McqTestScreenState();
}

class _McqTestScreenState extends State<McqTestScreen> {
  bool isA = false;
  bool isB = false;
  bool isC = false;
  bool isD = false;
  Color aborderColor = Colors.grey;
  Color bborderColor = Colors.grey;
  Color cborderColor = Colors.grey;
  Color dborderColor = Colors.grey;
  int marks = 0;
  var _db = FirebaseFirestore.instance;
  int mcqno = 0;
  int mcq_count = 1;
  int count = 0;
  bool isCorrect = false;
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
                  InkWell(
                    onTap: () {
                      isA = true;
                      isB = false;
                      isC = false;
                      isD = false;
                      aborderColor = Colors.green;
                      bborderColor = Colors.grey;
                      cborderColor = Colors.grey;
                      dborderColor = Colors.grey;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: aborderColor)),
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
                                                    isCorrect == true
                                                ? Colors.green
                                                : Colors.black),
                                  )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      isA = false;
                      isB = true;
                      isC = false;
                      isD = false;
                      aborderColor = Colors.grey;
                      bborderColor = Colors.green;
                      cborderColor = Colors.grey;
                      dborderColor = Colors.grey;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            border: Border.all(color: bborderColor)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: datalist.isEmpty
                              ? Text('')
                              : Text(
                                  ' B ${datalist[mcqno].b}',
                                  style: TextStyle(
                                    color: datalist[mcqno].ans.toLowerCase() ==
                                                'b' &&
                                            isCorrect == true
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                                  maxLines: 2,
                                ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      isA = false;
                      isB = false;
                      isC = true;
                      isD = false;
                      aborderColor = Colors.grey;
                      bborderColor = Colors.grey;
                      cborderColor = Colors.green;
                      dborderColor = Colors.grey;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            border: Border.all(color: cborderColor)),
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
                                                    isCorrect == true
                                                ? Colors.green
                                                : Colors.black),
                                  )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      isA = false;
                      isB = false;
                      isC = false;
                      isD = true;
                      aborderColor = Colors.grey;
                      bborderColor = Colors.grey;
                      cborderColor = Colors.grey;
                      dborderColor = Colors.green;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            border: Border.all(color: dborderColor)),
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
                                                    isCorrect == true
                                                ? Colors.green
                                                : Colors.black),
                                  )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Show Answers'),
                  //     Switch(
                  //         value: isMcqShown,
                  //         onChanged: (value) {
                  //           isMcqShown = !isMcqShown;
                  //           setState(() {});
                  //         })
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (mcqno == datalist.length - 1) {
                              Navigator.pushReplacementNamed(
                                  context, RouteNames.score_screen,
                                  arguments: marks.toString());
                            } else if (isA &&
                                datalist[mcqno].ans.toLowerCase() == 'a') {
                              mcqno++;
                              count++;
                              mcq_count++;
                              marks++;
                              isA = false;
                              isB = false;
                              isC = false;
                              isD = false;
                              aborderColor = Colors.grey;
                              bborderColor = Colors.grey;
                              cborderColor = Colors.grey;
                              dborderColor = Colors.grey;
                              setState(() {});
                            } else if (isB &&
                                datalist[mcqno].ans.toLowerCase() == 'b') {
                              mcqno++;
                              count++;
                              mcq_count++;
                              marks++;
                              isA = false;
                              isB = false;
                              isC = false;
                              isD = false;
                              aborderColor = Colors.grey;
                              bborderColor = Colors.grey;
                              cborderColor = Colors.grey;
                              dborderColor = Colors.grey;
                              setState(() {});
                            } else if (isC &&
                                datalist[mcqno].ans.toLowerCase() == 'c') {
                              mcqno++;
                              count++;
                              mcq_count++;
                              marks++;
                              isA = false;
                              isB = false;
                              isC = false;
                              isD = false;
                              aborderColor = Colors.grey;
                              bborderColor = Colors.grey;
                              cborderColor = Colors.grey;
                              dborderColor = Colors.grey;
                              setState(() {});
                            } else if (isD &&
                                datalist[mcqno].ans.toLowerCase() == 'd') {
                              mcqno++;
                              count++;
                              mcq_count++;
                              marks++;
                              isA = false;
                              isB = false;
                              isC = false;
                              isD = false;
                              aborderColor = Colors.grey;
                              bborderColor = Colors.grey;
                              cborderColor = Colors.grey;
                              dborderColor = Colors.grey;
                              setState(() {});
                            } else {
                              mcqno++;
                              count++;
                              mcq_count++;

                              isA = false;
                              isB = false;
                              isC = false;
                              isD = false;
                              aborderColor = Colors.grey;
                              bborderColor = Colors.grey;
                              cborderColor = Colors.grey;
                              dborderColor = Colors.grey;
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
