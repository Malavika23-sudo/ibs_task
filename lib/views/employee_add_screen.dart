import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ibs_dubai_task/views/employee_list_screen.dart';

import '../models/employee_model.dart';

class EmployeeAddScreen extends StatefulWidget {
  static String routeName = "/employeeAddScreen";

  @override
  State<EmployeeAddScreen> createState() => _EmployeeAddScreenState();
}

class _EmployeeAddScreenState extends State<EmployeeAddScreen> {
  final _formKey = GlobalKey<FormState>();
  List<dynamic> countries = [];
  final idEditingController = TextEditingController();
  final nameEditingController = TextEditingController();
  String? id;
  String? name;
  String? date;
  String? gender = 'Select';
  String? filename = 'No image Selected';
  bool pressed = false;

  Future CreateEmployee({required Employee emp}) async {
    final docEmp = FirebaseFirestore.instance.collection('employee').doc(id);
    emp.id=docEmp.id;
    final json = emp.toJson();
    await docEmp.set(json);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
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
                          'Employee Registration',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(32),
                          left: ScreenUtil().setWidth(16),
                        ),
                        child: Text(
                          'Employee ID',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(5),
                            left: ScreenUtil().setWidth(16)),
                        child: TextBox(
                          textEditingController: idEditingController,
                          textType: TextInputType.phone,
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the employee id';
                            }
                            return null;
                          },
                          onChange: (value) {
                            setState(() {
                              id = value;
                              print(
                                  "id==========================================>>>");
                              print(name);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(32),
                          left: ScreenUtil().setWidth(16),
                        ),
                        child: Text(
                          'Employee Name',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(5),
                            left: ScreenUtil().setWidth(16)),
                        child: TextBox(
                          textEditingController: nameEditingController,
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the employeee Name';
                            }
                            return null;
                          },
                          onChange: (value) {
                            setState(() {
                              name = value;
                              print(
                                  "name==========================================>>>");
                              print(name);
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(32),
                          left: ScreenUtil().setWidth(16),
                        ),
                        child: Text(
                          'Gender',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setWidth(5),
                              left: ScreenUtil().setWidth(16),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Color(0xffC9C9C9)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.5))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(16),
                                    right: ScreenUtil().setWidth(16)),
                                child: DropdownButton<String>(
                                  value: gender,
                                  icon: Container(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // elevation: 16,
                                  style: Theme.of(context).textTheme.headline2,
                                  underline: Container(
                                    height: 0,
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      gender = newValue!;
                                      print('gender==================> $gender');
                                    });
                                  },
                                  items: <String>[
                                    'Select',
                                    'Female',
                                    'Male',
                                    'Other',
                                    'Prefer not to answer'
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          gender == 'Select' && pressed == true
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      // top: ScreenUtil().setWidth(35),
                                      left: ScreenUtil().setWidth(16)),
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        'None selected',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(32),
                          left: ScreenUtil().setWidth(16),
                        ),
                        child: DateTimePicker(
                          icon: Icon(Icons.event),
                          cursorColor: Colors.black,
                          initialDate: null,
                          initialValue: ' /  /   ',
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Date of Birth',
                          onChanged: (val) {
                            date = val;
                            print('date=========================> $date');
                          },
                          validator: (val) {
                            return '';
                          },
                          onSaved: (val) => print(val),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setWidth(32),
                                left: ScreenUtil().setWidth(16)),
                            child: TextButton(
                                onPressed: () async {
                                  // final result =  FilePicker.platform.pickFiles();
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    PlatformFile Pickedfile = result.files.first;
                                    setState(() {
                                      filename = Pickedfile.name.toString();
                                    });

                                    print(filename);
                                    // print(Pickedfile!.bytes);
                                    // print(Pickedfile!.size);
                                    // print(Pickedfile!.extension);
                                    // print(Pickedfile!.path);
                                  } else {
                                    return;
                                  }
                                },
                                child: Text('Attach Image',
                                    style: Theme.of(context).textTheme.headline2),
                                style: ButtonStyle(
                                  fixedSize:
                                      MaterialStateProperty.all(Size(100, 40)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Color(0xffC9C9C9)),
                                )),
                          ),
                          filename != 'No image Selected'
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(35),
                                      left: ScreenUtil().setWidth(16)),
                                  child: Container(
                                      height: 40,
                                      width: 150,
                                      child: Center(
                                          child: Text(
                                        filename.toString(),
                                        style:
                                            Theme.of(context).textTheme.headline4,
                                        maxLines: 3,
                                      ))),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(35),
                                      left: ScreenUtil().setWidth(16)),
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    child: Center(
                                      child: Text(
                                        'No Image Selected',
                                        style: TextStyle(
                                            color:
                                                pressed ? Colors.red : Colors.black,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(12),
                            left: ScreenUtil().setWidth(16)),
                        child: TextButton(
                            onPressed: () {},
                            child: Text('Upload',
                                style: Theme.of(context).textTheme.headline2),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(Size(100, 40)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffC9C9C9)),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(32),
                            left: ScreenUtil().setWidth(16)),
                        child: Container(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                setState(() {
                                  pressed = true;
                                });
                                final employee = Employee(
                                    id: idEditingController.text,
                                    name: nameEditingController.text,
                                    gender: gender,
                                    dob: DateTime.parse(date.toString()).toString(),
                                    image: filename);
                                CreateEmployee(emp: employee);
                                // _firebasecore.collection('user').add({
                                //   'name': name,
                                //   'phone': phone,
                                //   'sex': sex,
                                //   'location': location==null?position:location,
                                //   'timestamp': FieldValue.serverTimestamp()
                                // });
                                // userModels.userModel.add(UserModel(name: name));
                                if (_formKey.currentState!.validate() ||
                                    (name != null &&
                                        id != null &&
                                        date != DateTime.now() &&
                                        gender != 'selected' &&
                                        gender != null &&
                                        filename != 'No image Selected' &&
                                        filename != null)) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmployeeList()),
                                  );
                                }
                                nameEditingController.clear();
                                idEditingController.clear();
                              },
                              child: Text('Register',
                                  style: Theme.of(context).textTheme.headline3),
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(343, 48)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
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

