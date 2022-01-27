import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Text('GraphScreen'),
      ],
    ));
  }
}
