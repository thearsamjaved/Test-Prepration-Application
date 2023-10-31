import 'dart:async';
import 'dart:io';

import 'package:adil_fyp/Utality/routes/route_name.dart';
import 'package:adil_fyp/resources/components/large_buttons.dart';

import 'package:adil_fyp/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _setobsecure = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Login Screen',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'FIeld Cnanot Be Empty';
                        } else if (value.contains('@') == false) {
                          return 'Email Not Valid';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<AuthViewModel>(
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          obscureText: value.obsecureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                              onTap: () {
                                value.setObsecure(!value.obsecureText);
                              },
                              child: Icon(value.obsecureText
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined),
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            } else if (value.length < 8) {
                              return 'Password Must Be 8 Characters';
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              LargeButtonCustom(
                callback: () async {
                  if (_formkey.currentState!.validate()) {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.clear();
                    sp.setString('email', _emailController.text.toString());
                    _setobsecure.signinUser(_emailController.text,
                        _passwordController.text, context);
                  }

                  // Navigator.pushReplacementNamed(
                  //     context, RouteNames.subjectscreen);
                },
                text: 'Login',
              ),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   padding: EdgeInsets.all(18),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.deepPurple),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Center(
              //     child: Text(
              //       'Register Now',
              //       style: TextStyle(
              //         fontSize: 20,
              //         color: Colors.deepPurple,
              //       ),
              //     ),
              //   ),
              // )
              CustomANimatedButton(
                onpress: () {
                  Timer(Duration(milliseconds: 300), () {
                    Navigator.pushNamed(context, RouteNames.signup);
                  });
                },
                height: 60.0,
                text: 'Sign Up',
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ),
      ),
    );
  }
}
