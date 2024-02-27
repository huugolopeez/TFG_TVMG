import 'package:flutter/material.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class ExistAccount extends StatelessWidget {

  late BuildContext _context;

  void onClickLogin() {
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  void onClickRegister() {
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 150, height: 50),
                    child: ElevatedButton(
                      onPressed: onClickLogin,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              DataHolder().colorFondo),
                          side: MaterialStateProperty.all(BorderSide(
                              color: DataHolder().colorPrincipal)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                      child: const Text('LOGIN'),
                    ))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(width: 150, height: 50),
                child: ElevatedButton(
                  onPressed: onClickRegister,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          DataHolder().colorPrincipal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: const Text('REGISTER'),
                ),
              ),
            ),
          ],
        ));
  }
}
