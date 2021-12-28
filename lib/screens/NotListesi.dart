// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlliteapp/model/Not.dart';
import 'package:sqlliteapp/screens/NotAyrintilari.dart';
import 'package:sqlliteapp/utils/dbhelper.dart';

class NotListesi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotListesi();
  }
}

class _NotListesi  extends State<NotListesi>{
  DBHelper vtIslemleri = DBHelper();
  List<Not> notlar;
  int count=0;

  void veriCek() {
    final notlarFuture = vtIslemleri.notlariListele();
    notlarFuture.then((sonuc) => {
      setState((){
        notlar = sonuc;
        count = notlar.length;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    if (notlar == null) {
      notlar = List<Not>();
      veriCek();
    }

    return Scaffold(
      body:notListesiNesneleri(),
      appBar: AppBar (title: Text("Notlar")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ayrintilaraGit(Not("", ""));
        },
        tooltip: 'Not Ekle',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView notListesiNesneleri() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) =>
            Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(this.notlar[position].baslik),
                subtitle: Text(this.notlar[position].icerik),
                onTap: () {
                  ayrintilaraGit(this.notlar[position]);
                },
              ),
            )
    );
  }
  void ayrintilaraGit(Not not) async {
    bool sonuc = await Navigator.push(
     context,MaterialPageRoute( builder:(context) => NotAyrintilari(not))
    );
    if (sonuc == true) {
      veriCek();
    }
  }

}
