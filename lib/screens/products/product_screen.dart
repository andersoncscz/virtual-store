import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/data/product_data.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;
  String _sizeSelected;

  
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    
    final _primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              autoplay: false,
              images: product.images.map((url) => NetworkImage(url)).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: _primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(product.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500), maxLines: 3),
                Text('R\$ ${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _primaryColor)),
                SizedBox(height: 16),
                Text(product.description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 34, 
                  child: GridView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 8, childAspectRatio: 0.5),
                    children: product.sizes.map((size) => InkWell(
                      onTap: () {
                        setState(() {
                         _sizeSelected = size;
                        });
                      },
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)), 
                          border: Border.all(
                            color: size == _sizeSelected ? _primaryColor : Colors.grey[500], 
                            width: 3
                          )
                        ),
                        child: Text(size, style: TextStyle(color: size == _sizeSelected ? _primaryColor : Colors.grey[500], fontWeight: FontWeight.bold)),
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: _sizeSelected != null 
                      ? () {} 
                      : null,
                    color: _primaryColor,
                    textColor: Colors.white,
                    child: Text('Adicionar ao Carrinho', style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 16),
                Text('Descrição', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(product.description, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}