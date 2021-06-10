import 'package:flutter/material.dart';
import 'package:listproject/api.dart';
import 'package:listproject/model/progresfitur.dart';
import 'package:listproject/model/projekfinish.dart';
import 'package:lottie/lottie.dart';

class Historydetail extends StatefulWidget {
  Historydetail({Key key, this.model}) : super(key: key);
  final Projekfinish model;
  @override
  _HistorydetailState createState() => _HistorydetailState();
}

class _HistorydetailState extends State<Historydetail> {
  Projekfinish model;
  Api api = Api();
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 3.2,
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
            height: MediaQuery.of(context).size.height / 3.2,
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
              width: MediaQuery.of(context).size.width / 2,
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
                    onPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Aplikasi Selesai",
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

  Widget fiturfinish() {
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
                            setState(() {});
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
                  fiturfinish(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
