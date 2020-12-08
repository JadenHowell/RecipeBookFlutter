import 'package:flutter/material.dart';
import 'package:recipebook/model/data_class.dart';
import 'package:recipebook/model/recipe_data.dart';
import 'package:recipebook/other_widgets/listed_recipe_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  List<RecipeData> listedRecipes;

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _updateList(_controller.text);
  }

  void dispose(){
    super.dispose();
    if(_controller != null) {
      _controller.dispose();
    }
  }

  callback() {
    setState(() {
      _updateList(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Container(
              child: TextField(
                autocorrect: true,
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Search:',
                  labelStyle: TextStyle(
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 16,
                ),
                onChanged: (String currentSearch) {
                  _updateList(currentSearch);
                },
              ),
            ),
          ),


          Expanded(
              child: ListView.builder(
                  itemCount: listedRecipes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListedRecipe(
                        recipe: listedRecipes[index],
                        callback: callback,
                        key: Key(listedRecipes[index].hashCode.toString()));
                  }
              )
          ),


        ],
      );
  }

  _updateList(String searchedText){
    searchedText = searchedText.toLowerCase();
    if(searchedText == ""){
      setState(() {
        listedRecipes = ReData().actualData;
      });
      return;
    }

    List<RecipeData> newList = [];
    for (int i = 0; i < ReData().actualData.length; i ++){
      if(ReData().actualData[i].name.toLowerCase().contains(searchedText,0)){
        newList.add(ReData().actualData[i]);
      }
    }

    setState(() {
      listedRecipes = newList;
    });
  }

}
