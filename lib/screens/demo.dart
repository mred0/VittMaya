import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../response/common_response.dart';
import '../utility/api_managar.dart';
import '../utility/utility.dart';

// Future<LoginModel> createAlbum(String username, String password) async {
//   final response = await http.post(
//     Uri.parse('https://ashwameghfashion.com/api/login.php'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'username': username,
//       'password': password,
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return LoginModel.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }

class LoginModel {
  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? role;
  String? response;
  String? msg;

  LoginModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.role,
      this.response,
      this.msg});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    role = json['role'];
    response = json['response'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['role'] = role;
    data['response'] = response;
    data['msg'] = msg;
    return data;
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() {
    return _DemoState();
  }
}

class _DemoState extends State<Demo> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  Future<LoginModel>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter user'),
        ),
        TextField(
          controller: _controller1,
          decoration: const InputDecoration(hintText: 'Enter password'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = loginApi();
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<LoginModel> buildFutureBuilder() {
    return FutureBuilder<LoginModel>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.toString());
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text('${snapshot.error}'),
              Text(snapshot.data.toString()),
            ],
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  loginApi() async {
    // isLoading.value = true;
    if (await ApiManager.checkInternet()) {
      var request = Map<String, dynamic>();
      request['username'] = 'admin';
      request['password'] = 'admin@123';

      LoginModel decodedResponse = LoginModel.fromJson(
          await ApiManager().postCall(
              'https://ashwameghfashion.com/api/login.php', request, context));

      if (decodedResponse.response == "1") {
        Utility.toast(
          message: decodedResponse.msg.toString(),
        );
      } else if (decodedResponse.response == "0") {
        Utility.toast(
          message: decodedResponse.response.toString(),
        );
      }

      Utility.toast(
        message: decodedResponse.msg.toString(),
      );
    } else {
      // isLoading.value = false;
      return Utility.toast(message: 'noInternetConnection');
    }
  }

  notify() {
    if (mounted) {
      setState(() {});
    }
  }
}
