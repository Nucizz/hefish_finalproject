import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:hefish_finalproject/class/user.dart';
import 'package:http/http.dart' as http;

import 'host.dart';

class GoogleAuth {

  static final _oauth = GoogleSignIn();

  static Future<GoogleSignInAccount?> googleLogin() => _oauth.signIn();

  static Future googleLogout() => _oauth.disconnect();

  static Future<bool> googleRegisterCheck(String email) async {
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

  static Future<bool> googleRegister(
    String email, String username) async {
    String url = "${Host.main}/users/register-oauth";
    var resp = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {'email': email, 'username': username}));
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<User> googleGetUser(String email) async {
    String url = "${Host.main}/users/login-oauth";
    var resp = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'email': email,}));
    var res = jsonDecode(resp.body);
    if (res.length > 0) {
      return User.fromJson(res[0]);
    } else {
      return User(id: -404, email: "???", username: "???", token: "???");
    }
  }

}
