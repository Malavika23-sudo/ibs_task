import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ibs_dubai_task/views/employee_add_screen.dart';

class EmployeeDetails extends StatefulWidget {
  final String? docId;

  EmployeeDetails({this.docId});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  final _firebasecore = FirebaseFirestore.instance;

  void deleteDoc() {
    setState(() {
      _firebasecore.collection('employee').doc(widget.docId).delete();
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(16),
                            top: ScreenUtil().setWidth(32),
                            bottom: ScreenUtil().setWidth(32),
                          ),
                          child: CircleAvatar(
                              child: BackButton(color: Colors.white),
                              backgroundColor: Color(0xff196819),
                              radius: 20),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 250,
                          child: ListView(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(16),
                                  right: ScreenUtil().setWidth(16),
                                  bottom: ScreenUtil().setWidth(16),
                                ),
                                child: GetEmployeeDetails(
                                  docId: widget.docId,
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(32),
                    ),
                    child: InkWell(
                      onTap: () {
                        deleteDoc();
                        // Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmployeeAddScreen()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 84,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF000000).withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(2, -2), // changes position of shadow
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
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(50),
                              topStart: Radius.circular(50),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Delete',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .merge(TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(16),
                    right: ScreenUtil().setWidth(16),
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff7aaf74).withOpacity(.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(2, -2), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                            BorderRadiusDirectional.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(32),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            backgroundImage: AssetImage('assets/images/img.jpg'),
                            radius: 50,

                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(16),
                          ),
                          child: Text(
                            data['name'],
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(5),
                            bottom: ScreenUtil().setWidth(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Eid ",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                "${data['id']}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(5),
                            bottom: ScreenUtil().setWidth(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Gender ",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                "${data['gender']}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(5),
                            bottom: ScreenUtil().setWidth(40),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Date of birth ",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                "${data['dob']}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
