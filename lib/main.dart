import 'package:flutter/material.dart';
import 'package:gaji_karyawan/homeKategori.dart';
import 'home.dart';
import 'homeKategori.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        primarySwatch: Colors.lightGreen,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(  
            title: Text("Penggajian Karyawan"),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Karyawan",
                  ),
                Tab(
                  text : "Kategori"
                ),
              ],
            ),
          ),
              body: TabBarView(
                children: [
                  Home(),
                  HomeKategori(),
                ],
              ),
          ),
        ),
    );
  }
}