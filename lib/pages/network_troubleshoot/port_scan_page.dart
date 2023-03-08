import 'package:flutter/material.dart';

class PortScanPage extends StatefulWidget {
  const PortScanPage({Key? key}) : super(key: key);

  @override
  State<PortScanPage> createState() => _PortScanPageState();
}

class _PortScanPageState extends State<PortScanPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Port scan"),
      ),
      body: Text("Port scan"),
    );
  }
}