import 'package:frontend/widgets/alert/info.dart';

alertError(context, String messageError) {
  alertInfo(
    context: context,
    title: "Error",
    description: messageError,
  );
}
