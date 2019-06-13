import 'package:flutter/material.dart';

class DefColors {
  Color color = Colors.grey[800];
  Color backgroundColor = Colors.white;
  Color splash = Colors.grey[800];
}

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  //final DefColors defaultColors = DefColors();
  final int page;
  final PageController pageController;

  DrawerTile(this.icon, this.text, this.page, this.pageController);

  DefColors _isSelected() {
    DefColors defColors = DefColors();
    if (pageController.page == page) {
      defColors.color = Color.fromARGB(255, 211, 118, 130);
      defColors.backgroundColor = Colors.grey[800];
      defColors.splash = Colors.white;
      return defColors;
    }
    return defColors;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 45,
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: Row(
              children: <Widget>[
                Icon(icon, size: 30, color: _isSelected().color),
                SizedBox(width: 20),
                Text(text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: _isSelected().color))
              ],
            ),
          )
        ),
      ),
    );
  }
}
