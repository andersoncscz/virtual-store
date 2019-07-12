import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/constants/order_constants.dart';

class OrderTile extends StatelessWidget {

  final String orderId;
  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {


  Widget _buildOrderStageCircle(String title, String subtitle, int orderStatus, int circleStatus) {
    
    Color backColor;
    Widget child;
    
    if (orderStatus < circleStatus) {
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white));
    }
    else if ((orderStatus == circleStatus) && (orderStatus < OrderStatus.delivered)) {
      backColor = Theme.of(context).primaryColor;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor))
        ],
      );
    }
    else {
      backColor = Theme.of(context).accentColor;
      child = Icon(Icons.check, color: Colors.white);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(radius: 20, backgroundColor: backColor, child: child),
        Text(subtitle),
      ],
    );
  }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection('orders').document(orderId).snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
              ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Pedido: $orderId', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Descrição: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(_buildProductText(snapshot.data)),
                  SizedBox(height: 4),
                  Text('Status: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildOrderStageCircle(
                        OrderStatus.inProgress.toString(), 
                        OrderStatus.statusMap[OrderStatus.inProgress], 
                        snapshot.data['status'], 
                        OrderStatus.inProgress
                      ),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildOrderStageCircle(
                        OrderStatus.dispatched.toString(), 
                        OrderStatus.statusMap[OrderStatus.dispatched], 
                        snapshot.data['status'], 
                        OrderStatus.dispatched
                      ),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildOrderStageCircle(
                        OrderStatus.delivered.toString(), 
                        OrderStatus.statusMap[OrderStatus.delivered], 
                        snapshot.data['status'], 
                        OrderStatus.delivered
                      ),                                            
                    ],
                  )
                ],
              );
          },
        ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot snapshot) {
    String text = '';
    for(LinkedHashMap p in snapshot.data['products']) {
      text += '   ${p['quantity']} x ${p['product']['title']}\n';
    }
    text += '   Total: R\$ ${snapshot.data['total_price']}';
    return text;
  }
}