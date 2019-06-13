import 'package:flutter/material.dart';
import 'package:virtual_store/data/product_data.dart';

import 'product_screen.dart';

class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductScreen(product)
        ));
      },
      child: Card(
        child: type == 'grid' 
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                product.images[0], 
                fit: BoxFit.cover
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(
                      product.title, 
                      style: TextStyle(fontWeight: FontWeight.w500)
                    ),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}', 
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold, 
                        color: Theme.of(context).primaryColor,
                      )
                    ),
                  ],
                ),
              ),
            )
          ],
        )
        : Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: AspectRatio(
              aspectRatio: 0.8,
                child: Image.network(
                  product.images[0], 
                  fit: BoxFit.cover
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      product.title, 
                      style: TextStyle(fontWeight: FontWeight.w500)
                    ),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}', 
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold, 
                        color: Theme.of(context).primaryColor,
                      )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}