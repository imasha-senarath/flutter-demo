import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/confirm_dialog.dart';
import 'package:flutter_demo/components/post.dart';
import 'package:flutter_demo/views/add_post_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/bottom_sheet_menu.dart';
import '../components/dialog.dart';
import '../model/post.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Post> postList = [];

  CollectionReference postsCollectionReference =
      FirebaseFirestore.instance.collection('Posts');

  @override
  void initState() {
    super.initState();
    _setPosts();
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

  Future<void> _setPosts() async {
    List<Post> posts = await _getPosts();
    setState(() {
      postList = posts;
    });
  }

  void postClicked(String postId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MyBottomSheetMenu(
          onItemSelected: (value) {
            if (value == 'View') {
            } else if (value == 'Delete') {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyConfirmDialog(
                      title: 'Delete',
                      description: "Are you sure want to delete?",
                      onTap: deletePost(postId),
                    );
                  });
            }
          },
        );
      },
    );
  }

  Future<void> deletePost(String postId) async {
    try {
      DocumentReference documentReference =
          postsCollectionReference.doc(postId);
      await documentReference.delete();

      Fluttertoast.showToast(
          msg: "Post deleted successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Posts").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index].data() as Map<String, dynamic>;
                final itemId = items[index].id;
                return MyPost(
                  title: item['title'],
                  description: item['description'],
                  onTap: () {
                    postClicked(itemId);
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:  (BuildContext context) => const AddPostView(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Center myListView() {
    return Center(
      child: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          Post post = postList[index];
          return MyPost(
            title: post.title,
            description: post.description,
            onTap: () {
              postClicked(post.id.toString());
            },
          );
        },
      ),
    );
  }
}
