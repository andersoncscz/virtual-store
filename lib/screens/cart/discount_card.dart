import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _handleSubmitCoupon(String couponCode) {
      CartModel.of(context).applyCoupon(
        couponCode,
        onSuccess: (DocumentSnapshot snapshot) {
          Scaffold.of(context).showSnackBar(
            SnackBar(duration: Duration(seconds: 2), content: Text('Desconto de ${snapshot.data['percent']}% aplicado!'))
          );
        },
        onFail: () {
          Scaffold.of(context).showSnackBar(
            SnackBar(duration: Duration(seconds: 2), content: Text('Cupom inexistente'))
          );
        },
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        title: Text(
          'Cupom de Desconto', 
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500, 
            color: Colors.grey[500]
          ),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: _handleSubmitCoupon,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cupom'
              ),
            ),
          )
        ],
      ),
    );
  }

}