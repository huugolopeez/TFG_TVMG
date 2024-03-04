import 'package:flutter/material.dart';
import 'package:tfg_tvmg/firestoreObjects/FbAnimes.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class PostView extends StatefulWidget {
  final bool isAnime;

  PostView(this.isAnime);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        body: widget.isAnime
            ? Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    color: DataHolder().colorPrincipal,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(DataHolder().selectedAnime.titulo,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white)),
                    )),
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Image(
                              image: NetworkImage(
                                  DataHolder().selectedAnime.urlImagen))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Capitulos: ${DataHolder().selectedAnime.capitulos}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Estudio: ${DataHolder().selectedAnime.estudio}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Tipo: ${DataHolder().selectedAnime.tipo}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Estado: ${DataHolder().selectedAnime.estatus}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Fecha publicacion: ${DataHolder().selectedAnime.fechaPublicacion}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Puntuacion: ${DataHolder().selectedAnime.puntuacion}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(DataHolder().selectedAnime.descripcion!,
                        maxLines: 10,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.justify),
                  )
                ],
              )
            : Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    color: DataHolder().colorPrincipal,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(DataHolder().selectedManga.titulo,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white)),
                    )),
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Image(
                              image: NetworkImage(
                                  DataHolder().selectedManga.urlImagen))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Capitulos: ${DataHolder().selectedManga.capitulos}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Volumenes: ${DataHolder().selectedManga.volumenes}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Autor: ${DataHolder().selectedManga.autor}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Tipo: ${DataHolder().selectedManga.tipo}',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Estado: ${DataHolder().selectedManga.estatus}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Fecha publicacion: ${DataHolder().selectedManga.fechaPublicacion}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                                'Puntuacion: ${DataHolder().selectedManga.puntuacion}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(DataHolder().selectedManga.descripcion!,
                        maxLines: 10,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                        textAlign: TextAlign.justify),
                  )
                ],
              ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(widget.isAnime) {
                DataHolder().firebaseAdmin.insertUserAnime(DataHolder().selectedAnime);
              } else {
                DataHolder().firebaseAdmin.insertUserManga(DataHolder().selectedManga);
              }
              },
            backgroundColor: DataHolder().colorPrincipal,
            child: const Icon(Icons.save)));
  }
}
