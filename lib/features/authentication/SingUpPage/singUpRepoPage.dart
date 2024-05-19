// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/commons/routerPages/dio.dart';
import '../../../commons/routerPages/apiPage.dart';
import '../../../commons/widgetsPages/snackBarPage.dart';

import 'singUpControllerpage.dart';

final authApiProvider =
    Provider<Authentication>((ref) => Authentication(ref: ref));

class Authentication {
  final Ref ref;

  Authentication({
    required this.ref,
  });
  createAccount({required Map data}) async {
    try {
      var response = await ApiMehtod(ref: ref).putMethod(
        url: ApiUser.signUpApi,
        data: data,
      );
      dynamic datas = jsonEncode(response);
      dynamic res = jsonDecode(datas);

      ref.read(lodeingSignupprovider.notifier).state = false;

      return res;
    } on DioException catch (e) {
      messageField(msg: "Something went wrong");
      ref.read(lodeingSignupprovider.notifier).state = false;
      return e.toString();
    }
  }

  Future loginApi({Map? data}) async {
    try {
      var response = await ApiMehtod(ref: ref)
          .putMethod(url: ApiUser.logInApi, data: data!);

      return response;
    } on DioException catch (err) {
      messageField(msg: "Something went wrong");

      return err;
    }
  }
}
