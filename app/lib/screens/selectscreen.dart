import 'package:flutter/material.dart';
import '/globals.dart' as globals;

import '/elements/selectwindow.dart';
import 'dart:convert';
import 'dart:math';

var _controller = TextEditingController();

class SelectScreen extends StatefulWidget {
  SelectScreen({Key? key}) : super(key: key);

  @override
  _SelectScreen createState() => _SelectScreen();
}

class _SelectScreen extends State<SelectScreen> {
  @override
  void initState() {
    super.initState();
    globals.setStateSelect = setState;
  }

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
        var t = "";
        var target_j;
        List target_a;
        var ok = true;

        try {
          val = json.decode(s2);
          f = val["folder"];
          c = val["category"];
          t = val["target"];
        } catch (e) {
          print("program " + pr + " catch (program json)");
          print(e);
          ok = false;
        }

        try {
          target_j = json.decode("{\"target\":[" + t + "]}");
          //print(target_j);
          target_a = json.decode("{\"target\":[" + t + "]}")["target"];
          //print(target_a);
          target_a = target_a;
          target_a.sort((a, b) => a.compareTo(b));
          if (target_a[0] > 20000) ok = false;
          //if ([30000, ...target_a].reduce(min) > 20000) ok = false;
          //if (target_a.fold(0, max) < 70) ok = false;
          //if (target_a.reduce(min) > 20000) ok = false;

          target_a.sort((b, a) => a.compareTo(b));
          //if (target_a.reduce(max) < 70) ok = false;
          if (target_a[0] < 70) ok = false;
          target_a = target_a;
        } catch (e) {
          print("program " + pr + " catch (target)");
          print(t);
          print(e);
          ok = false;
        }

        var fs = globals.select["folder"][globals.selected["folder"]];
        var cs = globals.select["category"][globals.selected["category"]];
        if (ok == true) if (f.contains(fs)) if (c.contains(cs)) fp[pr] = src1[pr];
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
    globals.setStateSelect(() {
      globals.SearchText = text;
      filterItemsAll();
    });
  }

  onClear() {
    _controller.clear();
    globals.setStateSelect(() {
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
              hintText: globals.AppLocalizationsOC!.searchHint /*'Search...'*/,
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
            onPressed: () {globals.setStateSelect(() {globals.isSearchShown = !globals.isSearchShown;});},
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
            alignment: Alignment.center, decoration: BoxDecoration(gradient: globals.config["gradient"]), child: searchBody(context)));
  }
}
