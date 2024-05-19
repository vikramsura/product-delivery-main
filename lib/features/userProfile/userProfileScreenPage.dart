// ignore_for_file: file_names

import 'package:easy_image_viewer/easy_image_viewer.dart';

import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/appBarPage.dart';
import 'Change_Password/change_password_screen.dart';
import 'profile_edit.dart';

import 'userProfileControllerpage.dart';

class UserProfilePage extends ConsumerWidget {
  final bool backbutton;
  const UserProfilePage({super.key, this.backbutton = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileDetails = ref.watch(profilegetProvider);
    final imagesPath = ref.watch(imageProvider);

    return profileDetails.when(
        skipError: true,
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        loading: () => loaderCircular(),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (data) {
          return Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: backbutton == true ? true : false,
                  title: buildText(
                      color: AppColorText.black,
                      text: "User Profile",
                      fontWeight: FontWeight.w500,
                      fontSize: 25.w),
                  centerTitle: true,
                  actions: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfilePage(data: data)));
                          // ref.read(stateProvider.call(context));

                          // ref
                          //     .read(profileEditProvider.notifier)
                          //     .stateData(context: context);
                        },
                        child: ImageIcon(
                            const AssetImage("assets/image/edit.png"),
                            color: AppColorBody.black)),
                    SizedBox(width: 30.w)
                  ]),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40.h),
                            Center(
                                child: SizedBox(
                                    width: 80.w,
                                    height: 80.h,
                                    child: Stack(children: [
                                      DottedBorder(
                                          borderType: BorderType.Circle,
                                          color: AppColorBody.black,
                                          padding: EdgeInsets.zero,
                                          dashPattern: [8.w, 4.w],
                                          strokeWidth: 4.w,
                                          child: imagesPath.isEmpty
                                              ? CircleAvatar(
                                                  radius: 35.r,
                                                  backgroundColor: AppColorBody
                                                      .blue)
                                              : InkWell(
                                                  onTap: () {
                                                    showImageViewer(
                                                        backgroundColor:
                                                            Colors.white60,
                                                        useSafeArea: true,
                                                        context,
                                                        NetworkImage(
                                                            data['data']
                                                                    ['image']
                                                                .toString(),
                                                            scale: 0.10),
                                                        swipeDismissible: true,
                                                        doubleTapZoomable:
                                                            true);
                                                  },
                                                  child: CircleAvatar(
                                                      radius: 35.r,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              data['data']
                                                                      ['image']
                                                                  .toString(),
                                                              scale: 0.10))))
                                    ]))),
                            Center(
                              child: buildText(
                                  color: AppColorText.black,
                                  text: data['data']['name'],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.w),
                            ),
                            SizedBox(height: 20.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Wallet = ",
                                  style: TextStyle(color: AppColorBody.blue),
                                ),
                                Text(data['data']['wallet']['amount']),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            buildText(
                                color: AppColorText.black,
                                text: "Mobile Number",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.w),
                            buildText(
                                color: AppColorText.black,
                                text: "${data['data']['country_code']}"
                                    " "
                                    "${data['data']['phone']}",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.w),
                            SizedBox(height: 10.h),
                            Divider(color: AppColorBody.grey, thickness: 1.w),
                            buildText(
                                color: AppColorText.black,
                                text: "Address",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.w),
                            buildText(
                                color: AppColorText.black,
                                text: data['data']['address'] == ""
                                    ? ""
                                    : "${data['data']['address']['address']}, ${data['data']['address']['city_name']}, ${data['data']['address']['state_name']}, ${data['data']['address']['pincode']}",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.w),
                            SizedBox(height: 10.h),
                            Divider(color: AppColorBody.grey, thickness: 1.w),
                            buildText(
                                color: AppColorText.black,
                                text: "Email",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.w),
                            buildText(
                                color: AppColorText.black,
                                text: data['data']['email'].toString(),
                                fontWeight: FontWeight.w400,
                                fontSize: 14.w),
                            SizedBox(height: 10.h),
                            Divider(color: AppColorBody.grey, thickness: 1.w),
                            SizedBox(height: 25.h),
                            InkWell(
                              onTap: () {
                                buildPush(
                                    context: context,
                                    widget: const ChangePasswordScreen());
                              },
                              child: Row(children: [
                                Icon(Icons.lock_outline,
                                    color: AppColorBody.grey),
                                SizedBox(width: 5.w),
                                buildText(
                                    color: AppColorText.black,
                                    text: "Change Password",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.w),
                                const Spacer(),
                                Icon(Icons.arrow_forward_ios,
                                    color: AppColorBody.grey)
                              ]),
                            ),
                            Divider(color: AppColorBody.grey, thickness: 1.w),
                            SizedBox(height: 25.h),
                            // Row(children: [
                            //   Icon(CupertinoIcons.creditcard_fill,
                            //       color: AppColorBody.grey),
                            //   SizedBox(width: 5.w),
                            //   buildText(
                            //       color: AppColorText.black,
                            //       text: "Select Default Payment Card",
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 14.w),
                            //   const Spacer(),
                            //   Icon(Icons.arrow_forward_ios,
                            //       color: AppColorBody.grey)
                            // ]),
                            // Divider(color: AppColorBody.grey, thickness: 1.w),
                          ]))));
        });
  }

  Widget buildTextFormField(
      {controller, keyboardType, readOnly, maxLines, maxLength}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
      child: TextFormField(
        maxLines: maxLines,
        maxLength: maxLength,
        readOnly: readOnly ?? false,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.multiline,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(bottom: 20.h),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorBody.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColorBody.grey)),
        ),
      ),
    );
  }
}
