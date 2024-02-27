import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario {

  final String username;
  final int seguidores;
  final int seguidos;

  FbUsuario({
    required this.username,
    required this.seguidores,
    required this.seguidos
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options
      ) {
    final data = snapshot.data();
    return FbUsuario(
        username: data?['username'],
        seguidores: data?['seguidores'],
        seguidos: data?['seguidos']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (username != null) "username" : username,
      if (seguidores != null) "seguidores" : seguidores,
      if (seguidos != null) "seguidos" : seguidos
    };
  }
}