import 'dart:developer';
import 'dart:ffi';

import 'package:codecrush_hackathon/constants/custom_icons.dart';
import 'package:codecrush_hackathon/extensions/hexcode_extension.dart';
import 'package:codecrush_hackathon/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class CustomListTile extends StatefulWidget {
  ProductDetails productDetails;

  CustomListTile({super.key, required this.productDetails});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }
  }

  Future _qrScanner() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      String? qrData = await scanner.scan();
      log(qrData!);
      await _launchUrl(qrData);
    } else {
      var isGrant = await Permission.camera.request();

      if (isGrant.isGranted) {
        String? qrData = await scanner.scan();
        log(qrData!);
        await _launchUrl(qrData);
      }
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
                        text: widget.productDetails.productId,
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
                    text: widget.productDetails.ownerName,
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
                    text: widget.productDetails.buyerName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ))
              ])),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  // const Icon(
                  //   Icons.done_rounded,
                  //   color: Colors.green,
                  //   size: 26,
                  // ),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  widget.productDetails.status == 'Delivered' ? CustomIcons().Delivered : (widget.productDetails.status == 'Ordered' ? CustomIcons().Ordered : CustomIcons().OutForDelivery),
                  const SizedBox(width: 5,), 
                  Text(
                    widget.productDetails.status,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor.fromHex('#228b22'),
                    ),
                    onPressed: () async {
                      await _launchUrl(widget.productDetails.ownerLocation);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Pickup Location"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor.fromHex('#228b22'),
                    ),
                    onPressed: () async {
                      await _launchUrl(widget.productDetails.buyerLocation);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.location_on,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Delivery Location"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor.fromHex('#475865')),
                        onPressed: () async {
                          await _qrScanner();
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.qr_code,
                            ),
                            Text('Scan'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor.fromHex('#475865'),
                        ),
                        onPressed: () async {
                          await _qrScanner();
                        },
                        child: Row(
                          children:  [
                            const Icon(
                              Icons.local_shipping_outlined,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(widget.productDetails.distance.substring(0, 2)),
                            const SizedBox(width: 2,),
                            const Text('km'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
