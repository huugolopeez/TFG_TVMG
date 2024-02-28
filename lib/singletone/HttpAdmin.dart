import 'package:http/http.dart' as http;
import 'dart:convert';

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

  List<String> getTitleAnime(String responseBody) {
    List<String> titulos = [];

    // Analiza el cuerpo de la respuesta JSON
    var jsonData = jsonDecode(responseBody);

    // Accede a los datos que necesitas
    var results = jsonData['data'];

    // Por ejemplo, puedes imprimir el título de cada anime en los resultados
    for (var result in results) {
      titulos.add(result['title']);
    }

    return titulos;
  }

  List<String> getImagenAnime(String responseBody) {
    List<String> imagenes = [];

    // Analiza el cuerpo de la respuesta JSON
    var jsonData = jsonDecode(responseBody);

    // Accede a los datos que necesitas
    var results = jsonData['data'];

    // Por cada anime en los resultados, obtén la URL de la imagen
    for (var anime in results) {
      // Verifica si existen datos de imágenes en formato 'jpg'
      if (anime['images'] != null && anime['images']['jpg'] != null) {
        imagenes.add(anime['images']['jpg']['image_url']);
      } else {
        // Si no hay imágenes disponibles, añade una URL predeterminada o deja en blanco según lo necesites
        imagenes.add('URL_POR_DEFECTO');
      }
    }

    return imagenes;
  }
}
