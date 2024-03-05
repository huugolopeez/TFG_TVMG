import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tfg_tvmg/custom/TMGrid.dart';
import 'package:tfg_tvmg/firestoreObjects/FbAnimes.dart';
import 'package:tfg_tvmg/firestoreObjects/FbMangas.dart';
import 'package:tfg_tvmg/main/PostView.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class BuscadorView extends StatefulWidget {
  @override
  _BuscadorViewState createState() => _BuscadorViewState();
}

class _BuscadorViewState extends State<BuscadorView> {
  TextEditingController tecAnime = TextEditingController();
  List<FbAnimes> _busquedaAnimes = [];
  List<FbMangas> _busquedaMangas = [];
  bool _isLoading = false;
  bool _isAnime = true;

  @override
  void initState() {
    super.initState();
    _searchAnime(tecAnime.text);
  }

  void animeOrManga(int index) {
    setState(() {
      if (index == 0) {
        _isAnime = true;
      } else if (index == 1) {
        _isAnime = false;
      }
    });
  }

  void onItemTap(int index) {
    if (_isAnime) {
      DataHolder().selectedAnime = _busquedaAnimes[index];
    } else {
      DataHolder().selectedManga = _busquedaMangas[index];
    }
    // DataHolder().saveSelectedPostInCache();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PostView(_isAnime)));
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
                          border: const OutlineInputBorder(),
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
                              crossAxisCount: kIsWeb ? 4 : 2,
                              mainAxisExtent: 400,
                            ),
                            itemCount: _busquedaAnimes.length,
                            itemBuilder: (context, index) {
                              return TMGrid(
                                  sTitle: _busquedaAnimes[index].titulo,
                                  sBody: _busquedaAnimes[index].urlImagen,
                                  dFontSize: 15,
                                  iPosition: index,
                                  onItemTap: onItemTap);
                            }),
                      )
                    : Expanded(
                        child: GridView.builder(
                            padding: const EdgeInsets.all(20),
                            gridDelegate:
                                 const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: kIsWeb ? 4 : 2,
                              mainAxisExtent: 400,
                            ),
                            itemCount: _busquedaMangas.length,
                            itemBuilder: (context, index) {
                              return TMGrid(
                                  sTitle: _busquedaMangas[index].titulo,
                                  sBody: _busquedaMangas[index].urlImagen,
                                  dFontSize: 15,
                                  iPosition: index,
                                  onItemTap: onItemTap);
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

      List<FbAnimes> animes = DataHolder().httpAdmin.getAnimeList(responseA);
      List<FbMangas> mangas = DataHolder().httpAdmin.getMangaList(responseM);

      setState(() {
        _busquedaAnimes = animes;
        _busquedaMangas = mangas;
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
