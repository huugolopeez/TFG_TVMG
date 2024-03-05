import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../singletone/DataHolder.dart';

class PhoneLoginView extends StatefulWidget {

  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {

  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();
  String sVerifyCode = '';
  bool blGetVerify = false;

  void sendPhonePressed() async {
    String sPhone = tecPhone.text;

    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: sPhone,
        verificationCompleted: verifyCompleted,
        verificationFailed: verifyFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeTimeout
    );
  }

  void verifyCompleted(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).popAndPushNamed('/homeview');
  }

  void verifyFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void codeSent(String code, int? resendToken) {
    sVerifyCode = code;

    setState(() {
      blGetVerify = true;
    });
  }

  void codeTimeout(String timeout) {

  }

  void enviarVerifyPressed() async {
    String smsCode = tecVerify.text;

    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: sVerifyCode, smsCode: smsCode);

    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).popAndPushNamed("/splashview");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        appBar: AppBar(
            title: const Text('Login por telefono'),
            centerTitle: true,
            backgroundColor: DataHolder().colorPrincipal
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: TextFormField(
                        controller: tecPhone,
                        decoration: const InputDecoration(
                            icon: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.drive_file_rename_outline_sharp)),
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(),
                            hintText: 'Numero de telefono')),
                  )),
              ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(width: 150, height: 50),
                  child: ElevatedButton(
                      onPressed: sendPhonePressed,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(DataHolder().colorFondo),
                          side: MaterialStateProperty.all(BorderSide(color: DataHolder().colorPrincipal)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ))),
                      child: const Text(
                          'Enviar',
                          style: TextStyle(
                              color: Colors.white
                          ))
                  )),
              if(blGetVerify)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: TextFormField(
                          controller: tecVerify,
                          obscureText: true,
                          decoration: const InputDecoration(
                              icon: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Icon(Icons.drive_file_rename_outline_sharp)),
                              hoverColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: 'Numero de verificacion')),
                    )),
              if(blGetVerify)
                ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 150, height: 50),
                    child: ElevatedButton(
                        onPressed: enviarVerifyPressed,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(DataHolder().colorFondo),
                            side: MaterialStateProperty.all(BorderSide(color: DataHolder().colorPrincipal)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                ))),
                        child: const Text(
                            'Enviar',
                            style: TextStyle(
                                color: Colors.white
                            ))
                    )),
            ]
        )
    );
  }
}