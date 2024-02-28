import 'package:flutter/material.dart';
import 'package:tfg_tvmg/main/HomeView.dart';
import 'package:tfg_tvmg/main/PostView.dart';
import 'package:tfg_tvmg/onBoarding/LoginView.dart';
import 'package:tfg_tvmg/onBoarding/PerfilView.dart';
import 'package:tfg_tvmg/onBoarding/RegisterView.dart';
import 'package:tfg_tvmg/splash/SplashView.dart';

import 'onBoarding/ExistAccount.dart';

class TVMG extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TVMG',
        debugShowCheckedModeBanner: false,
        initialRoute: '/accountview',
        routes: {
          '/accountview': (context) => ExistAccount(),
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (context) => PerfilView(),
          '/homeview': (context) => HomeView()
        });
  }
}
