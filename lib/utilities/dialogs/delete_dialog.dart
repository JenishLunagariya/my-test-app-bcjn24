import 'package:flutter/material.dart';
import 'package:test_application/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Delete",
    content: "Are you sure want to delete this note?",
    optionsbuilder: () => {
      'Cancel':false,
      'Delete':true,
    },
  ).then((value)=> value ?? false);
}