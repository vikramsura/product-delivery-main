// ignore_for_file: file_names

import 'package:project/all_imports.dart';

buildPushReplacement({required BuildContext context, required Widget widget}) {
  return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

buildPush({required BuildContext context, required Widget widget}) {
  return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

navigatorRemove({context, widget}) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}
