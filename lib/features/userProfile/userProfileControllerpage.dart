// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../commons/routerPages/apiPage.dart';
import '../../commons/routerPages/dio.dart';

import '../../commons/widgetsPages/snackBarPage.dart';

final imageProvider = Provider<String>((ref) {
  return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgLoFFWDuNrpPkxtTcERVyDe1vn_tPsmEBbw&usqp=CAU";
});

final profilegetProvider = FutureProvider.autoDispose((ref) async {
  ref.keepAlive();

  var response = await ApiMehtod(ref: ref).postMehtod(url: ApiUser.profile);

  if (response['success'] == true) {
    return response;
  } else if (response['success'] == false) {
    messageField(msg: response["message"]);
    throw "Error: Some technical issue";
  } else {
    messageField(msg: response["message"]);
    throw "Error: Some technical issue";
  }
});
