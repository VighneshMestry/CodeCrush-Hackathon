import 'dart:developer';

import 'package:codecrush_hackathon/constants/custom_icons.dart';
import 'package:codecrush_hackathon/extensions/hexcode_extension.dart';
import 'package:codecrush_hackathon/model/product_model.dart';
import 'package:flutter/material.dart';
// import 'package:popover/popover.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'custom_dialog.dart';

class CustomListTile extends StatefulWidget {
  ProductDetails productDetails;

  CustomListTile({super.key, required this.productDetails});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

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

  String stringToDecimal(String value) {
    int decimalIndex = value.indexOf('.'); // 2
    String digitsUpToDecimal = value.substring(0, decimalIndex);
    return digitsUpToDecimal;
  }

  int stringToInteger(String value) {
    int decimalIndex = value.indexOf('.'); // 2
    String digitsUpToDecimal = value.substring(0, decimalIndex);
    int dist = int.parse(digitsUpToDecimal);
    return dist;
  }

  double carbonPetrolConsumption (int kilometer) {
    double answer = (kilometer/0.08)*2.3;
    // (kilometer/fuel consumption of a average vehicle per kilometer) * Carbon emissions per liter of petrol in kg CO2
    return answer;
  }

  double carbonElectricConsumption (int kilometer) {
    double answer = (kilometer * 0.2) * 0.5;
    // ( kilometer / kilowatt-hours per kilometer) * CO2 per kilowatt-hour
    return answer;
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
                        text: widget.productDetails.id,
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
                  widget.productDetails.status == 'Delivered'
                      ? CustomIcons().Delivered
                      : (widget.productDetails.status == 'Ordered'
                          ? CustomIcons().Ordered
                          : CustomIcons().OutForDelivery),
                  const SizedBox(
                    width: 5,
                  ),
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
                      // Tooltip(
                      //   decoration: const BoxDecoration(color: Colors.black),
                      //   preferBelow: false,
                      //   // Provide a global key with the "TooltipState" type to show
                      //   // the tooltip manually when trigger mode is set to manual.
                      //   key: tooltipkey,
                      //   triggerMode: TooltipTriggerMode.manual,
                      //   showDuration: const Duration(seconds: 8),
                      //   message: 'I am a Tooltip',
                      // ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor.fromHex('#475865'),
                        ),
                        onPressed: () async {
                          var distance =
                              stringToInteger(widget.productDetails.distance);
                          double petrolEmission = carbonPetrolConsumption(distance);
                          double evEmission = carbonElectricConsumption(distance);
                          var finalPetrolEmission = num.parse(petrolEmission.toStringAsFixed(2));
                          var finalElectricEmission = num.parse(evEmission.toStringAsFixed(2));
                          int dist = stringToInteger(widget.productDetails.distance);
                          String mode = dist <= 100
                              ? "Electric Vehicle"
                              : "Petrol Vehicle";
                              
                          await showErrorDialog(
                            context,
                            'As the distance is ${distance} km. The Efficient mode of transport is ${mode}',
                            'Mode Of Transport.',
                          );
                          // tooltipkey.currentState?.ensureTooltipVisible();
                          // showPopover(
                          //   context: context,
                          //   bodyBuilder: (context) => const ListItems(),
                          //   onPop: () => print('Popover was popped!'),
                          //   direction: PopoverDirection.top,
                          //   width: 200,
                          //   height: 400,
                          //   arrowHeight: 15,
                          //   arrowWidth: 30,
                          // );

                          // floatingActionButton: FloatingActionButton.extended(
                          //   onPressed: () {
                          //     // Show Tooltip programmatically on button tap.
                          //     tooltipkey.currentState?.ensureTooltipVisible();
                          //   },
                          //   label: const Text('Show Tooltip'),
                          // );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.local_shipping_outlined,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(stringToDecimal(
                                widget.productDetails.distance)),
                            const SizedBox(
                              width: 2,
                            ),
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

class ListItems extends StatelessWidget {
  const ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            InkWell(
              onTap: () {
                print('GestureDetector was called on Entry A');
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Entry A')),
              ),
            ),
            const Divider(),
            Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('Entry B')),
            ),
          ],
        ),
      ),
    );
  }
}
