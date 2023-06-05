import 'package:flutter/material.dart';
import 'package:tungleua/styles/button_style.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {Key? key,
      required this.name,
      required this.email,
      required this.profileImage})
      : super(key: key);
  final String name;
  final String email;
  final String profileImage;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final editProfileFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  bool isEditable = false;

  void setEditable() {
    setState(() {
      if (isEditable) {
        isEditable = false;
      } else {
        isEditable = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: editProfileFormKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    // Profile Image
                    // TODO: Implement image picker
                    SizedBox(
                      width: 162.77,
                      height: 162.77,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.profileImage),
                      ),
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
                      enabled: isEditable,
                      decoration: const InputDecoration(
                          filled: true,
                          border: UnderlineInputBorder(),
                          labelText: "Edit your name"),
                    ),

                    const SizedBox(height: 20),

                    if (isEditable)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Save Button
                            // TODO: Save info and send to backend
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 30),
                              height: 45,
                              child: OutlinedButton(
                                  style: roundedOutlineButton,
                                  onPressed: () {},
                                  child: const Text('Save')),
                            ),

                            const SizedBox(width: 10),

                            // Cancel Button
                            // TODO: Turn isEdiable to false and discard all change
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 30),
                              height: 45,
                              child: FilledButton(
                                  style: filledButton,
                                  onPressed: () {},
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
    );
  }
}
