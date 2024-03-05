import 'package:flutter/material.dart';
import 'package:tfg_tvmg/custom/TMDrawer.dart';
import 'package:tfg_tvmg/main/AnimesView.dart';
import 'package:tfg_tvmg/main/MangasView.dart';
import 'package:tfg_tvmg/main/MiPerfilView.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

import 'BuscadorView.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _numMenu = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    AnimesView(),
    MangasView(),
    BuscadorView(),
    MiPerfilView()
  ];

  void vistaMenu(int numMenu) {
    setState(() {
      _numMenu = numMenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DataHolder().colorFondo,
      appBar: AppBar(
          title: const Text('HOME'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent),
      body: Center(
          child: _widgetOptions[_numMenu]
      ),
      drawer: TMDrawer(onItemTap: vistaMenu),
    );
  }
}