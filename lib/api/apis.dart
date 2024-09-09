import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:night_bite/models/canteen_user.dart';

class APIs {
  //For authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore databse
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //for accessing cloud firebase Storage
  //static FirebaseStorage storage = FirebaseStorage.instance

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

}