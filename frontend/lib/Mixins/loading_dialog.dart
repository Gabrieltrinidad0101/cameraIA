import 'package:frontend/widgets/modals/loading_dialog.dart' as dialog;
import 'package:flutter/material.dart';

class LoadingDialog {
  showLoadingDialog(context, key) {
    dialog.showLoadingDialog(context, key);
  }

  hiddenLoadingDialog(key) {
    final BuildContext? dialogContext = key.currentContext;
    if (dialogContext != null) {
      Navigator.of(dialogContext, rootNavigator: true).pop();
    }
  }
}
