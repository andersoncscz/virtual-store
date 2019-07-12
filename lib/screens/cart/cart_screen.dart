import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/screens/cart/cart_price.dart';
import 'package:virtual_store/screens/cart/ship_card.dart';
import 'package:virtual_store/screens/orders/order_screen.dart';

import 'cart_tile.dart';
import 'discount_card.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    void onFinishOrder() async {
      String orderId = await CartModel.of(context).finishOrder();
      if (orderId != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OrderScreen(orderId))
        );
      }   
    }    

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Carrinho'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
            tooltip: 'Lista de desejos',
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
          }
          else {
            if (model.products.length > 0) {
              return ListView(
                children: <Widget>[
                  Column(children: model.products.map((product) => CartTile(product)).toList()),
                  DiscountCard(),
                  ShipCard(),
                  CartPrice(onFinishOrder: onFinishOrder)
                ],
              );
            }
            return Container(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/sad.png', width: 100, height: 100,),
                SizedBox(height: 20),
                Text('Seu carrinho está vazio!', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),) 
              ],
            ),
            );
          }
        }
      ),
    );
  }
}