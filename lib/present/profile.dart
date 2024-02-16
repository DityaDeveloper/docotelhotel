import 'dart:convert';

import 'package:docotelhotel/model/user_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UsersModel? usersModel;
  //Response? response;

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  fetchUser() async {
    String url =
        "https://1518f853-b279-4960-aa5f-b3db1adbb13e.mock.pstmn.io/profile";
    final response = await http.Client()
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      debugPrint('Request Timeout');
      return http.Response('Request Timeout', 408);
    });

    final data = json.decode(response.body) as Map<String, dynamic>;
    usersModel = UsersModel.fromJson(data['data']);
    debugPrint(usersModel.toString());
    //usersModel =  jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(usersModel!.name),
        Text(usersModel!.email),
        Text(usersModel!.phone),
        Text(usersModel!.moto),
      ],
    );
  }
}
