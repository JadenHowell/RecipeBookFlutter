import 'package:flutter/material.dart';
import 'package:recipebook/model/data_class.dart';
import 'package:recipebook/model/icomoon.dart';
import 'package:recipebook/model/recipe_data.dart';
import 'package:recipebook/model/theme_data.dart';
import 'package:recipebook/other_widgets/listed_recipe_widget.dart';
import 'package:recipebook/other_widgets/nav_button.dart';
import 'package:recipebook/page_widgets/recipe_widget.dart';
import 'package:recipebook/page_widgets/search_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await ReData().init();
  }on Exception catch(e){
    //This catches the first time the app is opened, and the file does not exist yet
  }
  runApp(RecipeBookApp());
}

class RecipeBookApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: CustomTheme.data,

      home: RecipePage()

    );
  }

}

class RecipePage extends StatefulWidget {
  @override
  _RecipePageState createState() => _RecipePageState();

  final _RecipePageState theState = _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<RecipeData> displayedRecipeList;
  Map<String, List<RecipeData>> categoryMap;

  @override
  void initState() {
    super.initState();
    _updateDisplayedList();
  }

  //This lets me setState when using listedRecipeWidget, updating the list after name change
  callback() {
    setState(() {
      ReData().saveData();
      _updateDisplayedList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Recipe Book'),
          actions: <Widget>[
          ],
        ),

        body: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: _selectedIndex == 1
                  ? getCategoryListView() //THIS IS IF WE SHOULD BE DISPLAYING THE CATEGORY MAP
                  : _selectedIndex == 2
                  // TODO: add in the page for conversions
                  ? SearchPage()//THIS IS WHERE WE SHOULD DISPLAY ALL CONVERSIONS
                  : ListView.builder( //THIS IS IF WE SHOULD BE DISPLAYING ALL RECIPES OR FAVORITES
                      itemCount: displayedRecipeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListedRecipe(
                          recipe: displayedRecipeList[index],
                          callback: callback,
                          key: Key(displayedRecipeList[index].hashCode.toString())
                        );
                      }
                    ),
              )
            ),
          ],
        ),

        resizeToAvoidBottomInset: false,  //This being false stops the floating action button from moving up when keyboard is pulled up
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(

          child: Center(
            child: Icon(Icons.add, size: 50,),
          ),
          onPressed: () {
            _addRecipe();
          }, //Add new recipe
        ),

        extendBody: true,

        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            height: 60,
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                NavButton(
                    iconData: IconMoon.spoonKnife,
                    text: 'Recipes',
                    doThis: () => _onItemSelected(0),
                    isSelected: (_selectedIndex == 0),
                ), // passes to custom widget: icon, text, and function to run
                NavButton(
                  iconData: IconMoon.categories,
                  text: 'Categories',
                  doThis: () => _onItemSelected(1),
                  isSelected: (_selectedIndex == 1),
                ),
                NavButton(
                  iconData: Icons.search,
                  text: 'Search',
                  doThis: () => _onItemSelected(2),
                  isSelected: (_selectedIndex == 2),
                ),
                NavButton(
                    iconData: IconMoon.favorite,
                    text: 'Favorites',
                    doThis: () => _onItemSelected(3),
                    isSelected: (_selectedIndex == 3),
                ), //uses anonymous function stuff
              ],
            ),
          ),
        ));
  }

  ListView getCategoryListView(){
    List<String> sortedCat = categoryMap.keys.toList();
    sortedCat.sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return ListView.builder(
        itemCount: categoryMap.keys.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                        child: Text(
                          sortedCat[index],
                          style: TextStyle(
                            fontFamily: 'Sriracha',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: getSingleCategoryList(categoryMap[sortedCat[index]]),
                    height: 65.0 * categoryMap[sortedCat[index]].length,
                  )
                ]
            ),
          );
        }
    );
  }

  ListView getSingleCategoryList(List<RecipeData> recipeList){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: recipeList.length,
      itemBuilder: (BuildContext context, int index){
        return ListedRecipe(
            recipe: recipeList[index],
            callback: callback,
            key: Key(recipeList[index].hashCode.toString())
        );
      }
    );
  }

  //0 = recipes, 1 = categories, 2 = conversions, 3 = favorites
  int _selectedIndex = 0;
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _updateDisplayedList();
    });
  }

  void _updateDisplayedList(){
    if (_selectedIndex == 0){
      displayedRecipeList = ReData().actualData;
    }else if (_selectedIndex == 1){
      fillCategoryMap();
    }else if(_selectedIndex == 3){    //Don't need an else if for conversions, that will just be updated in the scaffold. No display list or anything.
      List<RecipeData> createNewList = [];
      for(int i = 0; i < ReData().actualData.length; i ++){
        if(ReData().actualData[i].isFavorite){
          createNewList.add(ReData().actualData[i]);
        }
      }
      displayedRecipeList = createNewList;
    }

  }

  void fillCategoryMap(){
    categoryMap = new Map<String, List<RecipeData>>();
    for(RecipeData rec in ReData().actualData){
      if(categoryMap.containsKey(rec.category)) {
        categoryMap[rec.category].add(rec);
      }else{
        categoryMap[rec.category] = new List<RecipeData>();
        categoryMap[rec.category].add(rec);
      }
    }
  }

  void _addRecipe() async {
    RecipeData newRecipe = RecipeData(name: "", instructions: "", numServings: 0,
        ingredients: [], category: "Other", isFavorite: false, cookingTime: Duration(hours: 0));
    newRecipe = await Navigator.push<RecipeData>(
      context,
      MaterialPageRoute(builder: (context) => RecipeWidget(recipe: newRecipe, isEditable: true,)),
    );
    if(newRecipe != null) {
      setState(() {
        ReData().actualData.add(newRecipe);
        ReData().sortData();
        _updateDisplayedList();
      });
    }
  }
}

