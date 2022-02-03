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

onSearchTextChanged(String text) async {
    globals.setState(() {
      globals.SearchText = text;

      var fp = [];

  globals.select["program"].keys.toList().forEach((pr) {
    if (pr.toLowerCase()
        .contains(globals.SearchText.toLowerCase()))
      fp.add(pr);
  });



      globals.filteredItems=fp; //globals.select["program"].keys.toList();
      print(fp);
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
                  onPressed: _controller.clear /*{
                    print(this.);                    
                  }*/,
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
  return Text(globals.config["title"]+" (3)");
}




AppBar myAppBar(context) {
  return AppBar(
    title: Column(children: [
      if (globals.isSearchShown != true) myTitle(),
      if (globals.isSearchShown == true) SearchText(context)
    ]),
    actions: [
      // Navigate to the Search Screen
      if (globals.config["search"] == true)
        IconButton(
            onPressed: () {globals.setState(() {globals.isSearchShown = !globals.isSearchShown;});},
            icon: Icon(Icons.search))
    ],
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
