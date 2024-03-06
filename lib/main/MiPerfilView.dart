import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg_tvmg/firestoreObjects/FbUsuario.dart';

import '../singletone/DataHolder.dart';

class MiPerfilView extends StatefulWidget {
  @override
  State<MiPerfilView> createState() => _MiPerfilViewState();
}

class _MiPerfilViewState extends State<MiPerfilView> {
  TextEditingController tecUser = TextEditingController();
  bool isEdit = false;

  final ImagePicker _picker = ImagePicker();
  File _imagenPreview = File('');
  bool isPhoto = false;

  void onHLButtonsBoarding(int index) async {
    if (index == 0) {
      String imgUrl = '';
      if (isPhoto) {
        final storageRef = FirebaseStorage.instance.ref();
        String rutaEnNube =
            'imgPerfil/${FirebaseAuth.instance.currentUser!.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final rutaAFicheroEnNube = storageRef.child(rutaEnNube);
        final metadata = SettableMetadata(contentType: 'image/jpeg');

        try {
          await rutaAFicheroEnNube.putFile(_imagenPreview, metadata);
        } on FirebaseException catch (e) {
          print('Error al subir la imagen');
        }

        imgUrl = await rutaAFicheroEnNube.getDownloadURL();
      }

      String userName = tecUser.text.trim().isNotEmpty
          ? tecUser.text
          : DataHolder().selectedUser.username;
      int seguidores = DataHolder().selectedUser.seguidores;
      int seguidos = DataHolder().selectedUser.seguidos;
      String url = imgUrl.trim().isNotEmpty
          ? imgUrl
          : DataHolder().selectedUser.urlPerfil;

      DataHolder().firebaseAdmin.updateUser(FbUsuario(
          username: userName,
          seguidores: seguidores,
          seguidos: seguidos,
          urlPerfil: url));
      DataHolder().selectedUser = FbUsuario(
          username: userName,
          seguidores: seguidores,
          seguidos: seguidos,
          urlPerfil: url);

      setState(() {
        isEdit = false;
      });
    } else if (index == 1) {
      Navigator.of(context).popAndPushNamed('/homeview');
    }
  }

  void onCameraButton() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imagenPreview = File(image.path);
      });
    }
    isPhoto = true;
  }

  void onGalleryButton() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagenPreview = File(image.path);
      });
    }
    isPhoto = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DataHolder().colorFondo,
        body: isEdit
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
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
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              onCameraButton();
                            },
                            child: Icon(Icons.camera_alt_rounded,
                                color: DataHolder().colorPrincipal)),
                        TextButton(
                            onPressed: () {
                              onGalleryButton();
                            },
                            child: Icon(Icons.image,
                                color: DataHolder().colorPrincipal)),
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                width: 150, height: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                onHLButtonsBoarding(0);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      DataHolder().colorFondo),
                                  side: MaterialStateProperty.all(BorderSide(
                                      color: DataHolder().colorPrincipal)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              child: const Text('ACEPTAR'),
                            ))),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            width: 150, height: 50),
                        child: ElevatedButton(
                          onPressed: () {
                            onHLButtonsBoarding(1);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  DataHolder().colorPrincipal),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: const Text('CANCELAR'),
                        ),
                      ),
                    ),
                  ],
                )
              ])
            : Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 60, 10, 5),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image(
                                image: NetworkImage(
                                    DataHolder().selectedUser.urlPerfil),
                                height: 200)),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 30),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                                width: 150, height: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isEdit = true;
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      DataHolder().colorPrincipal),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)))),
                              child: const Text('EDITAR PERFIL'),
                            ),
                          ),
                        ),
                      ])),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Text('Username: ${DataHolder().selectedUser.username.toString()}',
                          style: const TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ],
              ));
  }
}
