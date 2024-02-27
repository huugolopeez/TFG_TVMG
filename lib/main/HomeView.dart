import 'package:flutter/material.dart';
import 'package:tfg_tvmg/custom/TMDrawer.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int numMenu = 0;

  Widget? vistaMenu(int numMenu) {
    if (numMenu == 0) {
    } else if (numMenu == 1) {
    } else if (numMenu == 2) {
    } else if (numMenu == 3) {}
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
      body: Center(child: vistaMenu(numMenu)),
      drawer: TMDrawer(onItemTap: vistaMenu),
    );
  }
}
