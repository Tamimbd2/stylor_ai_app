import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/shapeselect_controller.dart';

class ShapeselectView extends GetView<ShapeselectController> {
  const ShapeselectView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShapeselectView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ShapeselectView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
