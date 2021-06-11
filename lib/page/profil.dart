import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  var nama = '', id = '', jabatan = '', foto = '', alamat = '', telpon = '';

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var images =
      'https://www.pngfind.com/pngs/m/470-4703547_icon-user-icon-hd-png-download.png';

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
      foto = preferences.getString("foto");
      nama = preferences.getString("nama");
      jabatan = preferences.getString("jabatan");
      alamat = preferences.getString("alamat");
      telpon = preferences.getString("telpon");
      id = preferences.getString("id");
      images = foto;
    });
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("foto", '');
    preferences.setString("nama", '');
    preferences.setString("jabatan", '');
    preferences.setString("alamat", '');
    preferences.setString("telpon", '');
    preferences.setString("id", '');
    preferences.commit();
    setState(() {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  Widget profilfoto() {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 8,
        left: 20,
        right: 20,
      ),
      width: MediaQuery.of(context).size.width / 1,
      height: 160,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 5,
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
              image: DecorationImage(
                image: NetworkImage(images),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
            ),
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  softWrap: true,
                ),
                Text(
                  jabatan,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1,
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profilalamat() {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      height: 100,
      margin: EdgeInsets.only(
        right: 20,
        left: 20,
      ),
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
            padding: EdgeInsets.all(10),
            child: Text(
              "$alamat",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.blue[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_location, color: Colors.white),
                  Text(
                    "Alamat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget telponprofil() {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      height: 40,
      margin: EdgeInsets.only(
        right: 20,
        left: 20,
      ),
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
            padding: EdgeInsets.all(10),
            child: Text(
              "$telpon",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.blue[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: Colors.white),
                  Text(
                    "Telpon",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  alertkeluar() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Anda yakin ingin Keluar?',
              style: TextStyle(
                fontFamily: 'Owsland',
              )),
          actions: <Widget>[
            RaisedButton(
                child: Text('sign out'),
                onPressed: () {
                  logout();
                }),
            RaisedButton(
                child: Text('cancel'),
                onPressed: () => Navigator.of(context).pop(false)),
          ]),
    );
  }

  Widget keluarsistem() {
    return InkWell(
      onTap: () {
        alertkeluar();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1,
        height: 40,
        margin: EdgeInsets.only(
          right: 20,
          left: 20,
        ),
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
        child: Center(
          child: Text(
            "Keluar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4.5,
                  width: MediaQuery.of(context).size.width / 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.blue[200],
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height / 1,
                  child: Column(
                    children: [
                      profilfoto(),
                      SizedBox(height: 10),
                      profilalamat(),
                      SizedBox(height: 10),
                      telponprofil(),
                      SizedBox(height: 10),
                      keluarsistem(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
