// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/appBarPage.dart';
import 'package:project/features/userProfile/profile_edit_Controller.dart';

import '../../../model/category_model.dart';
import 'seeAllControllerpage.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final categoriesBuild = ref.watch(categoriesProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // toolbarHeight: 100.h,
        title: buildText(
            color: AppColorText.blue,
            text: "Categories",
            fontWeight: FontWeight.w500,
            fontSize: 25.w),
        centerTitle: true,
      ),
      body: categoriesBuild.when(
        skipError: true,
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: true,
        loading: () => loaderCircular(),
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        data: (data) {
          Categrory categrorys = Categrory.fromJson(data);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(children: [
              customTextField(context,
                  // name: "Search",
                  controllerData: searchController,
                  color: AppColorBody.white,
                  colorBorder: AppColorBody.grey,
                  hintText: "Search",
                  hintColor: AppColorBody.grey, onChanged: (value) {
                setState(() {
                  ref.read(searchProvider.notifier).state = value;
                });
              }),
              Expanded(
                child: LayoutBuilder(builder: (context, constraint) {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraint.maxWidth > 500 ? 5 : 3,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 20.h,
                          mainAxisExtent: 140.h),
                      itemCount: categrorys.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (searchController.text.isEmpty) {
                          return Container(
                            height: 130.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColorBody.grey),
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.w,
                                  bottom: 10.w,
                                  top: 15.w,
                                  right: 10.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                        child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage: NetworkImage(categrorys
                                          .data![index].image
                                          .toString()),
                                      backgroundColor: const Color(0xFFC3F7FF),
                                      // child: Image(
                                      //     height: 47.h,
                                      //     width: 33.w,
                                      //     fit: BoxFit.fill,
                                      //     image: NetworkImage(categrorys
                                      //         .data![index].image
                                      //         .toString()))
                                    )),
                                    buildText(
                                        color: AppColorText.black,
                                        text: categrorys.data![index].name,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.w),
                                  ]),
                            ),
                          );
                        } else if (categrorys.data![index].name!
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return Container(
                            height: 130.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColorBody.grey),
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.w,
                                  bottom: 10.w,
                                  top: 15.w,
                                  right: 10.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                        child: CircleAvatar(
                                            radius: 30.r,
                                            backgroundColor:
                                                const Color(0xFFC3F7FF),
                                            child: Image(
                                                height: 47.h,
                                                width: 33.w,
                                                fit: BoxFit.fill,
                                                image: NetworkImage(categrorys
                                                    .data![index].image
                                                    .toString())))),
                                    buildText(
                                        color: AppColorText.black,
                                        text: categrorys.data![index].name,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.w),
                                  ]),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                }),
              ),
            ]),
          );
        },
      ),
    );
  }
}
