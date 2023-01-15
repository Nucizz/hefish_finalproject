import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hefish_finalproject/class/user.dart';
import 'package:hefish_finalproject/page/homePage.dart';
import 'package:hefish_finalproject/page/registerPage.dart';
import 'package:hefish_finalproject/class/color_palette.dart';
import 'package:hefish_finalproject/design/customTextField.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import '../class/google_auth.dart';
import '../class/host.dart';
import '../design/animatedPageRoute.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController unameCtrl = TextEditingController();
  TextEditingController pwordCtrl = TextEditingController();

  Future<User> loginUser(String username, String password) async {
    String url = "${Host.main}/users/login";
    var resp = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username': username, 'password': password}));
    var res = jsonDecode(resp.body);
    if (res.length > 0) {
      return User.fromJson(res[0]);
    } else if (res.length == 0) {
      return User(id: -404, email: "???", username: "???", token: "???");
    } else {
      return User(id: -500, email: "???", username: "???", token: "???");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.background,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/images/HEfish logo.png",
                    height: 150, fit: BoxFit.fitHeight),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Palette.accent,
                      fontSize: 40),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign in to continue.",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Palette.black,
                      fontSize: 20),
                ),
              ),
              Column(
                children: [
                  CustomTextField(
                    controller: unameCtrl,
                    top: 25,
                    hintText: "Username",
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: Icons.person,
                  ),
                  CustomTextField(
                    controller: pwordCtrl,
                    top: 25,
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: Icons.visibility,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                        width: double.infinity,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Material(
                                textStyle: const TextStyle(
                                    color: Palette.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    backgroundColor:
                                        Color.fromARGB(255, 232, 239, 239)),
                                child: InkWell(
                                  child: const Text("Password Recovery"),
                                  onTap: () {
                                    const pwRecMsg = SnackBar(
                                      content: Text("Not Avaiable Yet"),
                                      backgroundColor: Palette.error,
                                      duration: Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(pwRecMsg);
                                  },
                                )))),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Palette.accent,
                                      blurRadius: 3,
                                      spreadRadius: 0,
                                      offset: Offset(
                                        0.0,
                                        0.0,
                                      ),
                                    ),
                                  ]),
                              child: TextButton(
                                  onPressed: () async {
                                    String errorMsg = "Login Success";
                                    Color snackBG;
                                    if (unameCtrl.text.isEmpty ||
                                        pwordCtrl.text.isEmpty) {
                                      errorMsg =
                                          "Please fill in your credentials!";
                                      snackBG = Palette.error;
                                    } else {
                                      User validation = await loginUser(
                                          unameCtrl.text, pwordCtrl.text);
                                      if (validation.id >= 0) {
                                        Navigator.of(context).push(
                                            AnimatedPageRoute(
                                                child: HomePage(
                                                    user: validation)));
                                        snackBG = Palette.success;
                                      } else if (validation.id == -404) {
                                        errorMsg =
                                            "Wrong username or password!";
                                        snackBG = Palette.error;
                                      } else {
                                        errorMsg = "Something went wrong!";
                                        snackBG = Palette.error;
                                      }
                                    }
                                    final message = SnackBar(
                                      content: Text(errorMsg),
                                      backgroundColor: snackBG,
                                      duration: const Duration(seconds: 3),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(message);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Palette.accent),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Palette.white),
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle>(
                                            const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                  ),
                                  child: const Text("Login"))))),
                  Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        children: const [
                          Expanded(
                              child: Divider(
                            color: Palette.grey,
                            thickness: 1,
                          )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Or continue with",
                                style: TextStyle(
                                    color: Palette.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            color: Palette.grey,
                            thickness: 1,
                          )),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: SizedBox(
                          width: 45,
                          height: 45,
                          child: FloatingActionButton(
                              elevation: 2,
                              backgroundColor: Palette.white,
                              onPressed: () async {
                                final googleUser =
                                    await GoogleAuth.googleLogin();
                                String errorMsg = "Login Success";
                                Color snackBG = Palette.success;
                                if (googleUser != null) {
                                  //Check registered google user
                                  bool registered = false;
                                  if (await GoogleAuth.googleRegisterCheck(
                                      googleUser.email)) {
                                    registered = true;
                                  } else if (await GoogleAuth.googleRegister(
                                      googleUser.email,
                                      googleUser.email.split('@')[0])) {
                                    registered = true;
                                  }

                                  if (registered) {
                                    User authenticated =
                                        await GoogleAuth.googleGetUser(
                                            googleUser.email);
                                    if (authenticated.id >= 0) {
                                      Navigator.of(context).push(
                                          AnimatedPageRoute(
                                              child: HomePage(
                                                  user: authenticated)));
                                    } else {
                                      await GoogleAuth.googleLogout();
                                      errorMsg = "Something went wrong!";
                                      snackBG = Palette.error;
                                    }
                                  }
                                } else {
                                  errorMsg = "Couldn't connect to Google!";
                                  snackBG = Palette.error;
                                }
                                final message = SnackBar(
                                  content: Text(errorMsg),
                                  backgroundColor: snackBG,
                                  duration: const Duration(seconds: 3),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(message);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.asset(
                                    "assets/images/Google logo.png",
                                    fit: BoxFit.fitHeight),
                              )))),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Dont have an account? ",
                              style: TextStyle(
                                  fontSize: 12, color: Palette.black)),
                          InkWell(
                            child: const Text("Register",
                                style: TextStyle(
                                    fontSize: 12, color: Palette.link)),
                            onTap: () {
                              Navigator.of(context).push(AnimatedPageRoute(
                                  child: const RegisterPage()));
                            },
                          )
                        ],
                      ))
                ],
              )
            ])),
      ),
    ));
  }
}
