import 'package:flutter/material.dart';
import 'package:recipebook/model/data_class.dart';
import 'package:recipebook/model/recipe_data.dart';
import 'package:recipebook/page_widgets/recipe_widget.dart';


class ListedRecipe extends StatelessWidget {
  final RecipeData recipe;
  Function() callback;

  ListedRecipe({
    @required this.recipe,
    this.callback,
    Key key,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          child: Placeholder(),
          height: 40,
          width: 40,
        ),
        title: Text(
            recipe.name,
          style: TextStyle(
            fontFamily: 'Sriracha',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () async {
          RecipeData updatedRecipe = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeWidget(recipe: recipe, isEditable: false)),
          );
          if (updatedRecipe == null){
            callback();
          }
          else {
            int idx = ReData().actualData.indexOf(recipe);
            ReData().actualData[idx] = updatedRecipe;
            callback();
          }
        },
      ),
      elevation: 5,
      color: Theme.of(context).cardColor,
    );
  }


}
