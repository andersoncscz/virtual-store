import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'store_tile.dart';

class StoresTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection('stores').getDocuments(),
      builder: (context, snapshot) {
        return !snapshot.hasData
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
          : ListView(
            children: snapshot.data.documents.map((doc) => StoreTile(doc)).toList(),
          );
      },
    );
  }
}