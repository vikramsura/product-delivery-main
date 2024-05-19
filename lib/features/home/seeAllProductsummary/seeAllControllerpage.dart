// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/commons/routerPages/apiPage.dart';

import '../../../commons/routerPages/dio.dart';

final searchProvider = StateProvider.autoDispose<String>((ref) => '');

final categoriesProvider = FutureProvider.autoDispose((ref) async {
  return categories(ref: ref);
});

categories({Ref? ref}) async {
  try {
    var response = await ApiMehtod(ref: ref).postMehtod(url: ApiUser.category);

    if (response['success'] == true) {
      return response;
    } else if (response['success'] == false) {
      throw "Error: Some technical issue";
    } else {
      throw "Error: Some technical issue";
    }

    // }
  } catch (err) {
    return err.toString();
  }
}
