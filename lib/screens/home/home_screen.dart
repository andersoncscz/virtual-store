import 'package:flutter/material.dart';
import 'package:virtual_store/screens/cart/cart_screen.dart';
import 'package:virtual_store/screens/cart/shopping_cart_button.dart';
import 'package:virtual_store/screens/orders/orders_tab.dart';
import 'package:virtual_store/screens/products/category_tab.dart';
import 'package:virtual_store/screens/home/home_tab.dart';
import 'package:virtual_store/screens/stores/stores_tab.dart';
import 'package:virtual_store/widgets/custom_drawer.dart';
import 'package:virtual_store/widgets/gradient_background_color.dart';

class HomeScreen extends StatelessWidget {

  final _pageController = PageController();
  
  HomeScreen({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    Widget _buildHomeTab() => Scaffold(
      drawer: CustomDrawer(_pageController),
      body: HomeTab(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.shopping_cart),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen()))
      ),
    );


    Widget _buildCategoryTab() => Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        centerTitle: true,
        actions: <Widget>[
          ShoppingCartButton()
        ],
      ),
      drawer: CustomDrawer(_pageController),
      body: CategoryTab(),
    );


    Widget _buildOrdersTab() => Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        centerTitle: true
      ),
      drawer: CustomDrawer(_pageController),
      body: OrdersTab(),
    );


    Widget _buildStoresTab() => Scaffold(
      appBar: AppBar(
        title: Text('Lojas'),
        centerTitle: true
      ),
      drawer: CustomDrawer(_pageController),
      body: StoresTab(),
    );    


    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        _buildHomeTab(),
        _buildCategoryTab(),
        _buildOrdersTab(),
        _buildStoresTab()
      ],
    );
  }
}