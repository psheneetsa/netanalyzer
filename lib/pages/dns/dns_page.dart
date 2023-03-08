import 'package:flutter/material.dart';

class DNSPage extends StatefulWidget {
  const DNSPage({Key? key}) : super(key: key);

  @override
  State<DNSPage> createState() => _DNSPageState();
}

class _DNSPageState extends State<DNSPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DNS Lookup"),
      ),
      body: Text(" DNS Lookup"),
    );
  }
}
