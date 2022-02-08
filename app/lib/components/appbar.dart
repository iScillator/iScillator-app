//https://www.kindacode.com/article/flutter-add-a-search-field-to-the-app-bar/

// https://api.flutter.dev/flutter/cupertino/CupertinoSearchTextField-class.html

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//import 'package:package_info_plus/package_info_plus.dart';
//PackageInfo packageInfo = await PackageInfo.fromPlatform();
//String appName = packageInfo.appName;
//String packageName = packageInfo.packageName;
//String version = packageInfo.version;
//String buildNumber = packageInfo.buildNumber;
//globals.config["apptitle"]=globals.config["title"]+" (build 2)"

import 'package:flutter/material.dart';

import '/globals.dart' as globals;
//PreferredSizeWidget
//StatelessWidget

filterItems(String Text,String Item) async {
    var fp = {};
    var pr2;
    var src1=globals.select[Item];
    var src= (src1 == null ? []:src1.keys.toList());

    src.forEach((pr) {
      pr2=globals.l108t(pr);
      if ((pr.toLowerCase().contains(globals.SearchText.toLowerCase()))||(pr2.toLowerCase().contains(globals.SearchText.toLowerCase())))
        fp[pr]=src1[pr];
    });

    globals.filteredItems[Item]=fp; //globals.select["program"].keys.toList();
    //print(fp);
}

onSearchTextChanged(String text) async {
    globals.setState(() {
      globals.SearchText = text;
      filterItems(text,"angle");
      filterItems(text,"oscillator");
      filterItems(text,"program");
      filterItems(text,"enviroment");
      filterItems(text,"modulation");
      filterItems(text,"multi");
      filterItems(text,"target");
    });

}

onClear() {  
  _controller.clear();
   globals.setState(() {
      var text="";
      globals.SearchText = "";
      filterItems(text,"angle");
      filterItems(text,"oscillator");
      filterItems(text,"program");
      filterItems(text,"enviroment");
      filterItems(text,"modulation");
      filterItems(text,"multi");
      filterItems(text,"target");
   });
}


Widget SearchText(context) {

    //controller.text.isNotEmpty


 return Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
                hintText:
                    AppLocalizations.of(context)!.searchHint /*'Search...'*/,
                border: InputBorder.none),
          ),
        ),
      );

      //child: Text("MyText", style: TextStyle(fontSize: 20))
}

Widget myTitle()
{
  return Text(globals.config["title"]);
}




AppBar myAppBar(context) {
  return AppBar(
    title: Column(children: [
      if (globals.isSearchShown != true) myTitle(),
      if (globals.isSearchShown == true) SearchText(context)
    ]),
    /*
    actions: [
      // Navigate to the Search Screen
      if (globals.config["search"] == true)
        IconButton(
            onPressed: () {globals.setState(() {globals.isSearchShown = !globals.isSearchShown;});},
            icon: Icon(Icons.search))
    ],*/
  );
}
/*Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SearchPage()))*/

var _controller = TextEditingController();

/*
// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: 
    );
  }
}
*/
