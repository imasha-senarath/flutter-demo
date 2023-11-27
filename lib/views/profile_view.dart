import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/const.dart';
import '../model/post.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  FirebaseAuth auth = FirebaseAuth.instance;

  late String? userId;

  CollectionReference usersCollectionReference =
      FirebaseFirestore.instance.collection('Users');

  @override
  void initState() {
    super.initState();

    User? user = auth.currentUser;
    userId = user?.uid;
  }

  Future<void> _getUserData() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('your_collection') // replace with your collection name
          .doc('your_document_id') // replace with your document ID
          .get();

      if (documentSnapshot.exists) {
        // Document exists, you can access the data
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        print('Document data: $data');
      } else {
        print('Document does not exist');
      }
    } catch (error) {
      print('Error getting document: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Icon(
              Icons.person,
              color: primaryColor,
              size: 100.0,
            ),
            const Text("--",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
