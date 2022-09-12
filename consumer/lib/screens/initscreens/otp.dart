import 'package:consumer/screens/initscreens/updateSt.dart';
import 'package:consumer/screens/initscreens/updateTea.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

//verification of an user by sending otp
class OTP extends StatelessWidget {
  final String email;
  final String userName;
  String id;
  final String phone;
  final String stoppage;
  final String pass;
  bool check;
  //get these infos from signup page
  OTP(this.userName, this.id, this.email, this.pass, this.phone, this.stoppage,
      this.check);

  final _auth = FirebaseAuth.instance;
  TextEditingController otpInput = TextEditingController();
  String? errorMessage;
  EmailAuth emailAuth = EmailAuth(sessionName: "Bus Management");

  //this function is called when resend button is pressed
  void sendOtp() async {
    bool res = await emailAuth.sendOtp(recipientMail: email, otpLength: 6);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(top: size.height / 2.5),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  controller: otpInput,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter OTP',
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    otpInput.text = value;
                    //calling the validateOtp method and storing the result in res variable
                    bool res = emailAuth.validateOtp(
                        recipientMail: email, userOtp: otpInput.text);
                    print(res);
                    //if res is true signup constructor called else signup failed
                    if (res == true) {
                      signUp(userName, id, email, pass, phone, stoppage, check,
                          context);
                    } else {
                      print('false');
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 260, right: 20),
            child: TextButton(
              child: const Text(
                'Resend',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                sendOtp();
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 50, right: 40),
            child: Text(
                "An OTP code has been sent to your email for verifiaction."),
          ),
        ]),
      ),
    );
  }

// method to sign a user up
  void signUp(String userName, String id, String email, String pass,
      String phone, String stoppage, bool check, context) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) => {
                // check variable keeps the track of the type of an user
                //if the var is false that indicates the user is a student
                //else the user is teacher
                if (check == false)
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => UpdateTeaInfo(
                              userName,
                              id,
                              email,
                              pass,
                              phone,
                              stoppage,
                              check,
                            ))),
                  }
                else
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => UpdateStuInfo(
                              userName,
                              id,
                              email,
                              pass,
                              phone,
                              stoppage,
                              check,
                            ))),
                  }
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
      print(error.code);
    }
  }
}
