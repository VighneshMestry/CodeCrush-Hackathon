import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String orderId;
  final String sellerName;
  final String buyerName;
  final String status;

  const CustomListTile(
      {super.key,
      required this.orderId,
      required this.sellerName,
      required this.buyerName,
      required this.status});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
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
            width: 10,
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
                        text: "Id : ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                    TextSpan(
                        text: widget.orderId,
                        style: const TextStyle(
                          color: Colors.black87,
                        ))
                  ])),
                  const SizedBox(
                    width: 10,
                  ),
                ],
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
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      // _launchUrl(i);
                    },
                    child: const Text("Get Location"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          // MaterialPageRoute(builder: (context) => ProductDetailsPage(productDetails: productDetails,)),
                          // );
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoPage()));
                        },
                        child: Row(
                          children: const [
                            Text('Details'),
                            Icon(Icons.arrow_drop_down),
                          ],
                        )),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
