import 'package:flutter/material.dart';
import 'package:frontend/widgets/alert/alert.dart';

alertError(context, Widget content) {
  alert(
    context: context,
    title: "Error",
    content: content,
  );
}
