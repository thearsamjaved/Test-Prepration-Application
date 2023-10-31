import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:adil_fyp/Utality/utils.dart';
import 'package:adil_fyp/resources/components/large_buttons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});
  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  String forceType = '';
  var useremail;
  var count = 0;
  List<String> army_Subjects = [
    'Information',
    'Armed Force \nInfo',
    'Who Can Apply',
    'Selection \nProcedure',
    'Initial Test',
  ];
  List<String> anf_subjects = [
    'Information',
    'Who Can Apply',
    'Application \nProcedure',
    'ANF Test \nSalybus',
    'ANF Written \nTest',
    'Initial Test',
  ];
  List<String> asf_subjects = [
    'Information',
    'Who Can Apply',
    'Application \nProcedure',
    'Initial Test',
  ];
  List<dynamic> armyPpaths = [
    '/army/information_about_army.pdf',
    '/army/armd_forces.pdf',
    '/army/who_can_apply_in_army.pdf',
    '/army/selection_procedure.pdf',
  ];
  List<dynamic> navyPpaths = [
    '/navy/information_about_pak_navy.pdf',
    '/navy/armd_forces.pdf',
    '/navy/who_can_apply_in_pak_navy.pdf',
    '/navy/selection_procedure.pdf',
  ];
  List<dynamic> pafPpaths = [
    '/paf/information_about_paf.pdf',
    '/paf/armd_forces.pdf',
    '/paf/who_can_apply_in_paf.pdf',
    '/paf/selection_procedure.pdf',
  ];
  List<dynamic> anfPpaths = [
    '/anf/Information.pdf',
    '/anf/Who_can_apply.pdf',
    '/anf/Information_about_apply.pdf',
    '/anf/anf_test_sylabus.pdf',
    '/anf/anf_written_test.pdf',
  ];
  List<dynamic> asfPpaths = [
    '/asf/information.pdf',
    '/asf/Who_can_apply.pdf',
    '/asf/information_about_apply.pdf',
  ];
  List<dynamic> Urls = [];
  final _Storageref = FirebaseStorage.instance.ref();
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _user = FirebaseFirestore.instance.collection('User');
  // var name = _db.collection('User').doc('arsamjavid@gmail.com').snapshots();
  Map<String, dynamic> name = {'name': ''};
  Future<void> getname() async {
    await _user.doc(useremail.toString()).get().then((value) {
      if (value.exists) {
        name = value.data() as Map<String, dynamic>;
        forceType = name['forceType'];
        if (name['forceType'].toString() == 'Army' ||
            name['forceType'].toString() == 'Navy' ||
            name['forceType'].toString() == 'PAF') {
          count = army_Subjects.length;

          geturls();
          setState(() {});
        } else if (name['forceType'] == 'ANF') {
          count = anf_subjects.length;
          geturls();
          setState(() {});
        } else {
          count = asf_subjects.length;
          geturls();
          setState(() {});
        }
        return name;
      } else {
        return name = {'name': name};
      }
    });
  }

  Future geturls() async {
    switch (name['forceType']) {
      case 'Army':
        for (var i = 0; i < army_Subjects.length; i++) {
          var temp = await _Storageref.child(armyPpaths[i].toString())
              .getDownloadURL();
          Urls.add(temp);
        }
        break;
      case 'Navy':
        for (var i = 0; i < army_Subjects.length; i++) {
          var temp = await _Storageref.child(navyPpaths[i].toString())
              .getDownloadURL();
          Urls.add(temp);
        }
        break;
      case 'PAF':
        for (var i = 0; i < army_Subjects.length; i++) {
          var temp =
              await _Storageref.child(pafPpaths[i].toString()).getDownloadURL();
          Urls.add(temp);
        }
        break;
      case 'ANF':
        for (var i = 0; i < anf_subjects.length; i++) {
          var temp =
              await _Storageref.child(anfPpaths[i].toString()).getDownloadURL();
          Urls.add(temp);
        }
        break;
      case 'ASF':
        for (var i = 0; i < asf_subjects.length; i++) {
          var temp =
              await _Storageref.child(asfPpaths[i].toString()).getDownloadURL();
          Urls.add(temp);
        }
        break;
      default:
    }
  }

  Future getuseremail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    useremail = sp.getString('email').toString();

    getname();
  }

  @override
  void initState() {
    // TODO: implement initState
    getuseremail();
    // Future.delayed(Duration(seconds: 1), () {
    //   getname();
    // });
    // Future.delayed(Duration(seconds: 2), () {
    //   geturls();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(Urls);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi! ${name['name'].toString()}',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.notifications_outlined),
        ],
      ),
      drawer: Drawer(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.25,
              width: double.infinity,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 220, 217, 217)),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    name['name'].toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.pushNamed(context, RouteNames.profile_screen,
            //         arguments: name);
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     height: size.height * 0.05,
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 5),
            //           child: Icon(Icons.person_3_outlined),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text('Profile'),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     width: double.infinity,
            //     height: size.height * 0.05,
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 5),
            //           child: Icon(Icons.info_outline),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text('About Us'),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: size.height * 0.5),
            Center(
              child: IconButton(
                onPressed: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.clear();
                  _auth.signOut();
                  Navigator.pushNamed(context, RouteNames.login);
                },
                icon: Icon(Icons.logout_outlined),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width * 1,
                height: size.height * 0.3,
                child: Image(
                  image: name['forceType'] == 'Army'
                      ? AssetImage('assets/Army.jpg')
                      : name['forceType'] == 'Navy'
                          ? AssetImage('assets/Navy.jpg')
                          : name['forceType'] == 'PAF'
                              ? AssetImage('assets/PAF.jpeg')
                              : name['forceType'] == 'ASF'
                                  ? AssetImage('assets/ASF.jpg')
                                  : name['forceType'] == 'ANF'
                                      ? AssetImage('assets/ANF.jpeg')
                                      : AssetImage('assets/images.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: size.height * 0.06,
                width: size.width * 1,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    name['forceType'] == 'Army' ||
                            name['forceType'] == 'Navy' ||
                            name['forceType'] == 'PAF'
                        ? 'Get Ready Soldier !'
                        : 'Get Ready Officer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              // GridView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: count,
              //   shrinkWrap: true,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     childAspectRatio: 1.5,
              //     // mainAxisSpacing: 10,
              //     // crossAxisSpacing: 10,
              //   ),
              //   itemBuilder: ((context, index) {
              //     return Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: CustomANimatedButton(
              //         alignment: Alignment.center,
              //         onpress: () {
              //           if (index == 4) {
              //             Navigator.pushNamed(
              //                 context, RouteNames.initialscreen);
              //           } else if (Urls.isNotEmpty) {
              //             Navigator.pushNamed(context, RouteNames.viewerscreen,
              //                 arguments: {
              //                   'url': Urls[index],
              //                   'name': army_Subjects[index],
              //                 });
              //           } else {
              //             Utils.toastMessage('Something Wwnt Wrong');
              //             debugPrint(Urls.toString());
              //           }
              //         },
              //         height: 200.0,
              //         text: army_Subjects[index],
              //       ),
              //     );
              //   }),
              // )
              name['forceType'] == 'ANF'
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: count,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        // mainAxisSpacing: 10,
                        // crossAxisSpacing: 10,
                      ),
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomANimatedButton(
                            alignment: Alignment.center,
                            onpress: () {
                              if (index == 5) {
                                Navigator.pushNamed(
                                    context, RouteNames.initialscreen,
                                    arguments: forceType);
                              } else if (Urls.isNotEmpty) {
                                Navigator.pushNamed(
                                    context, RouteNames.viewerscreen,
                                    arguments: {
                                      'url': Urls[index],
                                      'name': army_Subjects[index],
                                    });
                              } else {
                                Utils.toastMessage('Something Wwnt Wrong');
                                debugPrint(Urls.toString());
                              }
                            },
                            height: 200.0,
                            text: anf_subjects[index],
                          ),
                        );
                      }),
                    )
                  : name['forceType'] == 'ASF'
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: count,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            // mainAxisSpacing: 10,
                            // crossAxisSpacing: 10,
                          ),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomANimatedButton(
                                alignment: Alignment.center,
                                onpress: () {
                                  if (index == 3) {
                                    Navigator.pushNamed(
                                        context, RouteNames.initialscreen,
                                        arguments: forceType);
                                  } else if (Urls.isNotEmpty) {
                                    Navigator.pushNamed(
                                        context, RouteNames.viewerscreen,
                                        arguments: {
                                          'url': Urls[index],
                                          'name': army_Subjects[index],
                                        });
                                  } else {
                                    Utils.toastMessage('Something Wwnt Wrong');
                                    debugPrint(Urls.toString());
                                  }
                                },
                                height: 200.0,
                                text: asf_subjects[index],
                              ),
                            );
                          }),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: count,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            // mainAxisSpacing: 10,
                            // crossAxisSpacing: 10,
                          ),
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomANimatedButton(
                                alignment: Alignment.center,
                                onpress: () {
                                  if (index == 4) {
                                    Navigator.pushNamed(
                                        context, RouteNames.initialscreen,
                                        arguments: forceType);
                                  } else if (Urls.isNotEmpty) {
                                    Navigator.pushNamed(
                                        context, RouteNames.viewerscreen,
                                        arguments: {
                                          'url': Urls[index],
                                          'name': army_Subjects[index],
                                        });
                                  } else {
                                    Utils.toastMessage('Something Wwnt Wrong');
                                    debugPrint(Urls.toString());
                                  }
                                },
                                height: 200.0,
                                text: army_Subjects[index],
                              ),
                            );
                          }),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
