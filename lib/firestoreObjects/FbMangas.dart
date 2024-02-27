import 'package:cloud_firestore/cloud_firestore.dart';

class FbMangas {

  final String titulo;
  final String urlImagen;
  final String estatus;

  FbMangas({
    required this.titulo,
    required this.urlImagen,
    required this.estatus
  });

  factory FbMangas.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options
      ) {
    final data = snapshot.data();
    return FbMangas(
        titulo: data?['titulo'],
        urlImagen: data?['urlImagen'],
        estatus: data?['estatus']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "titulo" : titulo,
      if (urlImagen != null) "urlImagen" : urlImagen,
      if (estatus != null) "estatus" : estatus
    };
  }
}