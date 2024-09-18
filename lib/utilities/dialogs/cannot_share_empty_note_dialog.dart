import 'package:dummy/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/widgets.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You cannot share empty note!',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
