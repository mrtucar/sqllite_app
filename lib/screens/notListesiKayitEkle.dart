// @dart=2.9
import 'package:flutter/material.dart';
import '../model/Not.dart';
import '../utils/dbhelper.dart';

class NotListesiKayitEkle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotListesiKayitEkle();
  }
}

class _NotListesiKayitEkle extends State<NotListesiKayitEkle>{
  DBHelper vtIslemleri = DBHelper();
  int count = -1;
  List<Not> notlar = List<Not>();

  void getData() {
    final todosFuture = vtIslemleri.notlariListele();
    todosFuture.then((result) => {
      setState(() {
        notlar= result;
        count = notlar.length;
      })
    });
  }
  @override
  Widget build(BuildContext context)  {
    // TODO: implement build
    //var resim =Image.asset("assets/OrnekResim.png").toString();
    Not not1 = Not("test","icerik");
    vtIslemleri.NotEkle(not1);

    //getData();
    //return Text("wwws" + count.toString(),textDirection: TextDirection.ltr);
  }
}
