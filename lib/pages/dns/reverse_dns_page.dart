import 'package:flutter/material.dart';


class ReverseDNSPage extends StatefulWidget {
  const ReverseDNSPage({Key? key}) : super(key: key);

  @override
  State<ReverseDNSPage> createState() => _ReverseDNSPageState();
}

class _ReverseDNSPageState extends State<ReverseDNSPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reverse DNS Lookup"),
      ),
      body: Text("Reverse DNS Lookup"),
    );
  }
}
