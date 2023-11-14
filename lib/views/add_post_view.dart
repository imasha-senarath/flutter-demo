import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/button.dart';
import '../components/dialog.dart';
import '../components/text_field.dart';
import '../const.dart';
import '../model/post.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({Key? key}) : super(key: key);

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  CollectionReference postsCollectionReference =
      FirebaseFirestore.instance.collection('Posts');

  Future<void> _addPost() async {
    String titleValue = titleController.text;
    String descriptionValue = descriptionController.text;

    if (titleValue == "" || descriptionValue == "") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const MyDialog(
              title: 'Error',
              description: "Field can't be empty.",
            );
          });
    } else {
      Map<String, dynamic> postData = {
        'title': titleValue,
        'description': descriptionValue,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter post details here.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              MyTextField(
                hintText: 'Title',
                controller: titleController,
                obscureText: false,
                icon: const Icon(null),
                multiLine: 1,
              ),
              const SizedBox(
                height: 10.0,
              ),
              MyTextField(
                hintText: 'Description',
                controller: descriptionController,
                obscureText: false,
                icon: const Icon(null),
                multiLine: null,
              ),
              const SizedBox(
                height: 15.0,
              ),
              MyButton(
                onTap: _addPost,
                name: 'Add',
              )
            ],
          ),
        ),
      ),
    );
  }
}
