import 'package:flutter/cupertino.dart';

import 'generic_dialog.dart';

Future<void> showErrorDialog (
  BuildContext context, 
  String content,
  String heading,
  ) {
  return showGenericDialog(context: context,
    title: heading, 
    content: content, 
    optionsBuilder: () => {
      'OK' : null,
    }
  );
}