// ignore_for_file: must_be_immutable, unused_result, file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/all_imports.dart';

// import '../SingUpPage/singUpControllerpage.dart';
import 'loginControllerpage.dart';

// import 'loginRepoPage.dart';

String pattern = r'^[1-9]\d{9}$';
RegExp phoneregExp = RegExp(pattern);

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final RegExp phoneRegExp = RegExp(r'^\d{10}$');
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(loadingProvider);
    final isShow = ref.watch(showLoginPasswordProvider);
    final loginControllerBuild = ref.watch(loginTextFieldProvider.notifier);
    setState(() {
      ref.read(loginTextFieldProvider.notifier);
    });
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                color: AppColorBody.blue,
                height: 106.h,
              ),
              Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        color: AppColorBody.blue,
                        image: const DecorationImage(
                            image: AssetImage("assets/image/login.png"),
                            fit: BoxFit.fill)),
                    child: Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Form(
                            key: _formkey,
                            child: Column(children: [
                              buildText(
                                  text: "  Welcome.",
                                  fontSize: 24.w,
                                  color: AppColorText.white,
                                  fontWeight: FontWeight.w500),
                              buildText(
                                  text: "     Gold to see you!.",
                                  fontSize: 24.w,
                                  color: AppColorText.white,
                                  fontWeight: FontWeight.w400),
                              SizedBox(
                                height: 183.h,
                              ),
                              buildTextField(validation: (value) {
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
                                  context,
                                  maxLines: 1,
                                  maxLength: 10,
                                  controllerData:
                                      loginControllerBuild.phoneController,
                                  keyboardType: TextInputType.phone,
                                  hintText: "Enter Number"),
                              SizedBox(height: 5.h),
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
                                if (!value.contains(
                                    RegExp(r'[!@#\$%^&*()<>?/|}{~:]'))) {
                                  return "Password must contain at least one special character";
                                }

                                return null;
                              },
                                  controllerData:
                                      loginControllerBuild.passwordController,
                                  obscureText: isShow,
                                  hintText: "Password",
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      ref
                                          .read(showLoginPasswordProvider
                                              .notifier)
                                          .state = isShow ? false : true;
                                    },
                                    child: Icon(
                                      isShow
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: AppColorBody.white,
                                    ),
                                  )),
                              SizedBox(
                                height: 8.h,
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                      onTap: () {
                                        buildPush(
                                            context: context,
                                            widget: const ForgotPassword());
                                      },
                                      child: buildText(
                                          text: "Forgot Password",
                                          fontSize: 14.w,
                                          color: AppColorText.black,
                                          fontWeight: FontWeight.w400))),
                              SizedBox(height: 20.h),
                              InkWell(
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      ref.read(loadingProvider.notifier).state =
                                          true;

                                      ref
                                          .read(loginTextFieldProvider.notifier)
                                          .loginController(context: context);

                                      // ref
                                      //     .refresh(loginTextFieldProvider)
                                      //     .dispose();
                                    }
                                  },
                                  child: buildContainerB(
                                    fontSize: 18.w,
                                    color: AppColorBody.white,
                                    borderColor: AppColorBody.blue,
                                    value: loader,
                                    text: "Login",
                                    colortext: AppColorText.blue,
                                    circularProgColor: AppColorText.blue,
                                  )),
                              SizedBox(height: 20.h),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAnAccount(),
                                        ));
                                  },
                                  child: buildText(
                                      text: "Create Account",
                                      fontSize: 18.w,
                                      color: AppColorText.blue,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 20.h)
                            ]))))
              ])
            ])));
  }
}
