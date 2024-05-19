// ignore_for_file: camel_case_types, must_be_immutable, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, unused_local_variable, unnecessary_brace_in_string_interps, use_build_context_synchronously, file_names, unused_result

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:project/all_imports.dart';
import 'package:project/commons/widgetsPages/appBarPage.dart';

import '../../../model/single_Product.dart';

import '../../userProfile/userProfileScreenPage.dart';
import '../seeAllProductsummary/CategoriesPage.dart';
import 'prodSummaryControllerpage.dart';
import 'prodSummaryRepoPage.dart';

final loaderData = StateProvider.autoDispose((ref) => false);

class Product_Summary extends ConsumerStatefulWidget {
  dynamic id;
  bool values;
  Product_Summary({super.key, this.id, required this.values});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Product_SummaryState();
}

class _Product_SummaryState extends ConsumerState<Product_Summary> {
  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(loaderData);
    final isChange = ref.watch(changeData);
    final productVarBuild = ref.watch(productVarProvider);
    final productSummeryBuild =
        ref.watch(singleProductProvider.call(widget.id));
    final currentPageBuild = ref.watch(currentpageProvider);

    return Scaffold(
      body: widget.values == true
          ? productSummeryBuild.when(
              skipError: true,
              skipLoadingOnReload: true,
              skipLoadingOnRefresh: true,
              loading: () => loaderCircular(),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              data: (data) {
                SingleProduct singleProductList = SingleProduct.fromJson(data);
                // print("oosss  $singleProductList");
                // SingleProduct singleProduct = SingleProduct.fromJson(data);

                var body = singleProductList.data!.productDetails!;
                String price =
                    "${double.parse(body.price.toString()) - double.parse(body.discount.toString())}";

                List<String> item = [
                  body.image.toString(),
                  body.image.toString()
                ];
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    const Align(
                        alignment: Alignment.centerLeft, child: BackButton()),
                    Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(height: 10.h),
                              // InkWell(
                              //     onTap: () {
                              //       Navigator.pop(context);
                              //     },
                              //     child: Icon(Icons.clear_outlined,
                              //         color: AppColorBody.white, size: 20.h)),
                              Center(
                                  child: SizedBox(
                                      // width: 204.w,
                                      // height: 200.h,
                                      child: CarouselSlider(
                                          items: item.map((e) {
                                            return CachedNetworkImage(
                                              height: 47.h,
                                              imageUrl: e,
                                              placeholder: (context, url) =>
                                                  const SizedBox(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            );
                                            //  Image.network(e);
                                          }).toList(),
                                          options: CarouselOptions(
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  const Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 800),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              onPageChanged: (index, reason) {
                                                ref
                                                    .read(currentpageProvider
                                                        .notifier)
                                                    .state = index;
                                              },
                                              scrollDirection:
                                                  Axis.horizontal)))),
                              SizedBox(height: 16.h),
                              // Center(
                              //     child: DotsIndicator(
                              //         decorator: DotsDecorator(
                              //             spacing: EdgeInsets.all(4.w),
                              //             activeColor: AppColorBody.blue),
                              //         dotsCount: item.length,
                              //         position: currentPageBuild)),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      height: 40.h,
                                      width: 170.w,
                                      child: buildText(
                                          color: AppColorText.black,
                                          fontSize: 18.w,
                                          text: singleProductList
                                              .data!.productDetails!.product
                                              .toString(),
                                          fontWeight: FontWeight.w400)),
                                  buildText(
                                      color: AppColorText.black,
                                      fontSize: 14.w,
                                      text:
                                          "\u{20B9} ${productVarBuild.toString().isNotEmpty ? double.parse(productVarBuild.toString()).toStringAsFixed(2) : price}",
                                      fontWeight: FontWeight.w400),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  buildText(
                                      color: AppColorText.grey,
                                      fontSize: 16.w,
                                      text: "${body.quantity} ${body.unitType}",
                                      fontWeight: FontWeight.w400),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      ref
                                                  .read(productVarProvider
                                                      .notifier)
                                                  .addProduct ==
                                              1
                                          ? const SizedBox()
                                          : ref
                                              .read(productVarProvider.notifier)
                                              .addProduct--;
                                      ref
                                          .read(productVarProvider.notifier)
                                          .increement(
                                              rsProduct: double.parse(
                                                  price.toString()));
                                      ref
                                          .refresh(changeData.notifier)
                                          .update((state) => true);
                                    },
                                    child: Container(
                                      width: 25.w,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        color: const Color(0x6545C8DC),
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.remove,
                                        color: AppColorBody.blue,
                                      )),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  buildText(
                                      color: AppColorText.grey,
                                      fontSize: 16.w,
                                      text: ref
                                          .read(productVarProvider.notifier)
                                          .addProduct
                                          .toString(),
                                      fontWeight: FontWeight.w400),
                                  SizedBox(width: 10.w),
                                  InkWell(
                                    onTap: () {
                                      ref
                                          .read(productVarProvider.notifier)
                                          .addProduct++;
                                      ref
                                          .read(productVarProvider.notifier)
                                          .increement(
                                              rsProduct: double.parse(
                                                  price.toString()));
                                      ref
                                          .refresh(changeData.notifier)
                                          .update((state) => true);
                                    },
                                    child: Container(
                                      width: 25.w,
                                      height: 25.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        color: const Color(0x6545C8DC),
                                      ),
                                      child: Center(
                                          child: Icon(
                                        Icons.add,
                                        color: AppColorBody.blue,
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              buildText(
                                  color: AppColorText.black,
                                  fontSize: 20.w,
                                  text: "Description",
                                  fontWeight: FontWeight.w400),
                              SizedBox(height: 15.h),
                              buildText(
                                  color: AppColorText.black,
                                  fontSize: 14.w,
                                  text: singleProductList
                                      .data!.productDetails!.description,
                                  fontWeight: FontWeight.w400),
                              SizedBox(height: 20.h),
                              buildText(
                                  color: AppColorText.black,
                                  fontSize: 16.w,
                                  text: "Related Products",
                                  fontWeight: FontWeight.w400),
                              SizedBox(height: 20.h),
                              SizedBox(
                                  height: 200.h,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: singleProductList
                                          .data!.products!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        var items = singleProductList
                                            .data!.products![index];
                                        var discount =
                                            "${double.parse(items.price.toString()) - double.parse(items.discount.toString())}";

                                        return InkWell(
                                            onTap: () {
                                              ref
                                                  .refresh(changeData.notifier)
                                                  .update((state) => true);

                                              ref
                                                  .refresh(productVarProvider
                                                      .notifier)
                                                  .updateShouldNotify(
                                                      true, data);
                                              buildPush(
                                                  context: context,
                                                  widget: Product_Summary(
                                                      values: true,
                                                      id: singleProductList
                                                          .data!
                                                          .products![index]
                                                          .id));
                                            },
                                            child: buildImage(
                                                network: items.image.toString(),
                                                text: items.product.toString(),
                                                textRs: discount,
                                                canRs: items.price.toString()));
                                      })),
                              SizedBox(height: 10.h),
                              InkWell(
                                  onTap: () async {
                                    await ref.read(getCartProvider);
                                    Future.delayed(
                                      Duration(milliseconds: 1),
                                      () {
                                        ref.read(getCartProvider);
                                      },
                                    );

                                    ref.read(changeData.notifier).state = true;
                                    ref.refresh(getCartProvider);
                                    await ref
                                        .read(addCartProvider.call({
                                          'product_id': body.id.toString(),
                                          'product_name':
                                              body.product.toString(),
                                          'product_amount': productVarBuild
                                                  .toString()
                                                  .isNotEmpty
                                              ? productVarBuild
                                              : price,
                                          'product_quantity': ref
                                              .read(productVarProvider.notifier)
                                              .addProduct
                                              .toString()
                                        }))
                                        .then((value) => ref
                                            .read(getCartProvider.future)
                                            .asStream());

                                    ref
                                        .refresh(productVarProvider.notifier)
                                        .stream;

                                    ref.refresh(getCartProvider);
                                    ref.read(changeData.notifier).state = false;
                                    // ref
                                    //     .refresh(changeData.notifier)
                                    //     .update((state) => false);
                                    // ref.read(changeData.notifier).state = false;
                                  },
                                  child: isChange
                                      ? buildContainerB(
                                          value: loader, text: "Add to Cart")
                                      : InkWell(
                                          onTap: () {
                                            buildPush(
                                                context: context,
                                                widget: Bottombar(
                                                  navigate: 2,
                                                ));

                                            ref
                                                .refresh(changeData.notifier)
                                                .update((state) => true);
                                            ref
                                                .refresh(
                                                    productVarProvider.notifier)
                                                .stream;
                                            ref.refresh(getCartProvider);

                                            ref.invalidate(changeData);
                                            ;
                                          },
                                          child: buildContainerB(
                                              value: loader,
                                              text: "Go to Cart"))),
                              SizedBox(height: 20.h)
                            ])),
                  ],
                ));
              })
          : allData[navigate],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          selectedItemColor: AppColorBody.blue,
          unselectedItemColor: AppColorBody.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
              color: AppColorBody.blue,
              fontSize: 12.w,
              fontWeight: FontWeight.w400),
          onTap: (value) {
            setState(() {
              widget.values = false;
              navigate = value;
              ref.read(getCartProvider);
              ref.refresh(getCartProvider.future).asStream();
              ref.refresh(productVarProvider.notifier).stream;
              ref.invalidate(changeData);
              ref.refresh(changeData.notifier).update((state) => true);
            });
          },
          currentIndex: navigate,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/home/home.png'),
                    size: 20.w),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/home/Categories.png'),
                    size: 20.w),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/home/Cart.png'),
                    size: 20.w),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: ImageIcon(const AssetImage('assets/home/profile.png'),
                    size: 20.w),
                label: 'Profile'),
          ]),
    );
  }

  List allData = [
    const Home(),
    const CategoriesPage(),
    const CartPage(backbutton: false),
    const UserProfilePage(backbutton: false),
  ];
  int navigate = 0;
}
