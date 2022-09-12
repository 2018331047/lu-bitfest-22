import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../databaseServices/addRequest.dart';
import '../../widgets/loginButton/deco.dart';
import 'package:intl/intl.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  final date = new TextEditingController();
  final time = new TextEditingController();
  final pickup = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Amborkhana"), value: "Amborkhana"),
      DropdownMenuItem(child: Text("Eidgah"), value: "Eidgah"),
      DropdownMenuItem(child: Text("TB Gate"), value: "TB Gate"),
      DropdownMenuItem(child: Text("Tilagor"), value: "Tilagor"),
      DropdownMenuItem(child: Text("Khadim"), value: "Khadim"),
      DropdownMenuItem(child: Text("Shahporan"), value: "Shahporan"),
      DropdownMenuItem(child: Text("Bondor"), value: "Bondor"),
      DropdownMenuItem(child: Text("Noyashorok"), value: "Noyashorok"),
      DropdownMenuItem(child: Text("Kumarpara"), value: "Kumarpara"),
      DropdownMenuItem(child: Text("Naiorpul"), value: "Naiorpul"),
      DropdownMenuItem(child: Text("Zindabazar"), value: "Zindabazar"),
      DropdownMenuItem(child: Text("Chowhatta"), value: "Chowhatta"),
      DropdownMenuItem(child: Text("Rikabibazar"), value: "Rikabibazar"),
      DropdownMenuItem(child: Text("Taltola"), value: "Taltola"),
      DropdownMenuItem(
          child: Text("Jitu miar point"), value: "Jitu miar point"),
      DropdownMenuItem(child: Text("Modina Market"), value: "Modina Market"),
      DropdownMenuItem(child: Text("Pathantula"), value: "Pathantula"),
      DropdownMenuItem(child: Text("Shubidbazar"), value: "Shubidbazar"),
      DropdownMenuItem(child: Text("Akhali ghat"), value: "Akhali ghat"),
      DropdownMenuItem(child: Text("SUST gate"), value: "SUST gate"),
      DropdownMenuItem(child: Text("Lakkatura"), value: "Lakkatura"),
      DropdownMenuItem(child: Text("Uposhohor"), value: "Uposhohor"),
      DropdownMenuItem(child: Text("Campus"), value: "Campus"),
    ];
    return menuItems;
  }

  late String t;
  void func(String vr) {
    t = vr;
    return;
  }

  String? selectedStop;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(27, 0, 10, 0),
                  margin: const EdgeInsets.only(right: 20, top: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 20, 25, 20),
                            hintText: "Date",
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintStyle: const TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: dateinput,
                          onTap: () async {
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2023),
                            ).then((pickedDate) {
                              if (pickedDate == null) {
                                return;
                              }
                              String formattedDate =
                                  DateFormat.yMd().format(pickedDate);
                              setState(() {
                                dateinput.text = formattedDate;

                                //print(dateinput.text);
                              });
                            });
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                      TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 20, 25, 20),
                            hintText: "Time",
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintStyle: const TextStyle(fontSize: 18),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: timeinput,
                          onTap: () async {
                            await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                            ).then((pickedTime) {
                              if (pickedTime == null) {
                                return;
                              }
                              // String formattedTime ;
                              setState(() {
                                timeinput.text = pickedTime.format(context);
                                print(timeinput.text);
                              });
                            });
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                      DropdownButtonFormField<String>(
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 20, 25, 20),
                            hintText: 'Pick-up Point',
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
                              value == null ? "Select Stoppage" : null,
                          dropdownColor: Colors.grey[200],
                          value: selectedStop,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedStop = newValue!;
                            });
                          },
                          items: dropdownItems),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              MaterialButton(
                textColor: Colors.white,
                onPressed: () async {
                  print(dateinput.text);
                  final _auth = FirebaseAuth.instance;
                  final User user = _auth.currentUser!;
                  late String type;
                  FirebaseFirestore.instance
                      .collection('user')
                      .doc(user.uid)
                      .get()
                      .then((value) {
                    func(value['user type']);
                  });
                  print(t);
                  bool flag = false;
                  FirebaseFirestore.instance
                      .collection('transportAllocation')
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      if (doc['time'] == timeinput.text) {
                        print(doc['time']);
                        flag = true;
                        Fluttertoast.showToast(msg: "Request Accepted");
                        AddRequest(dateinput.text, timeinput.text,
                                selectedStop!, t)
                            .addRequest();
                        return;
                      }
                      if (flag == false) {
                        Fluttertoast.showToast(
                            msg: "There is no bus at this time.");
                      }
                    });
                  });
                },
                padding: const EdgeInsets.all(0),
                child: Deco('Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
