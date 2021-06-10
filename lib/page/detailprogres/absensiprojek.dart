import 'dart:async';

import 'package:date_time_picker/date_time_picker.dart';
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
  Projekproses model;
  Timer timer;

  @override
  void initState() {
    // timer = Timer.periodic(
    //   Duration(milliseconds: 1000),
    //   (timer) {
    //     bloctimeline.tampil(iduser, idproject);
    //   },
    // );
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

  Widget tanggalabsen() {
    return DateTimePicker(
      type: DateTimePickerType.date,
      dateMask: 'yyyy-MM-d',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      dateLabelText: 'Date',
      selectableDayPredicate: (date) {
        // Disable weekend days to select from the calendar
        if (date.weekday == 6 || date.weekday == 7) {
          return false;
        }

        return true;
      },
      onChanged: (val) {
        setState(() {
          tanggal = val.toString();
        });
      },
    );
  }

  Widget statusprojek() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            bloctimeline.addtimeline(idproject, iduser, '0');
            setState(() {});
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
            bloctimeline.addtimeline(idproject, iduser, '1');
            setState(() {});
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
            bloctimeline.addtimeline(idproject, iduser, '2');
            setState(() {});
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
            bloctimeline.addtimeline(idproject, iduser, '3');
            setState(() {});
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
                                  onPressed: () {},
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
