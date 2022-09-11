import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/loginButton/deco.dart';
import '../../widgets/loginScreenTitle/titleOne.dart';
import '../../widgets/loginScreenTitle/titleThree.dart';
import '../../widgets/loginScreenTitle/titleTwo.dart';
import 'otp.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String err = "OTP sent";
  bool check = true;
  EmailAuth emailAuth = EmailAuth(sessionName: "Bus Management");

  //sends otp to verify user
  void sendOtp() async {
    bool res = await emailAuth.sendOtp(
        recipientMail: emailEditingController.text, otpLength: 6);
  }

  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();
  final userNameEditingController = new TextEditingController();
  final stoppageEditingController = new TextEditingController();
  final fullNameEditingController = new TextEditingController();
  //late final String name;
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  final idEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey[200],
          width: size.width,
          height: size.height,
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: size.width * 1,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Title1('SignUp'),
              SizedBox(
                height: size.height * 0.02,
              ),
              Title2('Hi,', 'Welcome!'),
              SizedBox(
                height: size.height * 0.004,
              ),
              Title3('Please sign up to continue'),
              SizedBox(height: size.height * 0.01),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  margin: const EdgeInsets.only(right: 20, top: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        //autofocus: false,
                        controller: userNameEditingController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("User Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid User Name(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          userNameEditingController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "User Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        //autofocus: false,
                        controller: idEditingController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("ID number cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid ID(Min. 3 Character)");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          idEditingController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "ID Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        controller: emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailEditingController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        controller: phoneEditingController,
                        //obscureText: true,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Please Enter Your Phone Number");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Phone Number(Min. 6 Character)");
                          }
                        },
                        onSaved: (value) {
                          phoneEditingController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.vpn_key),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        controller: stoppageEditingController,
                        // obscureText: true,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Please Enter Your Stoppage");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Stoppage(Min. 6 Character)");
                          }
                        },
                        onSaved: (value) {
                          stoppageEditingController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.place),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: "Pickup Stoppage",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          autofocus: false,
                          controller: passwordEditingController,
                          obscureText: true,
                          onSaved: (value) {
                            passwordEditingController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                          child: Row(
                        children: [
                          MaterialButton(
                            textColor: Colors.white,
                            onPressed: () {
                              check = true;
                              if (_formKey.currentState!.validate()) {
                                sendOtp();
                                Fluttertoast.showToast(msg: err);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OTP(
                                          emailEditingController.text,
                                          passwordEditingController.text,
                                          check,
                                          fullNameEditingController.text,
                                        )));
                              }
                            },
                            padding: const EdgeInsets.all(0),
                            child: Deco('AS STUDENT'),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          MaterialButton(
                            textColor: Colors.white,
                            onPressed: () {
                              check = false;
                              if (_formKey.currentState!.validate()) {
                                sendOtp();
                                Fluttertoast.showToast(msg: err);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OTP(
                                          emailEditingController.text,
                                          passwordEditingController.text,
                                          check,
                                          fullNameEditingController.text,
                                        )));
                              }
                            },
                            padding: const EdgeInsets.all(0),
                            child: Deco('AS TEACHER/STUFF'),
                          ),
                        ],
                      )),
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
