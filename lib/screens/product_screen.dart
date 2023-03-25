import 'package:codecrush_hackathon/extensions/hexcode_extension.dart';
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

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var heartButton = const Icon(Icons.favorite_border);
  var redHeartButton = const Icon(Icons.favorite, color: Colors.red,);
  bool heart = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#768c87'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: const EdgeInsets.only(left: 25),
          child: const Icon(Icons.arrow_back),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 25),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  !heart;
                });
              },
              child: heart?heartButton:redHeartButton,
            ),
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
      ],
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
              TextSpan(
                  text: 'Product Name',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              TextSpan(text: "\n"),
              TextSpan(
                  text: 'Product Category', style: TextStyle(fontSize: 32)),
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
  static final List<String> imgList = ['fruits.jpg'];
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
                          image: AssetImage(imgList[i]), fit: BoxFit.fill),
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
    double sheetItemHeight = 185;

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
                  sellerDetails(sheetItemHeight),
                  buyerDetails(sheetItemHeight),
                  productStatus(sheetItemHeight),
                  // const SizedBox(
                  //   height: 220,
                  // ),
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

  buyerDetails(sheetItemHeight) {
    return Container(
      // height: sheetItemHeight,
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: const ExpansionTile(
        title: Text(
          'Buyer Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Text(
      //       "Seller Details",
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 18,
      //         fontWeight: FontWeight.w700,
      //       ),
      //     ),
      //     Container(
      //       width: 300,
      //       height: sheetItemHeight,
      //       margin: const EdgeInsets.only(top: 15),
      //       child: ExpansionTile(
      //         title: Text('Buyer Details'),
      //       ),
      //       // child: ListView.builder(
      //       //   // scrollDirection: Axis.vertical,
      //       //   itemCount: 2,
      //       //   itemBuilder: (_, i) {
      //       //     // return ListItem(
      //       //     //   sheetItemHeight: sheetItemHeight,
      //       //     //   mapVal: const {
      //       //     //     'Trial1': Text('trial1'),
      //       //     //     'Trial2': Text('trial2'),
      //       //     //   },
      //       //     // );
      //       //     return Container(
      //       //       // width: 100,
      //       //       height: 100,
      //       //       color: Colors.green,
      //       //       margin: const EdgeInsets.only(bottom: 10),
      //       //     );
      //       //   },
      //       // ),
      //     )
      //   ],
      // ),
    );
  }

  productStatus(double sheetItemHeight) {
    return Container(
      // height: sheetItemHeight,
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: const ExpansionTile(
        title: Text(
          'Product Status',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Text(
      //       "Seller Details",
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 18,
      //         fontWeight: FontWeight.w700,
      //       ),
      //     ),
      //     Container(
      //       width: 300,
      //       height: sheetItemHeight,
      //       margin: const EdgeInsets.only(top: 15),
      //       // child: const Text('Product Details'),
      //       child: ListView.builder(
      //         // scrollDirection: Axis.vertical,
      //         itemCount: 2,
      //         itemBuilder: (_, i) {
      //           // return ListItem(
      //           //   sheetItemHeight: sheetItemHeight,
      //           //   mapVal: const {
      //           //     'Trial1': Text('trial1'),
      //           //     'Trial2': Text('trial2'),
      //           //   },
      //           // );
      //           return Container(
      //             // width: 100,
      //             height: 100,
      //             color: Colors.green,
      //             margin: const EdgeInsets.only(bottom: 10),
      //           );
      //         },
      //       ),
      //     )
      //   ],
      // )
    );
  }

  sellerDetails(double sheetItemHeight) {
    return Container(
      // height: sheetItemHeight,
      padding: const EdgeInsets.only(top: 15, left: 10),
      child: ExpansionTile(
        title: const Text(
          'Seller Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: const [
                      Text(
                        'Seller Name:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Vighnesh'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: const [
                      Text(
                        'Seller Address:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Address'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Text(
      //       "Seller Details",
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 18,
      //         fontWeight: FontWeight.w700,
      //       ),
      //     ),
      //     Container(
      //       width: 300,
      //       height: sheetItemHeight,
      //       margin: const EdgeInsets.only(top: 15),
      //       // child: const Text('Product Details'),
      //       child: ListView.builder(
      //         // scrollDirection: Axis.vertical,
      //         itemCount: 2,
      //         itemBuilder: (_, i) {
      //           // return ListItem(
      //           //   sheetItemHeight: sheetItemHeight,
      //           //   mapVal: const {
      //           //     'Trial1': Text('trial1'),
      //           //     'Trial2': Text('trial2'),
      //           //   },
      //           // );
      //           return Container(
      //             // width: 100,
      //             height: 100,
      //             color: Colors.green,
      //             margin: const EdgeInsets.only(bottom: 10),
      //           );
      //         },
      //       ),
      //     )
      //   ],
      // ),
    );
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
