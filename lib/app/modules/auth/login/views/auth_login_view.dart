import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_login_controller.dart';

class AuthLoginView extends GetView<AuthLoginController> {
  const AuthLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthLoginView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AuthLoginView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
