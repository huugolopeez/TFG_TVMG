import 'package:flutter/material.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class TMDrawer extends StatelessWidget {
  final Function(int indice)? onItemTap;

  const TMDrawer({super.key, required this.onItemTap});

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
                  padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
                  child: Row(children: [
                    const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.account_circle, color: Colors.white)),
                    Text(DataHolder().selectedUser.username.toString(),
                        style: const TextStyle(color: Colors.white))
                  ])),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                            '${DataHolder().selectedUser.seguidores} seguidores',
                            style: const TextStyle(color: Colors.white))),
                    Text('${DataHolder().selectedUser.seguidos} seguidos',
                        style: const TextStyle(color: Colors.white))
                  ]))
            ],
          )),
          ListTile(
            leading: const Icon(Icons.tv, color: Colors.white),
            selectedColor: DataHolder().colorPrincipal,
            onTap: () {
              onItemTap!(0);
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
              onItemTap!(1);
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
              onItemTap!(2);
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
              onItemTap!(3);
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
