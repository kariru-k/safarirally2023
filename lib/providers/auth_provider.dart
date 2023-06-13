import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart';

class AuthProvider extends ChangeNotifier {

  late File? image;
  bool isShopPicAvailable = false;
  bool isOwnerPicAvailable = false;
  final picker = ImagePicker();
  String? pickererror;
  double? userLatitude;
  double? userLongitude;
  String? error;
  String? email;

  Future<File?> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      pickererror = "No image selected";
      notifyListeners();
    }

    return image;
  }

  Future<File?> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera, imageQuality: 20);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      pickererror = "No image selected";
      notifyListeners();
    }

    return image;
  }

  Future getCurrentAddress() async {
    loc.Location location = loc.Location();
    bool serviceEnabled;
    LocationPermission permissionGranted;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.denied) {
      permissionGranted = await Geolocator.requestPermission();
      if (permissionGranted == LocationPermission.denied) {
        return Future.error("Location Permissions are denied");
      }
    }
    Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );

    userLatitude = position.latitude;
    userLongitude = position.longitude;
    notifyListeners();

    return GeoPoint(userLatitude!, userLongitude!);
    }

  Future<UserCredential?> registerUser(email, password) async {
      this.email = email;
      notifyListeners();

      UserCredential? userCredential;
      try {
        userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak_password") {
          error = e.code;
          notifyListeners();
        } else if (e.code == "email-already-in-use") {
          error = e.code;
          notifyListeners();
        }
      } catch (e) {
        error = e.toString();
        notifyListeners();
      }
      return userCredential;
  }


  Future<UserCredential?> loginUser(email, password) async {
    this.email = email;
    notifyListeners();

    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      error = e.code;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }

    return userCredential;
  }


  Future<void> resetPassword(email) async {
      this.email = email;
      notifyListeners();
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        error = e.code;
        notifyListeners();
      } catch (e) {
        error = e.toString();
        notifyListeners();
      }
  }

  Future<void> saveUserDataToDb({
    required String? name,
    required String? emailaddress,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;

    DocumentReference users = FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid);

    users.set({
      'uid': user?.uid,
      'email': emailaddress,
      'location': GeoPoint(userLatitude!, userLongitude!),
      'name': name
    });

    return;
  }
}