import 'package:flutter/material.dart';
import 'package:virtual_store/widgets/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  accountName: Text('Anderson Cruz', style: TextStyle(color: Colors.grey[800])),
                  accountEmail: Text('andersoncscz@hotmail.com', style: TextStyle(color: Colors.grey[800])),
                  currentAccountPicture: GestureDetector(
                    onTap: () => print('asdasdsa'),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                ),
              ],
            ),
            DrawerTile(Icons.home, 'Início', 0, pageController),
            DrawerTile(Icons.list, 'Produtos', 1, pageController),
            DrawerTile(Icons.location_on, 'Lojas', 2, pageController),
            DrawerTile(Icons.playlist_add_check, 'Pedidos', 3, pageController),
          ],
        ));
  }
}
