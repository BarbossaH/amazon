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

}