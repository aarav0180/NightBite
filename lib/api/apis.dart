import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:night_bite/models/canteen_user.dart';

class APIs {
  //For authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore databse
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //for accessing cloud firebase Storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //For storing self information
  static late CanteenUser me;

  //To return current user
  static User get user =>auth.currentUser!;

  //For checking user exists or not
  static Future<bool> userExists() async{
    return (await firestore.collection('users').doc(auth.currentUser!.uid).get()).exists; //exclamation mark to ensure here that current user is not null
  }

  //For getting info of current user
  static Future<void> getSelfInfo() async{
    await firestore.collection('users').doc(user.uid).get().then((user) async{
      if(user.exists){
        me = CanteenUser.fromJson(user.data()!);
        print("My data: ${user.data()}");
      }
      else{
        await createUser().then((value)=>getSelfInfo());
      }
    });
  }

  //To create new user
  static Future<void> createUser() async {
    final canteenUser = CanteenUser(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        contact: '',
        id: user.uid,
        email: user.email.toString(),
        pushToken: ''
    );
    return await firestore.collection('users').doc(user.uid).set(canteenUser.toJson());
  }

  //To update user's personal info
  static Future<void> updateUserInfo() async{
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
    });
  }

  //Update Profile Picture of User
  static Future<void> updateProfilePicture(File file) async{
    //Getting image final extension
    final ext = file.path.split('.').last; //This will return the string after '.'\
    print("Extension: $ext");

    //Storage final reference with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');

    //Uploading image
    await ref.putFile(file, SettableMetadata(contentType: "image/$ext")).then((p0){
      print('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //Updating image in firebase database
    me.image = await ref.getDownloadURL();
    await firestore. collection('users').doc(user.uid).update({
      'image': me.image
    });
  }

  //Apply Customised Colour
  static Color hexToColor(String hexCode){
    return Color(int.parse(hexCode.substring(1, 7),radix: 16) + 0xFF000000);
  }

}