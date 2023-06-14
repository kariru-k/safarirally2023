import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference maps = FirebaseFirestore.instance.collection("maps");

  Future<DocumentSnapshot>validateUser(id) async {
    DocumentSnapshot result = await users.doc(id).get();
    return result;
  }

  getMaps(){
    return maps.snapshots();
  }

}