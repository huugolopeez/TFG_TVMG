import 'package:cloud_firestore/cloud_firestore.dart';

class FbMangas {
  final int id;
  final String titulo;
  final String urlImagen;

  FbMangas(
      {required this.id,
      required this.titulo,
      required this.urlImagen});

  factory FbMangas.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return FbMangas(
        id: data?['id'],
        titulo: data?['titulo'],
        urlImagen: data?['urlImagen']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (titulo != null) "titulo": titulo,
      if (urlImagen != null) "urlImagen": urlImagen
    };
  }
}
