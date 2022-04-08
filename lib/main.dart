// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:test_job_thing/view/home.dart';
import 'package:test_job_thing/view/blogs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Main());
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      body: pages(),
    );
  }

  Widget bottomBar() {
    const style = TextStyle(color: Colors.white);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_rounded),
          label: 'Candidates',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ballot_outlined),
          label: 'Blogs',
        ),
      ],
      onTap: (int index) => setState(() => this.index = index),
    );
  }

  Widget pages() {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const Blogs();
      default:
        return Container();
    }
  }
}
