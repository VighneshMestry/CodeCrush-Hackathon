

import 'package:codecrush_hackathon/extensions/hexcode_extension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomListTile extends StatefulWidget {
  final String orderId;
  final String sellerName;
  final String buyerName;
  final String status;
  final String url;

  const CustomListTile(
      {super.key,
      required this.orderId,
      required this.sellerName,
      required this.buyerName,
      required this.status,
      required this.url});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.black) ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // const SizedBox(width: 10,),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/016/973/351/original/shopping-cart-icon-in-flat-style-trolley-illustration-on-black-round-background-with-long-shadow-effect-basket-circle-button-business-concept-vector.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    const TextSpan(
                        text: "Id: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: widget.orderId,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ))
                  ])),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Seller Name: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                TextSpan(
                    text: widget.sellerName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ))
              ])),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: "Buyer Name: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
                TextSpan(
                    text: widget.buyerName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ))
              ])),
              const SizedBox(
                height: 10,
              ),

              Row(
                children: const [
                  Icon(
                    Icons.done_rounded,
                    color: Colors.green,
                    size: 26,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Ordered",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor.fromHex('#228b22'),
                    ),
                    onPressed: () async {
                      await _launchUrl(widget.url);
                    },
                    child: 
                    Row(
                      children: const [
                        Icon(Icons.location_on, size: 20,),
                        SizedBox(width: 5,),
                        const Text("Get Location"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  // SizedBox(
                  //   width: 100,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: Colors.blue,
                  //       ),
                  //       onPressed: () {
                  //         // Navigator.push(
                  //         //   context,
                  //         // MaterialPageRoute(builder: (context) => ProductDetailsPage(productDetails: productDetails,)),
                  //         // );
                  //         // Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoPage()));
                  //       },
                  //       child: Row(
                  //         children: const [
                  //           Text('Details'),
                  //           Icon(Icons.arrow_drop_down),
                  //         ],
                  //       )),
                  // )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
