// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:propereal/text_constants.dart';

class AdDetail extends StatefulWidget {
  AdDetail(this.adId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('ad_list').doc(adId);
    _futureData = _reference.get();
  }
  String adId;
  late DocumentReference _reference;
  late Future<DocumentSnapshot> _futureData;

  @override
  State<AdDetail> createState() => _AdDetailState();
}

class _AdDetailState extends State<AdDetail> {
  late Map data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: widget._futureData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Some error occurred ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          //Get the data
          DocumentSnapshot documentSnapshot = snapshot.data;
          data = documentSnapshot.data() as Map;

          //display the data
          return Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: data.containsKey('image')
                            ? Image.network(
                                '${data['image']}',
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.keyboard_arrow_left,
                              size: 50, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PText(
                          '${data['type']}',
                          fontSize: 27,
                          weight: FontWeight.bold,
                        ),
                        Text(
                          '${data['price']}',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.bed_outlined,
                                size: 37,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white,
                            ),
                            PText(
                              '${data['bedroom']} Bedroom',
                              fontSize: 20,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.shower_outlined,
                                size: 37,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white,
                            ),
                            PText(
                              '${data['bathroom']} Bathroom',
                              fontSize: 20,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.house_outlined,
                                size: 30,
                                color: Colors.black,
                              ),
                              backgroundColor: Colors.white,
                            ),
                            PText(
                              '${data['size']} Size',
                              fontSize: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: PText(  
                      "Description",
                      weight: FontWeight.bold,
                          fontSize: 22,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 5, 10),
                    child: Text(
                      '${data['description']}',
                      style: GoogleFonts.poppins(
                          fontSize: 20,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Color(0xff283e49),
                                size: 30,
                              ),
                            ),
                          ),
                          TextSpan(
                              text: '${data['location']}',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color(0xff283e49),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 15, 31, 76),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: Icon(
                                      Icons.call_outlined,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                    text: '${data['phonenumber']}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
