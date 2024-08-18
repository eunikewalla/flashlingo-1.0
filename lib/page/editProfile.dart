import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashlingo1_0/settings/ColorScheme.dart';
import 'package:flashlingo1_0/settings/profilepicker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfile();
}

class _editProfile extends State<editProfile> {
  var userData;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();

  Future<void> getUserData() async {
    User user = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    userData = userDoc.data();

    setState(() {});
  }

  Future<void> updateUserProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    User user = FirebaseAuth.instance.currentUser!;
    var imageUrl;
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child("${user.uid}.jpg");
      if (_selectedImage == null) {
      } else {
        await storageRef.putFile(_selectedImage!);
        imageUrl = await storageRef.getDownloadURL();
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({...userData, 'imageUrl': imageUrl});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Positioned(
            //   child: Container(
            //     height: MediaQuery.of(context).size.height,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/images/editBg.png"),
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              ProfileImagePicker(onSelectImage: (image) {
                                _selectedImage = image;
                              })
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 20.0,
                                bottom: 50.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.0),
                                  Text("First Name"),
                                  SizedBox(height: 10.0),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFececf8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      initialValue:
                                          userData['first_name'] ?? '',
                                      onSaved: (newValue) {
                                        userData['first_name'] = newValue;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Text("Last Name"),
                                  SizedBox(height: 10.0),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFececf8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      initialValue: userData['last_name'] ?? '',
                                      onSaved: (newValue) {
                                        userData['last_name'] = newValue;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Text("Email"),
                                  SizedBox(height: 10.0),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFececf8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextFormField(
                                      initialValue: userData['email'] ?? '',
                                      onSaved: (newValue) {
                                        setState(() {
                                          userData['email'] = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 25.0),
                                  Center(
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(80),
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.0),
                                        width: 210,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: lightBlue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            await updateUserProfile();
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                            child: Text(
                                              "Update Profile",
                                              style: TextStyle(
                                                color: dark,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
