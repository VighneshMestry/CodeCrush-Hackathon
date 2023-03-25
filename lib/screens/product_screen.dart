import 'package:flutter/material.dart';

import '../bloc/state_bloc.dart';
import '../bloc/state_provider.dart';

void main() {
  runApp(const MyApp());
}

// final currentCar = carList.cars[0];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: const EdgeInsets.only(left: 25),
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 25),
            child: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: const LayoutStart(),
    );
  }
}

class LayoutStart extends StatelessWidget {
  const LayoutStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        CarDetailsAnimation(),
        _CustomBottomSheet(),
        RentButton(),
      ],
    );
  }
}

class RentButton extends StatelessWidget {
  const RentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
        width: 200,
        child: TextButton(
          onPressed: () {},
          child: const Text(
            "Rent Car",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 1.4,
                fontFamily: "arial"),
          ),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
          // ),
          // color: Colors.black,
          // padding: EdgeInsets.all(25),
        ),
      ),
    );
  }
}

class CarDetailsAnimation extends StatefulWidget {
  const CarDetailsAnimation({super.key});

  @override
  State<CarDetailsAnimation> createState() => _CarDetailsAnimationState();
}

class _CarDetailsAnimationState extends State<CarDetailsAnimation>
    with TickerProviderStateMixin {
  // late AnimationController fadeController;
  // late AnimationController scaleController;

  // late Animation<double> fadeAnimation;
  // late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
  }

  late AnimationController fadeController = AnimationController(
      duration: const Duration(milliseconds: 180), vsync: this);
  late AnimationController scaleController = AnimationController(
      duration: const Duration(milliseconds: 350), vsync: this);

  late Animation<double> fadeAnimation = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(fadeController);
  late Animation<double> scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(
    CurvedAnimation(
        parent: scaleController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut),
  );

  forward() {
    fadeController.forward();
    scaleController.forward();
  }

  reverse() {
    fadeController.reverse();
    scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: StateProvider().isAnimating,
        stream: stateBloc.animationStatus,
        //snapshot.data in this case is the isAnimating value that we are receiving from the screen
        builder: (context, snapshot) {
          snapshot.data ? forward() : reverse();
          return ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: const CarDetails(),
            ),
          );
        });
  }
}

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 30),
          child: _carTitle(),
        ),
        const CarCarousel()
      ],
    );
  }

  _carTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(color: Colors.white, fontSize: 38),
            children: [
              TextSpan(text: 'Product Id'),
              TextSpan(text: "\n"),
              TextSpan(
                  text: 'Product Name',
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // RichText(
        //   text: TextSpan(
        //     style: const TextStyle(fontSize: 16),
        //     children: [
        //       TextSpan(
        //         text: '123',
        //         style: TextStyle(
        //           color: Colors.grey[20],
        //         ),
        //       ),
        //       const TextSpan(
        //         text: " / day",
        //         style: TextStyle(color: Colors.grey),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }
}

class CarCarousel extends StatefulWidget {
  const CarCarousel({super.key});

  @override
  State<CarCarousel> createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  static final List<String> imgList = ['Logo.png'];
  // final List<Widget> child = _map<Widget>(imgList, (index, String assetName) {
  //   return Container(
  //       child: Image.asset("assets/$assetName", fit: BoxFit.fitWidth));
  // }).toList();

  // static List<T> _map<T>(List list, Function handler) {
  //   List<T> result = [];
  //   for (var i = 0; i < list.length; i++) {
  //     result.add(handler(i, list[i]));
  //   }
  //   return result;
  // }
  late int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 252,
          child: PageView.builder(
            controller: PageController(viewportFraction: 1.0),
            itemCount: imgList.length,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
            itemBuilder: (_, i) {
              return Column(
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(imgList[i]), fit: BoxFit.fitWidth),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < imgList.length; i++)
              if (i == _current)
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(color: Colors.grey[100]),
                )
              else
                Container(
                  margin: const EdgeInsets.only(right: 2),
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                  ),
                )
          ],
        ),
      ],
    );
  }
}

