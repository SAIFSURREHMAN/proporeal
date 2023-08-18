import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propereal/SearchScreen.dart';
import 'package:propereal/mainscreen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _typeTextController = TextEditingController();
  final TextEditingController _locationTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final TextEditingController _sizeTextController = TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();
  final TextEditingController _phonenumberTextController =
      TextEditingController();
  final TextEditingController _bathroomTextController = TextEditingController();
  final TextEditingController _bedroomTextController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  CollectionReference _reference =
      FirebaseFirestore.instance.collection('ad_list');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 31, 76),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 31, 76),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        }, icon: Icon(Icons.arrow_back)),
        title: Text(
          'Sell your Property',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: key,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _typeTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Type',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Ad Type Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceTextController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Ad Price',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Ad Price Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Ad Description Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationTextController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Ad Location Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sizeTextController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Size',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Ad size Required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bathroomTextController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Bathroom',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'How Many Bathroom';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bedroomTextController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Bedroom',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'How Many Bedroom';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phonenumberTextController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black)),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number  Required';
                    }
                    return null;
                  },
                ),
                IconButton(
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      print('${file?.path}');

                      if (file == null) return;
                      //Import dart:core
                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceDirImages =
                          referenceRoot.child('images');

                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      //Handle errors/success
                      try {
                        //Store the file
                        await referenceImageToUpload.putFile(File(file!.path));
                        //Success: get the download URL
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                      } catch (error) {
                        //Some error occurred
                      }
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      size: 70,
                    )),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      String type = _typeTextController.text;
                      String location = _locationTextController.text;
                      String phonenumber = _phonenumberTextController.text;
                      String bedroom = _bedroomTextController.text;
                      String bathroom = _bathroomTextController.text;

                      String description = _descriptionTextController.text;
                      String price = _priceTextController.text;

                      String size = _sizeTextController.text;

                      Map<String, String> dataToSend = {
                        'type': type,
                        'location': location,
                        'description': description,
                        'price': price,
                        'phonenumber': phonenumber,
                        'bathroom': bathroom,
                        'bedroom': bedroom,
                        'size': size,
                        'image': imageUrl,
                      };

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                      _reference.add(dataToSend);
                    }
                  },
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
