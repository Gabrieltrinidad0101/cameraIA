import 'package:frontend/widgets/modals/loadingDialog.dart' as Dialog;
import 'package:flutter/material.dart';

class LoadingDialog {
  showLoadingDialog(context, key) {
    Dialog.showLoadingDialog(context, key);
  }

  hiddenLoadingDialog(key) {
    final BuildContext? dialogContext = key.currentContext;
    if (dialogContext != null) {
      Navigator.of(dialogContext, rootNavigator: true).pop();
    }
  }
}
