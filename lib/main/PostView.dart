import 'package:flutter/material.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class PostView extends StatelessWidget {
  final bool isAnime;

  PostView(this.isAnime);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isAnime
            ? Column(
                children: [
                  Text(DataHolder().selectedAnime.titulo),
                  Image(
                      image: NetworkImage(DataHolder().selectedAnime.urlImagen))
                ],
              )
            : Column(
                children: [
                  Text(DataHolder().selectedManga.titulo),
                  Image(
                      image: NetworkImage(DataHolder().selectedManga.urlImagen))
                ],
              ));
  }
}
