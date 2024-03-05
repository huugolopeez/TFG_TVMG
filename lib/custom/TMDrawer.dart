import 'package:flutter/material.dart';
import 'package:tfg_tvmg/firestoreObjects/FbUsuario.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class TMDrawer extends StatefulWidget {
  final Function(int indice)? onItemTap;

  const TMDrawer({super.key, required this.onItemTap});

  @override
  State<TMDrawer> createState() => _TMDrawerState();
}

class _TMDrawerState extends State<TMDrawer> {
  late FbUsuario usuario;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usuario = DataHolder().selectedUser;
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: DataHolder().colorFondo,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 60, 10, 5),
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image(image: NetworkImage(usuario.urlPerfil), height: 40)),
                    Text(usuario.username.toString(),
                        style: const TextStyle(color: Colors.white))
                  ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                            '${usuario.seguidores} seguidores',
                            style: const TextStyle(color: Colors.white))),
                    Text('${usuario.seguidos} seguidos',
                        style: const TextStyle(color: Colors.white))
                  ]))
            ],
          )),
          ListTile(
            leading: const Icon(Icons.tv, color: Colors.white),
            selectedColor: DataHolder().colorPrincipal,
            onTap: () {
              widget.onItemTap!(0);
            },
            title: const Text(
              'Mis Animes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Colors.white),
            selectedColor: DataHolder().colorPrincipal,
            onTap: () {
              widget.onItemTap!(1);
            },
            title: const Text(
              'Mis Mangas',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search, color: Colors.white),
            selectedColor: DataHolder().colorPrincipal,
            onTap: () {
              widget.onItemTap!(2);
            },
            title: const Text(
              'Buscador',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.white),
            selectedColor: DataHolder().colorPrincipal,
            onTap: () {
              widget.onItemTap!(3);
            },
            title: const Text(
              'Mi perfil',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