class _CustomBottomSheet extends StatefulWidget {
  const _CustomBottomSheet({super.key});

  @override
  State<_CustomBottomSheet> createState() => __CustomBottomSheetState();
}

class __CustomBottomSheetState extends State<_CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop = 400;
  double minSheetTop = 100;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop).animate(
      CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut),
    )..addListener(
        () {
          setState(() {});
        },
      );
  }

  forwardAnimation() {
    controller.forward();
    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    controller.reverse();
    stateBloc.toggleAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {
          // controller.isCompleted ? controller.reverse() : controller.forward();
          controller.isCompleted ? reverseAnimation() : forwardAnimation();
        },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          if (dragEndDetails.primaryVelocity! < 0.0) {
            // controller.forward();
            forwardAnimation();
          } else if (dragEndDetails.primaryVelocity! > 0.0) {
            // controller.reverse();
            reverseAnimation();
          } else {
            return;
          }
        },
        child: const SheetContainer(),
      ),
    );
  }
}

class SheetContainer extends StatelessWidget {
  const SheetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double sheetItemHeight = 110;

    return Container(
        padding: const EdgeInsets.only(top: 25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
          color: Color(0xfff1f1f1),
        ),
        child: Column(
          children: [
            drawerHandle(),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  offerDetails(sheetItemHeight),
                  specifications(sheetItemHeight),
                  features(sheetItemHeight),
                  const SizedBox(
                    height: 220,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  drawerHandle() {
    return Container(
        height: 3,
        width: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[400],
        ));
  }

  specifications(sheetItemHeight) {
    return Container(
        padding: const EdgeInsets.only(top: 15, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Buyer Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: sheetItemHeight,
              child: const Text('Product Details'),
              // child: ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: 2,
              //   itemBuilder: (_, i) {
              //     return ListItem(
              //       sheetItemHeight: sheetItemHeight,
              //       mapVal: const {
              //         'Trial1' : 'Trial1',
              //         'Trial2' : 'Trial2',
              //       },
              //     );
              //   },
              // ),
            )
          ],
        ));
  }

  features(double sheetItemHeight) {
    return Container(
        padding: const EdgeInsets.only(top: 15, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product status",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: sheetItemHeight,
              child: const Text('Product Details'),
              // child: ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: 2,
              //   itemBuilder: (_, i) {
              //     return ListItem(
              //       sheetItemHeight: sheetItemHeight,
              //       mapVal: const {
              //         'Trial1' : 'Trial1',
              //         'Trial2' : 'Trial2',
              //       },
              //     );
              //   },
              // ),
            )
          ],
        ));
  }

  offerDetails(double sheetItemHeight) {
    return Container(
        padding: const EdgeInsets.only(top: 15, left: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Seller Details",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              height: sheetItemHeight,
              child: const Text('Product Details'),
              // child: ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: 2,
              //   itemBuilder: (_, i) {
              //     return ListItem(
              //       sheetItemHeight: sheetItemHeight,
              //       mapVal: const {
              //         'Trial1' : 'Trial1',
              //         'Trial2' : 'Trial2',
              //       },
              //     );
              //   },
              // ),
            )
          ],
        ));
  }
}

class ListItem extends StatelessWidget {
  final double sheetItemHeight;
  final Map mapVal;

  const ListItem(
      {super.key, required this.mapVal, required this.sheetItemHeight});

  @override
  Widget build(BuildContext context) {
    var innerMap;
    bool isMap;

    if (mapVal.values.elementAt(0) is Map) {
      innerMap = mapVal.values.elementAt(0);
      isMap = true;
    } else {
      innerMap = mapVal;
      isMap = false;
    }

    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: sheetItemHeight,
      height: sheetItemHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          mapVal.keys.elementAt(0),
          isMap
              ? Text(
                  innerMap.keys.elementAt(0),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black, letterSpacing: 1.2, fontSize: 11),
                )
              : Container(),
          Text(
            innerMap.values.elementAt(0),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
