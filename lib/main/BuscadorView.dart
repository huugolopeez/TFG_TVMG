import 'package:flutter/material.dart';
import 'package:tfg_tvmg/custom/TMGrid.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class BuscadorView extends StatefulWidget {
  @override
  _BuscadorViewState createState() => _BuscadorViewState();
}

class _BuscadorViewState extends State<BuscadorView> {
  TextEditingController tecAnime = TextEditingController();
  List<String> _busquedaTitulosA = [];
  List<String> _busquedaImagenesA = [];
  List<String> _busquedaTitulosM = [];
  List<String> _busquedaImagenesM = [];
  bool _isLoading = false;
  bool _isAnime = true;

  void animeOrManga(int index) {
    setState(() {
      if (index == 0) {
        _isAnime = true;
      } else if (index == 1) {
        _isAnime = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchAnime(tecAnime.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        body: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: TextFormField(
                      controller: tecAnime,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              _searchAnime(tecAnime.text);
                            },
                          ),
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Ingrese el nombre del anime')),
                )),
            _isLoading
                ? const CircularProgressIndicator()
                : _isAnime
                    ? Expanded(
                        child: GridView.builder(
                            padding: const EdgeInsets.all(20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisExtent: 400,
                            ),
                            itemCount: _busquedaTitulosA.length,
                            itemBuilder: (context, index) {
                              return TMGrid(
                                  sTitle: _busquedaTitulosA[index],
                                  sBody: _busquedaImagenesA[index],
                                  dFontSize: 15,
                                  iPosition: index,
                                  onItemTap: null);
                            }),
                      )
                    : Expanded(
                        child: GridView.builder(
                            padding: const EdgeInsets.all(20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisExtent: 400,
                            ),
                            itemCount: _busquedaTitulosM.length,
                            itemBuilder: (context, index) {
                              return TMGrid(
                                  sTitle: _busquedaTitulosM[index],
                                  sBody: _busquedaImagenesM[index],
                                  dFontSize: 15,
                                  iPosition: index,
                                  onItemTap: null);
                            }),
                      ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
                onPressed: () => animeOrManga(0),
                child: Icon(Icons.tv, color: DataHolder().colorPrincipal)),
            TextButton(
                onPressed: () => animeOrManga(1),
                child: Icon(Icons.book, color: DataHolder().colorPrincipal))
          ]),
        ));
  }

  Future<void> _searchAnime(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String responseA =
          await DataHolder().httpAdmin.fetchAnimeData(tecAnime.text);
      String responseM =
          await DataHolder().httpAdmin.fetchMangaData(tecAnime.text);

      List<String> titulosA = DataHolder().httpAdmin.getTitleAnime(responseA);
      List<String> imagenesA = DataHolder().httpAdmin.getImagenAnime(responseA);
      List<String> titulosM = DataHolder().httpAdmin.getTitleAnime(responseM);
      List<String> imagenesM = DataHolder().httpAdmin.getImagenAnime(responseM);
      setState(() {
        _busquedaTitulosA = titulosA;
        _busquedaImagenesA = imagenesA;
        _busquedaTitulosM = titulosM;
        _busquedaImagenesM = imagenesM;
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
