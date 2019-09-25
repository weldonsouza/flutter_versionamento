import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'login_widget.dart';

class CheckVersion extends StatefulWidget {
  @override
  _CheckVersionState createState() => _CheckVersionState();
}

class _CheckVersionState extends State<CheckVersion> {
  List<dynamic> _dados = [];

  PackageInfo _packageInfo = PackageInfo(
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    _packageInfo = info;
    versionamento();
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  checkPlataformVersion() async {
    if (Platform.isIOS) {
      print('is a IOS');
      alertMessage(context, 'Informativo', 'Favor comparecer a TI para realizar atualização do App.',
          true, 'OK', 'assets/alert.png');
    } else if (Platform.isAndroid) {
      print('is a Andriod');
      _launchURL();
    } else {}
  }

  Future<List<dynamic>> versionamento() async {

    var url = 'https://192.168.1.1/VALIDAR?APP=Teste&VERSAO=${_packageInfo.version}';
    var response = await http.put(url);

    _dados = (json.decode(response.body)).toList();

    if (_dados[0]['SUCCESS'] == 'TRUE' && _dados[0]['MSG'] == '') {
      print('SUCCESS: true e MSG: ');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginWidget()),
      );
    } else if (_dados[0]['SUCCESS'] == 'TRUE' && _dados[0]['MSG'] != null) {
      print('SUCCESS: true e MSG: ${_dados[0]['MSG']}');
      alertMessage(context, 'Informativo', _dados[0]['MSG'], false, 'Prosseguir', 'assets/alert.png');
    } else {
      print('SUCCESS: false e MSG: ${_dados[0]['MSG']}');
      alertMessage(context, 'Atenção', _dados[0]['MSG'], true, 'Atualizar', 'assets/error.png');
    }

    return _dados;
  }

  alertMessage(context, titulo, msg, retorno, buttonOk, icon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Image.asset(icon, width: MediaQuery.of(context).size.width * 0.06,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(titulo),
            ],
          ),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text(buttonOk,
                  style: TextStyle(color: Colors.grey, fontSize: 15)),
              onPressed: () {
                Navigator.of(context).pop();
                if (retorno == true) {
                  checkPlataformVersion();
                } else {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginWidget()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  _launchURL() async {
    const url = 'https://play.google.com/store/apps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: versionamento,
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: MediaQuery.of(context).size.width * 0.7,),
              Text(
                'Versão do App: ${_packageInfo.version}',
                style: TextStyle(
                    color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.045),
              )
            ],
          ),
        ),
      ),
    );
  }
}