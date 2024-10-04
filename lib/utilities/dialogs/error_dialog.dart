import 'package:flutter/material.dart';
import 'package:test_application/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: "An Error Occured!!",
    content: text,
    optionsbuilder: () => {
      'OK':null,
    },
  );
}
