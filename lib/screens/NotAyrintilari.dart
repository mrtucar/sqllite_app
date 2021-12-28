// @dart=2.9
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlliteapp/model/Not.dart';
import 'package:sqlliteapp/utils/dbhelper.dart';


final List<String> secenekler = const <String>[menuSave, menuDelete, menuBack];

const menuSave = "Kaydet";
const menuDelete = "Sil";
const menuBack = "Geri Dön";

class NotAyrintilari extends StatefulWidget {
  @override
  final Not not;
  NotAyrintilari(this.not);

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NotAyrintilari(not);
  }

}

class _NotAyrintilari extends State{
  Not not;
  _NotAyrintilari(this.not);


  DBHelper vtIslemleri = DBHelper();
  File _file;
  TextEditingController baslikKontroller = TextEditingController();
  TextEditingController ayrintiKontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    baslikKontroller.text = not.baslik;
    ayrintiKontroller.text = not.icerik;
    return Scaffold(
      appBar: AppBar (
        automaticallyImplyLeading: false,
        title: Text("Ayrıntılar"),
        actions: [
          PopupMenuButton<String>(
            onSelected: secim,
            itemBuilder: (BuildContext context) {
              return secenekler.map((e)  {
                return PopupMenuItem<String>(
                  value:e,
                  child: Text(e),
                );
              }).toList();
            },
          )
        ],
      ),
      body:SingleChildScrollView(
        child: Padding (
        padding:  EdgeInsets.all(5.0),
        child: Column(
          children: [

            TextField(
              controller: baslikKontroller,
              decoration: InputDecoration(
                labelText:"Başlık",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )
              ),
            ),
            TextField(
              controller: ayrintiKontroller,
              decoration: InputDecoration(
                  labelText:  "Ayrıntı",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )
              ),
            )
          ],
        ),
      ) ),
    );
  }


  void secim(String value) async {
    not.baslik = baslikKontroller.text;
    not.icerik = ayrintiKontroller.text;
    AlertDialog alertDialog;
    if (value ==menuSave) {
      if (not.id != null) {
        vtIslemleri.NotGuncelle(not);
        alertDialog = AlertDialog(
            title: Text("Not Güncelle"),
            content: Text("Not Güncelleme İşlemi Gerçekleşti"));
      }
      else {
        vtIslemleri.NotEkle(not);
        alertDialog = AlertDialog(
            title: Text("Not Ekle"),
            content: Text("Not Ekleme İşlemi Gerçekleşti"));
      }

      Navigator.pop(context,true);
      showDialog(context: context, builder: (_) => alertDialog);
    }
    else if (value==menuDelete) {

      if (not.id==null) {
        return;
      }
      int result = await vtIslemleri.NotSil(not.id);
      Navigator.pop(context,true);

      if (result != 0) {
        AlertDialog alertDialog = AlertDialog(
          title: Text("Silme İşlemi"),
          content: Text("Not Silindi"),
        );
        showDialog(context: context, builder: (_) => alertDialog);
      }
    }
    else if (value == menuBack) {
      Navigator.pop(context, true);
    }
  }
}