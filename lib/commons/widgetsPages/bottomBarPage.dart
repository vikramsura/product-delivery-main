// ignore_for_file: must_be_immutable, file_names

import 'package:project/all_imports.dart';
import 'package:project/features/home/seeAllProductsummary/CategoriesPage.dart';
import 'package:project/features/userProfile/userProfileScreenPage.dart';

class Bottombar extends StatefulWidget {
  int navigate;
  Bottombar({super.key, required this.navigate});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  // @override
  // void initState() {
  //   widget.navigate;
  //   super.initState();
  // }
  // var _currentIndex = 0;
  List allData = [
    const Home(),
    const CategoriesPage(),
    const CartPage(backbutton: false),
    const UserProfilePage(
      backbutton: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: allData[widget.navigate],
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
                widget.navigate = value;
              });
            },
            currentIndex: widget.navigate,
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(const AssetImage('assets/home/home.png'),
                      size: 20.w),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                      const AssetImage('assets/home/Categories.png'),
                      size: 20.w),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon: ImageIcon(const AssetImage('assets/home/Cart.png'),
                      size: 20.w),
                  label: 'Cart'),
              BottomNavigationBarItem(
                  icon: ImageIcon(const AssetImage('assets/home/profile.png'),
                      size: 20.w),
                  label: 'Profile')
            ]));
  }
}
