import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propereal/text_constants.dart';

import 'SearchScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/images/house2-removebg-preview.png"),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                "Let's\nExplore\nBeautifull Homes",
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 5, 0),
              child: PText(
                  "Make a living easy,Chores are done hassle-free Complete home solutions,  Experience fine  living, Get the best appliances The best performance \n around."),
            ),
            SizedBox(height: 45),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
                },
                child: Container(
                  height: 60,
                  width: 270,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 15, 31, 76),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                      child: PText(
                    "Get Started",
                    color: Colors.white,
                    fontSize: 18,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
