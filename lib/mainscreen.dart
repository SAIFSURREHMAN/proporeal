import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:propereal/text_constants.dart';

import 'detail_page.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('ad_list');
  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }
            if (snapshot.hasData) {
              //get the data
              QuerySnapshot querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot.docs;

              //          Convert the documents to Maps
              List<Map> ads = documents
                  .map((e) => {
                        'bedroom': e['bedroom'],
                        'bathroom': e['bathroom'],
                        'id': e.id,
                        'type': e['type'],
                        'location': e['location'],
                        'size': e['size'],
                        'price': e['price'],
                        //  'price': e['price'],
                        'imageUrl': e['image'],
                      })
                  .toList();

              return SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 35,
                                color: Colors.grey.shade700,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              PText(
                                "Showing Result",
                                fontSize: 25,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              PText("Properties to buy",
                                  fontSize: 15, color: Colors.black),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ListView.builder(
                        itemCount: ads.length,
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // Disable outer ListView scrolling
                        itemBuilder: (BuildContext context, int index) {
                          Map thisAd = ads[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AdDetail(thisAd['id'])));
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(18.0),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 2),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: thisAd
                                                    .containsKey('imageUrl')
                                                ? Image.network(
                                                    '${thisAd['imageUrl']}',
                                                    fit: BoxFit.fill,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  )
                                                : Container(),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    PText(
                                                      '${thisAd['type']}',
                                                      fontSize: 22,
                                                      weight: FontWeight.bold,
                                                    ),
                                                    Spacer(),
                                                    PText(
                                                      '${thisAd['price']}',
                                                      fontSize: 19,
                                                      weight: FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: PText(
                                                    '${thisAd['location']}',
                                                    fontSize: 15,
                                                    // weight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Icon(
                                                              Icons
                                                                  .bed_outlined,
                                                              size: 30,
                                                              color: Colors.black,
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                          PText(
                                                            '${thisAd['bedroom']} Bedroom',
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Icon(
                                                              Icons
                                                                  .shower_outlined,
                                                              size: 30,
                                                              color: Colors.black,
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                          PText(
                                                            '${thisAd['bathroom']} Bathroom',
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          CircleAvatar(
                                                            child: Icon(
                                                              Icons
                                                                  .house_outlined,
                                                              size: 30,
                                                              color: Colors.black,
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                          PText(
                                                            '${thisAd['size']} Size',
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
