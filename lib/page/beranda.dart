import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:listproject/api.dart';
import 'package:listproject/bloc/blocfinis.dart';
import 'package:listproject/bloc/blocproses.dart';
import 'package:listproject/bloc/blocwaiting.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  var nama;
  var jabatan;
  var id;
  var bonus = '0';
  Api api = Api();
  Timer timer;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getbonus(id) async {
    final res = await http.get(Api.api + "/total-bonus/" + id);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      setState(() {
        bonus = data['bonus'];
      });
    }
  }

  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString("nama");
      jabatan = preferences.getString("jabatan");
      id = preferences.getString("id");
      blocfinis.tampil(id);
      blocproses.tampil(id);
      blocwaiting.tampil('0');
      getbonus(id);
    });
  }

  Future<Null> _refreshLocalGallery() async {
    getPref();
  }

  Widget appbar() {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width / 1,
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Project",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.blue,
                fontFamily: 'PoppinsMedium'),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width / 2.4,
            child: TextField(
              style: TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
              autofocus: false,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: HexColor("#52555A"),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                filled: true,
                hintStyle: TextStyle(
                    color: HexColor("#52555A"), fontFamily: 'PoppinsMedium'),
                contentPadding: const EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(25.7),
                ),
              ),
            ),
          ),
          IconButton(
            splashRadius: 20,
            icon: Icon(
              Icons.notifications_none_sharp,
              size: 30,
              color: Colors.blue,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Widget containeruser() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: EdgeInsets.all(20),
      height: 190,
      width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$nama",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 26,
                        fontFamily: 'PoppinsBold'),
                  ),
                  Text(
                    "$jabatan",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Rp.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    bonus,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 50),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[50],
            ),
            child: Center(
              child: Text(
                "Jumlah Bonus RP." + bonus,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget waitingproject() {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 1,
      height: 120,
      child: StreamBuilder(
        stream: blocwaiting.allwaiting,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var waitingdata = snapshot.data;
            if (waitingdata.length == 0) {
              return Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Lottie.asset('asset/empty.json'),
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: waitingdata.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 110,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue[100],
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.only(right: 6),
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Text(
                              waitingdata[i].judul,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Owsland',
                              ),
                              softWrap: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 30),
                            child: Text(
                              waitingdata[i].deskripsi,
                              softWrap: true,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox(
                              height: 90,
                              width: MediaQuery.of(context).size.width - 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0 * 1.5,
                                      vertical: 20.0 / 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow[200],
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      "Waiting",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: Container(
              width: 200,
              height: 200,
              child: Lottie.asset('asset/loading.json'),
            ),
          );
        },
      ),
    );
  }

  Widget progresproject() {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 1,
      height: 120,
      child: StreamBuilder(
        stream: blocproses.allproses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var prosesdata = snapshot.data;
            if (prosesdata.length == 0) {
              return Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Lottie.asset('asset/empty.json'),
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: prosesdata.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 110,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue[100],
                    ),
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.only(right: 5),
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Text(
                              prosesdata[i].judul,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PoppinsMedium',
                              ),
                              softWrap: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 30),
                            child: Text(
                              prosesdata[i].deskripsi,
                              softWrap: true,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox(
                              height: 90,
                              width: MediaQuery.of(context).size.width - 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0 * 1.5,
                                      vertical: 20.0 / 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[200],
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      "Proses",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: Container(
              width: 200,
              height: 200,
              child: Lottie.asset('asset/loading.json'),
            ),
          );
        },
      ),
    );
  }

  Widget historyproject() {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 1,
      height: 110,
      child: StreamBuilder(
        stream: blocfinis.allfinis,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var finishdata = snapshot.data;
            if (finishdata.length == 0) {
              return Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Lottie.asset('asset/empty.json'),
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: finishdata.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 110,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue[100],
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.only(right: 5),
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Text(
                              finishdata[i].judul,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Owsland',
                              ),
                              softWrap: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 30),
                            child: Text(
                              finishdata[i].deskripsi,
                              softWrap: true,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox(
                              height: 90,
                              width: MediaQuery.of(context).size.width - 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.0 * 1.5,
                                      vertical: 20.0 / 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.teal[200],
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      "Finish",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: Container(
              width: 200,
              height: 200,
              child: Lottie.asset('asset/loading.json'),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refreshLocalGallery,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                appbar(),
                containeruser(),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 60,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Waiting",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                waitingproject(),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 60,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Progress",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                progresproject(),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: 60,
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Finish",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                historyproject(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
