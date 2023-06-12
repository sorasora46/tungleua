import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tungleua/services/user_service.dart';
import 'package:tungleua/styles/button_style.dart';
import 'package:tungleua/widgets/profile_pic.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {Key? key,
      required this.uid,
      required this.name,
      required this.email,
      this.profileImage})
      : super(key: key);
  final String uid;
  final String name;
  final String email;
  final String? profileImage;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final editProfileFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final ImagePicker imgPicker = ImagePicker();

  bool isEditable = false;
  String? imageString;
  File? image;

  Future<void> handleImagePicker() async {
    final image = await imgPicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final file = File(image.path);
    final fileStr = base64Encode(await file.readAsBytes());
    setState(() {
      this.image = file;
      imageString = fileStr;
    });
  }

  Future<void> handleSave() async {
    final Map<String, Object> updates = {'name': nameController.text};

    if (image != null) {
      updates['image'] = base64Encode(await image!.readAsBytes());
    }

    final isSuccess = await UserService().updateUserById(widget.uid, updates);
    if (isSuccess != null && isSuccess) {
      setState(() {
        isEditable = false;
      });
    }
  }

  void setEditable() {
    setState(() {
      if (isEditable) {
        handleCancel();
      } else {
        isEditable = true;
      }
    });
  }

  void handleCancel() {
    setState(() {
      isEditable = false;
      nameController.text = widget.name;
      emailController.text = widget.email;
    });
  }

  @override
  void initState() {
    super.initState();
    imageString = widget.profileImage;
    nameController.text = widget.name;
    emailController.text = widget.email;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: <Widget>[
          IconButton(
            onPressed: setEditable,
            icon: Icon(isEditable ? Icons.edit_off : Icons.edit),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: editProfileFormKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      // Profile Image
                      SizedBox(
                        width: 162.77,
                        height: 162.77,
                        child: GestureDetector(
                            onTap: isEditable ? handleImagePicker : null,
                            child: ProfilePic(image: imageString)),
                      ),

                      const SizedBox(height: 30),

                      // Name
                      TextFormField(
                        controller: nameController,
                        enabled: isEditable,
                        decoration: const InputDecoration(
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: "Edit your name"),
                      ),

                      const SizedBox(height: 20),

                      // Email
                      TextFormField(
                        controller: emailController,
                        // enabled: isEditable,
                        enabled: false,
                        decoration: const InputDecoration(
                            filled: true,
                            border: UnderlineInputBorder(),
                            labelText: "Edit your email"),
                      ),

                      const SizedBox(height: 20),

                      if (isEditable)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Save Button
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 30),
                                height: 45,
                                child: OutlinedButton(
                                    style: roundedOutlineButton,
                                    onPressed: handleSave,
                                    child: const Text('Save')),
                              ),

                              const SizedBox(width: 10),

                              // Cancel Button
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 30),
                                height: 45,
                                child: FilledButton(
                                    style: filledButton,
                                    onPressed: handleCancel,
                                    child: const Text('Cancel')),
                              ),
                            ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
