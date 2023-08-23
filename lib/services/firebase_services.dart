import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference maps = FirebaseFirestore.instance.collection("maps");
  CollectionReference marshallReports = FirebaseFirestore.instance.collection("marshallreports");
  CollectionReference reports = FirebaseFirestore.instance.collection("reports");
  List<String> stages = [];
  String? userName;

  Future<DocumentSnapshot>validateUser(id) async {
    DocumentSnapshot result = await users.doc(id).get();
    return result;
  }

  Future<DocumentSnapshot> getUserName() async{
    DocumentSnapshot result = await users.doc(user!.email).get();
    return result;
  }



  getMaps(){
    return maps.snapshots();
  }

  Future<QuerySnapshot<Object?>> getUsers() async{
    var result = await users.get();
    for (var item in result.docs){
    }
    return result;
  }

  getForms(){
    return marshallReports.snapshots();
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

  Future<void>addStageReport(documentId, data){

    var result = marshallReports.doc(documentId).collection(data["Stage Name"]).add(data);
    return result;
  }

  Future<void>addOtherReport(documentId, data){
    var result = marshallReports.doc(documentId).collection("${data['Submitted By']}_${DateTime.now().day}_${DateTime.now().hour}_${DateTime.now().minute}").add(data);
    return result;
  }

  Future<void>addNoiseTestData(data){
    var result = marshallReports.doc("Noise Test Reports").collection("Reports").add(data);
    return result;
  }

  Future<String?>uploadShopPicFile(filePath) async {
    var dateTime = DateTime.now().millisecondsSinceEpoch;
    File file = File(filePath);
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage
          .ref("uploads/reportimages/${dateTime.toString()}").putFile(file);
    } on FirebaseException {
    }
    String downloadUrl = await storage
        .ref("uploads/reportimages/${dateTime.toString()}")
        .getDownloadURL();

    return downloadUrl;
  }

  Future<void>addCommentReport({url, comment, submitter, location, area}){
    var result = reports.add({
      "image": url,
      "comment": comment,
      "submitted by": submitter,
      "location": location,
      "area": area,
      "time": DateTime.now()
    });
    return result;
  }

}