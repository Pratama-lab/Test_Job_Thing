// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_job_thing/api/api_call_services.dart';
import 'package:test_job_thing/model/blogs.dart';
import 'package:test_job_thing/view/blog_detail.dart';
import 'package:test_job_thing/widget/search_widget.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  List<Blog> blogs = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final cands = await ApiCallBlog.getBlogs(query);

    setState(() => blogs = cands);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: buildSearch()),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Expanded(
                      child: FutureBuilder(
                    future: ApiMerge().getMergeData(query),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                itemCount: blogs.length,
                                itemBuilder: (context, index) {
                                  final candidate = blogs[index];
                                  return Card(child: buildCandidate(candidate));
                                }));
                      }
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.blue));
                    },
                  ))
                ],
              ))),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: searchCandidate,
      );

  Future searchCandidate(String query) async {
    final _blogs = await ApiCallBlog.getBlogs(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      blogs = _blogs;
    });
  }

  Widget buildCandidate(Blog _blog) => GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlogDetail(
              title: _blog.title,
              subTitle: _blog.subTitle,
              photo: _blog.photo,
              content: _blog.content,
              author: _blog.author,
              tag: _blog.tag))),
      child: ListTile(
          title: Row(
        children: [
          Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 8,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(_blog.photo, fit: BoxFit.cover))),
          Container(
              padding: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width / 1.9,
              child: Column(
                children: [Text(_blog.title)],
              ))
        ],
      )));
}
