// ignore_for_file: sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:flutter_launch/flutter_launch.dart';

class CandidateDetail extends StatefulWidget {
  final String? name;
  final String? photo;
  final String? gender;
  final String? email;
  final String? phone;
  final String? address;
  final String? city;
  final int birthday;
  final String? jobTitle;
  final String? companyName;
  final String? industry;
  const CandidateDetail(
      {Key? key,
      this.name,
      this.photo,
      this.gender,
      this.email,
      this.phone,
      this.address,
      this.city,
      required this.birthday,
      this.jobTitle,
      this.companyName,
      this.industry})
      : super(key: key);

  @override
  _CandidateDetailState createState() => _CandidateDetailState();
}

class _CandidateDetailState extends State<CandidateDetail> {
  @override
  void initState() {
    super.initState();
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final timestamp1 = widget.birthday;
    final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Candidate Detail',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.height / 6,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network('${widget.photo}',
                                fit: BoxFit.cover))),
                    Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Name')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text('${widget.name}'))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Gender')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: widget.gender == 'm'
                                        ? const Text('Male')
                                        : const Text('Female'))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Birthday')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                        '${DateFormat.yMMMd().format(date1)}'))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Email')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: GestureDetector(
                                        onTap: () async {
                                          EmailContent email = EmailContent(
                                            to: [
                                              '${widget.email}',
                                            ],
                                            subject:
                                                'Hi i am ${widget.companyName} company',
                                            body:
                                                'Hi i am ${widget.companyName} company',
                                            cc: [],
                                            bcc: [''],
                                          );

                                          OpenMailAppResult result =
                                              await OpenMailApp
                                                  .composeNewEmailInMailApp(
                                                      nativePickerTitle:
                                                          'Select email app to compose',
                                                      emailContent: email);
                                          if (!result.didOpen &&
                                              !result.canOpen) {
                                            showNoMailAppsDialog(context);
                                          } else if (!result.didOpen &&
                                              result.canOpen) {
                                            showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  MailAppPickerDialog(
                                                mailApps: result.options,
                                                emailContent: email,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text('${widget.email}',
                                            style: const TextStyle(
                                                color: Colors.blue))))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Phone')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: GestureDetector(
                                        onTap: () async {
                                          await FlutterLaunch.launchWhatsapp(
                                              phone: '${widget.phone}',
                                              message:
                                                  'Hi i am ${widget.companyName} company');
                                        },
                                        child: Text('${widget.phone}',
                                            style: const TextStyle(
                                                color: Colors.blue))))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Address')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text('${widget.address}'))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('City')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text('${widget.city}'))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Job Title')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text('${widget.jobTitle}'))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Company Name')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text('${widget.companyName}'))
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: const Text('Industry')),
                                const Text(':'),
                                Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text('${widget.industry}'))
                              ],
                            )
                          ],
                        ))
                  ],
                ))));
  }
}
