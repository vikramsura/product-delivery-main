// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/routerPages/apiPage.dart';
import '../../commons/routerPages/dio.dart';

final getOrderProvider = FutureProvider.autoDispose((ref) async {
  ref.keepAlive();
  return getOrder(ref: ref);
});

getOrder({Ref? ref}) async {
  try {
    var response = await ApiMehtod(ref: ref).postMehtod(url: ApiUser.getOrder);

    if (response['success'] == true) {
      return response;
    } else {
      throw "Error: Some technical issue";
    }

    // }
  } catch (err) {
    return err.toString();
  }
}

// 0=CANCELED,1=CREATED,2=PREPARING,3=READY,4=DISPATCHED,5=DELIVERED,6=COMPLETED

final statusProvider = StateProvider<Map>((ref) {
  return {
    "0": "Your Order Cancelled",
    "1": "Your Order Create",
    "2": "Your Order Preparing",
    "3": "Your Items Ready",
    "4": "Yor Order Dispatched",
    "5": "Delivered",
    "6": "Complete"
  };
});


