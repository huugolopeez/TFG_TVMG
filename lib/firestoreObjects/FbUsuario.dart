import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario {

  final String username;
  final int seguidores;
  final int seguidos;
  final String urlPerfil;

  FbUsuario({
    required this.username,
    required this.seguidores,
    required this.seguidos,
    required this.urlPerfil
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options
      ) {
    final data = snapshot.data();
    return FbUsuario(
        username: data?['username'],
        seguidores: data?['seguidores'],
        seguidos: data?['seguidos'],
        urlPerfil: data?['urlPerfil']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) "username" : username,
      if (seguidores != null) "seguidores" : seguidores,
      if (seguidos != null) "seguidos" : seguidos,
      if (urlPerfil != null) "urlPerfil" : urlPerfil
    };
  }
}