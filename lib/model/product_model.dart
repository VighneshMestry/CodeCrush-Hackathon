import 'dart:convert';

ProductDetails productDetailsFromJson(String str) => ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
    ProductDetails({
        required this.id,
        required this.productId,
        required this.ownerId,
        required this.ownerName,
        required this.ownerPhone,
        required this.ownerLocation,
        required this.buyerName,
        required this.buyerPhone,
        required this.buyerLocation,
        required this.orderDate,
        required this.distance,
        required this.status,
        required this.v,
    });

    String id;
    String productId;
    String ownerId;
    String ownerName;
    String ownerPhone;
    String ownerLocation;
    String buyerName;
    String buyerPhone;
    String buyerLocation;
    String orderDate;
    String distance;
    String status;
    int v;

    factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["_id"] ?? "",
        productId: json["productId"] ?? "",
        ownerId: json["ownerId"] ?? "",
        ownerName: json["ownerName"] ?? "",
        ownerPhone: json["ownerPhone"] ?? "",
        ownerLocation: json["ownerLocation"] ?? "",
        buyerName: json["buyerName"] ?? "",
        buyerPhone: json["buyerPhone"]?? "",
        buyerLocation: json["buyerLocation"] ?? "",
        orderDate: json["orderDate"] ?? "",
        distance: json["distance"] ?? "",
        status: json["status"] ?? "",
        v: json["__v"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId,
        "ownerId": ownerId,
        "ownerName": ownerName,
        "ownerPhone": ownerPhone,
        "ownerLocation": ownerLocation,
        "buyerName": buyerName,
        "buyerPhone": buyerPhone,
        "buyerLocation": buyerLocation,
        "orderDate": orderDate,
        "distance": distance,
        "status": status,
        "__v": v,
    };
}