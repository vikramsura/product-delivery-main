// ignore_for_file: file_names

import 'package:project/all_imports.dart';

class OrderPlacedSuccessfull extends StatelessWidget {
  const OrderPlacedSuccessfull({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print(
            'Backbutton pressed (device or appbar button), do whatever you want.');

        //trigger leaving and use own data
        Navigator.pop(context, false);
        Navigator.pop(context, false);
        Navigator.pop(context, false);
        //we need to return a future
        // terminal git update test

        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            SizedBox(
              height: 181.h,
            ),
            Center(
              child: Image(
                  height: 212.h,
                  width: 250.w,
                  image: const AssetImage("assets/image/orderSuccessfull.png")),
            ),
            SizedBox(
              height: 53.h,
            ),
            buildText(
                color: AppColorText.black,
                fontSize: 18.w,
                text: "Order placed successfull",
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 11.h,
            ),
            buildText(
                color: AppColorText.black,
                fontSize: 14.w,
                text: "Order #123456",
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 44.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Bottombar(
                              navigate: 0,
                            )));
                // buildPush(context: context, widget: Bottombar());
              },
              child: buildContainerB(value: false, text: "Go Home"),
            ),
          ]),
        ),
      ),
    );
  }
}
