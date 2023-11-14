import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/post.dart';
import 'package:flutter_demo/const.dart';
import 'package:flutter_demo/views/add_post_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/bottom_sheet_menu.dart';
import '../model/post.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<Post> postList = [];

  CollectionReference postsCollectionReference =
      FirebaseFirestore.instance.collection('Posts');

  @override
  void initState() {
    super.initState();

  }

  Future<List<Post>> _getPosts() async {
    List<Post> list = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Posts').get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      list.add(Post(
        id: doc.id,
        title: data['title'],
        description: data['description'],
      ));
    }

    return list;
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
            const Text(
              "John Smith",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
      ),
    );
  }
}
