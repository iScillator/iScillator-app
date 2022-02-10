import 'package:flutter/material.dart';
import '/globals.dart' as globals;

import '/elements/selectwindow.dart';
import 'dart:convert';

var _controller = TextEditingController();

class SelectScreen extends StatelessWidget {
  const SelectScreen({Key? key}) : super(key: key);

  List ifWindow(BuildContext context, item) {
    //print(ifWindow);
    //print(globals.isWindowShown[item]);
    return [
      if (globals.isWindowShown[item] == true)
        SelectWindow(
          item: item,
          //items: items,
          //selectItem: _select,
          //selectedItem: _selected,
        )
    ];
  }

  filterItems(String Text, String Item) async {
    var fp = {};
    var pr2;
    var src1 = globals.select[Item];
    var src = (src1 == null ? [] : src1.keys.toList());

    src.forEach((pr) {
      pr2 = globals.l108t(pr);
      if ((pr.toLowerCase().contains(globals.SearchText.toLowerCase())) ||
          (pr2.toLowerCase().contains(globals.SearchText.toLowerCase()))) if (Item == "program") {
        var s = globals.select[Item][pr];
        var s2 = s.replaceAll("'", "\"");
        var val;
        var f = "";
        var c = "";

        try {
          val = json.decode(s2);
          f = val["folder"];
          c = val["category"];
        } catch (e) {
          print(e);
          print("catch" + pr);
        }
        var fs = globals.select["folder"][globals.selected["folder"]];
        var cs = globals.select["category"][globals.selected["category"]];
        if (f.contains(fs)) if (c.contains(cs)) fp[pr] = src1[pr];
      } else {
        fp[pr] = src1[pr];
      }
    });

    globals.filteredItems[Item] = fp; //globals.select["program"].keys.toList();
    //print(fp);
  }

  filterItemsAll() {
    var text = globals.SearchText;

    filterItems(text, "folder");
    filterItems(text, "category");
    filterItems(text, "angle");
    filterItems(text, "oscillator");
    filterItems(text, "program");
    filterItems(text, "enviroment");
    filterItems(text, "modulation");
    filterItems(text, "multi");
    filterItems(text, "target");
  }

  onSearchTextChanged(String text) async {
    globals.setState(() {
      globals.SearchText = text;
      filterItemsAll();
    });
  }

  onClear() {
    _controller.clear();
    globals.setState(() {
      //var text="";
      globals.SearchText = "";
      filterItemsAll();
    });
  }

  Widget SearchText(context) {
    //controller.text.isNotEmpty

    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          controller: _controller,
          onChanged: onSearchTextChanged,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: onClear,
                //onPressed: _controller.clear;
              ),
              hintText: globals.AppLocalizations.of(context)!.searchHint /*'Search...'*/,
              border: InputBorder.none),
        ),
      ),
    );

    //child: Text("MyText", style: TextStyle(fontSize: 20))
  }

  AppBar searchAppBar(BuildContext context) {
    return AppBar(
        title: SearchText(context
            /*
    actions: [
      // Navigate to the Search Screen
      if (globals.config["search"] == true)
        IconButton(
            onPressed: () {globals.setState(() {globals.isSearchShown = !globals.isSearchShown;});},
            icon: Icon(Icons.search))
    ],*/
            ));
  }

  Widget searchBody(BuildContext context) {
    return Stack(
      children: [
        //Text("searchBody"),
        ...ifWindow(context, "folder"),
        ...ifWindow(context, "category"),
        ...ifWindow(context, "program"),
        ...ifWindow(context, "oscillator"),
        ...ifWindow(context, "angle"),
        ...ifWindow(context, "enviroment"),
        ...ifWindow(context, "modulation"),
        ...ifWindow(context, "multi"),
        ...ifWindow(context, "target"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    globals.filterItemsAll = filterItemsAll;

    return Scaffold(
        appBar: searchAppBar(context),
        //bottomNavigationBar: myBottomNavigationBar(context),
        body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Color.fromRGBO(12, 232, 92, 1.0),
              Color.fromRGBO(7, 117, 229, 1.0),
            ])),
            child: searchBody(context)));
  }
}
