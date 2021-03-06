import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:listproject/bloc/blocbonus.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bonus extends StatefulWidget {
  @override
  _BonusState createState() => _BonusState();
}

class _BonusState extends State<Bonus> {
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

  void getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
      blocbonus.tampil(id);
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

  Widget bonusprojek() {
    return Container(
        height: MediaQuery.of(context).size.height / 1,
        width: MediaQuery.of(context).size.width / 1,
        child: StreamBuilder(
          stream: blocbonus.allbonus,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var bonusdata = snapshot.data;
              if (bonusdata.length != 0) {
                return ListView.builder(
                    itemCount: bonusdata.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        height: 80,
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
                          height: 80,
                          width: MediaQuery.of(context).size.width / 1,
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                ),
                                child: Text(
                                  bonusdata[i].namaProject,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                width: 100,
                                child: Container(
                                  height: 30,
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  child: Center(
                                    child: Text(
                                      bonusdata[i].statusBayar == '0'
                                          ? "Belum Bayar"
                                          : "Sudah Bayar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                width: 230,
                                child: Container(
                                  height: 30,
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                    color: Colors.blue[200],
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Bonus : Rp. " +
                                            bonusdata[i].hargaBersih +
                                            ", -",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        bonusdata[i].persen + "%",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    height: 55,
                                    width: 100,
                                    child: Lottie.asset('asset/money.json'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
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
        ));
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
                bonusprojek(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
