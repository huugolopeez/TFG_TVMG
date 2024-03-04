import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tfg_tvmg/firestoreObjects/FbAnimes.dart';
import 'package:tfg_tvmg/firestoreObjects/FbMangas.dart';

import 'DataHolder.dart';

class FirebaseAdmin {
  Future<List<FbAnimes>> getAnimes() async {
    List<FbAnimes> animes = [];
    String uidUser = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> animeCollection = await DataHolder()
        .db
        .collection('AnimesList')
        .doc(uidUser)
        .collection('Animes')
        .get();

    animeCollection.docs.forEach((element) {
      FbAnimes anime = FbAnimes.fromFirestore(element, null);
      animes.add(anime);
    });

    return animes;
  }

  void insertUserAnime(FbAnimes anime) {
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference animeCollection = DataHolder()
        .db
        .collection('AnimesList')
        .doc(uidUser)
        .collection('Animes');

    animeCollection.doc('${anime.id}').set(anime.toFirestore());
  }

  void insertUserManga(FbMangas manga) {
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference mangaCollection = DataHolder()
        .db
        .collection('MangaList')
        .doc(uidUser)
        .collection('Mangas');

    mangaCollection.doc('${manga.id}').set(manga.toFirestore());
  }
}
