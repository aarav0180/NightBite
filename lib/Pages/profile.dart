import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:night_bite/Pages/Login.dart';
import '../api/apis.dart';
import '../helper/dialogs.dart';
import '../models/canteen_user.dart';

class ProfileScreen extends StatefulWidget {
  final CanteenUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _image;
  bool _isUploading = false;  // Flag for tracking upload state

  Color hexToColor(String hexCode) {
    return Color(int.parse(hexCode.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: hexToColor('#293d3d'),
        appBar: AppBar(
          title: const Text("Profile Details", style: TextStyle(fontSize: 25)),
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              Dialogs.showProgressLoader(context); // Show progress bar
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  // Hide progress bar and move to login screen
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Login()));
                });
              });
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(width: mq.size.width, height: mq.size.height * .02),

                  // Profile Picture Section
                  Stack(
                    children: [
                      _isUploading
                          ? const CircularProgressIndicator() // Show loader when uploading
                          : _image != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(mq.size.height * .1),
                        child: Image.file(
                          File(_image!),
                          width: mq.size.height * .2,
                          height: mq.size.height * .2,
                          fit: BoxFit.cover,
                        ),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(mq.size.height * .1),
                        child: CachedNetworkImage(
                          width: mq.size.height * .2,
                          height: mq.size.height * .2,
                          fit: BoxFit.cover,
                          imageUrl: widget.user.image,
                          errorWidget: (context, url, error) => const CircleAvatar(
                            child: Icon(CupertinoIcons.person),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: -5,
                        width: mq.size.width * .2,
                        height: mq.size.height * .03,
                        child: MaterialButton(
                          onPressed: _showBottomSheet,
                          color: Colors.grey,
                          shape: const CircleBorder(),
                          elevation: 1,
                          child: const Icon(Icons.edit, color: Colors.orange, size: 20),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: mq.size.height * .019),

                  // Email Display
                  Text(widget.user.email, style: const TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: mq.size.height * .04),

                  // Name TextField
                  TextFormField(
                    initialValue: widget.user.name,
                    style: const TextStyle(color: Colors.white),
                    onSaved: (val) => APIs.me.name = val ?? '',
                    validator: (val) => val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.yellow, width: 2.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "eg. Mickey Mouse",
                      prefixIcon: const Icon(Icons.person, color: Colors.white),
                      label: const Text("Name", style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  SizedBox(height: mq.size.height * .05),

                  // Update Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(mq.size.width * .5, mq.size.height * .06),
                      backgroundColor: Colors.greenAccent,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackbar(context, 'Profile Updated Successfully');
                        });
                      }
                    },
                    label: const Text("Update", style: TextStyle(fontSize: 23, color: Colors.white)),
                    icon: const Icon(Icons.edit, color: Colors.white, size: 25),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        final mq = MediaQuery.of(context);

        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: mq.size.height * .03, bottom: mq.size.height * .08),
          children: [
            const Text(
              "Pick Profile Picture",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: mq.size.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Pick from Gallery
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(mq.size.width * .3, mq.size.height * .15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      _handleImageUpload(File(image.path));
                    }
                  },
                  child: Image.asset('image/gallery.png'),
                ),
                // Pick from Camera
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: Size(mq.size.width * .3, mq.size.height * .15),
                  ),
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      _handleImageUpload(File(image.path));
                    }
                  },
                  child: Image.asset('image/camera.png'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _handleImageUpload(File image) async {
    try {
      setState(() => _isUploading = true);

      // Close the bottom sheet after picking the image
      Navigator.pop(context);

      // Update profile picture and set the new image path
      await APIs.updateProfilePicture(image);

      if (mounted) {
        setState(() {
          _image = image.path; // Set the new image
          _isUploading = false; // Stop the loading state
        });
        Dialogs.showSnackbar(context, 'Profile picture updated successfully');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isUploading = false);
        Dialogs.showSnackbar(context, 'Failed to upload image');
      }
    }
  }
}
