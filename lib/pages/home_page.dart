import 'dart:io';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:netanalyzer/models/wifi_info.dart';
import 'package:netanalyzer/pages/dns/dns_page.dart';
import 'package:netanalyzer/pages/dns/reverse_dns_page.dart';

import 'package:netanalyzer/pages/network_troubleshoot/ping_page.dart';
import 'package:netanalyzer/pages/network_troubleshoot/port_scan_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _WifiDetailState createState() => _WifiDetailState();
}

class _WifiDetailState extends State<HomePage> {
  WifiInfo? _wifiInfo;
  bool _location = false;

  Future<void> _getWifiInfo() async {
    if (Platform.isAndroid) {
      await Permission.location.request();
    }

    final wifiIP = await NetworkInfo().getWifiIP();
    final wifiBSSID = await NetworkInfo().getWifiBSSID();
    final wifiName = await NetworkInfo().getWifiName();

    setState(() {
      _wifiInfo = WifiInfo(wifiIP, wifiBSSID, wifiName, wifiName == null);
    });
    if (Platform.isAndroid || Platform.isIOS) {
      Permission.location.serviceStatus.isEnabled.then(
        (value) => setState(() {
          _location = value;
        }),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getWifiInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: _wifiInfo == null
                ? const CircularProgressIndicator.adaptive()
                : ListTile(
                    minVerticalPadding: 10,
                    leading: const Icon(Icons.router),
                    title: Text(_wifiInfo!.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Connected to ${_wifiInfo!.bssid}'),
                        const SizedBox(height: 5),
                        if (_location)
                          const SizedBox()
                        else
                          Text(
                            'Location should be on to display Wifi name',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        const Divider(height: 3),
                        const SizedBox(height: 10),

                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        _getWifiInfo();
                      },
                    ),
                  ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.network_check),
              title: const Text('Network Troubleshooting'),
              minVerticalPadding: 10,
              subtitle: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PingPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.trending_up),
                        label: const Text('Ping'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PortScanPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.radar),
                        label: const Text('Scan open ports'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.dns),
              title: const Text('Domain Name System (DNS)'),
              minVerticalPadding: 10,
              subtitle: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DNSPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.search),
                        label: const Text('Lookup'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReverseDNSPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.find_replace),
                        label: const Text('Reverse Lookup'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
