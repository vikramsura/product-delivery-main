// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/features/authentication/SingUpPage/singUpRepoPage.dart';
// import 'package:project/features/authentication/createNewPassword/createNewPaControllerpage.dart';

import '../../../commons/routerPages/navigationPage.dart';
import '../../../commons/widgetsPages/snackBarPage.dart';
import '../otpVerification/otpVerficationScreenPage.dart';

final showSignupPassword1Provider =
    StateProvider.autoDispose<bool>((ref) => true);
final showSignupPassword2Provider =
    StateProvider.autoDispose<bool>((ref) => true);
final lodeingSignupprovider = StateProvider<bool>((ref) => false);

final defaultValueprovider = StateProvider<String>((ref) => '');
final dropDownListDataprovider = StateProvider<List>((ref) => [
      {"title": "Male", "value": "1"},
      {"title": "Female", "value": "2"},
      {"title": "Trans", "value": "0"}
    ]);

final textControllerProvider = StateNotifierProvider.autoDispose((ref) {
  final respo = ref.watch(authApiProvider);
  return TextControllerNotifier(resp: respo, ref: ref);
});

class TextControllerNotifier extends StateNotifier {
  final Authentication resp;
  final Ref ref;
  TextControllerNotifier({required this.ref, required this.resp}) : super('');
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController customersController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String selectedValue = 'Male';
  String selected = '1';

  // String defaultValue = "";
  // List dropDownListData = [
  //   {"title": "Male", "value": "1"},
  //   {"title": "Female", "value": "2"},
  //   {"title": "Trans", "value": "0"}
  // ];

  signUpClear() {
    nameController.clear();
    numberController.clear();
    genderController.clear();
    customersController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  signUpController({required BuildContext context}) async {
    ref.onDispose(() {
      signUpClear();
    });
    Map data = {
      "name": nameController.text.trim(),
      "phone": numberController.text.trim(),
      "gender": ref.read(defaultValueprovider.notifier).state,
      "customers": customersController.text.trim(),
      "password": passwordController.text.trim(),
      "conpassword": confirmPasswordController.text.trim()
    };

    try {
      var response = await resp.createAccount(data: data);

      if (response["status"] == 200) {
        buildPush(
            context: context,
            widget: OtpVerifySignIn(
              number: numberController.text.trim(),
              value: 1,
            ));
        // signUpClear();

        ref.read(lodeingSignupprovider.notifier).state = false;

        messageField(msg: response["message"]);
      } else if (response["status"] == false) {
        messageField(msg: response["msg"]);

        ref.read(lodeingSignupprovider.notifier).state = false;
      }
    } catch (err) {
      ref.read(lodeingSignupprovider.notifier).state = false;

      // messageField(context, "Something went wrong");
    }
  }
}
