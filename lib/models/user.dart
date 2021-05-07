import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lms/models/books.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionHistory {
  late String issued;
  late List<FirebaseBooks> books;
  late String returned;
}

class CurrentlyIssued {
  late String dueDate;
  late List<FirebaseBooks> issuedBooks;
  late bool isApproved;
}

class LMSUser extends ChangeNotifier {
  File? imageFile;
  late String name = '';
  late String imgUrl = '';
  late String phone = '';
  late String rollNo = '';
  late String email = FirebaseAuth.instance.currentUser!.email ?? '';
  late String address = '';
  late String docId = '';
  late String lastIssued = 'No Data';
  late bool isEligible = true;
  late double dueFine = 0.0;
  late double totalFinePaid = 0.0;
  late List<TransactionHistory> transactionHistory = [];
  late List<FirebaseBooks> wishlist = [];

  void updateUserImgUrl({required String imgUrl}) {
    this.imgUrl = imgUrl;
  }

  void updateImgaeLocal(File img) {
    imageFile = img;
    notifyListeners();
  }

  void updateUser({
    required String name,
    required String phone,
    required String rollNo,
    required String address,
  }) {
    this.name = name;
    this.phone = phone;
    this.address = address;
    this.rollNo = rollNo;
    notifyListeners();
  }

  Future<bool> getUserFromFirebase(BuildContext context) async {
    bool isComplete = false;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    await collectionReference
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      var data = value.docs.first.data();
      this.name = data['name'];
      this.imgUrl = data['imgUrl'] ?? '';
      this.phone = data['phone'];
      this.rollNo = data['rollNo'];
      this.email = data['email'];
      this.address = data['address'];
      this.lastIssued = data['lastIssued'];
      this.isEligible = data['isEligible'];
      this.dueFine = data['dueFine'];
      this.totalFinePaid = data['totalFinePaid'];
      this.transactionHistory = []; //data['transactionHistory'];
      this.wishlist = []; //data['wishlist'];
      isComplete = true;
    }).catchError((err) {
      isComplete = false;
    });
    notifyListeners();
    return isComplete;
  }

  static Future<bool> setUserToFirebase(
      BuildContext context, LMSUser lmsUser) async {
    bool returnvalue = false;
    Map<String, dynamic> map = {
      'name': lmsUser.name,
      'imgUrl': lmsUser.imgUrl,
      'phone': lmsUser.phone,
      'rollNo': lmsUser.rollNo,
      'email': lmsUser.email,
      'address': lmsUser.address,
      'lastIssued': lmsUser.lastIssued,
      'isEligible': lmsUser.isEligible,
      'dueFine': lmsUser.dueFine,
      'totalFinePaid': lmsUser.totalFinePaid,
      'transactionHistory': lmsUser.transactionHistory,
      'wishlist': lmsUser.wishlist
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    var providedUser = Provider.of<LMSUser>(context, listen: false);
    if (providedUser.docId != '') {
      var docSnapshot = await collectionReference.doc(providedUser.docId).get();
      if (docSnapshot.exists) {
        docSnapshot.reference.update(map);
        return true;
      } else {
        docSnapshot.reference.set(map);
        return true;
      }
    } else {
      await collectionReference.add({}).then((DocumentReference reference) {
        providedUser.docId = reference.id;
        returnvalue = true;
      }).catchError((err) {
        returnvalue = false;
      });
    }
    return returnvalue;
  }
}

// class Cart {
//   List<FirebaseBooks>
// }
