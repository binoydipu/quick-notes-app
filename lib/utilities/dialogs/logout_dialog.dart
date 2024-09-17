import 'package:dummy/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Log out',
    content: 'Are you sure you want to log out',
    optionBuilder: () => {
      'Cancle': false,
      'Log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
