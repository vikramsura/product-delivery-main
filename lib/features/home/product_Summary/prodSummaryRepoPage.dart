// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/main.dart';

import '../../../commons/routerPages/apiPage.dart';
import '../../../commons/widgetsPages/flutter_secure_token.dart';

import '../../../commons/widgetsPages/snackBarPage.dart';
import '../../authentication/loginPage/loginScreenPage.dart';
import 'prodSummaryControllerpage.dart';

// final pricessProvider = Provider.autoDispose((ref) => singleProduct());

final singleProductProvider =
    FutureProvider.autoDispose.family((ref, id) async {
  return SingleProductItem(id: id, ref: ref).singleProduct();
});
// List<SingleProduct> singleProductList = [];

class SingleProductItem {
  var id;
  Ref? ref;
  SingleProductItem({this.id, this.ref});

  Future singleProduct() async {
    // ref!.onDispose(() {
    //   singleProductList = [];
    // });
    var data = FormData.fromMap({'product_id': id});
    try {
      final token1 = await ref!.read(storageProvider).readData('token');

      Response response = await dio.post(ApiUser.singleProduct,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token1'}));
      print("res r $response");
      if (response.statusCode == 200) {
        if (response.data['success'] == true) {
          return response.data;
        }
      } else if (response.data['status'] == false) {
        throw "Error: Some technical issue";
      } else if (response.statusCode == 401) {
        navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        // navigatorRemove(context: context, widget: LoginPage());
        throw messageField(msg: response.data['message']);
      } else if (response.statusCode == 400) {
        throw "Some technical issue";
      } else if (response.statusCode == 404) {
        throw "Some technical issue";
      } else {
        throw 'Error: Some technical issue';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
