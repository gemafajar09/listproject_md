import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:listproject/bloc/blocwaiting.dart';
import 'package:listproject/page/detailwaiting/waitingdetail.dart';
import 'package:lottie/lottie.dart';

class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  Timer timer;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _refreshLocalGallery() async {
    blocwaiting.tampil('0');
  }

  @override
  void initState() {
    blocwaiting.tampil('0');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  Widget waitingproject() {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 1,
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
                itemCount: waitingdata.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 110,
                    margin: EdgeInsets.only(left: 5, right: 5, top: 5),
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
                      height: 110,
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
                                          builder: (context) => Waitingdetail(
                                            model: waitingdata[i],
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
                waitingproject(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
