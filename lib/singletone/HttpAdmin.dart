import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tfg_tvmg/firestoreObjects/FbAnimes.dart';
import 'package:tfg_tvmg/firestoreObjects/FbMangas.dart';

class HttpAdmin {
  Future<String> fetchAnimeData(String anime) async {
    String responseBody = '';

    var url = 'https://api.jikan.moe/v4/anime?q=$anime';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Procesa los datos de respuesta aquí
      responseBody = response.body;
    } else {
      // Maneja errores de solicitud aquí
      print('Error: ${response.statusCode}');
    }

    return responseBody;
  }

  Future<String> fetchMangaData(String manga) async {
    String responseBody = '';

    var url = 'https://api.jikan.moe/v4/manga?q=$manga';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Procesa los datos de respuesta aquí
      responseBody = response.body;
    } else {
      // Maneja errores de solicitud aquí
      print('Error: ${response.statusCode}');
    }

    return responseBody;
  }

  List<FbAnimes> getAnimeList(String responseBody) {
    List<FbAnimes> animeList = [];

    // Analiza el cuerpo de la respuesta JSON
    var jsonData = jsonDecode(responseBody);

    // Accede a los datos que necesitas
    var results = jsonData['data'];

    for (var anime in results) {
      int id = anime['mal_id'];
      String titulo = anime['title'];
      String descripcion =
          anime['synopsis'] ?? ''; // Descripción del anime, si está disponible
      String urlImagen =
          anime['images'] != null && anime['images']['jpg'] != null
              ? anime['images']['jpg']['image_url']
              : 'URL_POR_DEFECTO'; // URL de la imagen del anime
      String estatus = anime['status']; // Estatus del anime
      int? capitulos = anime['episodes']; // Cantidad de capítulos del anime
      String fechaPublicacion = anime['aired']['from'] ??
          ''; // Fecha de publicación del anime, si está disponible
      String tipo = anime['type']; // Tipo de anime
      List<String> generos = (anime['genres'] as List)
          .map((genre) => genre['name'].toString())
          .toList(); // Lista de géneros del anime
      double puntuacion = anime['score'] ?? 0.0; // Puntuación del anime
      String estudio = anime['studios'] != null && anime['studios'].isNotEmpty
          ? anime['studios'][0]['name']
          : ''; // Estudio del anime

      // Crear objeto FbAnimes y agregarlo a la lista
      animeList.add(FbAnimes(
        id: id,
        titulo: titulo,
        descripcion: descripcion,
        urlImagen: urlImagen,
        estatus: estatus,
        capitulos: capitulos,
        fechaPublicacion: fechaPublicacion,
        tipo: tipo,
        generos: generos,
        puntuacion: puntuacion,
        estudio: estudio,
      ));
    }

    return animeList;
  }

  List<FbMangas> getMangaList(String responseBody) {
    List<FbMangas> mangaList = [];

    // Analiza el cuerpo de la respuesta JSON
    var jsonData = jsonDecode(responseBody);

    // Accede a los datos que necesitas
    var results = jsonData['data'];

    for (var anime in results) {
      int id = anime['mal_id'];
      String titulo = anime['title'];
      String descripcion =
          anime['synopsis'] ?? ''; // Descripción del manga, si está disponible
      String urlImagen =
          anime['images'] != null && anime['images']['jpg'] != null
              ? anime['images']['jpg']['image_url']
              : 'URL_POR_DEFECTO'; // URL de la imagen del manga
      String estatus = anime['status']; // Estatus del manga
      int? capitulos = anime['chapters']; // Cantidad de capítulos del manga
      int? volumenes = anime['volumes']; // Cantidad de volumenes del manga
      String fechaPublicacion = anime['published']['from'] ??
          ''; // Fecha de publicación del manga, si está disponible
      String tipo = anime['type']; // Tipo de manga
      double puntuacion = anime['score'] ?? 0.0; // Puntuación del manga
      var authors = anime['authors'] as List;
      String autor = '';
      for (var author in authors) {
        autor = author['name'];
      }

      // Crear objeto FbAnimes y agregarlo a la lista
      mangaList.add(FbMangas(
        id: id,
        titulo: titulo,
        descripcion: descripcion,
        urlImagen: urlImagen,
        estatus: estatus,
        capitulos: capitulos,
        volumenes: volumenes,
        fechaPublicacion: fechaPublicacion,
        tipo: tipo,
        puntuacion: puntuacion,
        autor: autor,
      ));
    }

    return mangaList;
  }
}
