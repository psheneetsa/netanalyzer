import 'package:flutter/material.dart';
import 'package:netanalyzer/main.dart';
import 'package:netanalyzer/ui/base_settings_dialog.dart';
import 'package:netanalyzer/values/strings.dart';

class SocketTimeoutDialog extends StatefulWidget {
  const SocketTimeoutDialog({Key? key}) : super(key: key);

  @override
  _SocketTimeoutDialogState createState() => _SocketTimeoutDialogState();
}

class _SocketTimeoutDialogState
    extends BaseSettingsDialog<SocketTimeoutDialog> {
  @override
  String getDialogTitle() {
    return StringValue.socketTimeout;
  }

  @override
  String getHintText() {
    return StringValue.socketTimeoutdesc;
  }

  @override
  TextInputType getKeyBoardType() {
    return TextInputType.number;
  }

  @override
  void onSubmit(String value) {
    final int val = int.parse(value);
    if (val != appSettings.socketTimeout) {
      appSettings.setSocketTimeout(val);
    }
  }

  @override
  String? validate(String? value) {
    if (value == null) return 'Value required';
    try {
      final int val = int.parse(value);
      if (val < 1) {
        return 'Should be a natural number';
      }
    } catch (e) {
      return 'Must be a number';
    }
  }

  @override
  String getInitialValue() {
    return appSettings.socketTimeout.toString();
  }
}
