import 'package:flutter/material.dart';

class DefColors {
  Color color = Colors.white;
  Color backgroundColor = Colors.grey[900];
  Color splash = Colors.white;
}

class DrawerTile extends StatelessWidget {
  final int page;
  final IconData icon;
  final String text;
  final PageController pageController;
  final VoidCallback onClick;

  DrawerTile({@required this.icon, @required this.text, @required this.page, @required this.pageController, this.onClick});

  @override
  Widget build(BuildContext context) {


    DefColors _isSelected() {
      DefColors defColors = DefColors();
      if (pageController.page == page) {
        defColors.color = Theme.of(context).accentColor;
        defColors.backgroundColor = Colors.grey[800];
        defColors.splash = Colors.white;
        return defColors;
      }
      return defColors;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (page >= 0) {
            Navigator.of(context).pop();
            pageController.jumpToPage(page);
          }
          if (onClick != null)
            onClick();
        },
        child: Container(
          color: _isSelected().backgroundColor,
          height: 45,
          child: Padding(
            padding: EdgeInsets.only(left: 18),
            child: Row(
              children: <Widget>[
                Icon(icon, size: 30, color: _isSelected().color),
                SizedBox(width: 20),
                Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _isSelected().color))
              ],
            ),
          )
        ),
      ),
    );
  }
}
