import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/screens/products/category_tile.dart';

class CategoryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('products').getDocuments(),
      builder: (context, snapshot) {
        return !snapshot.hasData
          ? Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ))
          : ListView(
            children: ListTile.divideTiles(
              tiles: snapshot.data.documents.map(
                (document) => CategoryTile(document)).toList(), 
              color: Colors.grey[500]
            ).toList(),
          );
      },
    );
  }
}