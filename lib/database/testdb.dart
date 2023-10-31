/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
*/

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();

void writeData() {
  databaseReference.child('users').set({
    'name': 'John Doe',
    'email': 'johndoe@example.com',
  });
}

void readData() {
  databaseReference.child('users').once().then((DataSnapshot snapshot) {
    print('Data: ${snapshot.value}');
  } as FutureOr Function(DatabaseEvent value));
}

void main() {
  writeData();
}