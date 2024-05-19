// ignore_for_file: must_be_immutable, unused_result, file_names, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/all_imports.dart';
import 'package:project/features/authentication/SingUpPage/singUpControllerpage.dart';

class CreateAnAccount extends ConsumerStatefulWidget {
  const CreateAnAccount({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateAnAccountState();
}

class _CreateAnAccountState extends ConsumerState<CreateAnAccount> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textEditorBuild = ref.watch(textControllerProvider.notifier);
    final loader = ref.watch(lodeingSignupprovider);
    final isPassword = ref.watch(showSignupPassword1Provider);
    final isConPassword = ref.watch(showSignupPassword2Provider);
    final dropDownListBuild = ref.watch(dropDownListDataprovider);
    final defaultValueBuild = ref.watch(defaultValueprovider);
    setState(() {
      ref.read(textControllerProvider.notifier);
    });

    return Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 46.h),
                          buildText(
                              text: "Create Account",
                              fontSize: 22.w,
                              color: AppColorText.blue,
                              fontWeight: FontWeight.w500),
                          SizedBox(height: 20.h),
                          buildTextField(context, validation: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Name";
                            } else {
                              return null;
                            }
                          },
                              controllerData: textEditorBuild.nameController,
                              hintText: "Enter Name"),
                          buildTextField(context, validation: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Numbers";
                            } else if (value.length < 10) {
                              return "Please enter 10 digit Number";
                            } else {
                              if (!phoneregExp.hasMatch(value)) {
                                return "Please enter Valid Mobile Number";
                              }
                              return null;
                            }
                          },
                              prifixIcon: SizedBox(
                                  child: Padding(
                                      padding: EdgeInsets.all(12.0.r),
                                      child: Text("+91",
                                          style: TextStyle(
                                              color: AppColorText.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.h)))),
                              maxLength: 10,
                              controllerData: textEditorBuild.numberController,
                              keyboardType: TextInputType.phone,
                              hintText: "Enter Number"),

                          SizedBox(
                            height: 20.h,
                          ),
                          DropdownButtonFormField<String>(
                            borderRadius: BorderRadius.circular(8),
                            // menuMaxHeight: 10,
                            // isDense: true,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(13),
                                isDense: true,
                                // contentPadding: EdgeInsets.only(right: 0),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColorBody.blue),
                                    borderRadius: BorderRadius.circular(12.r)),
                                filled: true,
                                focusColor: AppColorBody.blue,
                                enabled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColorBody.blue),
                                    borderRadius: BorderRadius.circular(12.r)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColorBody.blue),
                                    borderRadius: BorderRadius.circular(12.r)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColorBody.blue),
                                    borderRadius: BorderRadius.circular(12.r)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColorBody.blue),
                                    borderRadius: BorderRadius.circular(12.r)),
                                fillColor: AppColorBody.blue),
                            autofocus: true,
                            // iconEnabledColor: Colors.white,
                            focusColor: AppColorBody.blue,
                            dropdownColor: AppColorBody.blue,
                            isExpanded: true,
                            value: defaultValueBuild,
                            items: [
                              const DropdownMenuItem(
                                value: "",
                                child: Text(
                                  "Select Gender",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ...dropDownListBuild
                                  .map<DropdownMenuItem<String>>((datas) {
                                return DropdownMenuItem(
                                  value: datas['value'],
                                  child: Text(
                                    datas['title'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }),
                            ],
                            onChanged: (salutation) => ref
                                .read(defaultValueprovider.notifier)
                                .state = salutation!,
                            validator: (value) {
                              if (value == null) {
                                return 'field required';
                              } else if (value == "") {
                                return "Please select gender";
                              }
                              return null;
                            },
                          ),
                          //  values==true? if (textEditorBuild.defaultValue == "")
                          //     Text(
                          //       "   Please select gender",
                          //       style: TextStyle(color: Colors.redAccent),
                          //     ):SizedBox(,)
                          buildTextField(context, validation: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Types of Customers";
                            } else {
                              return null;
                            }
                          },
                              controllerData:
                                  textEditorBuild.customersController,
                              hintText: "Type of Customers"),
                          buildTextField(context, validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            // Perform custom password validation here
                            if (value.length < 6) {
                              return "Password must be at least 6 characters long";
                            }
                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              return "Password must contain at least one uppercase letter";
                            }
                            if (!value.contains(RegExp(r'[a-z]'))) {
                              return "Password must contain at least one lowercase letter";
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return "Password must contain at least one numeric character";
                            }
                            if (!value
                                .contains(RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                              return "Password must contain at least one special character";
                            }

                            return null;
                          },
                              controllerData:
                                  textEditorBuild.passwordController,
                              obscureText: isPassword,
                              hintText: "Password",
                              suffixIcon: InkWell(
                                  onTap: () {
                                    ref
                                        .read(showSignupPassword1Provider
                                            .notifier)
                                        .state = isPassword ? false : true;
                                  },
                                  child: Icon(
                                      isPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColorBody.white))),
                          buildTextField(context, validation: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Password";
                            } else if (textEditorBuild.passwordController.text
                                    .trim() !=
                                textEditorBuild.confirmPasswordController.text
                                    .trim()) {
                              return " Password and Confirm Password not Match";
                            } else {
                              return null;
                            }
                          },
                              controllerData:
                                  textEditorBuild.confirmPasswordController,
                              obscureText: isConPassword,
                              hintText: "Confirm Password",
                              suffixIcon: InkWell(
                                  onTap: () {
                                    ref
                                        .read(showSignupPassword2Provider
                                            .notifier)
                                        .state = isConPassword ? false : true;
                                  },
                                  child: Icon(
                                      isConPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColorBody.white))),
                          SizedBox(height: 30.h),
                          InkWell(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  ref
                                      .read(lodeingSignupprovider.notifier)
                                      .state = true;

                                  ref
                                      .read(textControllerProvider.notifier)
                                      .signUpController(context: context);
                                }
                              },
                              child: buildContainerB(
                                  fontSize: 18.w,
                                  color: AppColorBody.white,
                                  borderColor: AppColorBody.blue,
                                  text: "SignUp",
                                  value: loader,
                                  colortext: AppColorText.blue,
                                  circularProgColor: AppColorText.blue)),
                          SizedBox(height: 30.h),
                          Center(
                            child: buildRichText(
                                color: AppColorText.grey,
                                fontSize: 12.w,
                                fontWeight: FontWeight.w400,
                                widget: [
                                  const TextSpan(
                                    text: "Already have an account? ",
                                  ),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context);
                                        },
                                      text: "Login",
                                      style:
                                          TextStyle(color: AppColorText.blue)),
                                ]),
                          ),
                          SizedBox(height: 15.h),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 2.h,
                                    width: 50.w,
                                    color: AppColorBody.grey),
                                SizedBox(width: 14.w),
                                buildText(
                                    text: "Or",
                                    color: AppColorText.black,
                                    fontSize: 14.w,
                                    fontWeight: FontWeight.w400),
                                SizedBox(width: 14.w),
                                Container(
                                    height: 2.h,
                                    width: 50.w,
                                    color: AppColorBody.grey)
                              ]),
                          SizedBox(height: 15.h),
                          Center(
                              child: buildText(
                                  text: "Login With",
                                  color: AppColorText.blue,
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: 30.h),
                          buildContainer(
                              height: 50.h,
                              width: 1.sw,
                              color: AppColorBody.white,
                              borderColor: AppColorBody.blue,
                              borderRadius: 12.w,
                              widget: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                        height: 20.h,
                                        width: 20.w,
                                        image: const AssetImage(
                                            "assets/image/google.png")),
                                    SizedBox(width: 10.w),
                                    buildText(
                                        text: "Continue With Google",
                                        color: AppColorText.blue,
                                        fontSize: 18.w,
                                        fontWeight: FontWeight.w500),
                                  ])),
                          SizedBox(height: 30.h),
                        ])))));
  }
}
