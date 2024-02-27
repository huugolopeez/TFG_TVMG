import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tfg_tvmg/firestoreObjects/FbUsuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  FirebaseFirestore db = FirebaseFirestore.instance;

  late Color colorFondo;
  late Color colorPrincipal;

  late FbUsuario selectedUser;

  DataHolder._internal() {
    initCache();
  }

  factory DataHolder() {
    return _dataHolder;
  }

  void initCache() {
    loadColors();
    loadCacheFbUser();
  }

  void loadColors() {
    colorFondo = const Color.fromRGBO(38, 41, 43, 1.0);
    colorPrincipal = const Color.fromRGBO(95, 122, 219, 1.0);
  }

  void saveSelectedUserInCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userName', selectedUser.nombre);
    prefs.setInt('userAge', selectedUser.edad);
  }

  void loadCacheFbUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userName = prefs.getString('userName');
    int? userAge = prefs.getInt('userAge');

    userName ??= '';
    userAge ??= 0;

    selectedUser = FbUsuario(nombre: userName, edad: userAge);
  }
}