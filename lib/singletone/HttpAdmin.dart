import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpAdmin {

  Future<void> fetchAnimeData(String anime) async {
    var url = 'https://api.jikan.moe/v4/anime?q=$anime';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Procesa los datos de respuesta aquí
      print(response.body);
    } else {
      // Maneja errores de solicitud aquí
      print('Error: ${response.statusCode}');
    }
  }

  void processAnimeData(String responseBody) {
    // Analiza el cuerpo de la respuesta JSON
    var jsonData = jsonDecode(responseBody);

    // Accede a los datos que necesitas
    var results = jsonData['data'];

    // Por ejemplo, puedes imprimir el título de cada anime en los resultados
    for (var result in results) {
      print(result['title']);
    }
  }
}