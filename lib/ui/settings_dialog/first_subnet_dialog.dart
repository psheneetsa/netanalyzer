import 'package:flutter/material.dart';
import 'package:netanalyzer/main.dart';
import 'package:netanalyzer/ui/base_settings_dialog.dart';
import 'package:netanalyzer/values/strings.dart';

class FirstSubnetDialog extends StatefulWidget {
  const FirstSubnetDialog({Key? key}) : super(key: key);

  @override
  _FirstSubnetDialogState createState() => _FirstSubnetDialogState();
}

class _FirstSubnetDialogState extends BaseSettingsDialog<FirstSubnetDialog> {
  @override
  String getDialogTitle() {
    return StringValue.firstSubnet;
  }

  @override
  String getHintText() {
    return StringValue.firstSubnetDesc;
  }

  @override
  TextInputType getKeyBoardType() {
    return TextInputType.number;
  }

  @override
  void onSubmit(String value) {
    final int val = int.parse(value);
    if (val != appSettings.firstSubnet) {
      appSettings.setFirstSubnet(val);
    }
  }

  @override
  String? validate(String? value) {
    if (value == null) return 'Value required';
    try {
      final int val = int.parse(value);
      if (val < 1) {
        return 'Value must be a natural number';
      }
      if (val > appSettings.lastSubnet) {
        return 'Value must be less than last subnet';
      }
    } catch (e) {
      return 'Must be a number';
    }
  }

  @override
  String getInitialValue() {
    return appSettings.firstSubnet.toString();
  }
}
