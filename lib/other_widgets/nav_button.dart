import 'package:flutter/material.dart';
import 'package:recipebook/model/static_variables.dart';

class NavButton extends StatelessWidget{
  final IconData iconData;
  final String text;
  final Function doThis;
  final bool isSelected;

  NavButton({
    @required this.iconData,
    @required this.text,
    @required this.doThis,
    this.isSelected = false,
    });

  @override
  Widget build(BuildContext context) {

    Color color = StaticVariables.textAndIcons;
    if(isSelected){
      color = StaticVariables.accentColor;
    }

    return GestureDetector(
      onTap: doThis,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Icon(iconData, color: color,),
            Text(text, style: TextStyle(color: color),),
          ],
        ),
      ),
    );
  }
}