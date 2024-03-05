import 'package:cloud_firestore/cloud_firestore.dart';

class FbMangas {
  final int id;
  final String titulo;
  final String urlImagen;
  final String? descripcion;
  final String? estatus;
  final int? capitulos;
  final int? volumenes;
  final String? fechaPublicacion;
  final String? tipo;
  final double? puntuacion;
  final String? autor;

  FbMangas(
      {required this.id,
      required this.titulo,
      required this.urlImagen,
      this.descripcion,
      this.estatus,
      this.capitulos,
      this.fechaPublicacion,
      this.tipo,
      this.volumenes,
      this.puntuacion,
      this.autor});

  factory FbMangas.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return FbMangas(
      id: data?['id'],
      titulo: data?['titulo'],
      urlImagen: data?['urlImagen'],
      descripcion: data?['descripcion'],
      estatus: data?['estatus'],
      capitulos: data?['capitulos'],
      fechaPublicacion: data?['fechaPublicacion'],
      tipo: data?['tipo'],
      volumenes: data?['volumenes'],
      puntuacion: data?['puntuacion'],
      autor: data?['autor'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (titulo != null) "titulo": titulo,
      if (urlImagen != null) "urlImagen": urlImagen,
      if (descripcion != null) "descripcion": descripcion,
      if (estatus != null) "estatus": estatus,
      if (capitulos != null) "capitulos": capitulos,
      if (fechaPublicacion != null) "fechaPublicacion": fechaPublicacion,
      if (tipo != null) "tipo": tipo,
      if (volumenes != null) "volumenes": volumenes,
      if (puntuacion != null) "puntuacion": puntuacion,
      if (autor != null) "autor": autor
    };
  }
}
