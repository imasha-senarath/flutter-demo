import 'package:flutter/material.dart';

class MyPost extends StatelessWidget {
  final String title;
  final String description;
  final Function()? onTap;

  const MyPost(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        "https://marketplace.canva.com/EADaiOc6T_o/3/0/1600w/canva-green-and-white-simple-blog-post-guide-linkedin-article-cover-image-k4HqWyb5gDA.jpg";
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              description,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
