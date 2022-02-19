import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth? firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;




  // UserRepository({this.firebaseAuth});
  Future<String?> signUp(String email, String password) async {
    try {
    var authUser = await firebaseAuth?.createUserWithEmailAndPassword(
          email: email, password: password);
    return authUser?.user?.email;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign In with email and password
  Future<String?> signIn(String email, String password) async {
    try {
      var auth = await firebaseAuth?.signInWithEmailAndPassword(
          email: email, password: password);
      return auth?.user?.email;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out

  Future<void> signOut() async {
    await firebaseAuth!.signOut();
  }

  // check Sign In
  Future<bool> isSignedIn() async {
    var currentUser = firebaseAuth!.currentUser;
    return currentUser != null;
  }

  //get current user
  Future<User?> getCurrentUser() async {
    return firebaseAuth!.currentUser;
  }


  //Add data to firestore
  Future<void> addData(int userData) async {
    final User? user = firebaseAuth?.currentUser;
    final uid = user?.uid;
    await fireStore.collection('users')
        .doc(uid)
        .set({
      'data': userData,
      'userId': uid,
      'email': user?.email
    });
  }

  //Fetch data from firestore
  Future<int?> getData() async{
    User? user = firebaseAuth?.currentUser;
    int data = (await FirebaseFirestore.instance.collection('users').doc(user?.uid).get()).data()?['data'];
    return int.parse(data.toString());
  }




}