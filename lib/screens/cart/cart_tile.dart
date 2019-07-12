import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/data/cart_product_data.dart';
import 'package:virtual_store/data/product_data.dart';
import 'package:virtual_store/models/cart_model.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;
  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {
      
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              cartProduct.productData.images[0], 
              fit: BoxFit.cover
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartProduct.productData.title, 
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  Text('Tamanho: ${cartProduct.size}', style: TextStyle(fontWeight: FontWeight.w300)),
                  Text('R\$ ${cartProduct.productData.price.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: cartProduct.quantity > 1 ? () => CartModel.of(context).decrement(cartProduct) : null,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: () => CartModel.of(context).increment(cartProduct),
                      ),
                      FlatButton(
                        child: Text('Remover'),
                        textColor: Colors.grey[400],
                        onPressed: () => CartModel.of(context).removeItem(cartProduct),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null 
        ? FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance
                          .collection('products')
                          .document(cartProduct.category)
                          .collection('items')
                          .document(cartProduct.productId)
                          .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cartProduct.productData = ProductData.fromDocument(snapshot.data);
              if (CartModel.of(context).products.lastIndexWhere((c) => c.id == cartProduct.id) == CartModel.of(context).products.length-1){
                CartModel.of(context).updatePrices();
              }
              return _buildContent();
            }
            else {
              return Container(
                height: 70,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                ),
                alignment: Alignment.center,
              );
            }
          },
        )
        : _buildContent(),
    );
  }

}