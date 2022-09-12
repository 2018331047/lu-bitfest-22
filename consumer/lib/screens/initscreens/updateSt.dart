import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumer/databaseServices/addStudent.dart';
import 'package:consumer/screens/initscreens/updateTea.dart';
import 'package:consumer/screens/tabs/tabscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/loginButton/deco.dart';
import '../../widgets/loginScreenTitle/titleFour.dart';

class UpdateStuInfo extends StatefulWidget {
  String userName;
  String id;
  String email;
  String pass;
  String phone;
  String stoppage;
  UpdateStuInfo(this.userName, this.id, this.email, this.pass, this.phone,
      this.stoppage, bool check,
      {Key? key})
      : super(key: key);

  @override
  State<UpdateStuInfo> createState() => _UpdateStuInfoState();
}

class _UpdateStuInfoState extends State<UpdateStuInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController sectionController = new TextEditingController();
  final TextEditingController batchController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController deptController = new TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("CSE"), value: "CSE"),
      DropdownMenuItem(child: Text("EEE"), value: "EEE"),
      DropdownMenuItem(child: Text("CIVIL"), value: "CIVIL"),
      DropdownMenuItem(child: Text("BBA"), value: "BBA"),
      DropdownMenuItem(child: Text("ENGLISH"), value: "ENGLISH"),
      DropdownMenuItem(child: Text("LAW"), value: "LAW"),
      DropdownMenuItem(child: Text("ARCHITECTURE"), value: "ARCHITECTURE"),
    ];
    return menuItems;
  }

  String? selectedDept;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(top: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              Title4('Update Profile'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(right: 20, top: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          nameController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            //icon: Icon(Icons.school),
                            hintText: 'Department',
                            prefixIcon: Icon(Icons.school),
                            //icon: Icon(Icons.school),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validator: (value) =>
                              value == null ? "Select Department" : null,
                          dropdownColor: Colors.grey[200],
                          value: selectedDept,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDept = newValue!;
                            });
                          },
                          items: dropdownItems),
                      const SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        controller: batchController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          batchController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_view_day),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Batch Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        controller: sectionController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          sectionController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.app_registration),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Section",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 30),
                        child: MaterialButton(
                          textColor: Colors.white,
                          onPressed: () async {
                            Fluttertoast.showToast(msg: "Sign Up Successful");

                            postDetailsToFirestore(
                                widget.userName,
                                widget.id,
                                widget.email,
                                widget.pass,
                                widget.phone,
                                widget.stoppage,
                                batchController.text,
                                sectionController.text,
                                selectedDept!);
                          },
                          padding: const EdgeInsets.all(0),
                          child: Deco('SAVE'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore(
      String userName,
      String id,
      String email,
      String pass,
      String phone,
      String stoppage,
      String batch,
      String section,
      String dept) async {
    AddStudent(
      userName,
      nameController.text,
      id,
      email,
      phone,
      stoppage,
      batch,
      section,
      dept,
    ).addStudent();

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => TabScreen()));
  }
}
