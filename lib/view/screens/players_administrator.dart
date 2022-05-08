import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayersAdministratorScreen extends StatefulWidget {
  const PlayersAdministratorScreen({Key? key}) : super(key: key);

  @override
  State<PlayersAdministratorScreen> createState() =>
      _PlayersAdministratorScreenState();
}

class _PlayersAdministratorScreenState
    extends State<PlayersAdministratorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('playersAdministrator'.tr),
      ),
      body: Container(),
    );
  }
}
