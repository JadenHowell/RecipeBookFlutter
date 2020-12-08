import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:recipebook/model/data_class.dart';
import 'package:recipebook/model/icomoon.dart';
import 'package:recipebook/model/ingredient.dart';
import 'package:recipebook/model/measurements.dart';
import 'package:recipebook/model/recipe_data.dart';
import 'package:recipebook/model/better_duration.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class RecipeWidget extends StatefulWidget {
  final RecipeData recipe;
  final bool isEditable;

  RecipeWidget({
    @required this.recipe,
    this.isEditable = false,
  });

  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  bool isEditable;
  List<bool> _isChecked;
  TextEditingController _itemController;
  TextEditingController _amountController;
  TextEditingController _instructionsController;
  TextEditingController _recipeNameController;
  TextEditingController _servingController;
  TextEditingController _categoryController;
  RecipeData recipe;
  Measurement selectedMeasure;
  Duration modifiedDuration;

  @override
  void initState() {
    super.initState();
    isEditable = widget.isEditable;
    recipe = widget.recipe;
    _isChecked = [for (int i = 0; i < recipe.ingredients.length; ++i) false];
    _itemController = TextEditingController();
    _amountController = TextEditingController();
    _instructionsController = TextEditingController(text: recipe.instructions);
    _recipeNameController = TextEditingController(text: recipe.name);
    _servingController = TextEditingController(text: recipe.numServings.toString());
    _categoryController = TextEditingController(text: recipe.category);
    selectedMeasure = Measurement.NA;
    modifiedDuration = recipe.cookingTime;
  }

  void dispose() {
    super.dispose();
    _itemController.dispose();
    _amountController.dispose();
    _instructionsController.dispose();
    _recipeNameController.dispose();
    _servingController.dispose();
    _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: isEditable ? _editPage() : _viewPage(),
    );
  }

  CustomScrollView _viewPage() {
    return CustomScrollView(
      slivers: <Widget>[
        //This sliver gives the appbar
        _getAppBar(),

        //This sliver is the top column/row combo
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: AutoSizeText(
                            recipe.name,
                            softWrap: true,
                            maxLines: 4,
                            maxFontSize: 16,
                            minFontSize: 5,
                            style: TextStyle(
                              fontFamily: 'Sriracha',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(IconMoon.favorite),
                        color: recipe.isFavorite
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        onPressed: () {
                          setState(() {
                            recipe.isFavorite = !recipe.isFavorite;
                          });
                          ReData().saveData();
                        },
                      ),
                      Placeholder(
                        color: Colors.grey,
                        fallbackHeight: 20,
                        fallbackWidth: 20,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text('Serves: ' + recipe.numServings.toString(),
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              )),
                        ),
                        Container(
                          child: Text('Category: ' + recipe.category,
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              )),
                        ),
                      ],
                    ),
                    Container(
                      child: Text(
                          'Cooking time: ' +
                              recipe.cookingTime.betterToString(),
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  endIndent: 15,
                  indent: 15,
                ),
              ],
            ),
          ),
        ),

        //This sliver does the ingredient list in a gridview
        _viewOnlyIngredients(),

        //This sliver does the column with the second divider and the instructions
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  thickness: 2,
                  endIndent: 15,
                  indent: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      recipe.instructions,
                      style: TextStyle(
                        fontFamily: 'Sriracha',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //This sliver gives a little bit of empty space at the bottom
        SliverToBoxAdapter(
          child: Container(
            height: 20,
          ),
        ),
      ],
    );
  }

  CustomScrollView _editPage() {
    return CustomScrollView(
      slivers: <Widget>[
        //This sliver gives the appbar
        _getAppBar(),

        //This sliver is the top column/row combo
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: TextField(
                            controller: _recipeNameController,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: 'Sriracha',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        flex: 3,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        child: Placeholder(
                          color: Colors.grey,
                          fallbackHeight: 110,
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Serves: ',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 16,
                                ),
                                controller: _servingController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Category: ',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'SourceSansPro',
                                  fontSize: 16,
                                ),
                                controller: _categoryController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Builder(
                        builder: (context) => FlatButton(
                          child: Text(
                              'Update cooking time: ' +
                                  recipe.cookingTime.betterToString(),
                              style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 15,
                              )),
                          onPressed: () => selectTime(context),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                  endIndent: 15,
                  indent: 15,
                ),
              ],
            ),
          ),
        ),

        //This sliver does the ingredient list in a gridview
        _editIngredients(),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Builder(
              builder: (context) => Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '#',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Sriracha',
                        fontSize: 16,
                      ),
                      controller: _amountController,
                      onSubmitted: (newText) => _addToIngredients(context),
                      keyboardType: TextInputType.number,
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Transform.translate(
                        offset: Offset(0, 8),
                        child: DropdownButton<Measurement>(
                          value: selectedMeasure,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 16,
                          elevation: 16,
                          focusColor: Colors.grey,
                          style: TextStyle(
                            fontFamily: 'Sriracha',
                            fontSize: 20,
                          ),
                          onChanged: (Measurement newValue) {
                            setState(() {
                              selectedMeasure = newValue;
                            });
                          },
                          items: Measurement.values
                              .map((measure) => DropdownMenuItem(
                                    value: measure,
                                    child: Text(
                                      measure.toReadableString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Sriracha',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter new ingredient here',
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(
                        fontFamily: 'Sriracha',
                        fontSize: 16,
                      ),
                      controller: _itemController,
                      autocorrect: true,
                      onSubmitted: (newText) => _addToIngredients(context),
                    ),
                    flex: 6,
                  ),
                ],
              ),
            ),
          ),
        ),

        //This sliver does the column with the second divider and the instructions
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  thickness: 2,
                  endIndent: 15,
                  indent: 15,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: TextField(
                      controller: _instructionsController,
                      maxLines: 5,
                      style: TextStyle(
                        fontFamily: 'Sriracha',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //The option to delete
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              iconSize: 30,
              onPressed: () {
                return Alert(
                  context: context,
                  title: "Delete this recipe?",
                  closeFunction: (){},//This allows us to close the alert with nothing else happening
                  buttons: [
                    DialogButton(
                      child: Text("Yes"),
                      onPressed: (){
                        Navigator.of(context).pop();//This removes the alert
                        ReData().actualData.remove(recipe);
                        Navigator.of(context).pop();//This exits the recipeWidget page
                      },
                    ),
                    DialogButton(
                      child: Text("No"),
                      onPressed: (){
                        Navigator.of(context).pop();//This removes the alert
                      },
                    ),
                  ],
                ).show();
              },
            ),
          ),
        ),

        //This sliver gives a little bit of empty space at the bottom
        SliverToBoxAdapter(
          child: Container(
            height: 20,
          ),
        ),
      ],
    );
  }

  SliverAppBar _getAppBar() {
    return SliverAppBar(title: Text(recipe.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            if(isEditable){
              await Alert(
                context: context,
                title: "Save and exit, or just save?",
                closeFunction: (){},
                buttons: [
                  DialogButton(
                    child: Text("Save + Exit"),
                    onPressed: (){
                      _onSaveTap();
                      Navigator.of(context).pop();//This removes the alert
                      Navigator.of(context).pop(recipe);//This exits the recipe page
                    },
                  ),
                  DialogButton(
                    child: Text("Save"),
                    onPressed: (){
                      _onSaveTap();
                      Navigator.of(context).pop();//This removes the alert
                    },
                  ),
                ],
              ).show();
            }
            else{
              Navigator.of(context).pop(recipe);
            }
          },
        ),
        actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.edit,
        ),
        onPressed: isEditable
            ? null
            : _onEditTap, //IconButton will be auto disabled if the onPressed function is null, so this statement does that
      ),
      IconButton(
        icon: Icon(
          Icons.save,
        ),
        onPressed: isEditable ? _onSaveTap : null,
      ),
    ]);
  }

  void _onEditTap() {
    setState(() {
      isEditable = true;
    });
  }

  void _onSaveTap() {
    setState(() {
      recipe.instructions = _instructionsController.text;
      recipe.name = _recipeNameController.text;
      recipe.numServings = int.parse(_servingController.text);
      if (_categoryController.text == ""){
        recipe.category = "Other";
      }else {
        recipe.category = _categoryController.text;
      }
      isEditable = false;
    });

    ReData().saveData();

  }

  void selectTime(BuildContext context) {
    modifiedDuration = recipe.cookingTime;
    showDialog(
      context: context,
      child: StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          elevation: 16,
          title: Text(
            'Update cooking time',
          ),
          content: DurationPicker(
            duration: modifiedDuration,
            onChange: (val) {
              setState(() => modifiedDuration = val);
            },
            snapToMins: 5.0,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('Save'),
              onPressed: setDuration,
            ),
          ],
        );
      }),
    );
  }

  void setDuration() {
    setState(() {
      recipe.cookingTime = modifiedDuration;
    });
    Navigator.of(context).pop();
  }

  void _addToIngredients(BuildContext context) {
    if (_itemController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      String ingredientName = _itemController.text;
      double amount = double.parse(_amountController.text);
      Measurement measure = selectedMeasure;
      Ingredient newIngredient = Ingredient(
        amount: amount,
        itemName: ingredientName,
        measure: measure,
      );

      setState(() {
        recipe.ingredients.add(newIngredient);
        _isChecked.add(false);
      });

      _itemController.clear();
      _amountController.clear();
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please fill both the # field and ingredient field'),
      ));
    }
  }

  SliverGrid _editIngredients() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        childAspectRatio: 10,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _getEditIngredient(index);
        },
        childCount: recipe.ingredients.length,
      ),
    );
  }

  SliverGrid _viewOnlyIngredients() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _getViewIngredient(index);
        },
        childCount: recipe.ingredients.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 10,
        childAspectRatio: 10,
      ),
    );
  }

  _getViewIngredient(int index) {
    Ingredient _currentIngredient = recipe.ingredients[index];
    return Row(
      children: <Widget>[
        Checkbox(
          value: _isChecked[index],
          onChanged: (bool newValue) {
            setState(() {
              _isChecked[index] = newValue;
            });
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isChecked[index] = !_isChecked[index];
              });
            },
            child: Container(
              color: Colors.transparent,
              child: AutoSizeText(
                  _getIngredientAmount(_currentIngredient.measure,
                          _currentIngredient.amount) +
                      ' ' +
                      _currentIngredient.itemName,
                  softWrap: true,
                  maxLines: 2,
                  maxFontSize: 16,
                  minFontSize: 11,
                  style: TextStyle(
                    fontFamily: 'Sriracha',
                    fontSize: 16,
                  )
              ),
            ),
          ),
        ),
      ],
    );
  }

  _getEditIngredient(int index) {
    Ingredient _currentIngredient = recipe.ingredients[index];
    return Row(
      children: <Widget>[
        Checkbox(
          value: _isChecked[index],
          onChanged: (bool newValue) {
            setState(() {
              _isChecked[index] = newValue;
            });
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isChecked[index] = !_isChecked[index];
              });
            },
            child: Container(
              color: Colors.transparent,
              child: AutoSizeText(
                  _getIngredientAmount(_currentIngredient.measure,
                          _currentIngredient.amount) +
                      ' ' +
                      _currentIngredient.itemName,
                  softWrap: true,
                  maxLines: 2,
                  maxFontSize: 16,
                  minFontSize: 11,
                  style: TextStyle(
                    fontFamily: 'Sriracha',
                    fontSize: 16,
                  )),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          color: Colors.red,
          iconSize: 15,
          onPressed: () {
            setState(() {
              _isChecked.removeAt(index);
              recipe.ingredients.removeAt(index);
            });
          },
        ),
      ],
    );
  }

  String _getIngredientAmount(Measurement measurement, double amount) {
    String amountFraction = convertDecimalToFraction(amount);

    String properMeasure = measurement.toReadableString();
    if (measurement == Measurement.NA) properMeasure = '';
    return amountFraction + ' ' + properMeasure;
  }

  String convertDecimalToFraction(double x) {
    if (x < 0) {
      return "-" + convertDecimalToFraction(-x);
    }
    double tolerance = 1.0E-6;
    double h1 = 1;
    double h2 = 0;
    double k1 = 0;
    double k2 = 1;
    double b = x;
    do {
      int a = b.floor();
      double aux = h1;
      h1 = a * h1 + h2;
      h2 = aux;
      aux = k1;
      k1 = a * k1 + k2;
      k2 = aux;
      b = 1 / (b - a);
    } while ((x - h1 / k1).abs() > x * tolerance);

    int numerator = h1.toInt();
    int denominator = k1.toInt();

    if (denominator == 1) {
      return numerator.toString();
    }

    return numerator.toString() + '/' + denominator.toString();
  }
}


