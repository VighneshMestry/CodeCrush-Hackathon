import 'dart:developer';

import 'package:codecrush_hackathon/common/list_tile.dart';
import 'package:codecrush_hackathon/model/product_model.dart';
import 'package:codecrush_hackathon/screens/product_screen.dart';
import 'package:codecrush_hackathon/services/auth_service.dart';
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

  AuthService authService = AuthService();

  Future<List<ProductDetails>> getTrackers() async {
    List<ProductDetails> products = [];
    try {
      var response = await authService.getTrackers() as List;
      products = response.map((e) => ProductDetails.fromJson(e)).toList();
      log(products.toString());
    } catch (e) {
      log(e.toString());
      throw Exception();
    }

    return products;
  }

  // void getTrackers() async {
  //   List<ProductDetails> products = [];
  //   try {
  //     List<ProductDetails> response = await authService.getTrackers() as List<ProductDetails>;
  //     _fetchProducts = response;
  //     // products = response.map((e) => ProductDetails.fromJson(e)).toList();
  //     log(products.toString());

  //   } catch (e) {
  //     log(e.toString());
  //     throw Exception();
  //   }
  // }

  // final mainListItems = ['1', '2', '3', '4', '5'];
  var mainListItems = [];

  var displayingListItem = [];
  var searchString = '';

  Future<List<ProductDetails>> tempFunction() {
    Future<List<ProductDetails>> _fetchProducts;
    _fetchProducts = getTrackers();
    return _fetchProducts;
  }

  @override
  void initState() {
    displayingListItem.addAll(mainListItems);
    getTrackers();
    // tempFunction();
    // log(_fetchProducts.toString());
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = [];
    // dummySearchList.addAll(mainListItems);
    for (int i = 0; i < mainListItems.length; i++) {
      dummySearchList.add(mainListItems[i]);
    }
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

  void fetchList(List<ProductDetails>? list) {
    for (int i = 0; i < list!.length; i++) {
      mainListItems.add(list[i].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Image.asset(
            'assets/Logo.png',
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
              buttonWidget: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              searchBoxWidth: 300,
              durationInMilliSeconds: Dimensions.t700,
              isSearchBoxOnRightSide: true,
              onChanged: (value) {
                setState(() {
                  searchString = value;
                });
                filterSearchResults(value);
              },
            )
          ],
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: tempFunction(),
              builder:
                  ((context, AsyncSnapshot<List<ProductDetails>> snapshot) {
                log("message");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  log('______________________________________' +
                      snapshot.data.toString());
                  fetchList(snapshot.data);

                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Container();
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    // itemCount: snapshot.data!.length,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      // fetchList();
                      // List<ProductDetails> list =  _fetchProducts;
                      log(index.toString());
                      ProductDetails p = snapshot.data![index];
                      // for (var i = 0; i < list.length; i++) {
                      //   ProductDetails p1 = list[i];
                      //   mainListItems.add(p1.id);
                      // }
                      return mainListItems[index].contains(searchString)
                          ? Column(
                              children: [
                                Container(
                                  height: 2,
                                  color: Colors.grey[200],
                                ),
                                GestureDetector(
                                  child: CustomListTile(
                                    productDetails: p,
                                  ),
                                  onTap: () {
                                    ProductDetails productDetails =
                                        ProductDetails(
                                      productName: p.productName,
                                      productCategory: p.productCategory,
                                      id: p.id,
                                      productId: p.productId,
                                      ownerId: p.ownerId,
                                      status: p.status,
                                      ownerLocation: p.ownerLocation,
                                      buyerName: p.buyerName,
                                      buyerLocation: p.buyerLocation,
                                      buyerPhone: p.buyerPhone,
                                      distance: p.distance,
                                      orderDate: p.orderDate,
                                      ownerName: p.ownerName,
                                      ownerPhone: p.ownerPhone,
                                      v: 0,
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
                                        builder: (context) => MyApp(
                                          productDetails: p,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            )
                          : Container();
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
