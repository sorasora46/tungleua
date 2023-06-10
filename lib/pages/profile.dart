import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tungleua/pages/create_store.dart';
import 'package:tungleua/pages/edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String profileImage =
      'https://www.mckinsey.com/~/media/mckinsey/our%20people/alessandro%20agosta/alessandro-agosta_fc_mask_profile_1536x1152.jpg?mw=400&car=2:2';
  final String name = 'Sorrawit Kwanja';
  final String email = 'sorrawit02546@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          // Profile Image
                          SizedBox(
                            width: 162.77,
                            height: 162.77,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(profileImage),
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Name
                          // TODO: Fetch user's name
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // Email
                          // TODO: Fetch user's email
                          Text(
                            email,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),

                          // Divider
                          const SizedBox(height: 15),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                            thickness: 1,
                          ),

                          // Profile (Go to edit profile, I guess?)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                            profileImage: profileImage,
                                            email: email,
                                            name: name,
                                          )));
                            },
                            child: const ListTile(
                              iconColor: Colors.black,
                              trailing: Icon(Icons.arrow_right),
                              leading: Icon(Icons.person_outlined),
                              title: Text('Profile'),
                            ),
                          ),

                          // Create store
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateStore()));
                            },
                            child: const ListTile(
                              iconColor: Colors.black,
                              trailing: Icon(Icons.arrow_right),
                              leading: Icon(Icons.location_on_outlined),
                              title: Text('Create Store'),
                            ),
                          ),

                          // Divider
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                            thickness: 1,
                          ),

                          const Spacer(),

                          // Logout Button
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            height: 45,
                            child: FilledButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                              },
                              style: const ButtonStyle(
                                // TODO: Use color from theme
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.green),
                              ),
                              child: const Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
