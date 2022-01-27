import 'package:flutter/material.dart';

class SyncScreen extends StatefulWidget {
  SyncScreen({Key? key}) : super(key: key);

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Text('SyncScreen'),
      ],
    ));
  }
}
