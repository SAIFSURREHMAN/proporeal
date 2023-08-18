import 'package:flutter/material.dart';
import 'package:propereal/mainscreen.dart';
import 'package:propereal/text_constants.dart';

import 'reusablewidget/reuseablewidget.dart';

class PhoneRegistration extends StatelessWidget {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();

  PhoneRegistration({super.key});

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
              "We're excited to have you on board and can't wait to see what you'll bring to our community.",
              color: Colors.white,
              fontSize: 18,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 20),
                child: reUsableTF(
                    "Phone Number", Icons.call, false, _phoneTextController)),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: reUsableTF(
                    "Name", Icons.person, false, _nameTextController)),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, left: 20, right: 20, top: 20),
                child: reUsableTF(
                    "Password", Icons.lock, true, _passwordTextController)),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ));
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
