import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:propereal/phonereg.dart';
import 'package:propereal/reusablewidget/reuseablewidget.dart';
import 'package:propereal/text_constants.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickalert/quickalert.dart';

class Registration extends StatefulWidget {
  Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _nameTextController = TextEditingController();

  final TextEditingController _phoneTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 31, 76),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              size: 50,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const PText(
          'Register Account',
          fontSize: 30,
          color: Colors.white,
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 15, 31, 76),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          height: MediaQuery.of(context).size.height * 0.55,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
          children: [
            const PText(
              "We're thrilled to have you join our community.",
              fontSize: 18,
              color: Colors.white,
            ),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: reUsableTF(
                    "Name", Icons.person, false, _nameTextController)),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: reUsableTF(
                    "Email", Icons.email, false, _emailTextController)),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: reUsableTF(
                    "Phone Number", Icons.call, false, _phoneTextController)),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: reUsableTF(
                    "Password", Icons.lock, true, _passwordTextController)),
            Align(
              alignment: Alignment.topCenter,
              child: MaterialButton(
                onPressed: () {
                  setState(() {});
                  String id = DateTime.now().microsecondsSinceEpoch.toString();
                  fireStore
                      .doc(id)
                      .set({
                        'name': _nameTextController.text,
                        'phone': _phoneTextController.text,
                        'email': _emailTextController.text,
                        'password': _passwordTextController.text,
                        'id': id,
                      })
                      .then((value) {})
                      .onError((error, stackTrace) {
                        print('there is an issue');
                      });

                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );

                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'Registeration Successful ',
                      autoCloseDuration: const Duration(seconds: 2),
                    );
                  }).onError((error, stackTrace) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Oops...',
                      text:
                          'Try To Write Correct Email Format or Strong Password',
                      backgroundColor: Colors.black,
                      titleColor: Colors.white,
                      textColor: Colors.white,
                    );
                  });
                },
                color: const Color.fromARGB(255, 74, 30, 155),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.arrow_right_alt_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const PText(
              "Or Continue With",
              fontSize: 30,
              color: Colors.black,
              weight: FontWeight.w700,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PhoneRegistration(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.login_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const PText(
              'By registering, you agree to our Terms and Conditions and Privacy Policy.',
              fontSize: 15,
            ),
          ],
        ),
      ]),
    );
  }
}
