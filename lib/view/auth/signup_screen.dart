import 'package:adil_fyp/Utality/utils.dart';
import 'package:adil_fyp/model/user_model.dart';
import 'package:adil_fyp/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/components/large_buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  List<String> items = ['Select An Item', 'Army', 'PAF', 'Navy', 'ASF', 'ANF'];
  String? selectedItem = 'Select An Item';
  bool checkval = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailcontroller.dispose();
    _emailFocusNode.dispose();
    _passwordcontroller.dispose();
    _passwordFocusNode.dispose();
    _confirmpasswordController.dispose();
    _confirmPasswordFocusNode.dispose();
    _usernamecontroller.dispose();
    _usernameFocusNode.dispose();
    _namecontroller.dispose();
    _nameFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _setobsecure = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Register',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _namecontroller,
                      focusNode: _nameFocusNode,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        Utils.focuschange(
                            context, _nameFocusNode, _usernameFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'FIeld Cnanot Be Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _usernamecontroller,
                      focusNode: _usernameFocusNode,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        Utils.focuschange(
                            context, _usernameFocusNode, _emailFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'FIeld Cnanot Be Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailcontroller,
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
                      onFieldSubmitted: (value) {
                        Utils.focuschange(
                            context, _emailFocusNode, _passwordFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'FIeld Cnanot Be Empty';
                        } else if (value.contains('@') == false) {
                          return 'Email Not Valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<AuthViewModel>(
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: _passwordcontroller,
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
                          onFieldSubmitted: (value) {
                            _scrollController.animateTo(5,
                                curve: Curves.ease,
                                duration: Duration(microseconds: 500));
                            Utils.focuschange(context, _passwordFocusNode,
                                _confirmPasswordFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Password';
                            } else if (value.length < 8) {
                              return 'Password Must Be 8 Characters';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<AuthViewModel>(
                      builder: (context, value, child) {
                        return TextFormField(
                          controller: _confirmpasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          obscureText: value.obsecureText,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
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
                              return 'Please Confirm Password';
                            } else if (value !=
                                _passwordcontroller.text.toString()) {
                              return 'Password Do not Match';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<AuthViewModel>(
                      builder: (context, value, child) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.green,
                          )),
                          child: Center(
                            child: DropdownButton(
                              hint: Text(
                                'Pick A Force',
                                style: TextStyle(color: Colors.green),
                              ),
                              value: selectedItem,
                              onChanged: (val) {
                                selectedItem = val;
                                value.setChosenValue(val);
                              },
                              items: items.map((valueitem) {
                                return DropdownMenuItem(
                                  value: valueitem,
                                  child: Text(valueitem),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              LargeButtonCustom(
                callback: () async {
                  final user = UserModel(
                      id: _usernamecontroller.text.toString(),
                      email: _emailcontroller.text.toString(),
                      forceType: selectedItem.toString(),
                      progress: 0,
                      name: _namecontroller.text.toString());
                  if (selectedItem == 'Select An Item') {
                    Utils.toastMessage('Please Pick A Force');
                  } else if (_formkey.currentState!.validate()) {
                    SharedPreferences sp =
                        await SharedPreferences.getInstance();
                    sp.clear();
                    sp.setString('email', _emailcontroller.text.toString());
                    _setobsecure.signupUser(
                      user,
                      _emailcontroller.text.toString(),
                      _passwordcontroller.text.toString(),
                      context,
                    );
                  }

                  // Navigator.pushReplacementNamed(
                  //     context, RouteNames.subjectscreen);
                },
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
