import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_store/models/cart_model.dart';

class CartPrice extends StatelessWidget {

  final VoidCallback onFinishOrder;
  CartPrice({@required this.onFinishOrder});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Resumo do Pedido', textAlign: TextAlign.start, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Subtotal'),
                    Text('R\$ ${model.productsPrice.toStringAsFixed(2)}')
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Desconto'),
                    Text('R\$ ${model.discount.toStringAsFixed(2)}')
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Entrega'),
                    Text('R\$ ${model.shipPrice.toStringAsFixed(2)}')
                  ],
                ),
                Divider(),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    Text('R\$ ${(model.productsPrice + model.shipPrice - model.discount).toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    child: Text('FINALIZAR COMPRA', style: TextStyle(fontSize: 18)),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: onFinishOrder,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}