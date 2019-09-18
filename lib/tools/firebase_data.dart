import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datematic/tools/app_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseData {
  String defaultURL =
      "http://images.clipartpanda.com/user-clipart-matt-icons_preferences-desktop-personal.png";
  //This gets the current name of the user
  Future<String> getName() async {
    FirebaseUser user = await auth.currentUser();
    if (user != null) {
      return user.displayName ?? "User";
    } else {
      return "User";
    }
  }

  Future<String> getPhotoURL() async {
    FirebaseUser user = await auth.currentUser();
    if (user != null) {
      return user.photoUrl ?? defaultURL;
    } else {
      return defaultURL;
    }
  }

  Future<String> getUserId() async {
    FirebaseUser user = await auth.currentUser();
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

// This function is called to update the FCM Token
  Future<Null> update() async {
    await Future.delayed(Duration(seconds: 30));
    String token = await getMobileFCMToken();
    String userId = await getUserId();
    DocumentSnapshot documentSnapshot =
        await db.collection("users").document(userId).get();
    String tok = documentSnapshot.data["fcm_token"];
    if (token != tok) {
      try {
        db.collection("users").document(userId).setData({"fcm_token": token});
      } catch (e) {
        print(e);
      }
    }
  }

  //This function is called to get Notification
  Future<String> getMobileFCMToken() async {
    String token = await firebaseMessaging.getToken();
    return token;
  }
}
