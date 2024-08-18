import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key, required this.onSelectImage});
  final void Function(File image) onSelectImage;

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? selectedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      selectedImage = File(pickedImage.path);
    });
    widget.onSelectImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    var profileImage = Image.asset(
      "assets/images/profpic.png",
      height: 150,
      width: 150,
      fit: BoxFit.cover,
    );
    if (selectedImage != null) {
      profileImage = Image.file(
        selectedImage!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    }
    return Center(
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: ClipRRect(
                  child: Container(
                      height: 150,
                      width: 150,
                      child: Center(child: CircularProgressIndicator()))),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("error"),
            );
          }
          return Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  child: snapshot.data!.data()!['imageUrl'] != null &&
                          selectedImage == null
                      ? Image.network(
                          snapshot.data!.data()!['imageUrl'],
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : profileImage),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: const Color.fromARGB(255, 116, 168, 193),
                    borderRadius: BorderRadius.all(
                      Radius.circular(500),
                    ),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: _pickImage,
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
