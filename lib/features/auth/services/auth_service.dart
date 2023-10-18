import 'dart:convert';

import 'package:amazon/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/utils/res_msg_handler.dart';
import '../../../common/widgets/utils/snack_bar.dart';
import '../../../constants/global_variable.dart';
class AuthService{
  // sign up
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required VoidCallback setStateCallback
  })async{
  try{
    UserModel userModel = UserModel(id: '', name: name, email: email,
        password: password, address: '', type: '', token: '');
    http.Response res= await http.post(Uri.parse('$uri/api/auth/signUp'),
        body: userModel.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    httpResMsgHandler(
        res: res,
        context: context,
        onSuccess: () {
          setStateCallback();
          showSnackBar(
              context, 'Account created! Login with the same credentials');
        });
  } catch (e) {    showSnackBar(context, e.toString());  }

  }
  //
  // void signInUser({
  //   required BuildContext context,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     // BuildContext localContext = context;
  //
  //     // print('$context 12');
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/api/auth/signIn'),
  //       body: jsonEncode({'email': email, 'password': password}),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //
  //     httpResMsgHandler(
  //         res: res,
  //         context: context,
  //         onSuccess: () async {
  //           // Navigator.pushNamedAndRemoveUntil(
  //           //     context, BottomBar.routeName, (route) => false);
  //           // login successfully, then store the response data
  //           //it stores data into hardware
  //           SharedPreferences prefs = await SharedPreferences.getInstance();
  //           //store data in memory
  //           Provider.of<UserProvider>(context, listen: false).setUser(res.body);
  //           await prefs.setString(authToken, jsonDecode(res.body)['token']);
  //           // print('$context 123');
  //         });
  //   } catch (e) {
  //     // showSnackBar(context, e.toString());
  //   }
  // }

  // void getUserData(
  //     BuildContext context,
  //     ) async {
  //   try {
  //     //try to get the token first
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String? token = preferences.getString(authToken);
  //     // print(
  //     //   '$token 22222',
  //     // );
  //     if (token == null || token.isEmpty) {
  //       preferences.setString(authToken, '');
  //       return;
  //     }
  //
  //     var tokenCheckRes = await http.post(Uri.parse('$uri/api/auth/tokenCheck'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           authToken: token
  //         });
  //     var isTokenValid = jsonDecode(tokenCheckRes.body);
  //     // print(isTokenValid);
  //
  //     if (isTokenValid == true) {
  //       //getUserData
  //       http.Response userRes = await http.get(
  //           Uri.parse('$uri/api/auth/getUserData'),
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //             authToken: token
  //           });
  //       // print(
  //       //   '${userRes.body} 1111122222',
  //       // );
  //       var userProvider = Provider.of<UserProvider>(context, listen: false);
  //       userProvider.setUser(userRes.body);
  //     }
  //   } catch (e) {
  //     // showSnackBar(context, e.toString());
  //   }
  // }
}