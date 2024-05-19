// ignore_for_file: file_names


import 'package:dio/dio.dart';

import 'package:project/all_imports.dart';
import 'package:project/commons/routerPages/dio.dart';

import '../../../main.dart';


final edit1Provider = StateProvider((ref) => true);
final edit2Provider = StateProvider((ref) => true);
final checkoutProvider = StateProvider((ref) => 0);
final onTapProvider = StateProvider((ref) => 1);
// ignore_for_file: file_names, avoid_print

final createOrderProvider = Provider.autoDispose((ref) {
  return OrderProduct(ref: ref);
});

class OrderProduct {
  final Ref ref;
  OrderProduct({required this.ref});

  Future createOrder({paymentMethod, cartId}) async {
    Map<dynamic, dynamic> data = {
      "payment_method": paymentMethod,
      "cart_id": cartId
    };
    try {
      var response = await ApiMehtod(ref: ref)
          .putMethod(url: ApiUser.createOreder, data: data);

      ref.refresh(getCartProvider.future).asStream();

      if (response['success'] == true) {
        print("datassss   @@%%%   $data");
        messageField(msg: response['message']);
        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: (context) => const OrderPlacedSuccessfull()));
        // buildPush(context: context, widget: const OrderPlacedSuccessfull());
        return response;
      } else if (response['success'] == false) {
        messageField(msg: response['message']);
        throw "No data";
      } else {
        throw messageField(msg: response["message"]);
      }
    } catch (error) {
      return error.toString();
    }
  }
}

final getAdressProvider = FutureProvider.autoDispose((ref) async {
  return getAdress(ref: ref);
});

getAdress({required Ref ref}) async {
  try {
    var response = await ApiMehtod(ref: ref).getMehtod(url: ApiUser.getAddress);

    if (response['success'] == true) {
      return response;
    } else if (response['success'] == false) {
      messageField(msg: response['message']);
      throw "Error: Some technical issue";
    } else {
      throw 'Error: Some technical issue';
    }
  } catch (error) {
    return error.toString();
  }
}

final walletProvider = FutureProvider.family((ref, ammount) {
  return wallet(ref: ref, amount: ammount);
});

wallet({Ref? ref, amount}) async {
  try {
    var response = await ApiMehtod(ref: ref).postMehtod(url: ApiUser.wallet);

    if (response['success'] == true) {
      messageField(msg: response['message']);
      if (int.parse(response['data']['amount'].toString()) > amount) {
        print('rrrrEE');
      } else {
        print("OP");
      }

      return response;
    } else if (response['success'] == false) {
      throw messageField(msg: response['message']);
    }
  } on DioException catch (e) {
    messageField(msg: "Something went wrong");

    return e.toString();
  }
}
