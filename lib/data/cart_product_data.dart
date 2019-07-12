import 'package:cloud_firestore/cloud_firestore.dart';

import 'product_data.dart';

class CartProduct {
  
  String id;
  String productId;
  String category;
  String size;

  int quantity;

  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    productId = snapshot.data['product_id'];
    category = snapshot.data['category'];
    size = snapshot.data['size'];
    quantity = snapshot.data['quantity'];
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'category': category,
      'size': size,
      'quantity': quantity,
      'product': productData.toSummaryMap()
    };
  }

}