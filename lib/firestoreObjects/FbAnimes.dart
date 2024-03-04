import 'package:cloud_firestore/cloud_firestore.dart';

class FbAnimes {
  final int id;
  final String titulo;
  final String urlImagen;
  final String? descripcion;
  final String? estatus;
  final int? capitulos;
  final String? fechaPublicacion;
  final String? tipo;
  final double? puntuacion;
  final String? estudio;

  FbAnimes(
      {required this.id,
      required this.titulo,
      required this.urlImagen,
      this.descripcion,
      this.estatus,
      this.capitulos,
      this.fechaPublicacion,
      this.tipo,
      this.puntuacion,
      this.estudio});

  factory FbAnimes.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return FbAnimes(
        id: data?['id'],
        titulo: data?['titulo'],
        urlImagen: data?['urlImagen'],
        descripcion: data?['descripcion'],
        estatus: data?['estatus'],
        capitulos: data?['capitulos'],
        fechaPublicacion: data?['fechaPublicacion'],
        tipo: data?['tipo'],
        puntuacion: data?['puntuacion'],
        estudio: data?['estudio']);
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
      if (puntuacion != null) "puntuacion": puntuacion,
      if (estudio != null) "estudio": estudio
    };
  }
}
