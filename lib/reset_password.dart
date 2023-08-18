import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propereal/mainscreen.dart';
import 'package:propereal/text_constants.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'reusablewidget/reuseablewidget.dart';

class ResetPass extends StatelessWidget {
  // final TextEditingController _passwordTextController = TextEditingController();
  // final TextEditingController _nameTextController = TextEditingController();
  // final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  ResetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 15, 31, 76),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
          height: MediaQuery.of(context).size.height * 0.75,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 50,
                    color: Colors.white,
                  )),
            ),
            PText(
              "Reset Password.",
              color: Colors.white,
              fontSize: 18,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 20),
                child: reUsableTF(
                    "Email", Icons.lock, false, _emailTextController)),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          )))
                      .onError((error, stackTrace) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Your email is incorrect',
                      backgroundColor: Colors.black,
                      titleColor: Colors.white,
                      textColor: Colors.white,
                    );
                  });
                },
                color: Color.fromARGB(255, 74, 30, 155),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.arrow_right_alt_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Spacer(),
            PText(
              'By registering, you agree to our Terms and Conditions and Privacy Policy.',
              fontSize: 15,
            ),
          ],
        ),
      ]),
    );
  }
}
