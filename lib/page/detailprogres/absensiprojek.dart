import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:listproject/bloc/bloctimeline.dart';
import 'package:listproject/model/projekproses.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Absensiprojek extends StatefulWidget {
  Absensiprojek({Key key, this.model}) : super(key: key);
  final Projekproses model;
  @override
  _AbsensiprojekState createState() => _AbsensiprojekState();
}

class _AbsensiprojekState extends State<Absensiprojek> {
  var tanggal;
  var iduser = '0';
  var idproject = '0';
  var pengecekan = false;
  TextEditingController keterangan = TextEditingController();
  Projekproses model;
  Timer timer;

  addizin() {
    setState(() {
      pengecekan = !pengecekan;
    });
  }

  @override
  void initState() {
    getPref();
    model = widget.model;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      iduser = preferences.getString("id");
      idproject = model.idProject;
      bloctimeline.tampil(iduser, idproject);
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

  Widget keteranganizin() {
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
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(children: [
            Center(
              child: Text(
                "Tambah Keterangan Izin",
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
              child: TextField(
                controller: keterangan,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
            SizedBox(height: 10),
            FlatButton(
              color: Colors.transparent,
              height: 50,
              onPressed: () {
                setState(() {
                  bloctimeline.addtimeline(
                      idproject, iduser, '1', keterangan.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                });
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

  Widget statusprojek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              bloctimeline.addtimeline(idproject, iduser, '0', '');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4.5,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
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
                  Text("Proses", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            addizin();
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4.5,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
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
                  Text("Izin", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              bloctimeline.addtimeline(idproject, iduser, '2', '');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4.5,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
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
                  Text("Stop", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              bloctimeline.addtimeline(idproject, iduser, '3', '');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4.5,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Center(
              child: Text("Selesai",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }

  Widget content() {
    return StreamBuilder(
      stream: bloctimeline.alltimeline,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var timelinedata = snapshot.data;
          print(timelinedata);
          if (timelinedata.length == 0) {
            return Center(
              child: Container(
                width: 200,
                height: 200,
                child: Lottie.asset('asset/empty.json'),
              ),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: timelinedata.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 5,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width / 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue[200],
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 1,
                      margin: EdgeInsets.only(
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              left: 10,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  color: Colors.grey,
                                  size: 25,
                                ),
                                Text(
                                  timelinedata[i].tanggal,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              height: 30,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                color: timelinedata[i].status == '0'
                                    ? Colors.blue[200]
                                    : timelinedata[i].status == '1'
                                        ? Colors.yellow[200]
                                        : timelinedata[i].status == '2'
                                            ? Colors.red[200]
                                            : timelinedata[i].status == '3'
                                                ? Colors.green[200]
                                                : Colors.green[200],
                              ),
                              child: Center(
                                child: Text(
                                  timelinedata[i].status == '0'
                                      ? 'Proses'
                                      : timelinedata[i].status == '1'
                                          ? 'Izin'
                                          : timelinedata[i].status == '2'
                                              ? 'Stop'
                                              : timelinedata[i].status == '3'
                                                  ? 'Selesai'
                                                  : 'Selesai',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    size: 35,
                                    color: Colors.red[200],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      bloctimeline.hapustimeline(
                                          timelinedata[i].idTimeline);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  super.widget));
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width / 1,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.purple, Colors.blue]),
                ),
                child: statusprojek(),
              ),
              SizedBox(
                height: 10,
              ),
              keteranganizin(),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 1,
                  child: content()),
            ],
          ),
        ),
      ),
    );
  }
}
