import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hefish_finalproject/page/loginPage.dart';
import 'package:hefish_finalproject/page/registerPage.dart';
import 'package:hefish_finalproject/design/customTextField.dart';
import '../class/host.dart';
import '../design/animatedPageRoute.dart';
import '../class/color_palette.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController unameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pwordCtrl = TextEditingController();
  TextEditingController pcnfmCtrl = TextEditingController();

  Future<bool> checkUsernameDuplication(String username) async {
    String url = "${Host.main}/users/register-check-username";
    var resp = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'username': username}));
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkEmailDuplication(String email) async {
    String url = "${Host.main}/users/register-check-email";
    var resp = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email}));
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registerUser(
      String email, String username, String password) async {
    String url = "${Host.main}/users/register";
    var resp = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {'email': email, 'username': username, 'password': password}));
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
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
                  "Get Started!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Palette.accent,
                      fontSize: 40),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Register to explore.",
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
                    controller: emailCtrl,
                    top: 25,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: Icons.mail,
                  ),
                  CustomTextField(
                    controller: pwordCtrl,
                    top: 25,
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: Icons.visibility,
                  ),
                  CustomTextField(
                    controller: pcnfmCtrl,
                    top: 25,
                    hintText: "Confirm Password",
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: Icons.visibility,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 40),
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
                                    RegExp pwordReg = RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-_!@#\$&*~]).{8,}$');
                                    String errorMsg = "Successfuly registered!";
                                    Color snackBG = Palette.success;
                                    if (emailCtrl.text.isEmpty ||
                                        unameCtrl.text.isEmpty ||
                                        pwordCtrl.text.isEmpty ||
                                        pcnfmCtrl.text.isEmpty) {
                                      errorMsg =
                                          "Please fill in all the forms!";
                                      snackBG = Palette.error;
                                    } else if (unameCtrl.text.length < 4) {
                                      errorMsg =
                                          "Username length must be at least 4 characters!";
                                      snackBG = Palette.error;
                                    } else if (!EmailValidator.validate(
                                        emailCtrl.text, true)) {
                                      errorMsg =
                                          "Email is either invalid or untrusted!";
                                      snackBG = Palette.error;
                                    } else if (pwordCtrl.text.length < 8) {
                                      errorMsg =
                                          "Password length must be at least 8 characters!";
                                      snackBG = Palette.error;
                                    } else if (!pwordReg
                                        .hasMatch(pwordCtrl.text)) {
                                      errorMsg =
                                          "Password must contains at least 1 upper, lower, and number character!";
                                      snackBG = Palette.error;
                                    } else if (pwordCtrl.text !=
                                        pcnfmCtrl.text) {
                                      errorMsg = "Password does not match!";
                                      snackBG = Palette.error;
                                    } else {
                                      if (await checkUsernameDuplication(
                                          unameCtrl.text)) {
                                        errorMsg =
                                            "An account with this username already exist";
                                        snackBG = Palette.error;
                                      } else if (await checkEmailDuplication(
                                          emailCtrl.text)) {
                                        errorMsg =
                                            "An account with this email address already exist";
                                        snackBG = Palette.error;
                                      } else {
                                        if (await registerUser(emailCtrl.text,
                                            unameCtrl.text, pwordCtrl.text)) {
                                          Navigator.of(context).pop(context);
                                          snackBG = Palette.success;
                                        } else {
                                          errorMsg = "Something went wrong!";
                                          snackBG = Palette.error;
                                        }
                                      }
                                    }
                                    final message = SnackBar(
                                      content: Text(errorMsg),
                                      backgroundColor: snackBG,
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
                                  child: const Text("Register"))))),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? ",
                              style: TextStyle(
                                  fontSize: 12, color: Palette.black)),
                          InkWell(
                            child: const Text("Login",
                                style: TextStyle(
                                    fontSize: 12, color: Palette.link)),
                            onTap: () {
                              Navigator.of(context).pop();
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
