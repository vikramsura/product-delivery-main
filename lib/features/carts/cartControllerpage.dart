// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore_for_file: deprecated_member_use, unused_result, prefer_typing_uninitialized_variables, file_names

import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/commons/routerPages/dio.dart';
import 'package:project/commons/widgetsPages/ColorPage.dart';

import '../../commons/routerPages/apiPage.dart';
import '../../commons/widgetsPages/snackBarPage.dart';

Dio dio = Dio();

final cartEditProvider =
    StateNotifierProvider.autoDispose((ref) => CartEditNotifier(ref: ref));

class CartEditNotifier extends StateNotifier {
  Ref ref;

  CartEditNotifier({required this.ref}) : super('');

  cartEdit({data}) async {
    try {
      var response = await ApiMehtod(ref: ref)
          .putMethod(url: ApiUser.editCart, data: data);

      if (response['success'] == true) {
        ref.refresh(getCartProvider);
        return response;
      } else if (response['success'] == false) {
        return messageField(msg: response['message']);
      } else {
        throw 'Some technical issue';
      }
    } catch (e) {
      return e.toString();
    }
  }

  deleteCart({id}) async {
    try {
      Map data = {'cart_id': id};

      var response = await ApiMehtod(ref: ref)
          .putMethod(url: ApiUser.deleteCart, data: data);

      if (response['success'] == true) {
        ref!.refresh(getCartProvider);
        messageField(msg: response["message"], snacColor: AppColorBody.red);
        data.clear();
        return response;
      } else if (response['success'] == false) {
        return messageField(msg: response['message']);
      } else {
        return 'Some technical issue';
      }
    } catch (e) {
      return e.toString();
    }
  }

  getCart() async {
    // final token1 = await ref!.watch(storageProvider).readData('token');
    // var headers = {'Authorization': 'Bearer $token1'};
    try {
      //   Response response = await dio.post(ApiUser.getCart,
      //       options: Options(method: 'POST', headers: headers));
      var response = await ApiMehtod(ref: ref).postMehtod(url: ApiUser.getCart);

      // if (response.statusCode == 200) {
      // return response.data;

      if (response['success'] == true) {
        return response;
      } else if (response['success'] == false) {
        throw messageField(msg: response['message']);
      } else {
        throw 'Error: Some technical issue';
      }
    } catch (error) {
      return error.toString();
    }
  }
}

final cartDeleteProvider = Provider.autoDispose
    .family((ref, id) => CartEditNotifier(ref: ref).deleteCart(id: id));

final getCartProvider = FutureProvider.autoDispose((ref) {
  ref.notifyListeners();
  return CartEditNotifier(ref: ref).getCart();
});

final changeData = StateProvider.autoDispose((ref) => true);
final addProductProvider = StateProvider.autoDispose((ref) => 1);

final cartQuantityProvider = StateNotifierProvider.autoDispose((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier {
  CartNotifier() : super('');
  bool loader = false;

  int addProduct = 1;
  void increement({required rsProduct}) {
    state = (rsProduct * addProduct);
  }
}
