import 'package:flutter/material.dart';
import 'package:virtual_store/screens/products/category_tab.dart';
import 'package:virtual_store/screens/home/home_tab.dart';
import 'package:virtual_store/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  
  final _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Categorias'),
            centerTitle: true,
          ),
          body: CategoryTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}