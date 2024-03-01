import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tfg_tvmg/firestoreObjects/FbAnimes.dart';
import 'package:tfg_tvmg/firestoreObjects/FbMangas.dart';
import 'package:tfg_tvmg/firestoreObjects/FbUsuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_tvmg/singletone/FirebaseAdmin.dart';
import 'package:tfg_tvmg/singletone/HttpAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  FirebaseFirestore db = FirebaseFirestore.instance;
  HttpAdmin httpAdmin = HttpAdmin();
  FirebaseAdmin firebaseAdmin = FirebaseAdmin();

  late Color colorFondo;
  late Color colorPrincipal;

  late FbUsuario selectedUser;
  late FbAnimes selectedAnime;
  late FbMangas selectedManga;

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

    prefs.setString('userName', selectedUser.username);
    prefs.setInt('userSeguidores', selectedUser.seguidores);
    prefs.setInt('userSeguidos', selectedUser.seguidos);
  }

  void loadCacheFbUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userName = prefs.getString('userName');
    int? userSeguidores = prefs.getInt('userSeguidores');
    int? userSeguidos = prefs.getInt('userSeguidos');

    userName ??= '';
    userSeguidores ??= 0;
    userSeguidos ??= 0;

    selectedUser = FbUsuario(username: userName, seguidores: userSeguidores, seguidos: userSeguidos);
  }
}