import 'package:flutter/material.dart';
import 'package:find_dropdown/find_dropdown.dart';
// import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtNama = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtAsalSekolah = new TextEditingController();
  TextEditingController txtJenisKelamin = new TextEditingController();
  TextEditingController txtTanggalLahir = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd");
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          BackButtonWidget(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.person), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: txtNama,
                          decoration: InputDecoration(hintText: 'Nama'),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.mail), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          controller: txtEmail,
                          decoration: InputDecoration(hintText: 'Email'),
                        )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.lock), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: TextField(
                          obscureText: true,
                          controller: txtPassword,
                          decoration: InputDecoration(hintText: 'Password'),
                        )))
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.school), onPressed: null),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  child: FindDropdown(
                    items: [
                      "---Pilih Prodi---",
                      "Sistem Informasi",
                      "Teknik Informatika",
                      "Manajemen Informatika",
                      "Teknik Komputer"
                    ],
                    label: "Program Studi:",
                    onChanged: (value) {
                      txtAsalSekolah.text = value;
                    },
                    selectedItem: "---Pilih Prodi--",
                    showSearchBox: true,
                    labelStyle: TextStyle(color: Colors.black),
                    backgroundColor: Colors.white,
                    titleStyle: TextStyle(color: Colors.black),
                    validate: (String item) {
                      if (item == null)
                        return "Required field";
                      else if (item == "---Pilih Sekolah---")
                        return "Invalid item";
                      else
                        return null;
                    },
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.date_range), onPressed: null),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 20, left: 10),
                        child: DateTimeField(
                          controller: txtTanggalLahir,
                          decoration:
                              InputDecoration(hintText: 'Tanggal Lahir'),
                          format: format,
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                initialDate: currentValue ?? DateTime.now(),
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2100));
                          },
                        )))
                // DateTimeField(
                //   controller: txtTanggalLahir,
                //   decoration: InputDecoration(labelText: "Tanggal Lahir"),
                //   format: format,
                //   onShowPicker: (context, currentValue) {
                //     return showDatePicker(
                //         context: context,
                //         initialDate: currentValue ?? DateTime.now(),
                //         firstDate: DateTime(1970),
                //         lastDate: DateTime(2100));
                //   },
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Radio(value: null, groupValue: null, onChanged: null),
                RichText(
                    text: TextSpan(
                        text: 'I have accepted the',
                        style: TextStyle(color: Colors.black),
                        children: [
                      TextSpan(
                          text: 'Terms & Condition',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold))
                    ]))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 60,
                child: RaisedButton(
                  onPressed: () {
                    _doSignUp();
                    // Navigator.pushNamed(context, 'Home');
                  },
                  color: Color(0xFF00a79B),
                  child: Text(
                    'DAFTAR',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _doSignUp() async {
    String nama = txtNama.text;
    String email = txtEmail.text;
    String password = txtPassword.text;
    String asalSekolah = txtAsalSekolah.text;
    String tanggalLahir = txtTanggalLahir.text;

    if (nama.isEmpty || email.isEmpty) {
      Alert(
              context: context,
              title: "Data Tidak Ada Yang Boleh Kosong!",
              type: AlertType.error)
          .show();
      return;
    }
    ProgressDialog progressDialog = ProgressDialog(context);
    progressDialog.style(message: "Loading...");
    progressDialog.show();
    final response =
        await http.post('http://demo-api.unama.ac.id/api/user', body: {
      'name': nama,
      'email': email,
      'password': password,
      'asal_sekolah': asalSekolah,
      'tanggal_lahir': tanggalLahir,
    }, headers: {
      'accept': 'application/json'
    });
    progressDialog.hide();
    if (response.statusCode == 201) {
      Alert(
          context: context,
          title: "Data Berhasil Disimpan !",
          type: AlertType.success,
          buttons: [
            DialogButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            DialogButton(
              child: Text("LOGIN"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ]).show();
    } else {
      Alert(
              context: context,
              title: "Data Gagal Disimpan !",
              type: AlertType.error)
          .show();
    }
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('asset/img/app.png'))),
      child: Positioned(
          child: Stack(
        children: <Widget>[
          Positioned(
              top: 20,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Positioned(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Buat Account Baru',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          )
        ],
      )),
    );
  }
}
