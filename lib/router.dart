import 'package:amazon/features/auth/screen/auth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_)=>const AuthScreen());
    default:
      return MaterialPageRoute(settings:routeSettings,
  builder: (_)=>const Scaffold(
    body: Center(
      child: Text("Screen does not exist!"),
    ),
  ));
      
  }
}