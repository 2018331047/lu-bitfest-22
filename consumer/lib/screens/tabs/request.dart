import 'package:flutter/material.dart';

import '../../widgets/loginButton/deco.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final date = new TextEditingController();
  final time = new TextEditingController();
  final pickup = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      controller: date,
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {},
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                        hintText: "Date",
                        hintStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: time,
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                        hintText: "Time",
                        hintStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: pickup,
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {},
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                        hintText: "Pickup",
                        hintStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            MaterialButton(
              textColor: Colors.white,
              onPressed: () {},
              padding: const EdgeInsets.all(0),
              child: Deco('Request'),
            ),
          ],
        ),
      ),
    );
  }
}
