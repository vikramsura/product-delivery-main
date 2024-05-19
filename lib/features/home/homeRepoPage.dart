// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../commons/routerPages/apiPage.dart';
import '../../commons/routerPages/dio.dart';
import '../../model/ProductModel.dart';

final homeApiProvider = FutureProvider.autoDispose((ref) {
  ref.keepAlive();

  return getProduct(ref: ref);
});
List<ProductsModel> homedataList = [];
getProduct({required Ref ref}) async {
  try {
    var response = await ApiMehtod(ref: ref).postMehtod(url: ApiUser.products);
    if (response['success'] == true) {
      ProductsModel profileData = await ProductsModel.fromJson(response);
      homedataList.add(profileData);

      return response;
    } else if (response['success'] == false) {
      throw "Error: Some technical issue";
    } else {
      throw "Error: Some technical issue";
    }
  } catch (err) {
    return err.toString();
  }
}
