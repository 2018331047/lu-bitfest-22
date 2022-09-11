import 'package:flutter/material.dart';

import '../../widgets/loginButton/deco.dart';
import '../../widgets/loginScreenTitle/titleFour.dart';
import '../tabs/tabscreen.dart';

class UpdateTeaInfo extends StatefulWidget {
  const UpdateTeaInfo({Key? key}) : super(key: key);

  @override
  State<UpdateTeaInfo> createState() => _UpdateTeaInfoState();
}

class _UpdateTeaInfoState extends State<UpdateTeaInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController codeController = new TextEditingController();
  final TextEditingController batchController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();

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

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(child: Text("Lecturer"), value: "Lecturer"),
      DropdownMenuItem(
          child: Text("Assistant Professor"), value: "Assistant Professor"),
      DropdownMenuItem(
          child: Text("Associate Professor"), value: "Associate Professor"),
      DropdownMenuItem(child: Text("Professor"), value: "Professor"),
    ];
    return menuItems2;
  }

  String? selectedDept;
  String? selectedDesignation;

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
                          contentPadding: EdgeInsets.fromLTRB(20, 23, 20, 23),
                          hintText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        controller: codeController,
                        keyboardType: TextInputType.text,
                        onSaved: (value) {
                          nameController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          contentPadding: EdgeInsets.fromLTRB(20, 23, 20, 23),
                          hintText: "Code Name",
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
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                          autofocus: false,
                          decoration: InputDecoration(
                            hintText: 'Designation',
                            prefixIcon: Icon(Icons.work_outline),
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
                              value == null ? "Select Designation" : null,
                          dropdownColor: Colors.grey[200],
                          value: selectedDesignation,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDesignation = newValue!;
                            });
                          },
                          items: dropdownItems2),
                      Container(
                        alignment: Alignment.centerRight,
                        margin:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 30),
                        child: MaterialButton(
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const TabScreen()));
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
}
