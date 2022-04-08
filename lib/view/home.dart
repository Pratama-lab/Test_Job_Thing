// ignore_for_file: sized_box_for_whitespace, unused_field, prefer_final_fields, non_constant_identifier_names, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_job_thing/api/api_call_services.dart';
import 'package:test_job_thing/model/candidates.dart';
import 'package:test_job_thing/model/merge.dart';
import 'package:test_job_thing/widget/search_widget.dart';
import 'package:test_job_thing/view/candidate_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Merge> merges = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final cands = await ApiMerge().getMergeData(query);

    setState(() => merges = cands);
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
                                  itemCount: merges.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                        child: GestureDetector(
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) => CandidateDetail(
                                                        name:
                                                            merges[index].name,
                                                        photo:
                                                            merges[index].photo,
                                                        gender: merges[index]
                                                            .gender,
                                                        email:
                                                            merges[index].email,
                                                        phone:
                                                            merges[index].phone,
                                                        address: merges[index]
                                                            .address,
                                                        city:
                                                            merges[index].city,
                                                        birthday: merges[index]
                                                            .birthday,
                                                        jobTitle: merges[index]
                                                            .jobTitle,
                                                        companyName: merges[index]
                                                            .companyName,
                                                        industry:
                                                            merges[index].industry))),
                                            child: ListTile(
                                                title: Row(
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                            merges[index].photo,
                                                            fit:
                                                                BoxFit.cover))),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Column(
                                                      children: [
                                                        Text(merges[index].name)
                                                      ],
                                                    ))
                                              ],
                                            ))));
                                  }));
                        }
                        return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.blue));
                      },
                    ))
                  ],
                ))));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search',
        onChanged: searchCandidate,
      );

  Future searchCandidate(String query) async {
    final _candidates = await ApiMerge().getMergeData(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      merges = _candidates;
    });
  }

  Widget buildCandidate(Candidate _candidate) => ListTile(
          title: Row(
        children: [
          Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 8,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(_candidate.photo, fit: BoxFit.cover))),
          Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [Text(_candidate.name)],
              ))
        ],
      ));
}
