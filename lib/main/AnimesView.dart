import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tfg_tvmg/firestoreObjects/FbAnimes.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

import '../custom/TMGrid.dart';
import 'PostView.dart';

class AnimesView extends StatefulWidget {
  @override
  State<AnimesView> createState() => _AnimesViewState();
}

class _AnimesViewState extends State<AnimesView> {
  List<FbAnimes> animes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAnimes();
  }

  void getAnimes() async {
    await Future.delayed(Duration(seconds: 2));

    // Obtiene los animes
    animes = await DataHolder().firebaseAdmin.getAnimes();

    setState(() {
      isLoading = false;
    });
  }

  void onItemTap(int index) {
    DataHolder().selectedAnime = animes[index];
    // DataHolder().saveSelectedPostInCache();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostView(true)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DataHolder().colorFondo,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: 400,
              ),
              itemCount: animes.length,
              itemBuilder: (context, index) {
                return TMGrid(
                    sTitle: animes[index].titulo,
                    sBody: animes[index].urlImagen,
                    dFontSize: 15,
                    iPosition: index,
                    onItemTap: onItemTap);
              }),
    );
  }
}
