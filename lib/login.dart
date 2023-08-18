import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propereal/addproduct_screen.dart';
import 'package:propereal/reset_password.dart';
import 'package:propereal/reusablewidget/reuseablewidget.dart';
import 'package:propereal/text_constants.dart';
import 'mainscreen.dart';
import 'package:quickalert/quickalert.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

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
              'Log In',
              fontSize: 30,
              color: Colors.white,
            ),
            PText(
              "We're excited to have you on board and can't wait to see what you'll bring to our community.",
              color: Colors.white,
              fontSize: 18,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 20),
                child: reUsableTF(
                    "Email", Icons.call, false, _emailTextController)),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 100, left: 20, right: 20, top: 20),
                child: reUsableTF(
                    "Password", Icons.lock, true, _passwordTextController)),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResetPass(),
                    ),
                  );
                },
                child: const Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    );
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Log In Successful',
                      autoCloseDuration: const Duration(seconds: 2),
                    );
                  }).onError((error, stackTrace) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text: 'Your email or password is incorrect',
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
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddProductScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_right_alt_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: PText(
                'By registering, you agree to our Terms and Conditions and Privacy Policy.',
                fontSize: 15,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
