import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/post.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CollectionReference postsCollectionReference =
      FirebaseFirestore.instance.collection('Posts');

  Future <void> _addUser(Post post) async {

    Map<String, dynamic> postData = {
      'title': post.title,
      'description': post.description,
    };

    postsCollectionReference
        .add(postData)
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "Post added.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0),
            })
        .catchError((error) => {
              Fluttertoast.showToast(
                  msg: error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addUser(Post("", "This is the first post",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit."));
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
