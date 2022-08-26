import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'employee_details_screen.dart';

class EmployeeList extends StatefulWidget {
  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final _firebasecore = FirebaseFirestore.instance;
  List selectedTabs = [];
  bool? isSelected = false;
  bool exist = false;
  List<String> docId = [];
  List<String> SelectedDocIds = [];

  Future getDocId() async {
    print('START OF GETID FUNCTION');
    await _firebasecore
        .collection('employee')
        .get()
        .then((value) => value.docs.forEach((element) {
              print('element.reference.id');
              if (docId.contains(element.reference.id))
                exist = docId.contains(element.reference.id);
              print('EXIST======================>>> $exist');
              if (!exist) docId.add(element.reference.id);
              print("DOCID==========> $docId");
              print("DOCID COUNT==========> ${docId.length}");
            }));
  }

  void deleteAll() {
    print("SELECTEDID==========> $SelectedDocIds");
    setState(() {
      if (SelectedDocIds.isNotEmpty)
        SelectedDocIds.forEach((employee) {
          _firebasecore.collection('employee').doc(employee).delete();
          SelectedDocIds.remove(employee);
          docId.remove(employee);
          selectedTabs.clear();
        });
    });

    print("SELECTEDID==========> $SelectedDocIds");
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF000000).withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF0eea4c),
                                  const Color(0xFF000000),
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            // color: Color(0xff000700),
                            borderRadius: BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(100),
                              // bottomStart: Radius.circular(30)
                            )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  // left: ScreenUtil().setWidth(16),
                                  top: ScreenUtil().setWidth(32),
                                  bottom: ScreenUtil().setWidth(32),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(16),
                                      ),
                                      child: CircleAvatar(
                                          child: BackButton(
                                              color: Color(0xff196819)),
                                          backgroundColor: Colors.white,
                                          radius: 20),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(12),
                                      ),
                                      child: Text(
                                        'Employees',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1!
                                            .merge(
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // StreamBuilder<List<Employee>>(
                              //     stream: readEmployee(),
                              //     builder: (context, snapshot) {
                              //       if (snapshot.hasData) {
                              //         final emp = snapshot.data;
                              //         return ListView(
                              //           children: emp!.map(buildList).toList(),
                              //         );
                              //       } else {
                              //         return Padding(
                              //           padding: EdgeInsets.only(
                              //             top: ScreenUtil().setWidth(250),
                              //           ),
                              //           child: Center(
                              //             child: CircularProgressIndicator(
                              //                 color: Colors.black),
                              //           ),
                              //         );
                              //       }
                              //     })
                              FutureBuilder(
                                  future: getDocId(),
                                  builder: (context, snapshot) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              250,
                                      child: ListView.builder(
                                          // reverse: true,
                                          itemCount: docId.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(16),
                                                right:
                                                    ScreenUtil().setWidth(32),
                                                bottom:
                                                    ScreenUtil().setWidth(16),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: selectedTabs
                                                          .contains(index)
                                                      ? BorderRadius.all(
                                                          Radius.circular(30))
                                                      : BorderRadius.zero,
                                                  color: selectedTabs
                                                          .contains(index)
                                                      ? Colors.red
                                                      : Colors.white
                                                          .withOpacity(.6),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xFF000000)
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: ListTile(
                                                  onLongPress: () {
                                                    setState(() {
                                                      print(
                                                          '<<<<<<<<<<ID of document===============> ${docId[index]}');
                                                      selectedTabs.add(index);

                                                      SelectedDocIds.add(
                                                          docId[index]);
                                                    });
                                                  },
                                                  trailing: selectedTabs
                                                          .contains(index)
                                                      ? Container(
                                                          width: 50,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                selectedTabs
                                                                    .remove(
                                                                        index);
                                                                SelectedDocIds
                                                                    .remove(docId[
                                                                        index]);
                                                              });
                                                            },
                                                            icon: Icon(
                                                                Icons.close),
                                                            iconSize: 35,
                                                            color: Colors.green,
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 0,
                                                          width: 0,
                                                        ),
                                                  // leading: CircleAvatar(
                                                  //   backgroundColor:
                                                  //       Colors.green[700],
                                                  //   child: Icon(
                                                  //     Icons
                                                  //         .person_outline_outlined,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                  title: GetEmployeeDetails(
                                                      index: index,
                                                      selectedTabs:
                                                          selectedTabs,
                                                      docId: docId[index]),
                                                  // Text(
                                                  //   docId[index],
                                                  //   style: TextStyle(
                                                  //     fontWeight: FontWeight.w500,
                                                  //   ),
                                                  // ),

                                                  onTap: () {
                                                    print('TAPPED');

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EmployeeDetails(
                                                                docId: docId[
                                                                    index],
                                                              )),
                                                    );
                                                    // setState(() {
                                                    //   contacts[index].isSelected = !contacts[index].isSelected;
                                                    //   if (contacts[index].isSelected == true) {
                                                    //     selectedContacts.add(ContactModel(name, phoneNumber, true));
                                                    //   } else if (contacts[index].isSelected == false) {
                                                    //     selectedContacts
                                                    //         .removeWhere((element) => element.name == contacts[index].name);
                                                    //   }
                                                    // });
                                                  },
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  })
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(32),
                            bottom: ScreenUtil().setWidth(32),
                            right: ScreenUtil().setWidth(16),
                            left: ScreenUtil().setWidth(16)),
                        child: Container(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  deleteAll();
                                });
                              },
                              child: Text('Delete',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .merge(TextStyle(
                                          color: Colors.white, fontSize: 22))),
                              style: ButtonStyle(
                                fixedSize:
                                    MaterialStateProperty.all(Size(343, 48)),
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff196819)),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

class GetEmployeeDetails extends StatelessWidget {
  final String? docId;
  int? index;
  List? selectedTabs;

  GetEmployeeDetails({this.docId, this.selectedTabs, this.index});

  @override
  Widget build(BuildContext context) {
    CollectionReference employees =
        FirebaseFirestore.instance.collection('employee');

    return FutureBuilder<DocumentSnapshot>(
        future: employees.doc(docId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print('DATA==================== $data');
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(5),
                  ),
                  child: Text(
                    data['name'],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(5),
                    bottom: ScreenUtil().setWidth(5),
                  ),
                  child: Text(
                    "Eid:${data['id']}",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setWidth(250),
              ),
              child: Center(
                child: LinearProgressIndicator(
                    color: Colors.black, backgroundColor: Colors.grey),
              ),
            );
          }
        });
  }
}
