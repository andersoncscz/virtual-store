import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/cart_model.dart';

import 'cart_screen.dart';

class ShoppingCartButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    void onPressed() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CartScreen()
      ));
    }

    return ScopedModelDescendant<CartModel>(
      builder: (context, child, model) => Center(
          child: Padding(
          padding: EdgeInsets.only(right: 12),
          child: Badge(
            position: BadgePosition.topRight(top: 2, right: -2),
            animationDuration: Duration(milliseconds: 100),
            animationType: BadgeAnimationType.scale,
            badgeColor: Colors.red,
            showBadge: model.products.length > 0,
            badgeContent: Text(model.products.length.toString(), style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.white,
              onPressed: onPressed
            ),
          ),
        )
      ),
    );
    
    
  }
}