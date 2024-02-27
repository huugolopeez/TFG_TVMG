import 'package:flutter/material.dart';

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
        backgroundColor: const Color.fromRGBO(38, 41, 43, 1.0),
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
                              const Color.fromRGBO(38, 41, 43, 1.0)),
                          side: MaterialStateProperty.all(const BorderSide(
                              color: Color.fromRGBO(95, 122, 219, 1.0))),
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
                          const Color.fromRGBO(95, 122, 219, 1.0)),
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
