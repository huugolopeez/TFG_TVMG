import 'package:flutter/material.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class BuscadorView extends StatefulWidget {
  @override
  _BuscadorViewState createState() => _BuscadorViewState();
}

class _BuscadorViewState extends State<BuscadorView> {
  TextEditingController tecAnime = TextEditingController();
  List<String> _searchResults = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DataHolder().colorFondo,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tecAnime,
              decoration: InputDecoration(
                hintText: 'Ingrese el nombre del anime',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchAnime(tecAnime.text);
                  },
                ),
              ),
            ),
          ),
          _isLoading
              ? CircularProgressIndicator()
              : Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResults[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchAnime(String query) async {
    setState(() {
      _isLoading = true;
    });

    // Aquí debes reemplazar la URL por la de tu API de búsqueda de anime
    String apiUrl = 'https://api.example.com/search?query=$query';

    try {
      String response = await DataHolder().httpAdmin.fetchAnimeData(tecAnime.text);
      List<String> searchResults = DataHolder().httpAdmin.processAnimeData(response);
      setState(() {
        _searchResults = searchResults;
      });
    } catch (e) {
      print('Error: $e');
      // Manejar el error aquí, como mostrar un mensaje al usuario
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}