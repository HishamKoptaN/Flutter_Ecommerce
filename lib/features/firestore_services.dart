import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
DateTime _dateTime = DateTime.now();
int duration = 30;
CollectionReference _users = FirebaseFirestore.instance.collection('users');

class FirestoreServices {
  final currentUser = FirebaseAuth.instance.currentUser!;

  String? downloadURL;

  late String photo;

  Future<void> downloadURLExample() async {
    downloadURL =
        await FirebaseStorage.instance.ref().child(photo).getDownloadURL();
    debugPrint(downloadURL.toString());
  }

  // Future<void> deleteClient(String docID) {
  //   return clients.doc(docID).delete();
  // }

  DateTime getEndDate() {
    return _dateTime.add(
      Duration(days: duration),
    );
  }

  Future<void> addClient(
    String client,
    String durationSub,
    String type,
  ) async {
    String fieldName = client;
    DocumentReference documentRef =
        firestore.collection('suppliers').doc(fieldName);
    await documentRef.set(
      {
        'Name': client,
        'Type': type,
        'Duration': durationSub,
        'Date': DateFormat('yyyy-MM-dd').format(_dateTime),
        'GetEndDate': DateFormat('yyyy-MM-dd').format(
          getEndDate(),
        ),
      },
    );
  }

  Color checkExpiration(DateTime now, clients) {
    DateTime endDate = DateTime.parse(clients['GetEndDate']);
    DateTime now = DateTime.now();
    if (now.isBefore(endDate)) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  // Future<void> addNote(String note) {
  //   return notes.add(
  //     {
  //       'Notes': note,
  //       'timestamp': Timestamp.now(),
  //     },
  //   );
  // }

  // Stream<QuerySnapshot> getNotesStream() {
  //   final notesStream =
  //       notes.orderBy('timestamp', descending: true).snapshots();
  //   return notesStream;
  // }

  // Future<void> updateNote(String docID, String newNote) {
  //   return notes.doc(docID).update(
  //     {
  //       'Notes': newNote,
  //       'timestamp': Timestamp.now(),
  //     },
  //   );
}

// Future<void> deleteNote(String docID) {
//   return notes.doc(docID).delete();
// }

// Stream<QuerySnapshot> getClientsStream() {
//   final clientsData = clients.snapshots();
//   return clientsData;
// }

Future<void> updateFavorite(
    String docID, String newName, String newType, String newDuration) async {
  try {
    await FirebaseFirestore.instance.collection('Clients').doc(docID).update({
      'Name': newName,
      'Type': newType,
      'GetEndDate': newDuration,
    });
    print('تم تحديث بيانات العميل بنجاح.');
  } catch (error) {
    print('حدث خطأ أثناء تحديث بيانات العميل: $error');
  }
}

Future<void> updateClient(
    String docID, String newName, String newType, String newDuration) async {
  try {
    await FirebaseFirestore.instance.collection('Clients').doc(docID).update({
      'Name': newName,
      'Type': newType,
      'GetEndDate': newDuration,
    });
    print('تم تحديث بيانات العميل بنجاح.');
  } catch (error) {
    print('حدث خطأ أثناء تحديث بيانات العميل: $error');
  }
}

Future<void> updateUserData(
    String userId, String newName, String newType, String newDuration) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).update(
      {
        'Name': newName,
        'Type': newType,
        'Duration': newDuration,
      },
    );
    print('User data updated successfully.');
  } catch (error) {
    print('Error updating user data: $error');
  }
  updateUserData('userId123', 'New Name', 'New Type', 'New Duration');
}

void addToFavorites(String productId, String userId) {
  DatabaseReference reference = FirebaseDatabase.instance.reference();

  // قم بتحديث القيمة في Firebase Realtime Database بحسب هوية المستخدم وهوية المنتج.
  reference.child('favorites').child(userId).child(productId).set(true);
}

void updateFavoriteStatus(docID, bool newFavoriteStatus) {}
