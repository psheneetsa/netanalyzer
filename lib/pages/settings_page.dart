import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:netanalyzer/api/update_checker.dart';
import 'package:netanalyzer/main.dart';
import 'package:netanalyzer/models/dark_theme_provider.dart';
import 'package:netanalyzer/ui/settings_dialog/first_subnet_dialog.dart';
import 'package:netanalyzer/ui/settings_dialog/last_subnet_dialog.dart';
import 'package:netanalyzer/ui/settings_dialog/ping_count_dialog.dart';
import 'package:netanalyzer/ui/settings_dialog/socket_timeout_dialog.dart';
import 'package:netanalyzer/values/strings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch(
                value: themeChange.darkTheme,
                onChanged: (bool? value) {
                  themeChange.darkTheme = value ?? false;
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(StringValue.firstSubnet),
              subtitle: const Text(StringValue.firstSubnetDesc),
              trailing: Text(
                '${appSettings.firstSubnet}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => const FirstSubnetDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(StringValue.lastSubnet),
              subtitle: const Text(StringValue.lastSubnetDesc),
              trailing: Text(
                '${appSettings.lastSubnet}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => const LastSubnetDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(StringValue.socketTimeout),
              subtitle: const Text(StringValue.socketTimeoutdesc),
              trailing: Text(
                '${appSettings.socketTimeout} ms',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => const SocketTimeoutDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(StringValue.pingCount),
              subtitle: const Text(StringValue.pingCountDesc),
              trailing: Text(
                '${appSettings.pingCount}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => const PingCountDialog(),
                );
                await appSettings.load();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

}
