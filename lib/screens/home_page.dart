import 'package:codecrush_hackathon/common/list_tile.dart';
import 'package:codecrush_hackathon/model/product_model.dart';
import 'package:codecrush_hackathon/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/const/dimensions.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extensions/hexcode_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController editingController = TextEditingController();

  final mainListItems = ['1', '2', '3', '4', '5'];

  void fillSearchList() {}

  // var items = List<String>();
  var displayingListItem = [];

  @override
  void initState() {
    displayingListItem.addAll(mainListItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    dummySearchList.addAll(mainListItems);
    if (query.isNotEmpty) {
      // List<String> dummyListData = List<String>();
      List<String> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        displayingListItem.clear();
        displayingListItem.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        displayingListItem.clear();
        displayingListItem.addAll(mainListItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Image.asset(
            'Logo.png',
            height: 70,
            width: 150,
          ),
          backgroundColor: HexColor.fromHex('#242734'),
          actions: [
            SearchBarAnimation(
              textEditingController: editingController,
              isOriginalAnimation: true,
              trailingWidget: const Icon(Icons.close),
              secondaryButtonWidget: const Icon(Icons.close),
              buttonWidget: const Icon(Icons.search, color: Colors.black,),
              searchBoxWidth: 300,
              durationInMilliSeconds: Dimensions.t700,
              isSearchBoxOnRightSide: true,
              onChanged: (value) {
                filterSearchResults(value);
              },
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: displayingListItem.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 2,
                        color: Colors.grey[200],
                      ),
                      GestureDetector(
                        child: const CustomListTile(
                          orderId: '123',
                          sellerName: 'Vighnesh',
                          buyerName: 'Chris',
                          status: 'Done',
                          url: 'https://goo.gl/maps/LyMxUWoRsiLXEVLr5',
                        ),
                        onTap: () {
                          ProductDetails productDetails = ProductDetails(
                            id: '1',
                            productId: '1234',
                            // arrival: response[i]
                            //     ['arrival'],
                            // ordered: response[i]
                            //     ['Ordered'],
                            status: 'Delivered',
                            location: 'Location',
                            buyeremail: 'BuyerEmail',
                            // v: response[i]['_v'],
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ProductDetailsPage(
                          //             productDetails: productDetails,
                          //           )),
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyApp()
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
