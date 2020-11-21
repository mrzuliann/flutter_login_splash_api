import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Akun extends StatefulWidget {
  @override
  _AkunState createState() => new _AkunState();
}

class _AkunState extends State<Akun> {
  //  DbHelper dbHelper = DbHelper();
  // List<Profil> profil;
  // String keteranganProfil = '';

  @override

  // _getProfil();
  void initState() {
    super.initState();
  }

  // _getProfil() async {
  //   final Future<Database> dbFuture = dbHelper.initDb();
  //   dbFuture.then((database) {
  //     Future<List<Profil>> profilFuture = dbHelper.getProfil();
  //     profilFuture.then((profilList) {
  //       setState(() {
  //         profil = profilList;
  //         keteranganProfil = profil[0].nama + '\n';
  //         keteranganProfil += profil[0].alamat + '\n';
  //         keteranganProfil += profil[0].kota + '\n';
  //         keteranganProfil += profil[0].telp;
  //       });
  //     });
  //   });
  // }

  _logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('slogin', false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('SignIn', (Route<dynamic> route) => false);
    Fluttertoast.showToast(
        msg: "Logout Berhasil!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SafeArea(
      child: new Container(
          color: Colors.white,
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Akun'),
                  RaisedButton(
                    onPressed: () => _logOut(),
                    color: Colors.white,
                    child: const Text('Logout', style: TextStyle(fontSize: 18)),
                  )
                ]),
          )),
    ));
  }
}
