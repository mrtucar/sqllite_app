// @dart=2.9
import 'package:flutter/foundation.dart';

class Not {
  int _id;
  String _baslik;
  String _icerik;


  int get id => _id;
  String get baslik => _baslik;
  String get icerik => _icerik;

  set baslik(String yeniBaslik) {
    if (yeniBaslik.length <= 255) {
      _baslik = yeniBaslik;
    }
  }

  set icerik(String yeniIcerik) {
    if (yeniIcerik.length <= 255) {
      _icerik = yeniIcerik;
    }
  }

  Not(this._baslik,this._icerik);
  Not.withID(this._id,this._baslik,this._icerik);

  Map<String,dynamic> toMap() {
    var map = Map<String,dynamic>();
    map["baslik"] = _baslik;
    map["icerik"] = _icerik;
    if (_id != null)
      map["id"] = _id;
    return map;
  }

  Not.fromObject(dynamic o){
    this._id = o['id'];
    this._baslik = o['baslik'];
    this._icerik = o['icerik'];
  }

}