class TextBox extends StatelessWidget {
  double left;
  bool obscure;
  Widget? toggleHide;
  void Function(String? val)? onChange;
  TextInputType? textType = TextInputType.multiline;
  final String? Function(String? value)? onValidate;
  TextEditingController? textEditingController;

  TextBox(
      {this.left = 16,
      this.obscure = false,
      this.toggleHide,
      this.textType,
      this.onChange,
      this.onValidate,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: ScreenUtil().setWidth(48),
      child: TextFormField(
        controller: textEditingController,
        validator: onValidate,
        onChanged: onChange,
        obscureText: obscure,
        keyboardType: textType,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: toggleHide,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1),
          ),
          fillColor: Color(0xffF8F8F8),
          filled: true,
          contentPadding: EdgeInsets.only(
              top: ScreenUtil().setWidth(38), left: ScreenUtil().setWidth(15)),
        ),
      ),
    );
  }
}

// class GenderDropDown extends StatefulWidget {
//   const GenderDropDown({Key? key}) : super(key: key);
//
//   @override
//   State<GenderDropDown> createState() => _GenderDropDownState();
// }
//
// class _GenderDropDownState extends State<GenderDropDown> {
//   String dropdownValue = 'Select';
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }

// class HomeScreen extends StatefulWidget {
//   static String routeName = "/homeScreen";
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {

//
//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context,
//         designSize: Size(414, 896), allowFontScaling: true);
//     return
//   }
// }
//
// class TextBox extends StatelessWidget {
//   double left;
//   bool obscure;
//   Widget? toggleHide;
//   void Function(String? val)? onChange;
//   TextInputType? textType = TextInputType.multiline;
//   final String? Function(String? value)? onValidate;
//   TextEditingController? textEditingController;
//
//   TextBox(
//       {this.left = 16,
//         this.obscure = false,
//         this.toggleHide,
//         this.textType,
//         this.onChange,
//         this.onValidate,
//         this.textEditingController});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       // height: ScreenUtil().setWidth(48),
//       child: TextFormField(
//         controller: textEditingController,
//         validator: onValidate,
//         onChanged: onChange,
//         obscureText: obscure,
//         keyboardType: textType,
//         decoration: InputDecoration(
//           errorStyle: TextStyle(
//             color: Colors.red,
//             fontSize: 12,
//             fontWeight: FontWeight.w400,
//           ),
//           suffixIcon: toggleHide,
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1)),
//           border: OutlineInputBorder(
//             borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1),
//           ),
//           fillColor: Color(0xffF8F8F8),
//           filled: true,
//           contentPadding: EdgeInsets.only(
//               top: ScreenUtil().setWidth(38), left: ScreenUtil().setWidth(15)),
//         ),
//       ),
//     );
//   }
// }
