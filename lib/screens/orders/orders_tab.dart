import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/models/user_model.dart';

import 'order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    String userId = UserModel.of(context).getSignedInUser().uid;

    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance
                       .collection('users')
                       .document(userId)
                       .collection('orders')
                       .getDocuments(),
      builder: (context, snapshot) {
        return !snapshot.hasData
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
          : ListView(
            children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList().reversed.toList(),
          );
      },
    );
  }

}