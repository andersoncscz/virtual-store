import 'package:flutter/material.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/widgets/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  
  final PageController _pageController;

  CustomDrawer(this._pageController);
  

  @override
  Widget build(BuildContext context) {
    
    UserModel model = UserModel.of(context);

    return Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.grey[900]),
        child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/drawer_header.jpg')
                )
              ),
              accountName: Text(model.isSignedIn() ? model.user['name'] : '' , style: TextStyle(color: Colors.white)),
              accountEmail: Text(model.isSignedIn() ? model.user['email'] : '', style: TextStyle(color: Colors.white)),
              currentAccountPicture: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: (model.isSignedIn() && model.user['profile_picture'] != '') ? NetworkImage(model.user['profile_picture']) : AssetImage('assets/images/profile_default.png'),
                ),
              ),
            ),
            DrawerTile(icon: Icons.home, text: 'Início', page: 0, pageController: _pageController),
            DrawerTile(icon: Icons.list, text: 'Produtos', page: 1, pageController: _pageController),
            DrawerTile(icon: Icons.playlist_add_check, text: 'Pedidos', page: 2, pageController: _pageController),
            DrawerTile(icon: Icons.location_on, text: 'Lojas', page: 3, pageController: _pageController),
            Divider(color: Colors.white),
            DrawerTile(icon: Icons.exit_to_app, text: 'Sair', page: -1, pageController: _pageController, onClick: () => _onSignOut(context)),
          ],
        )
      ),
    );
  }

  void _onSignOut(BuildContext context) {
    UserModel.of(context).signOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
