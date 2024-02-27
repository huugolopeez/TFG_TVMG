import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tfg_tvmg/singletone/DataHolder.dart';

class LoginView extends StatelessWidget {
  late BuildContext _context;
  TextEditingController tecUser = TextEditingController();
  TextEditingController tecPass = TextEditingController();

  throwSnackBar(String error) {
    SnackBar snackBar = SnackBar(content: Text(error));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  Future<void> onClickAceptar() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUser.text,
          password: tecPass.text
      );
      Navigator.of(_context).popAndPushNamed('/splashview');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        print(' --> Formato del email incorrecto.');
        throwSnackBar('-- Formato del email incorrecto --');
      } else if (e.code == 'invalid-login-credentials') {
        print(' --> Credenciales incorrectas.');
        throwSnackBar('-- Credenciales incorrectas --');
      }
    }
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed('/accountview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        appBar: AppBar(
            title: const Text('LOGIN'),
            centerTitle: true,
            backgroundColor: DataHolder().colorPrincipal),
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
                      hintText: 'USUARIO')),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: TextFormField(
                    controller: tecPass,
                    obscureText: true,
                    decoration: const InputDecoration(
                        icon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.password)),
                        hoverColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'PASSWORD')),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(width: 150, height: 50),
                      child: ElevatedButton(
                        onPressed: onClickAceptar,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                DataHolder().colorFondo),
                            side: MaterialStateProperty.all(BorderSide(
                                color: DataHolder().colorPrincipal)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        child: const Text('ACEPTAR'),
                      ))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 150, height: 50),
                  child: ElevatedButton(
                    onPressed: onClickCancelar,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            DataHolder().colorPrincipal),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    child: const Text('CANCELAR'),
                  ),
                ),
              ),
            ],
          )
        ]));
  }
}
