// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:project/all_imports.dart';
// import 'package:project/features/home/homeRepoPage.dart';
import 'package:project/features/home/home_src.dart';
import 'package:project/features/home/seeAllProductsummary/CategoriesPage.dart';
import 'package:project/main.dart';

import 'homeRepoPage.dart';
import 'product_Summary/prodSummaryControllerpage.dart';

// import 'homeControllerpage.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var homeapiBuild = ref.watch(homeApiProvider);

    return RefreshIndicator.adaptive(
      color: AppColorBody.blue,
      onRefresh: () => ref.refresh(homeApiProvider.future),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerWidget(),
        body: homeapiBuild.when(
          skipError: true,
          skipLoadingOnReload: true,
          skipLoadingOnRefresh: true,
          loading: () => Center(
              child: CircularProgressIndicator(color: AppColorBody.blue)),
          data: (data) {
            // ProductsModel profileData = ProductsModel.fromJson(data);

            return Container(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 28.h),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _scaffoldKey.currentState?.openDrawer();
                                      },
                                      child: ImageIcon(
                                        const AssetImage(
                                            "assets/home/homeTop.png"),
                                        size: 36.w,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildText(
                                              color: AppColorText.black,
                                              text: "Deliver to",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.w),
                                          InkWell(
                                            onTap: () => _scaffoldKey
                                                .currentState
                                                ?.openDrawer(),
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  buildText(
                                                      color: AppColorText.black,
                                                      text:
                                                          "Luminous tower sheikhghetv",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.w),
                                                  const Icon(
                                                      Icons.keyboard_arrow_down)
                                                ]),
                                          )
                                        ]),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        navigatorKey.currentState?.push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Bottombar(navigate: 1)));
                                      },
                                      child: Icon(
                                        Icons.search,
                                        size: 30.w,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 21.h,
                                ),
                                SizedBox(
                                  width: 250.w,
                                  child: buildRichText(
                                      color: AppColorText.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25.w,
                                      widget: [
                                        const TextSpan(text: "Get your"),
                                        TextSpan(
                                            text: " Milk ",
                                            style: TextStyle(
                                              color: AppColorText.blue,
                                            )),
                                        const TextSpan(
                                            text: "delivered quickly"),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25.h),
                          SizedBox(
                            width: 1.sw,
                            height: 150.h,
                            child: CarouselSlider.builder(
                              options: CarouselOptions(
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  onPageChanged: (index, reason) {
                                    ref
                                        .read(currentpageProvider.notifier)
                                        .state = index;
                                  },
                                  scrollDirection: Axis.horizontal),
                              itemCount: homedataList[0].data!.category!.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  SizedBox(
                                height: 150,
                                width: 315.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    // height: 47.h,
                                    // width: 315.w,
                                    imageUrl: homedataList[0]
                                        .data!
                                        .category![itemIndex]
                                        .image
                                        .toString(),
                                    placeholder: (context, url) =>
                                        const SizedBox(),
                                    errorWidget: (context, url, error) =>
                                        new Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: homedataList[0].data!.category!.length,
                              itemBuilder: (context, outerIndex) {
                                var itemData =
                                    homedataList[0].data!.category![outerIndex];
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          buildText(
                                              color: AppColorText.blue,
                                              text: itemData.name.toString(),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.w),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              buildPush(
                                                  context: context,
                                                  widget: CategoriesPage());
                                            },
                                            child: buildText(
                                                color: AppColorText.grey,
                                                text: "See All",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.w),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 14.h,
                                      ),
                                      SizedBox(
                                          height: 200.h,
                                          width: 1.sw,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  itemData.products?.length,
                                              itemBuilder:
                                                  (context, innerIndex) {
                                                var item = itemData
                                                    .products![innerIndex];
                                                var discount =
                                                    "${double.parse(item.price.toString()) - double.parse(item.discount.toString())}";

                                                return InkWell(
                                                  onTap: () {
                                                    buildPush(
                                                        context: context,
                                                        widget: Product_Summary(
                                                            values: true,
                                                            id: item.id));
                                                  },
                                                  child: buildImage(
                                                      network:
                                                          item.image.toString(),
                                                      text: item.product,
                                                      // ?.subcategories,
                                                      textRs:
                                                          discount.toString(),
                                                      canRs: item.price
                                                          .toString()),
                                                );
                                              })),
                                      SizedBox(height: 14.h)
                                    ]));
                              })
                        ])));
          },
          error: (error, stackTrace) {
            return Center(child: Text("$error"));
          },
        ),
      ),
    );
  }

  Widget buildRow({navigator, widgets, text, imageIcon}) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: InkWell(
        onTap: () {
          buildPush(context: context, widget: navigator);
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: 10.w,
          ),
          ImageIcon(
            AssetImage(imageIcon),
            color: AppColorBody.white,
            size: 20.w,
          ),
          SizedBox(width: 14.w),
          buildText(
              color: AppColorText.white,
              text: text,
              fontWeight: FontWeight.w500,
              fontSize: 14.w),
          const Spacer(),
          widgets ?? const SizedBox()
        ]),
      ),
    );
  }
}
