import 'package:cloud_firestore/cloud_firestore.dart';

class FbAnimes {

  final String titulo;
  final String urlImagen;
  final String tipo;
  final String estatus;

  FbAnimes({
    required this.titulo,
    required this.urlImagen,
    required this.tipo,
    required this.estatus
  });

  factory FbAnimes.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options
      ) {
    final data = snapshot.data();
    return FbAnimes(
        titulo: data?['titulo'],
        urlImagen: data?['urlImagen'],
        tipo: data?['tipo'],
        estatus: data?['estatus']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (titulo != null) "titulo" : titulo,
      if (urlImagen != null) "urlImagen" : urlImagen,
      if (tipo != null) "tipo" : tipo,
      if (estatus != null) "estatus" : estatus
    };
  }
}