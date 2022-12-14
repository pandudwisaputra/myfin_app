import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:Myfin/alertsucces.dart';
import 'package:Myfin/loading.dart';
import 'package:Myfin/loginpage/login_screen.dart';
import 'package:Myfin/registerpage/register_model.dart';
import 'package:Myfin/registerpage/verif_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/conecttion.dart';
import '../helper/exception_handler.dart';

// ignore: use_key_in_widget_constructors
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late RegisterModel _registerData;
  TextEditingController emailController = TextEditingController();

  Future<bool?> emailCheck(String email) async {
    try {
      SharedPreferences server = await SharedPreferences.getInstance();
      String? baseUrl = server.getString('server');
      final msg = jsonEncode({"email": email});
      var response = await http.post(Uri.parse(baseUrl! + '/api/emailcheck'),
          headers: {
            'X-API-Key': "myfin",
            'Accept': "application/json",
          },
          body: msg);
      var data = response.body;
      print(data);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return true;
      } else
        return false;
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConnectionPage(
            button: true,
            error: error,
          ),
        ),
      );
    }
  }

  Future<bool?> registerData(String email) async {
    try {
      SharedPreferences server = await SharedPreferences.getInstance();
      String? baseUrl = server.getString('server');
      final msg = jsonEncode({"email": email});
      var response = await http.post(Uri.parse(baseUrl! + '/api/datanasabah'),
          headers: {
            'X-API-Key': "myfin",
            'Accept': "application/json",
          },
          body: msg);
      var data = response.body;
      print(data);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var decodeId = RegisterModel.fromJson(jsonDecode(response.body));
        int idNasabah = decodeId.data.id;
        String emailNasabah = decodeId.data.email;
        print(idNasabah);
        SharedPreferences prefsId = await SharedPreferences.getInstance();
        await prefsId.setInt('idNasabah', idNasabah);

        SharedPreferences prefsEmail = await SharedPreferences.getInstance();
        await prefsEmail.setString('emailNasabah', emailNasabah);
        return true;
      } else
        return false;
    } catch (e) {
      var error = ExceptionHandlers().getExceptionString(e);
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConnectionPage(
            button: true,
            error: error,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 68.0),
              child: Text(
                'Daftar',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(53, 80, 112, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 68),
            Lottie.network(
              'https://assets5.lottiefiles.com/packages/lf20_zw0djhar.json',
              width: 280,
              height: 250,
            ),
            // Image.asset(
            //   "assets/png/login.png",
            //   width: 280,
            //   height: 250,
            // ),
            Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding:
                    const EdgeInsets.only(left: 32.0, right: 32.0, top: 60.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) => validateEmail(value),
                    showCursor: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Email',
                    ),
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            RawMaterialButton(
              onPressed: () async {
                String email = emailController.text;
                if (email == "") {
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            title: const Text("Isi Email Dengan Benar"),
                          ));
                } else {
                  bool? data = await emailCheck(email);
                  if (data == false) {
                    registerLoading(context);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('emailNasabah', emailController.text);
                    if (data != true) {
                      bool? daftar = await registerData(email);
                      if (daftar == true) {
                        var navigationResult = await Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Verifikasi()));
                      }
                    }
                  } else {
                    emailTerdaftar(context);
                    //showDialog(context: context, builder: (context) => const AlertDialog(title: const Text("Email Sudah Terdaftar"),));
                  }
                }
              },
              fillColor: const Color.fromRGBO(53, 80, 112, 1),
              constraints: const BoxConstraints(minHeight: 49, minWidth: 128),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              child: const Text('Daftar'),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah Punya Akun?'),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: const Color.fromRGBO(2, 62, 138, 1),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text("Login"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginDemo()),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Masukkan Email Dengan Benar';
    } else {
      return null;
    }
  }
}
