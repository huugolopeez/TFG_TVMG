import 'package:flutter/material.dart';

class PerfilView extends StatelessWidget {
  late BuildContext _context;
  TextEditingController tecUser = TextEditingController();

  void onClickAceptar() {
    Navigator.of(_context).popAndPushNamed('/homeview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(38, 41, 43, 1.0),
        appBar: AppBar(
            title: const Text('PERFIL'),
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(95, 122, 219, 1.0)),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: TextFormField(
                  controller: tecUser,
                  decoration: const InputDecoration(
                      icon: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.account_circle)),
                      hoverColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'NOMBRE DE USUARIO')),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 150, height: 50),
                  child: ElevatedButton(
                    onPressed: onClickAceptar,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(38, 41, 43, 1.0)),
                        side: MaterialStateProperty.all(const BorderSide(
                            color: Color.fromRGBO(95, 122, 219, 1.0))),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    child: const Text('ACEPTAR'),
                  ))),
        ]));
  }
}
