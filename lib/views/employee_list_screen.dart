import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

import '../models/employee_model.dart';

class EmployeeList extends StatelessWidget {
  final _firebasecore = FirebaseFirestore.instance;

  Stream<List<Employee>> readEmployee() {
    final data = _firebasecore.collection('employee').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Employee.fromJson(doc.data())).toList());
    print(data);
    return data;
  }

  final _formKey = GlobalKey<FormState>();

  Widget buildList(Employee emp) => ListTile(
        leading: Text('${emp.id}'),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setWidth(32),
                    right: ScreenUtil().setWidth(16),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(16),
                          ),
                          child: Text(
                            'Employee List',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        StreamBuilder<List<Employee>>(
                            stream: readEmployee(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final emp = snapshot.data;
                                return ListView(
                                  children: emp!.map(buildList).toList(),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(250),
                                  ),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.black),
                                  ),
                                );
                              }
                            })
                      ]),
                ),
              ),
            )));
  }
}
