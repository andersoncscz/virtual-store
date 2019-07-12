import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/constants/order_constants.dart';
import 'package:virtual_store/data/cart_product_data.dart';
import 'package:virtual_store/models/user_model.dart';

class CartModel extends Model {
  
  int discountPercentage = 0;
  double productsPrice = 0;
  double shipPrice = 0;
  double discount = 0;
  bool isLoading = false;
  String couponCode;
  
  UserModel user;
  List<CartProduct> products = [];
  CartModel(this.user);


  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addItem(CartProduct cartProduct, VoidCallback onSucess, VoidCallback onFail)  async {
    try {
      
      CartProduct cartProductAux;

      if (products.length > 0) {
        cartProductAux = products.firstWhere((cp) => (
            cp.productId == cartProduct.productId 
            && cp.size == cartProduct.size
          ), 
          orElse: () => null
        );
      }

      if (cartProductAux != null) {
        increment(cartProductAux);
      }
      else {
        products.add(cartProduct);
        FirebaseUser _firebaseUser = user.getSignedInUser();
        Firestore
              .instance
              .collection('users')
              .document(_firebaseUser.uid)
              .collection('cart')
              .add(cartProduct.toMap())
              .then((doc) =>  cartProduct.id = doc.documentID);
        updatePrices();
      }
      _handleCallback(callback: onSucess);

    } catch (e) {
      print(e.toString());
      _handleCallback(callback: onFail);
    }
  }



  void removeItem(CartProduct cartProduct, {VoidCallback onSucess, VoidCallback onFail}) async {
    try {
      
      FirebaseUser _firebaseUser = user.getSignedInUser();
      Firestore
            .instance
            .collection('users')
            .document(_firebaseUser.uid)
            .collection('cart')
            .document(cartProduct.id)
            .delete();
      
      products.remove(cartProduct);
      updatePrices();
      _handleCallback(callback: onSucess);    
    } catch (e) {
      _handleCallback(callback: onFail);
    }
  }  



  void decrement(CartProduct cartProduct) {
    cartProduct.quantity--;
    FirebaseUser _firebaseUser = user.getSignedInUser();
    Firestore.instance
              .collection('users')
              .document(_firebaseUser.uid)
              .collection('cart')
              .document(cartProduct.id)
              .updateData(cartProduct.toMap());
    updatePrices();
  }



  void increment(CartProduct cartProduct) {
    cartProduct.quantity++;
    FirebaseUser _firebaseUser = user.getSignedInUser();
    Firestore.instance
              .collection('users')
              .document(_firebaseUser.uid)
              .collection('cart')
              .document(cartProduct.id)
              .updateData(cartProduct.toMap());
    updatePrices();
  }  



  void applyCoupon(String couponCode, {Function(DocumentSnapshot) onSuccess, VoidCallback onFail}) {
    Firestore.instance.collection('coupons').document(couponCode).get().then((snapshot) {
      if (snapshot != null && snapshot.data != null) {
        this.couponCode = couponCode;
        this.discountPercentage = snapshot.data['percent'];
        updatePrices();
        _handleCallback(callback: onSuccess(snapshot));
      }
      else {
        this.couponCode = null;
        this.discountPercentage = 0;
        _handleCallback(callback: onFail);
      }
    });
  }


  double _calculateProductsPrice() {
    double price = 0;
    for (CartProduct cartProduct in products) {
      if (cartProduct.productData != null) {
        price += cartProduct.quantity * cartProduct.productData.price;
      }
    }
    return price;
  }


  double _calculateShipPrice() => 9.99;


  double _calculateDiscount() => _calculateProductsPrice() * discountPercentage / 100;


  void updatePrices() {
    productsPrice = _calculateProductsPrice();
    shipPrice = _calculateShipPrice();
    discount = _calculateDiscount();
    notifyListeners();
  }


  void getCartItems() async {
    FirebaseUser _firebaseUser = user.getSignedInUser();
    QuerySnapshot snapshot = await Firestore.instance
              .collection('users')
              .document(_firebaseUser.uid)
              .collection('cart').getDocuments();

    products = snapshot.documents.map((document) => CartProduct.fromDocument(document)).toList();
    updatePrices();
  }


  Future<String> finishOrder() async {
    if (products.length > 0) {
      
      onLoading();

      DocumentReference documentReference = await Firestore.instance
        .collection('orders')
        .add({
          'user_id': user.getSignedInUser().uid,
          'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
          'ship_price': shipPrice,
          'products_price': productsPrice,
          'discount': discount,
          'total_price': productsPrice + shipPrice - discount,
          'status': OrderStatus.inProgress
      });

      await Firestore.instance
        .collection('users')
        .document(user.getSignedInUser().uid)
        .collection('orders')
        .document(documentReference.documentID)
        .setData({
          'order_id': documentReference.documentID
      });

      onLoadFinished();
      cleanCart();
      _resetPrices();      
      
      return documentReference.documentID;
    }

    return null;
  }



  cleanCart() async {
    QuerySnapshot snapshot = await Firestore.instance
              .collection('users')
              .document(user.getSignedInUser().uid)
              .collection('cart')
              .getDocuments();

    for(DocumentSnapshot doc in snapshot.documents) {
      doc.reference.delete();
    }
    products.clear();
  }



  void _resetPrices() {
    productsPrice = 0;
    shipPrice = 0;
    discount = 0;
    couponCode = null;
  }



  void _handleCallback({VoidCallback callback, bool shouldNotifyListeners : true}) async {
    if (callback != null)
      callback();
    if (shouldNotifyListeners) {
      notifyListeners();
    }
  }

  void onLoading() {
    isLoading = true;
    notifyListeners();
  }

  void onLoadFinished() {
    isLoading = false;
    notifyListeners();
  }  

}