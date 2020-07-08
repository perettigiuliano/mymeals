import 'package:flutter/material.dart';
import 'package:mymeals/widgets/main_drawer.dart';

enum Filters { GLUTENFREE, VEGAN, VEGETARIAN, LACTOSEFREE }

class FiltersScreen extends StatefulWidget {
  static const String ROUTENAME = "filters-screen";
  final Function saveHandler;
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  FiltersScreen(this.saveHandler, Map<String, bool> filters) {
    _isGlutenFree = filters["gluten"];
    _isVegan = filters["vegan"];
    _isVegetarian = filters["vegetarian"];
    _isLactoseFree = filters["lactose"];
  }

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;
  bool _isResetAllFiltersEnabled = false;

  _FiltersScreenState() {}

  void resetAllFilters() {
    setState(() {
      _isGlutenFree = false;
      _isVegan = false;
      _isVegetarian = false;
      _isLactoseFree = false;
      _isResetAllFiltersEnabled = false;
    });
  }

  Widget _switchListTile(String title, String subTitle, Filters filter) {
    bool oldValue = false;
    switch (filter) {
      case Filters.GLUTENFREE:
        oldValue = _isGlutenFree;
        break;
      case Filters.VEGAN:
        oldValue = _isVegan;
        break;
      case Filters.VEGETARIAN:
        oldValue = _isVegetarian;
        break;
      case Filters.LACTOSEFREE:
        oldValue = _isLactoseFree;
        break;
    }

    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: oldValue,
      onChanged: (value) {
        setState(() {
          switch (filter) {
            case Filters.GLUTENFREE:
              _isGlutenFree = !_isGlutenFree;
              break;
            case Filters.VEGAN:
              _isVegan = !_isVegan;
              break;
            case Filters.VEGETARIAN:
              _isVegetarian = !_isVegetarian;
              break;
            case Filters.LACTOSEFREE:
              _isLactoseFree = !_isLactoseFree;
              break;
          }
          _isResetAllFiltersEnabled =
              _isGlutenFree || _isVegan || _isVegetarian || _isLactoseFree;
        });
      },
    );
  }

  @override
  initState() {
    _isGlutenFree = widget._isGlutenFree;
    _isVegan = widget._isVegan;
    _isVegetarian = widget._isVegetarian;
    _isLactoseFree = widget._isLactoseFree;
    _isResetAllFiltersEnabled =
        _isGlutenFree || _isVegan || _isVegetarian || _isLactoseFree;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your filters!"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.saveHandler({
                "gluten": _isGlutenFree,
                "vegan": _isVegan,
                "vegetarian": _isVegetarian,
                "lactose": _isLactoseFree
              });
              Navigator.of(context).pushNamed("/");
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your recipes selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: _isResetAllFiltersEnabled ? resetAllFilters : null,
                child: Text("Reset filters"),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _switchListTile("Gluten Free",
                    "Recipes that dosn't contain gluten", Filters.GLUTENFREE),
                _switchListTile(
                    "Vegan", "Only vegetables ingredients", Filters.VEGAN),
                _switchListTile(
                    "Vegetarian", "No meats...", Filters.VEGETARIAN),
                _switchListTile("Lactose Free",
                    "No ingredients contain lactose", Filters.LACTOSEFREE),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: <Widget>[
          //     FlatButton(
          //       onPressed: () {
          //         Navigator.of(context).pushNamed("/",
          //             arguments: {"isGlutenFree": _isGlutenFree});
          //       },
          //       child: Text("Apply"),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
