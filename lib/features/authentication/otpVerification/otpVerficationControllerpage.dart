// ignore_for_file: use_build_context_synchronously, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/commons/routerPages/dio.dart';
import 'package:project/commons/routerPages/navigationPage.dart';

import '../../../commons/routerPages/apiPage.dart';
import '../../../commons/widgetsPages/bottomBarPage.dart';
import '../../../commons/widgetsPages/flutter_secure_token.dart';
import '../../../commons/widgetsPages/snackBarPage.dart';
import '../createNewPassword/createNewPaScreenPage.dart';

final loaderOtpProvider = StateProvider<bool>((ref) {
  return false;
});
final sendOptProvider = Provider.autoDispose<OtpGenerate>((ref) {
  return OtpGenerate(ref: ref);
});

class OtpGenerate {
  Ref? ref;
  OtpGenerate({this.ref});
  otpSend({required data}) async {
    try {
      var response = await ApiMehtod(ref: ref)
          .putMethod(url: ApiUser.createVerify, data: data);
      return response;
      // Dio dio = Dio();
      // var response = await dio.post(ApiUser.createVerify, data: data);

      // if (response.statusCode == 200) {
      //   return response.data;
      // }
      // // }
      // return "please valid otp";
    } catch (err) {
      return err.toString();
    }
  }
}

final otpProvider = StateNotifierProvider.autoDispose((ref) {
  final reso = ref.watch(sendOptProvider);
  // final loader = ref.watch(loaderOtpProvider);
  return OtpSendNotifier(ref: ref, res: reso);
});

class OtpSendNotifier extends StateNotifier {
  // var otpCode;
  final OtpGenerate res;
  final Ref ref;

  OtpSendNotifier({
    required this.ref,
    required this.res,
    // this.otpCode,
  }) : super('');

  otpSendprovider(
      {required BuildContext context,
      number,
      otpCode,
      required int value}) async {
    ref.onDispose(() {
      // otpCode = '';
    });

    ref.read(loaderOtpProvider.notifier).state = true;

    var data = {"phone": number, "login_otp": otpCode, 'type': value};
    print("opt   $data");
    var response = await res.otpSend(data: data);

    if (value == 0) {
      if (response['success'] == true) {
        buildPush(context: context, widget: CreateNewPassword(noPhone: number));

        ref.invalidate(loaderOtpProvider);
        ref.read(loaderOtpProvider.notifier).state = false;
      } else if (response['success'] == false) {
        ref.read(loaderOtpProvider.notifier).state = false;
        return messageField(msg: response["message"]);
      }
    } else if (value == 1) {
      if (response['success'] == true) {
        String token = await response['data']['access_token'];
        await ref.read(storageProvider).writeData(key: 'token', value: token);
        messageField(msg: response["message"]);

        navigatorRemove(context: context, widget: Bottombar(navigate: 0));
        ref.read(loaderOtpProvider.notifier).state = false;

        ref.invalidate(loaderOtpProvider);
      } else if (response['success'] == false) {
        ref.read(loaderOtpProvider.notifier).state = false;
        return messageField(msg: response["message"]);
      }
    } else {
      if (response['success'] == true) {
        // messageField('invalide OTP');
        ref.read(loaderOtpProvider.notifier).state = false;
        ref.invalidate(loaderOtpProvider);
        return messageField(msg: response["message"]);
      } else if (response['success'] == false) {
        ref.read(loaderOtpProvider.notifier).state = false;
        return messageField(msg: response["message"]);
      }
      ref.read(loaderOtpProvider.notifier).state = false;
    }
    ref.read(loaderOtpProvider.notifier).state = false;
  }
}
