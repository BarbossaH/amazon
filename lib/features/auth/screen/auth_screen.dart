import 'package:amazon/common/widgets/customButton.dart';
import 'package:amazon/common/widgets/custom_textfiled.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import '../services/auth_service.dart';

enum Auth {signIn, signUp}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }
  void signUpUser(VoidCallback setStateCallback) {

    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        setStateCallback: setStateCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Welcome',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                RadioListTile(
                  activeColor: GlobalVariable.primaryColor,
                  tileColor: _auth == Auth.signUp
                      ? GlobalVariable.backgroundColor
                      : GlobalVariable.greyBackgroundCOlor,
                  title: const Text("Create Account",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  value: Auth.signUp.toString(),
                  groupValue: _auth.toString(),
                  onChanged: (String ? value ){
                    setState(() {
                      _auth = Auth.values.firstWhere((element) => element.toString()==value);
                    });
                  },
                ),
                if(_auth==Auth.signUp)
                  Container(
                    padding:const EdgeInsets.all( 9),
                    color: GlobalVariable.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            CustomTextField(controller: _nameController,hintText: 'Name',),
                           const SizedBox(height: 9,),
                            CustomTextField(controller: _emailController,hintText: 'Email',),
                            const SizedBox(height: 9,),
                            CustomTextField(controller: _passwordController,hintText: 'Password',),
                            const SizedBox(height: 9,),
                            CustomButtom( voidCallback:  () {
                              log('data: 123');
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser(() {
                                  setState(() {
                                    _auth = Auth.signIn;
                                  });
                                });
                              }
                            },text: "Sign Up",)
                          ],
                        )),
                  ),
                RadioListTile<Auth>(
                  activeColor: GlobalVariable.primaryColor,
                  title: const Text(
                    'Sign In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: _auth == Auth.signIn
                      ? GlobalVariable.backgroundColor
                      : GlobalVariable.greyBackgroundCOlor,
                  value: Auth.signIn,
                  groupValue: _auth,
                  onChanged: (Auth? value) {
                    setState(() {
                      _auth = value!;
                    });
                  },
                ),
                if(_auth==Auth.signIn)
                  Container(
                    padding:const EdgeInsets.all( 9),
                    color: GlobalVariable.backgroundColor,
                    child: Form(
                        key: _signUpFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            CustomTextField(controller: _emailController,hintText: 'Email',),
                            const SizedBox(height: 9,),
                            CustomTextField(controller: _passwordController,hintText: 'Password',),
                            const SizedBox(height: 9,),
                            CustomButtom(text: "Sign In", voidCallback: (){
                              if(_signInFormKey.currentState!.validate()){

                              }
                            })
                          ],
                        )),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
