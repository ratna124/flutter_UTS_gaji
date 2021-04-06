import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'model/kategori.dart';
import 'package:flutter/material.dart';
import 'entryformKategori.dart';
import 'dbhelper.dart';

//pendukung program asinkron
class HomeKategori extends StatefulWidget {
  @override
  HomeKategoriState createState() => HomeKategoriState();
}

class HomeKategoriState extends State<HomeKategori> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Kategori> itemList;
  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Kategori>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kategori'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text("Tambah Kategori"),
              onPressed: () async {
                var kategori = await navigateToEntryForm(context, null);
                if (kategori != null) {

                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertK(kategori);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
            ),
          ),
        ),
      ]),
    );
  }

  Future<Kategori> navigateToEntryForm(BuildContext context, Kategori kategori) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryFormKategori(kategori);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.itemList[index].golongan,
              style: textStyle,
            ),
            subtitle: Text(this.itemList[index].gaji.toString()),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Kategori
                int result = await dbHelper.deleteK(this.itemList[index].id);
                if (result > 0) {
                  updateListView();
                }
              },
            ),
            onTap: () async {
              var kategori =
                  await navigateToEntryForm(context, this.itemList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              int result = await dbHelper.updateK(kategori);
              if (result > 0) {
                updateListView();
              }
            },
          ),
        );
      },
    );
  }

  //update List Kategori
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Kategori>> itemListFuture = dbHelper.getItemListK();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}