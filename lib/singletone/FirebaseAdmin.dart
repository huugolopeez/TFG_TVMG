import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tfg_tvmg/firestoreObjects/FbAnimes.dart';

import 'DataHolder.dart';

class FirebaseAdmin {
  Future<QuerySnapshot<FbAnimes>> getPosts() async {
    CollectionReference<FbAnimes> reference = DataHolder()
        .db
        .collection("Animes")
        .withConverter(
            fromFirestore: FbAnimes.fromFirestore,
            toFirestore: (FbAnimes post, _) => post.toFirestore());

    return await reference.get();
  }

  void insertUserAnime(FbAnimes anime) {
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference animeCollection = DataHolder()
        .db
        .collection('AnimesList')
        .doc(uidUser).collection('Animes');

    animeCollection.doc('${anime.id}').set(anime.toFirestore());
  }
}
