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

  List<String> processAnimeData(String responseBody) {
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
}
