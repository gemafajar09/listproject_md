import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listproject/api.dart';
import 'package:listproject/bloc/blocproses.dart';
import 'package:listproject/model/projekproses.dart';
import 'package:listproject/model/progresfitur.dart';
import 'package:listproject/page/home.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Progresdetail extends StatefulWidget {
  Progresdetail({Key key, this.model}) : super(key: key);
  final Projekproses model;
  @override
  _ProgresdetailState createState() => _ProgresdetailState();
}

class _ProgresdetailState extends State<Progresdetail> {
  Projekproses model;
  Api api = Api();
  bool isSwitched = false;
  bool pengecekan = false;
  var id;
  String pilihan;

  List satuan = [];

  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
    });
  }

  Future<List> getprogrammer() async {
    final res = await http.get(Api.api + "/programmer-all");
    if (res.statusCode == 200) {
      setState(() {
        satuan = jsonDecode(res.body);
      });
    }
  }

  updatelist(ids, statuss, id_user) async {
    final res = await http.post(Api.api + "/projek-fitur-update",
        body: {'id': ids, 'status': statuss, 'id_user': id_user});
    if (res.statusCode == 200) {
      setState(() {});
    }
  }

  addteam() {
    setState(() {
      pengecekan = !pengecekan;
    });
  }

  @override
  void initState() {
    super.initState();
    getprogrammer();
    getPref();
    model = widget.model;
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 2.8,
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
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.teal[100],
                  Colors.blue[200],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    model.judul,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Text(
                  "Timeline : " + model.tglMasuk + " s/d " + model.tglDateline,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Nama Client : " + model.namaClient,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Telpon Client : " + model.noHpClient,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Deskripsi : ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Text(
                  "- " + model.deskripsi,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        blocproses.selesaikan(model.idProject);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Selesaikan",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        addteam();
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Tambah Team",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Hero(
              tag: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                height: 55,
                width: 100,
                child: Lottie.asset('asset/progres.json'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addrekan() {
    if (pengecekan == true) {
      return Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 1,
        height: MediaQuery.of(context).size.height / 3.5,
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
          margin: EdgeInsets.only(
            right: 5,
          ),
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(children: [
            Center(
              child: Text(
                "Tambah Team",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20),
                    ),
                  ),
                ),
                hint: Text('-PILIH REKAN-'),
                value: pilihan,
                onChanged: (value) {
                  setState(() {
                    pilihan = value;
                  });
                },
                items: satuan.map((item) {
                  return DropdownMenuItem(
                    child: new Text(item),
                    value: item,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              color: Colors.transparent,
              height: 50,
              onPressed: () {
                if (pilihan != '') {
                  setState(() {
                    blocproses.tambahteams(model.idProject, pilihan);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => super.widget));
                  });
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
                  child:
                      Text("Tambahkan", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ]),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget fiturprojek() {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 1,
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
        padding: EdgeInsets.only(left: 10, right: 10),
        margin: EdgeInsets.only(right: 5),
        width: MediaQuery.of(context).size.width / 1,
        height: MediaQuery.of(context).size.height / 1,
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
        child: FutureBuilder<List<Progresfitur>>(
          future: api.getfiturprogres(model.idProject.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var datalist = snapshot.data;
              if (datalist.length == 0) {
                return Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Lottie.asset('asset/notfound.json'),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: datalist.length,
                  itemBuilder: (context, no) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                          child: Text(
                            '- ',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Owsland',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(
                            datalist[no].fitur,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Owsland',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Switch(
                          value: datalist[no].status != '0' ? true : false,
                          onChanged: (value) {
                            setState(() {
                              updatelist(datalist[no].idFitur.toString(),
                                  datalist[no].status.toString(), id);
                            });
                          },
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.white,
                        ),
                      ],
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  header(),
                  addrekan(),
                  fiturprojek(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
