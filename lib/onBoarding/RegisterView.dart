import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  late BuildContext _context;
  TextEditingController tecUser = TextEditingController();
  TextEditingController tecPass = TextEditingController();
  TextEditingController tecRePass = TextEditingController();

  throwSnackBar(String error) {
    SnackBar snackBar = SnackBar(content: Text(error));
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }

  Future<void> onClickAceptar() async {
    if (tecPass.text == tecRePass.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: tecUser.text, password: tecPass.text);
        Navigator.of(_context).popAndPushNamed('/perfilview');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print(' --> La contraseña es muy debil.');
          throwSnackBar('-- La contraseña es muy debil --');
        } else if (e.code == 'email-already-in-use') {
          print(' --> El correo electronico ya esta en uso.');
          throwSnackBar('-- El correo electronico ya esta en uso --');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print(' --> Las contraseñas no coinciden.');
      throwSnackBar('-- Las contraseñas no coinciden --');
    }
  }

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed('/accountview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
        backgroundColor: const Color.fromRGBO(38, 41, 43, 1.0),
        appBar: AppBar(
            title: const Text('REGISTER'),
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: TextFormField(
                    controller: tecRePass,
                    obscureText: true,
                    decoration: const InputDecoration(
                        icon: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.password)),
                        hoverColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'CONFIRM PASSWORD')),
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
                                const Color.fromRGBO(38, 41, 43, 1.0)),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Color.fromRGBO(95, 122, 219, 1.0))),
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
                            const Color.fromRGBO(95, 122, 219, 1.0)),
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
