import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/data/product_data.dart';
import 'package:virtual_store/screens/cart/shopping_cart_button.dart';
import 'package:virtual_store/screens/products/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  //Snapshot from category
  final DocumentSnapshot snapshot;

  static const String _typeGrid = 'grid';
  static const String _typeList = 'list';

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data['title']),
          centerTitle: true,
          actions: <Widget>[
            ShoppingCartButton()
          ],          
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('products').document(snapshot.documentID).collection('items').getDocuments(),
          builder: (context, snapshot) {
            return !snapshot.hasData
              ? Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              ))
              : TabBarView(
                //physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 0.65
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => _handleTypeSelected(snapshot, index, _typeGrid),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => _handleTypeSelected(snapshot, index, _typeList),
                  )
                ],
              );
          },
        ),
      ),
    );
  }

  Widget _handleTypeSelected(AsyncSnapshot<QuerySnapshot> snapshot, int index, String type) {
    ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
    data.category = this.snapshot.documentID;
    return ProductTile(type, data);
  }
}