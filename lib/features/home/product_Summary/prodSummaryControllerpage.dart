// ignore_for_file: unused_result, file_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/commons/routerPages/dio.dart';

import '../../../commons/routerPages/apiPage.dart';

import '../../../commons/widgetsPages/snackBarPage.dart';
import '../../carts/cartControllerpage.dart';



final currentpageProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

final productVarProvider = StateNotifierProvider.autoDispose((ref) {
  return ProductsNotifier();
});

class ProductsNotifier extends StateNotifier {
  ProductsNotifier() : super("");

  // int? allTotal;

  // bool loader = false;

  int addProduct = 1;

  increement({required rsProduct}) {
    state = (rsProduct * addProduct);
  }
}

Dio dio = Dio();
final addCartProvider =
    Provider.autoDispose.family((ref, add) => addToCart(ref: ref, data: add));

addToCart({data, Ref? ref}) async {
  try {
    // final token1 = await ref!.read(storageProvider).readData('token');

    // Response response = await dio.post(ApiUser.addcart,
    //     data: data,
    //     options: Options(headers: {'Authorization': 'Bearer $token1'}));
    ref!.refresh(getCartProvider);
    var responses =
        await ApiMehtod(ref: ref).putMethod(url: ApiUser.addcart, data: data);

    ref.refresh(getCartProvider);
    if (responses['success'] == true) {
      log("::::::::::::::::FFF::::::::::");

      messageField(msg: responses["message"], snacColor: Colors.green);

      throw responses;
    }
    throw "No Data";
  } catch (e) {
    return e.toString();
  }
}
