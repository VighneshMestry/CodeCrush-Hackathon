// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'dart:convert';

ProductDetails productDetailsFromJson(String str) => ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
    ProductDetails({
        required this.id,
        required this.productId,
        // required this.arrival,
        // required this.ordered,
        required this.status,
        required this.location,
        required this.buyeremail,
        // required this.v,
    });

    String id;
    String productId;
    // String arrival;
    // String ordered;
    String status;
    String location;
    String buyeremail;
    // int v;

    factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["_id"],
        productId: json["productId"] ?? "",
        // arrival: json["arrival"],
        // ordered: json["ordered"],
        status: json["status"] ?? "",
        location: json["location"] ?? "",
        buyeremail: json["buyeremail"] ?? "",
        // v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId,
        // "arrival": arrival,
        // "ordered": ordered,
        "status": status,
        "location": location,
        "buyeremail": buyeremail,
        // "__v": v,
    };
}
