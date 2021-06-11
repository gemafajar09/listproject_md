import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:listproject/bloc/blocfinis.dart';
import 'package:listproject/page/detailhistory/historydetail.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Timer timer;
  var id;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    getPref();

    super.initState();
  }

  Future<Null> _refreshLocalGallery() async {
    getPref();
  }

  @override
  void dispose() {
    // blocfinis.dispose();
    super.dispose();
  }

  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      blocfinis.tampil(id);
    });
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

  Widget historyproject() {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 1,
      child: StreamBuilder(
        stream: blocfinis.allfinis,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var finishdata = snapshot.data;
            if (finishdata.length != 0) {
              return ListView.builder(
                itemCount: finishdata.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 110,
                    margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                    width: MediaQuery.of(context).size.width / 1,
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
                      height: 110,
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
                          Positioned(
                            bottom: 8,
                            left: 0,
                            child: Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.pending_actions_outlined,
                                      color: Colors.blue[100],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Historydetail(
                                            model: finishdata[i],
                                          ),
                                        ),
                                      );
                                    },
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
            } else {
              return Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: Lottie.asset('asset/empty.json'),
                ),
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
                historyproject(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
