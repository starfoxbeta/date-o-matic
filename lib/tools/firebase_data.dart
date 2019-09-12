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
}
