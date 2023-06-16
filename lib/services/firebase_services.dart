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

  getMapDetails(id){
    return maps.where("name", isEqualTo: id).snapshots();
  }

  Future<void>updateToiletLocation(documentId, type, position){
    final data = {
      "position": position,
      "submittedAt": DateTime.now()
    };
    var result = maps.doc(documentId).update({
      "Toilets.$type": FieldValue.arrayUnion([data]),
      "Toilet Locations.$type": FieldValue.arrayUnion([data])
    },);
    return result;
  }

  Future<void>updateLitterLocation(documentId, position){
    final data = {
      "position": position,
      "submittedAt": DateTime.now()
    };
    var result = maps.doc(documentId).update({
      "Littered Areas": FieldValue.arrayUnion([data]),
      "Littered Areas Locations": FieldValue.arrayUnion([data])
    },);
    return result;
  }

  Future<void>deleteLitteredArea({documentId, timestamp, location}){
    final docRef = maps.doc(documentId);
    // Remove the 'capital' field from the document
    final data = {
      "position": location,
      "submittedAt": timestamp
    };

    final updates = <String, dynamic>{
      "Littered Areas": FieldValue.arrayRemove([data]),
    };

    var result = docRef.update(updates);

    return result;
  }


  Future<void>deleteToiletLocation({documentId, type, timestamp, location}){
    final docRef = maps.doc(documentId);
    // Remove the 'capital' field from the document
    final data = {
      "position": location,
      "submittedAt": timestamp
    };

    final updates = <String, dynamic>{
      "Toilets.$type": FieldValue.arrayRemove([data]),
    };

    var result = docRef.update(updates);

    return result;
  }




}