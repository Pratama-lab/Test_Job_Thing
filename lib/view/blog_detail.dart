// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class BlogDetail extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final String? photo;
  final String? content;
  final String? author;
  final String? tag;
  const BlogDetail(
      {Key? key,
      this.title,
      this.subTitle,
      this.photo,
      this.content,
      this.author,
      this.tag})
      : super(key: key);

  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text('Blog Detail',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
            centerTitle: true,
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new_rounded))),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Text('${widget.title}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center)),
                Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Text('${widget.subTitle}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.justify)),
                Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Image.network('${widget.photo}', fit: BoxFit.cover)),
                Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: Text('${widget.content}',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify)),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.grey.shade400])),
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text('Author by '),
                          Text(
                            '${widget.author}',
                            style: const TextStyle(color: Colors.red),
                          )
                        ],
                      )),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width / 1.15,
                    child: Text('Tags: ${widget.tag}')),
                const Padding(padding: EdgeInsets.only(top: 50))
              ],
            ),
          ),
        ));
  }
}
