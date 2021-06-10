import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listproject/api.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey();
  String msg = '';
  bool pengecekan = true;

  tampilPassword() {
    setState(() {
      pengecekan = !pengecekan;
    });
  }

  logins() async {
    final res = await http.post(Api.api + "/auth-login", body: {
      'username': username.text,
      'password': password.text,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(data);
      var foto = data['foto'];
      var nama = data['nama'];
      var jabatan = data['jabatan'];
      var alamat = data['alamat'];
      var telpon = data['telpon'];
      var id = data['id_user'];
      if (id != null) {
        savePref(foto, nama, jabatan, id.toString(), alamat, telpon);
        showToast('${data['message']} $nama');
        Navigator.pushReplacementNamed(context, '/splash');
      } else {
        showToast('invalid Data');
        username.clear();
        password.clear();
      }
    }
  }

  @override
  void initState() {
    getPref();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void savePref(String foto, String nama, String jabatan, String id,
      String alamat, String telpon) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("foto", foto);
    preferences.setString("nama", nama);
    preferences.setString("jabatan", jabatan);
    preferences.setString("alamat", alamat);
    preferences.setString("telpon", telpon);
    preferences.setString("id", id);
    preferences.commit();
    setState(() {});
  }

  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      if (preferences.getString("id") != null) {
        Navigator.pushReplacementNamed(context, '/splash');
      }
    });
  }

  showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  }

  Widget header() {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            child: Lottie.asset('asset/login.json'),
          ),
        ],
      ),
    );
  }

  Widget popup() {
    return AlertDialog(
      title: Text('Anda yakin ingin Keluar?'),
      actions: <Widget>[
        RaisedButton(
            child: Text('Ya'),
            onPressed: () => Navigator.of(context).pop(true)),
        RaisedButton(
            child: Text('Tidak'),
            onPressed: () => Navigator.of(context).pop(false)),
      ],
    );
  }

  Widget _username() {
    return TextFormField(
      controller: username,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.person),
        hintText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _password() {
    return TextFormField(
      controller: password,
      obscureText: pengecekan,
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            tampilPassword();
          },
          icon: Icon(
            pengecekan ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _button() {
    return FlatButton(
      color: Colors.transparent,
      height: 50,
      onPressed: () {
        if (username.text == '') {
          showToast('Username Masih Kosong');
        } else {
          if (password.text == '') {
            showToast('Username Masih Kosong');
          } else {
            logins();
          }
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.2,
              0.4,
            ],
            colors: [
              Colors.indigo[200],
              Colors.blue[100],
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Text("LOGIN", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tinggi = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async =>
            showDialog(context: context, builder: (context) => popup()),
        child: Scaffold(
          backgroundColor: Colors.white,
          key: formKey,
          body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(
              children: [
                header(),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  margin: EdgeInsets.only(
                    top: tinggi / 2.4,
                  ),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 20),
                      // Text(
                      //   "LOGIN",
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(height: 40),
                      _username(),
                      SizedBox(height: 20),
                      _password(),
                      SizedBox(height: 20),
                      _button(),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            )),
          ),
        ));
  }
}
