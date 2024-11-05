import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Dio _dio = Dio();

  Future<void> login() async {
    const String url =
        'https://learnonyx.com:8097/ultimate-onyxix/api/v5.1.5/erpweb/main/adm/user/login';

    final Map<String, dynamic> loginData = {
      'lngNo': 1,
      'lngDflt': 1,
      'dbsUsr': 1,
      'lgnByUsrCodeFlg': 0,
      'usrNo': 1,
      'usrCode': _usernameController.text,
      'usrPswrd': _passwordController.text,
      'yrNo': 2024,
      'yearNo': 2024,
      'untNo': 2,
      'sysNo': 1,
      'sysTyp': 1,
      'email': 'x@x.com',
      'mobileNo': '0000',
      'dvcInfo': {
        'browserName': 'Safari',
        'browserVersion': '16.0',
        'deviceImei': 'test00',
        'deviceMacAddress': 'test12',
        'deviceName': 'iPhone 12',
        'deviceSerial': 'edfss54fdrejf',
        'deviceType': 1,
        'deviceVersion': 12,
        'osName': 'iOS',
        'osVersion': '16.4',
      },
    };

    final headers = {
      'Calender': 'higrah',
      'CharSet': 'AL32UTF8',
      'IASConfig': 'OnyxIx',
      'DateFormat': 'DD/MM/RRRR',
      'TimeFormat': 'HH24:MI:SSA',
      'ReportPrefix': 'IX',
      'ReportPort': '8080',
      'NetService': 'test',
      'Territory': 'Egyptian',
      'CID': 'A2024',
      'APPID': '123456789'
    };

    try {
      final response = await _dio.post(
        url,
        data: loginData,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        // Handle successful login
        final responseData = response.data;
        // Do something with the response data
        log('Login successful: $responseData');
      } else {
        // Handle login error
        log('Login failed: ${response.statusCode} ${response.data}');
      }
    } catch (error) {
      log('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
