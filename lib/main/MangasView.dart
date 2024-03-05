import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tfg_tvmg/firestoreObjects/FbMangas.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

import '../custom/TMGrid.dart';
import 'PostView.dart';

class MangasView extends StatefulWidget {
  @override
  State<MangasView> createState() => _MangasViewState();
}

class _MangasViewState extends State<MangasView> {
  List<FbMangas> mangas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getMangas();
  }

  void getMangas() async {
    await Future.delayed(const Duration(seconds: 2));

    // Obtiene los animes
    mangas = await DataHolder().firebaseAdmin.getMangas();

    setState(() {
      isLoading = false;
    });
  }

  void onItemTap(int index) {
    DataHolder().selectedManga = mangas[index];
    // DataHolder().saveSelectedPostInCache();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostView(false)));
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
            crossAxisCount: kIsWeb ? 4 : 2,
            mainAxisExtent: 400,
          ),
          itemCount: mangas.length,
          itemBuilder: (context, index) {
            return TMGrid(
                sTitle: mangas[index].titulo,
                sBody: mangas[index].urlImagen,
                dFontSize: 15,
                iPosition: index,
                onItemTap: onItemTap);
          }),
    );
  }
}
